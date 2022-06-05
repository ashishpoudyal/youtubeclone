import 'package:flutter/material.dart';
import 'package:youtube_app_bloc/common/constants/theme.dart';

class DashboardWidgets extends StatelessWidget {
  const DashboardWidgets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomTheme.primaryColor,
      ),
      body: Container(
        child: Text("DashbOard page"),
      ),
    );
  }
}
