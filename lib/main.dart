import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rubik_timer/rubik_pro_timer.dart';

void main() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp
  ]);
  runApp(RubikProTimer());
}
