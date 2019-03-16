import 'package:flutter/material.dart';
import '../main.dart';

class MainMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                  'Welcome to hidden treasure game !',
                  style: TextStyle(fontFamily: 'Pacifico', color: Colors.blue[300], fontSize: 20),
              ),
              RaisedButton(
                child: Text('go!!'),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Main.game?.widget)
                  );
                },
              )
            ],
          )
      )
    );
  }
}
