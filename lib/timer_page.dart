import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rubik_timer/CountDown.dart';
import 'package:rubik_timer/constants.dart';
import 'package:rubik_timer/counter.dart';
import 'package:rubik_timer/credits.dart';
import 'package:rubik_timer/scramble_moves.dart';
import 'package:rubik_timer/scrambler.dart';
import 'package:vibrate/vibrate.dart';

class TimerPage extends StatefulWidget {
  TimerPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  Timer timer;
  Timer countDownTimer;
  int m100s = 0;
  int countDown = 15;
  Color textColor = Colors.white70;
  Color backgroundColor = Colors.black38;
  String countDownSeconds = '15';
  List<String> scrambledMoves = scrambleRubikMoves(25);

  @override
  void initState() {
    timer = Timer(Duration(milliseconds: 100), () {});
    countDownTimer = Timer(Duration(seconds: 1), () {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: GestureDetector(
        onLongPress: _start,
        onTap: _stop,
        child: Container(
          color: backgroundColor,
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: <Widget>[
              ScrambleMoves(scrambledMoves: scrambledMoves),
              Credits(),
              Counter(
                total100milliseconds: m100s,
              ),
              CountDown(
                textColor: textColor,
                countDown: countDown,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _reset();
          _generateNewScramble();
        },
        tooltip: 'Reset',
        child: Icon(Icons.refresh),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  _start() async {
    bool canVibrate = await Vibrate.canVibrate;
    if (canVibrate) Vibrate.vibrate();
    _reset();
    _countDown();
  }

  _stop() {
    timer.cancel();
  }

  _countDown() {
    countDownTimer = Timer.periodic(Duration(seconds: 1), (t) {
      setState(() {
        countDown--;
        if (countDown <= 8) {
          textColor = Colors.black;
          backgroundColor = Colors.redAccent[700];
        }
        if (countDown == 0) {
          backgroundColor = Colors.greenAccent[700];
        }
      });
      if (countDown == 0) {
        countDownTimer.cancel();
        timer.cancel();
        timer = Timer.periodic(Duration(milliseconds: 100), (t) {
          setState(() {
            m100s++;
          });
        });
      }
    });
  }

  _generateNewScramble() {
    this.setState(() {
      scrambledMoves = scrambleRubikMoves(25);
    });
  }

  _reset() {
    setState(() {
      m100s = 0;
      countDown = int.parse(countDownSeconds);
      textColor = Colors.white70;
      backgroundColor = Colors.black38;
      timer.cancel();
      countDownTimer.cancel();
    });
  }

  _appBar() {
    return AppBar(
      title: Text(widget.title),
      actions: <Widget>[
        DropdownButton<String>(
          items: COUNTDOWN_OPTIONS.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          value: countDownSeconds,
          onChanged: (v) {
            setState(() {
              countDownSeconds = v;
              countDown = int.parse(countDownSeconds);
            });
          },
        )
      ],
    );
  }
}
