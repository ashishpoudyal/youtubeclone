import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:youtube_app_bloc/common/cubits/common_state.dart';
import 'package:youtube_app_bloc/features/authentication/resource/user_repository.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<CommonState> {
  SignupCubit({required this.userRepository}) : super(CommonInitialState());
  final UserRepository userRepository;
  signUp({required String email, required String password}) async {
    emit(CommonLoadingState());
    final _res = await userRepository.signUpWitheEmailPassword(
        email: email, password: password);
    if (_res.status) {
      emit(CommonSucessState(data: true));
    } else {
      emit(CommonErrorState(message: _res.message));
    }
  }
}
