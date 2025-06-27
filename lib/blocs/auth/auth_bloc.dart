import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matchme_lover/models/user_model.dart';
import 'package:matchme_lover/repositories/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc(this._authRepository) : super(AuthInitial()) {
    on<SignUpRequested>(_onSignUpRequested);
    on<SignInRequested>(_onSignInRequested);
    on<SignOutRequested>(_onSignOutRequested);
  }

  Future<void> _onSignUpRequested(
    SignUpRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    try {
      // Gebruik de nieuwe signUpUser methode die alles afhandelt
      final user = await _authRepository.signUpUser(
        email: event.email,
        password: event.password,
        name: event.naam,
        birthDate: event.geboortedatum,
      );

      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onSignInRequested(
    SignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    try {
      final firebaseUser = await _authRepository.signIn(
        email: event.email,
        password: event.password,
      );

      // Voor sign in maak je een basic UserModel aan
      // In de toekomst kun je hier de user data uit Firestore ophalen
      final user = UserModel(
        uid: firebaseUser.uid,
        name: '', // Ophalen uit Firestore
        age: 0, // Ophalen uit Firestore
        email: firebaseUser.email ?? event.email,
        birthDate: DateTime.now(), // Ophalen uit Firestore
        createdAt: DateTime.now(), // Ophalen uit Firestore
      );

      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onSignOutRequested(
    SignOutRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      await _authRepository.signOut();
      emit(AuthInitial());
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}
