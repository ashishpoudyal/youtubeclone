part of 'startup_cubit.dart';

abstract class StartupState {}

class StartupInitial extends StartupState {}

class StartupLoading extends StartupState {}

class StartupSucess extends StartupState {
  final bool isFirstTime;
  final bool isLoggedIn;
  StartupSucess({
    required this.isFirstTime,
    required this.isLoggedIn,
  });
}
