import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_app_bloc/common/constants/theme.dart';
import 'package:youtube_app_bloc/common/utils/snackbar_utils.dart';
import 'package:youtube_app_bloc/common/widgets/buttons/custom_rounded_buttons.dart';
import 'package:youtube_app_bloc/common/widgets/textfield/custom_testField.dart';
import 'package:youtube_app_bloc/features/authentication/cubit/login_cubit.dart';
import 'package:youtube_app_bloc/features/authentication/cubit/social_login_cubit.dart';
import 'package:youtube_app_bloc/features/authentication/ui/pages/signup_page.dart';
import 'package:youtube_app_bloc/features/dashboard/ui/screens/dashboard_page.dart';

import '../../../../common/constants/assets.dart';

class LoginWidgets extends StatefulWidget {
  const LoginWidgets({Key? key}) : super(key: key);

  @override
  State<LoginWidgets> createState() => _LoginWidgetsState();
}

class _LoginWidgetsState extends State<LoginWidgets> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    return MultiBlocListener(
      listeners: [
        BlocListener<SocialLoginCubit, SocialLoginState>(
          listener: (context, state) {
            // TODO: implement listener
            if (state is SocialLoginLoading) {
              setState(() {
                _isLoading = true;
              });
            } else {
              setState(() {
                _isLoading = false;
              });
            }
            if (state is SocialLoginSucess) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DashBoardPage(),
                  ),
                  (route) => false);
              SnackBarUtils.showSnackBar(
                  context: context, message: "Logged in Sucessfull");
            }
            if (state is SocialLoginError) {
              SnackBarUtils.showSnackBar(
                  context: context, message: state.message);
            }
          },
        ),
        BlocListener<LoginCubit, LoginState>(
          listener: (context, state) {
            // TODO: implement listener
            if (state is LoginLoading) {
              setState(() {
                _isLoading = true;
              });
            } else {
              setState(() {
                _isLoading = false;
              });
            }
            if (state is LoginSucess) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DashBoardPage(),
                  ),
                  (route) => false);
              SnackBarUtils.showSnackBar(
                  context: context, message: "Logged in Sucessfully");
            } else if (state is LoginError) {
              SnackBarUtils.showSnackBar(
                  context: context, message: state.message);
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: CustomTheme.primaryColor,
        ),
        body: Container(
          padding: EdgeInsets.symmetric(
            horizontal: CustomTheme.horizontalPadding,
          ),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              CustomTextField(
                title: "Email",
                hintText: "Enter Email Address",
                controller: _emailController,
              ),
              CustomTextField(
                obsecureText: true,
                title: "Password",
                hintText: "Enter Your Password",
                controller: _passwordController,
              ),
              CustomRoundedButton(
                  onPressed: () {
                    context.read<LoginCubit>().signinWithEmailPassword(
                        email: _emailController.text,
                        password: _passwordController.text);
                  },
                  title: "LOGIN"),
              SizedBox(
                height: 20,
              ),
              Divider(
                height: 1,
              ),
              RichText(
                  text: TextSpan(
                      text: "Don't have account",
                      style: _textTheme.bodyText2,
                      children: [
                    TextSpan(
                        text: "sign up",
                        style: _textTheme.bodyText2!.copyWith(
                            color: CustomTheme.primaryColor,
                            fontWeight: FontWeight.w600),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            print("sign up pressed");
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => SignUpPage(),
                            ));
                          })
                  ])),
              SizedBox(
                height: 20,
              ),
              Text("Or signin with "),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      context.read<SocialLoginCubit>().loginwithFacebook();
                    },
                    icon: Icon(Icons.facebook),
                  ),
                  IconButton(
                      onPressed: () {
                        context.read<SocialLoginCubit>().loginwithGoogle();
                      },
                      icon: Image.asset(
                        Assets.googleIcon,
                        height: 50,
                        width: 50,
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
