import 'package:flutter/cupertino.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_app_bloc/features/authentication/cubit/login_cubit.dart';
import 'package:youtube_app_bloc/features/authentication/cubit/social_login_cubit.dart';
import 'package:youtube_app_bloc/features/authentication/resource/user_repository.dart';

import '../widgets/login_widget.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SocialLoginCubit(
            userRepository: RepositoryProvider.of<UserRepository>(context),
          ),
        ),
        BlocProvider(
          create: (context) => LoginCubit(
              userRepository: RepositoryProvider.of<UserRepository>(context)),
        ),
      ],
      child: LoginWidgets(),
    );
  }
}
