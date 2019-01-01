import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vibrate/vibrate.dart';
import 'dart:async';

const List<String> MOVE_TYPES = ["R", "L", "U", "D", "B", "F"];
const List<String> MOVE_TYPES_OPTIONS = ["", "'", "2"];

void main() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp
  ]);
  runApp(MyApp());
}

List<String> scrambleRubikMoves(int totalMoves) {
  List<String> result = List<String>();
  int randTypeIdx = 0;
  int randTypeOptionIdx = 0;
  String move;
  Random rnd = Random();
  for (int i = 0; i < totalMoves; i++) {
    do {
      randTypeIdx = rnd.nextInt(MOVE_TYPES.length);
      randTypeOptionIdx = rnd.nextInt(MOVE_TYPES_OPTIONS.length);
      move = MOVE_TYPES[randTypeIdx] + MOVE_TYPES_OPTIONS[randTypeOptionIdx];
    } while (i > 0 && move[0].compareTo(result[i - 1][0]) == 0);
    result.add(move);
  }
  return result;
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rubik Pro Timer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: MyHomePage(title: 'Rubik Pro Timer'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Timer timer;
  Timer countDownTimer;
  int m100s = 0;
  int countDown = 15;
  Color textColor = Colors.white70;
  Color backgroundColor = Colors.black38;
  String countDownSeconds = '15';
  List<String> scrambledMoves = scrambleRubikMoves(25);
  // Stopwatch sw;
  @override
  void initState() {
    timer = Timer(Duration(milliseconds: 100), () {
      print('Timer');
    });
    countDownTimer = Timer(Duration(seconds: 1), () {
      print('CountDown');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int seconds = (m100s / 10).floor();
    int ms = m100s % 10;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          DropdownButton<String>(
            items:
                <String>['5', '10', '15', '20', '25', '30'].map((String value) {
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
      ),
      body: GestureDetector(
        onLongPress: () async {
          bool canVibrate = await Vibrate.canVibrate;
          if (canVibrate) Vibrate.vibrate();
          _reset();
          _startCountDown();
        },
        onTap: () {
          print('Start timer');
          timer.cancel();
        },
        child: Container(
          color: backgroundColor,
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                top: -350,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        scrambledMoves
                            .getRange(0, 12)
                            .reduce((a, b) => a + "  " + b),
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
              ),
              Positioned(
                left: 20,
                bottom: 30,
                child: Text(
                  'By: Ovidio R. Calvet',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Center(
                child: Text(
                  '$seconds.$ms',
                  style: Theme.of(context).textTheme.display1.copyWith(
                        fontSize: 110,
                        fontFamily: 'Orbitron',
                      ),
                ),
              ),
              Positioned(
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
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _reset,
        tooltip: 'Reset',
        child: Icon(Icons.refresh),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  _startCountDown() {
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

  _reset() {
    setState(() {
      m100s = 0;
      countDown = int.parse(countDownSeconds);
      textColor = Colors.white70;
      backgroundColor = Colors.black38;
      scrambledMoves = scrambleRubikMoves(25);
      timer.cancel();
      countDownTimer.cancel();
    });
  }
}
