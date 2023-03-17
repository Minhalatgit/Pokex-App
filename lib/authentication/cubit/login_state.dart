import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthState {}

class InitAuthState extends AuthState {}

class LoadingAuthState extends AuthState {}

class ErrorAuthState extends AuthState {
  final String message;

  ErrorAuthState(this.message);
}

class SuccessAuthState extends AuthState {
  final UserCredential userCredential;

  SuccessAuthState(this.userCredential);
}
