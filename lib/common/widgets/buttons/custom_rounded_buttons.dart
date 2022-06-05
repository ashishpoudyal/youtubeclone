import 'package:flutter/material.dart';
import 'package:youtube_app_bloc/common/constants/theme.dart';

class CustomRoundedButton extends StatelessWidget {
  final String title;
  final void Function() onPressed;
  final double? width;

  const CustomRoundedButton(
      {Key? key, required this.title, required this.onPressed, this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    return InkWell(
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
        width: width,
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        decoration: BoxDecoration(
          color: CustomTheme.primaryColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          title,
          style: _textTheme.headline6?.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
