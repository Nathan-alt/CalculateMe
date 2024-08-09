import 'package:flutter/material.dart';

import '../Sub-atomic/colors.dart';
import '../Sub-atomic/screen_paddings.dart';

class UISafeScaffold extends StatelessWidget {
  const UISafeScaffold({super.key, required this.child, this.appBar});
  final Widget child;
  final AppBar? appBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: UIColors.white,
        appBar: appBar,
        body: SafeArea(
          minimum: const EdgeInsets.all(ScreenPaddings.normal),
          child: child,
        )
    );
  }
}
