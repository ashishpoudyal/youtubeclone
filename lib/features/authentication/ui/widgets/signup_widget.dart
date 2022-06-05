import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_app_bloc/common/cubits/common_state.dart';
import 'package:youtube_app_bloc/common/utils/snackbar_utils.dart';
import 'package:youtube_app_bloc/features/authentication/cubit/signup_cubit.dart';
import 'package:youtube_app_bloc/features/authentication/cubit/social_login_cubit.dart';
import 'package:youtube_app_bloc/features/authentication/ui/pages/login_page.dart';

import '../../../../common/constants/assets.dart';
import '../../../../common/constants/theme.dart';
import '../../../../common/widgets/buttons/custom_rounded_buttons.dart';
import '../../../../common/widgets/textfield/custom_testField.dart';
import '../pages/signup_page.dart';

class SignUpWidget extends StatefulWidget {
  SignUpWidget({Key? key}) : super(key: key);

  @override
  State<SignUpWidget> createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    return MultiBlocListener(
      listeners: [
        BlocListener<SignupCubit, CommonState>(
          listener: (context, state) {
            // TODO: implement listener
            if (state is CommonLoadingState) {
              setState(() {
                _isLoading = true;
              });
            } else {
              setState(() {
                _isLoading = false;
              });
            }
            if (state is CommonSucessState) {
              SnackBarUtils.showSnackBar(
                  context: context, message: "Logged in Sucessfull");
            }
            if (state is CommonErrorState) {
              SnackBarUtils.showSnackBar(
                  context: context, message: state.message);
              Navigator.pop(context);
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text("Sin Up"),
          backgroundColor: CustomTheme.primaryColor,
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Container(
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
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return "Email field cannot be empty";
                      }
                      final _isValid = EmailValidator.validate(val);
                      if (_isValid) {
                        return null;
                      } else {
                        return "Enter valid email";
                      }
                    },
                  ),
                  CustomTextField(
                    obsecureText: true,
                    title: "Password",
                    hintText: "Enter Your Password",
                    controller: _passwordController,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return "Password field cannot be empty";
                      } else if (val.length < 4) {
                        return "Password field must be at least 4 character long";
                      } else {
                        return null;
                      }
                    },
                  ),
                  CustomTextField(
                    obsecureText: true,
                    title: "Confirm Password",
                    hintText: "Confirm Your Password",
                    controller: _passwordController,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return " Confirm Password field cannot be empty";
                      } else if (val.length < 4) {
                        return "Password field must be at least 4 character long";
                      } else if (val != _passwordController.text) {
                        return "password doesnot matched";
                      } else {
                        return null;
                      }
                    },
                  ),
                  CustomRoundedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<SignupCubit>().signUp(
                            email: _emailController.text,
                            password: _passwordController.text);
                      }
                    },
                    title: "SIGNUP",
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Divider(
                    height: 1,
                  ),
                  RichText(
                      text: TextSpan(
                          text: "Already have an account",
                          style: _textTheme.bodyText2,
                          children: [
                        TextSpan(
                            text: "Sign In ",
                            style: _textTheme.bodyText2!.copyWith(
                                color: CustomTheme.primaryColor,
                                fontWeight: FontWeight.w600),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                print("sign up pressed");
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => LoginPage(),
                                ));
                              })
                      ])),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
