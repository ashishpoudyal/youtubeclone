import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:youtube_app_bloc/features/authentication/resource/user_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({required this.userRepository}) : super(LoginInitial());

  final UserRepository userRepository;
  signinWithEmailPassword(
      {required String email, required String password}) async {
    emit(LoginLoading());
    final _res = await userRepository.loginWitheEmailPassword(
        email: email, password: password);
    if (_res.status) {
      emit(LoginSucess());
    } else {
      emit(LoginError(message: _res.message));
    }
  }
}
