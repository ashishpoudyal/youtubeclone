import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_app_bloc/features/authentication/cubit/social_login_cubit.dart';
import 'package:youtube_app_bloc/features/authentication/resource/user_repository.dart';

import '../../features/splash/resourse/startup_repository.dart';

class MultiRepositoryWrapper extends StatelessWidget {
  final Widget child;
  const MultiRepositoryWrapper({Key? key, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(providers: [
      RepositoryProvider(
        create: (context) => StartupRepository(),
      ),
      RepositoryProvider(
        create: (context) => UserRepository(),
      )
    ], child: child);
  }
}
