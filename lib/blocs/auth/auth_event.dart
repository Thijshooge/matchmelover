import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SignUpRequested extends AuthEvent {
  final String email;
  final String password;
  final String naam;
  final DateTime geboortedatum;
  final int leeftijd;

  SignUpRequested({
    required this.email,
    required this.password,
    required this.naam,
    required this.geboortedatum,
    required this.leeftijd,
  });

  @override
  List<Object?> get props => [email, password, naam, geboortedatum, leeftijd];
}

class SignInRequested extends AuthEvent {
  final String email;
  final String password;

  SignInRequested({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class SignOutRequested extends AuthEvent {}
