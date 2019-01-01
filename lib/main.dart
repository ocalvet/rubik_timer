import 'package:flutter/material.dart';
import 'package:vibrate/vibrate.dart';
import 'dart:async';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rubik Crazy Timer',
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
            items: <String>['5', '10', '15', '20', '25', '30'].map((String value) {
              return new DropdownMenuItem<String>(
                value: value,
                child: new Text(value),
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
        if (countDown == 8) {
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
      timer.cancel();
      countDownTimer.cancel();
    });
  }
}
