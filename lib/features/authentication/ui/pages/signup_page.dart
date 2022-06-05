import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_app_bloc/features/authentication/cubit/signup_cubit.dart';
import 'package:youtube_app_bloc/features/authentication/resource/user_repository.dart';
import 'package:youtube_app_bloc/features/authentication/ui/widgets/signup_widget.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupCubit(
        userRepository: RepositoryProvider.of<UserRepository>(context)
      ),
      child: SignUpWidget(),
    );
  }
}
