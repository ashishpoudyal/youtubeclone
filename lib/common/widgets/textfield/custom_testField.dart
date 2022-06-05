import 'package:flutter/material.dart';
import 'package:youtube_app_bloc/common/constants/theme.dart';

class CustomTextField extends StatelessWidget {
  final String title;
  final void Function()? onChanged;
  final TextEditingController? controller;
  final String hintText;
  final double bottomMargin;
  final bool obsecureText;
  final String? Function(String?)? validator;

  const CustomTextField(
      {Key? key,
      required this.title,
      this.onChanged,
      this.controller,
      required this.hintText,
      this.bottomMargin = 20,
      this.obsecureText = false, this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    return Container(
      padding: EdgeInsets.only(bottom: bottomMargin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: _textTheme.bodyText2!.copyWith(
                fontSize: 16,
                letterSpacing: 0.24,
                fontWeight: FontWeight.w500,
                color: CustomTheme.textColor),
          ),
          SizedBox(
            height: 8,
          ),
          TextFormField(
            obscureText: obsecureText,
            validator: validator,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: 20,
                ),
                hintText: hintText,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                )),
          )
        ],
      ),
    );
  }
}
