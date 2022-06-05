import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_app_bloc/features/dashboard/ui/screens/dashboard_page.dart';

import '../../../../common/constants/assets.dart';
import '../../../authentication/ui/pages/login_page.dart';
import '../../../onboarding/ui/screens/onboarding_page.dart';
import '../../cubit/cubit/startup_cubit.dart';

class SplashWidgets extends StatefulWidget {
  const SplashWidgets({Key? key}) : super(key: key);

  @override
  State<SplashWidgets> createState() => _SplashWidgetsState();
}

class _SplashWidgetsState extends State<SplashWidgets> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<StartupCubit>().fetchStartupData();
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    return BlocListener<StartupCubit, StartupState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is StartupSucess) {
          print("inside sucess");
          if (state.isFirstTime) {
            print("first time .....................");
            print("First time");
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => OnBoardingPage(),
            ));
          } else {
            if (state.isLoggedIn) {
              //send to dashboard

              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DashBoardPage(),
                  ),
                  (route) => false);
            } else {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => LoginPage(),
              ));
            }
          }
        }
      },
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(child: Image.asset(Assets.youtube)),
              SizedBox(height: 10),
              Expanded(
                  child: Text(
                "Youtube Clone",
                style: _textTheme.headline5,
              )),
            ],
          ),
        ),
      ),
    );
  }
}
