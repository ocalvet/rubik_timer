import 'package:flutter/material.dart';

class CountDown extends StatelessWidget {
  final int countDown;
  final Color textColor;
  const CountDown({Key key, this.countDown, this.textColor}) : super(key: key);
  @override
  Widget build(BuildContext context) {
   return Positioned(
      right: 20,
      top: 20,
      child: Text(
        '${countDown}s',
        style: TextStyle(
          color: textColor,
          fontSize: 48.0,
          letterSpacing: 2,
          fontFamily: 'Orbitron',
        ),
      ),
    );
  }
}
