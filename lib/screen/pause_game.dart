import 'package:flutter/material.dart';
import '../main.dart';

class PauseGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                  'Game paused..',
                  style: TextStyle(fontFamily: 'Pacifico', color: Colors.blue[300], fontSize: 20),
              )
            ],
          )
      )
    );
  }
}
