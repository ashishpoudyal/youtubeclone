part of 'social_login_cubit.dart';

abstract class SocialLoginState {}

class SocialLoginInitial extends SocialLoginState {}

class SocialLoginLoading extends SocialLoginState {}

class SocialLoginSucess extends SocialLoginState {}

class SocialLoginError extends SocialLoginState {
  final String message;
  SocialLoginError({required this.message});
}
