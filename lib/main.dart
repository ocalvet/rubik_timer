import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math' as m;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rubik Crazy Timer',
      theme: ThemeData.dark(),
      home: MyHomePage(title: 'Rubik Crazy Timer'),
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
  int m100s = 0;
  // Stopwatch sw;
  @override
  void initState() {
    // sw = Stopwatch();
    timer = Timer(Duration(milliseconds: 100), () {
      print('Timer...');
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
      ),
      body: GestureDetector(
        onTap: () {
          print('Start timer');
          timer.cancel();
          timer = Timer.periodic(Duration(milliseconds: 100), (t) {
            setState(() {
              m100s++;
            });
          });
        },
        child: Container(
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
                  style: Theme.of(context)
                      .textTheme
                      .display1
                      .copyWith(fontSize: 80),
                ),
              ),
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

  _reset() {
    print('To Reset');
    setState(() {
      m100s = 0;
      timer.cancel();
    });
  }
}
