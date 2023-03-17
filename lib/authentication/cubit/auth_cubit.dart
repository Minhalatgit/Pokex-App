import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokex/authentication/cubit/login_state.dart';
import 'package:pokex/repository/login_repository.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginRepository _repository;

  AuthCubit(this._repository) : super(InitAuthState());

  Future<void> login(String email, String password) async {
    emit(LoadingAuthState());
    try {
      UserCredential userCredential = await _repository.login(email, password);
      emit(SuccessAuthState(userCredential));
    } catch (e) {
      emit(ErrorAuthState(e.toString()));
    }
  }

  Future<void> signup(String email, String password) async {
    emit(LoadingAuthState());
    try {
      UserCredential userCredential = await _repository.signup(email, password);
      emit(SuccessAuthState(userCredential));
    } catch (e) {
      emit(ErrorAuthState(e.toString()));
    }
  }
}
