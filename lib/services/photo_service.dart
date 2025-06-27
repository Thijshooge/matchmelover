import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logging/logging.dart';

class PhotoService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Logger _logger = Logger('PhotoService');

  // Test Firebase Storage verbinding
  Future<void> testStorageConnection() async {
    final user = _auth.currentUser;
    if (user == null) {
      _logger.warning('No user logged in for storage test');
      return;
    }

    try {
      _logger.info('Testing Firebase Storage connection...');
      _logger.info('Storage bucket: ${_storage.bucket}');
      _logger.info('Max upload retry time: ${_storage.maxUploadRetryTime}');

      // Test of we een referentie kunnen maken
      final testRef = _storage.ref().child('test').child('connection.txt');
      _logger.info('Test ref path: ${testRef.fullPath}');
      _logger.info('Storage connection test passed!');
    } catch (e) {
      _logger.severe('Storage connection test failed: $e');
      if (e is FirebaseException) {
        _logger.severe('Firebase error code: ${e.code}');
        _logger.severe('Firebase error message: ${e.message}');
      }
    }
  }

  // Haal alle foto's op van de huidige user
  Stream<List<String?>> getPhotos() {
    final user = _auth.currentUser;
    if (user == null) return Stream.value(List.filled(9, null));

    return _firestore
        .collection('Users')
        .doc(user.uid)
        .collection('photos')
        .orderBy('index')
        .snapshots()
        .map((snapshot) {
          // Start met lege lijst van 9 plekken
          List<String?> photos = List.filled(9, null);

          // Vul de lijst met foto URLs op de juiste index
          for (var doc in snapshot.docs) {
            final data = doc.data();
            final index = data['index'] as int;
            final photoUrl = data['photoUrl'] as String?;

            if (index >= 0 && index < 9) {
              photos[index] = photoUrl;
            }
          }

          return photos;
        });
  }

  // Vind de eerste beschikbare positie
  Future<int> _findFirstAvailablePosition() async {
    final user = _auth.currentUser;
    if (user == null) return 0;

    final snapshot = await _firestore
        .collection('Users')
        .doc(user.uid)
        .collection('photos')
        .get();

    // Maak lijst van bezette posities
    List<int> occupiedPositions = [];
    for (var doc in snapshot.docs) {
      final data = doc.data();
      final index = data['index'] as int;
      occupiedPositions.add(index);
    }

    // Vind eerste vrije positie (0-8)
    for (int i = 0; i < 9; i++) {
      if (!occupiedPositions.contains(i)) {
        return i;
      }
    }

    return 0; // Fallback naar positie 0
  }

  // Upload een foto en sla op in Firebase (altijd naar eerste beschikbare positie)
  Future<void> uploadPhoto(File imageFile, int requestedIndex) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception('User not logged in');

    try {
      // Vind eerste beschikbare positie in plaats van opgegeven index
      final index = await _findFirstAvailablePosition();
      _logger.info(
        'Starting upload for photo at position $index (requested: $requestedIndex)...',
      );
      _logger.info('User ID: ${user.uid}');
      _logger.info('File path: ${imageFile.path}');
      _logger.info('File exists: ${await imageFile.exists()}');
      if (await imageFile.exists()) {
        _logger.info('File size: ${await imageFile.length()} bytes');
      }

      // Controleer of het bestand bestaat
      if (!await imageFile.exists()) {
        throw Exception('Image file does not exist');
      }

      // Upload naar Firebase Storage - gebruik default instance voor iOS compatibility
      final storageRef = _storage
          .ref()
          .child('users')
          .child(user.uid)
          .child('photos')
          .child('photo_$index.jpg');

      _logger.info('Storage ref path: ${storageRef.fullPath}');
      _logger.info('Starting Firebase Storage upload...');

      // Upload met expliciete contentType voor iOS compatibility
      final metadata = SettableMetadata(
        contentType: 'image/jpeg',
        customMetadata: {
          'uploadedBy': user.uid,
          'uploadedAt': DateTime.now().millisecondsSinceEpoch.toString(),
        },
      );

      // Retry mechanism voor iOS compatibility
      int retryCount = 0;
      const maxRetries = 3;
      String downloadUrl = '';

      while (retryCount < maxRetries) {
        try {
          // Voor iOS: gebruik putData in plaats van putFile
          final imageBytes = await imageFile.readAsBytes();
          _logger.info('Read ${imageBytes.length} bytes from file');

          final uploadTask = storageRef.putData(imageBytes, metadata);

          // Wacht tot upload voltooid is
          final snapshot = await uploadTask.whenComplete(() {});
          _logger.info(
            'Upload completed (attempt ${retryCount + 1}), getting download URL...',
          );

          downloadUrl = await snapshot.ref.getDownloadURL();
          _logger.info('Download URL: $downloadUrl');
          break; // Success, exit retry loop
        } catch (e) {
          retryCount++;
          _logger.warning('Upload attempt $retryCount failed: $e');

          if (retryCount >= maxRetries) {
            rethrow; // Final failure
          }

          // Wait before retry
          await Future.delayed(Duration(seconds: retryCount * 2));
          _logger.info('Retrying upload...');
        }
      }

      // Sla URL op in Firestore
      _logger.info('Saving to Firestore...');
      await _firestore
          .collection('Users')
          .doc(user.uid)
          .collection('photos')
          .doc('photo_$index')
          .set({
            'index': index,
            'photoUrl': downloadUrl,
            'uploadedAt': FieldValue.serverTimestamp(),
          });

      _logger.info('Photo upload completed successfully!');
    } catch (e) {
      _logger.severe('Photo upload error: $e');
      _logger.severe('Error type: ${e.runtimeType}');
      if (e is FirebaseException) {
        _logger.severe('Firebase error code: ${e.code}');
        _logger.severe('Firebase error message: ${e.message}');
        _logger.severe('Firebase error details: ${e.toString()}');
      }
      rethrow; // Gooi de originele error door
    }
  }

  // Helper: krijg de eerste beschikbare positie (voor UI)
  Future<int> getFirstAvailablePosition() async {
    return await _findFirstAvailablePosition();
  }

  // Upload meerdere foto's (elk naar eerste beschikbare positie)
  Future<void> uploadMultiplePhotos(List<File> imageFiles) async {
    for (File imageFile in imageFiles) {
      await uploadPhoto(imageFile, -1); // -1 = ignore requested index
    }
  }

  // Verwijder een foto
  Future<void> deletePhoto(int index) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception('User not logged in');

    try {
      // Verwijder uit Firestore
      await _firestore
          .collection('Users')
          .doc(user.uid)
          .collection('photos')
          .doc('photo_$index')
          .delete();

      // Verwijder uit Storage
      final storageRef = _storage
          .ref()
          .child('users')
          .child(user.uid)
          .child('photos')
          .child('photo_$index.jpg');

      await storageRef.delete();
    } catch (e) {
      // Als foto niet bestaat in storage, negeer de error
      _logger.warning('Photo deletion error (might not exist): $e');
    }
  }

  // Herorder foto's (wissel twee posities)
  Future<void> reorderPhotos(int fromIndex, int toIndex) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception('User not logged in');

    final batch = _firestore.batch();
    final photosRef = _firestore
        .collection('Users')
        .doc(user.uid)
        .collection('photos');

    try {
      // Haal beide foto documenten op
      final fromDoc = await photosRef.doc('photo_$fromIndex').get();
      final toDoc = await photosRef.doc('photo_$toIndex').get();

      // Als beide foto's bestaan, wissel ze volledig (inclusief document IDs)
      if (fromDoc.exists && toDoc.exists) {
        final fromData = fromDoc.data()!;
        final toData = toDoc.data()!;

        // Verwijder beide oude documenten
        batch.delete(fromDoc.reference);
        batch.delete(toDoc.reference);

        // Maak nieuwe documenten met de juiste IDs en data
        batch.set(photosRef.doc('photo_$toIndex'), {
          'index': toIndex,
          'photoUrl': fromData['photoUrl'],
          'uploadedAt': fromData['uploadedAt'],
        });

        batch.set(photosRef.doc('photo_$fromIndex'), {
          'index': fromIndex,
          'photoUrl': toData['photoUrl'],
          'uploadedAt': toData['uploadedAt'],
        });
      }
      // Als alleen fromDoc bestaat, verplaats het
      else if (fromDoc.exists) {
        final fromData = fromDoc.data()!;

        batch.delete(fromDoc.reference);
        batch.set(photosRef.doc('photo_$toIndex'), {
          'index': toIndex,
          'photoUrl': fromData['photoUrl'],
          'uploadedAt': fromData['uploadedAt'],
        });
      }
      // Als alleen toDoc bestaat, verplaats het
      else if (toDoc.exists) {
        final toData = toDoc.data()!;

        batch.delete(toDoc.reference);
        batch.set(photosRef.doc('photo_$fromIndex'), {
          'index': fromIndex,
          'photoUrl': toData['photoUrl'],
          'uploadedAt': toData['uploadedAt'],
        });
      }

      await batch.commit();
      _logger.info('Photos reordered successfully: $fromIndex ↔ $toIndex');
    } catch (e) {
      _logger.severe('Failed to reorder photos: $e');
      throw Exception('Failed to reorder photos: $e');
    }
  }
}
