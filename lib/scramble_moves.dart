import 'package:flutter/material.dart';

class ScrambleMoves extends StatelessWidget {
  final List<String> scrambledMoves;
  ScrambleMoves({this.scrambledMoves,});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      top: -350,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              scrambledMoves.getRange(0, 12).reduce((a, b) => a + "  " + b),
              style: TextStyle(fontSize: 19),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              scrambledMoves
                  .getRange(13, scrambledMoves.length)
                  .reduce((a, b) => a + "  " + b),
              style: TextStyle(fontSize: 19),
            ),
          ],
        ),
      ),
    );
  }
}
