import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/profile_model.dart';

class ProfileService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Timer? _saveTimer;
  static const Duration _saveDelay = Duration(seconds: 2);

  String? get currentUserId => _auth.currentUser?.uid;

  // Firebase structure: Users/{uid}/profiel info/details (consistent with existing structure)
  CollectionReference get _usersCollection => _firestore.collection('Users');

  /// Haalt profiel op
  Future<ProfileModel?> getProfile(String uid) async {
    try {
      final docSnapshot = await _usersCollection
          .doc(uid)
          .collection('profiel info')
          .doc('details')
          .get();

      if (docSnapshot.exists && docSnapshot.data() != null) {
        final data = docSnapshot.data() as Map<String, dynamic>;
        return ProfileModel.fromMap(uid, data);
      }
      return null;
    } catch (e) {
      print('Error fetching profile: $e');
      rethrow;
    }
  }

  /// Slaat profiel op
  Future<void> saveProfile(ProfileModel profile) async {
    try {
      await _usersCollection
          .doc(profile.uid)
          .collection('profiel info')
          .doc('details')
          .set(profile.toMap(), SetOptions(merge: true));
    } catch (e) {
      print('Error saving profile: $e');
      rethrow;
    }
  }

  /// Update bio met debouncing (automatisch opslaan na 2 seconden)
  Future<void> updateBio(String bio) async {
    final uid = currentUserId;
    if (uid == null) return;

    // Cancel vorige timer
    _saveTimer?.cancel();

    // Start nieuwe timer
    _saveTimer = Timer(_saveDelay, () async {
      try {
        await _usersCollection
            .doc(uid)
            .collection('profiel info')
            .doc('details')
            .update({
              'bio': bio,
              'updated_at': DateTime.now().toIso8601String(),
            });
        print('Bio auto-saved');
      } catch (e) {
        print('Error auto-saving bio: $e');
      }
    });
  }

  /// Update ander profiel veld
  Future<void> updateField(String field, dynamic value) async {
    final uid = currentUserId;
    if (uid == null) return;

    try {
      await _usersCollection
          .doc(uid)
          .collection('profiel info')
          .doc('details')
          .set({
            field: value,
            'updated_at': DateTime.now().toIso8601String(),
          }, SetOptions(merge: true));
      print('Field $field updated to: $value');
    } catch (e) {
      print('Error updating $field: $e');
      rethrow;
    }
  }

  /// Maak nieuw profiel aan
  Future<ProfileModel> createProfile(String uid) async {
    final now = DateTime.now();
    final newProfile = ProfileModel(uid: uid, createdAt: now, updatedAt: now);

    await saveProfile(newProfile);
    return newProfile;
  }

  /// Stream voor real-time updates
  Stream<ProfileModel?> profileStream(String uid) {
    return _usersCollection
        .doc(uid)
        .collection('profiel info')
        .doc('details')
        .snapshots()
        .map((snapshot) {
          if (snapshot.exists && snapshot.data() != null) {
            final data = snapshot.data() as Map<String, dynamic>;
            return ProfileModel.fromMap(uid, data);
          }
          return null;
        });
  }

  void dispose() {
    _saveTimer?.cancel();
  }
}
