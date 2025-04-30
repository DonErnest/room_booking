import 'package:flutter/material.dart';

class ScreenCanvas extends StatelessWidget {
  final List<Widget>? appBarActions;
  final Widget? bottomBar;
  final List<Widget> widgets;

  const ScreenCanvas({
    super.key,
    required this.widgets,
    this.appBarActions,
    this.bottomBar,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: bottomBar,
        appBar: AppBar(actions: appBarActions),
        body: Center(child: Column(children: widgets)),
      ),
    );
  }
}
