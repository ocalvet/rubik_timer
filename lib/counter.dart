import 'package:flutter/material.dart';

class Counter extends StatelessWidget {
  final int total100milliseconds;
  Counter({Key key, this.total100milliseconds}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    int totalSeconds = (total100milliseconds / 10).floor();
    int minutes = (totalSeconds / 60).floor();
    int seconds = totalSeconds % 60;
    int ms = total100milliseconds % 10;
    TextStyle textStyle = Theme.of(context).textTheme.display1.copyWith(
          fontSize: 85,
          fontFamily: 'Orbitron',
        );
    return Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          _displayValue(minutes),
          style: textStyle,
        ),
        Text(
          ':',
          style: textStyle,
        ),
        Text(
          _displayValue(seconds),
          style: textStyle,
        ),
        Text(
          '.',
          style: textStyle,
        ),
        Text(
          '$ms',
          style: textStyle,
        ),
      ],
    ));
  }

  String _displayValue(int v) {
    return v < 10 ? "0$v" : "$v";
  }
}
