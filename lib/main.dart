import 'package:flutter/material.dart';
import 'package:lamaran/treasure_game.dart';
import 'package:flutter/gestures.dart';
import 'package:flame/flame.dart';
import 'package:lamaran/screen/main_menu.dart';

class Main {
  static TreasureGame game;
}

void main() async {
  Flame.audio.disableLog();
  Main.game = TreasureGame([
    new Level(1, 10.0),
    new Level(2, 30.0),
    new Level(3, 130.0)
  ]);

  Flame.images.loadAll(['bg.jpg', 'fg.png', 'magnifying_glass.png', 'treasure.png']);

  runApp(new MyApp());

  Flame.util.addGestureRecognizer(new PanGestureRecognizer()..onUpdate = (DragUpdateDetails evt) => Main.game.handleInput(evt, false));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Treasure Game!!',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MainMenu()
    );
  }
}
