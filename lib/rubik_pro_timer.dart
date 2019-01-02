import 'package:flutter/material.dart';
import 'package:rubik_timer/timer_page.dart';

class RubikProTimer extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final String appTitle = 'Rubik Pro Timer';
    return MaterialApp(
      title: appTitle,
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: TimerPage(title: appTitle),
    );
  }
}
