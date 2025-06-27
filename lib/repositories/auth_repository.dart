import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:matchme_lover/models/user_model.dart';

class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Volledige signup functie
  Future<UserModel> signUpUser({
    required String email,
    required String password,
    required String name,
    required DateTime birthDate,
  }) async {
    try {
      // Maak Firebase Auth account aan
      final cred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = cred.user!;
      final now = DateTime.now();

      // Bereken leeftijd
      int age = now.year - birthDate.year;
      if (now.month < birthDate.month ||
          (now.month == birthDate.month && now.day < birthDate.day)) {
        age--;
      }

      // Maak UserModel
      final userModel = UserModel(
        uid: user.uid,
        name: name,
        age: age,
        email: email,
        birthDate: birthDate,
        createdAt: now,
      );

      // Sla gegevens op in Firestore
      await _saveUserToFirestore(userModel);

      return userModel;
    } catch (e) {
      rethrow;
    }
  }

  // Private methode om user data op te slaan
  Future<void> _saveUserToFirestore(UserModel user) async {
    final userDoc = _firestore.collection('Users').doc(user.uid);

    // Sla op in het hoofddocument (basis info)
    await userDoc.set({
      'email': user.email,
      'naam': user.name,
      'datumVanAanmaak': FieldValue.serverTimestamp(),
    });

    // Sla op in de subcollectie (voor ProfileScreen)
    await userDoc.collection('gebruiker info').doc('details').set({
      'naam': user.name,
      'gebruikersnaam': user.username,
      'leeftijd': user.age,
      'email': user.email,
      'telefoonnummer': user.phoneNumber,
      'geboorteDatum':
          '${user.birthDate.day}/${user.birthDate.month}/${user.birthDate.year}',
      'datumVanAanmaak': FieldValue.serverTimestamp(),
    });
  }

  // Sign in functie
  Future<User> signIn({required String email, required String password}) async {
    final cred = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return cred.user!;
  }

  // Sign out functie
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Huidige gebruiker ophalen
  User? get currentUser => _auth.currentUser;

  // Auth state stream
  Stream<User?> get authStateChanges => _auth.authStateChanges();
}
