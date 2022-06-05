import 'package:bloc/bloc.dart';

import '../../../../common/utils/shared_pref.dart';

part 'startup_state.dart';

class StartupCubit extends Cubit<StartupState> {
  StartupCubit() : super(StartupInitial());

  fetchStartupData() async {
    emit(StartupLoading());
    final _isFirstTime = await SharedPref().getFirstTime();
    final _user = await SharedPref.getUser();
    await Future.delayed(const Duration(seconds: 2));
    final _isLoggedIn = _user != null;
    emit(StartupSucess(isFirstTime: _isFirstTime, isLoggedIn: _isLoggedIn));
  }
}
