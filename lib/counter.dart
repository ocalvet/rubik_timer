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
    return Center(
      child: Text(
        '$minutes:$seconds.$ms',
        style: Theme.of(context).textTheme.display1.copyWith(
              fontSize: 110,
              fontFamily: 'Orbitron',
            ),
      ),
    );
  }
}
