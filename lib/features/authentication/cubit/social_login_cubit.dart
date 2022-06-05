import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:youtube_app_bloc/features/authentication/resource/user_repository.dart';

part 'social_login_state.dart';

class SocialLoginCubit extends Cubit<SocialLoginState> {
  SocialLoginCubit({required this.userRepository})
      : super(SocialLoginInitial());

  final UserRepository userRepository;
  loginwithGoogle() async {
    emit(SocialLoginLoading());
    final _res = await userRepository.loginWithGoogle();
    if (_res.status = true) {
      emit(SocialLoginSucess());
    } else {
      emit(SocialLoginError(message: _res.message));
    }
  }

  loginwithFacebook() async {
    emit(SocialLoginLoading());
    final _res = await userRepository.loginWithFacebook();
    if (_res.status = true) {
      emit(SocialLoginSucess());
    } else {
      emit(SocialLoginError(message: _res.message));
    }
  }
}
