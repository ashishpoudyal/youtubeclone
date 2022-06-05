import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../../../../common/constants/assets.dart';
import '../../../../common/utils/shared_pref.dart';
import '../../../authentication/ui/pages/login_page.dart';

class OnboardingWidget extends StatefulWidget {
  OnboardingWidget({Key? key}) : super(key: key);

  @override
  State<OnboardingWidget> createState() => _OnboardingWidgetState();
}

class _OnboardingWidgetState extends State<OnboardingWidget> {
  final List<PageViewModel> _items = [
    PageViewModel(
      title: "Play some video first  ",
      body:
          "Here you can write the description of the page, to explain someting...",
      image: Center(
        child: SvgPicture.asset(Assets.video, height: 175.0),
      ),
    ),
    PageViewModel(
      title: "Play some game video second ",
      body:
          "Here you can write the description of the page, to explain someting...",
      image: Center(
        child: SvgPicture.asset(Assets.game, height: 175.0),
      ),
    )
  ];
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;

    return Scaffold(
      body: IntroductionScreen(
        pages: _items,
        onDone: () {
          SharedPref.setFirstTime(false);
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => LoginPage(),
          ));
        },
        showBackButton: true,
        showSkipButton: false,
        back: Icon(Icons.arrow_back),
        done: Text("Done", style: _textTheme.bodyText2),
        next: Text("Next", style: _textTheme.bodyText2),
      ),
    );
  }
}
