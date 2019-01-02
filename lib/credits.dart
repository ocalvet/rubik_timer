import 'package:flutter/material.dart';

class Credits extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   return Positioned(
      left: 20,
      bottom: 30,
      child: Text(
        'By: Ovidio R. Calvet',
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}