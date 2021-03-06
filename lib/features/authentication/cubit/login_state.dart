part of 'login_cubit.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginSucess extends LoginState {}

class LoginError extends LoginState {
  final String message;
  LoginError({
    required this.message,
  });
}

class LoginLoading extends LoginState {}
