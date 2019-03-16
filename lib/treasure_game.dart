import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:lamaran/foreground.dart';
import 'package:lamaran/background.dart';
import 'package:lamaran/magnifying_glass.dart';
import 'package:lamaran/screen/main_menu.dart';
import 'package:lamaran/treasure.dart';

class Level {
  int levelNo;
  double position;
  Level(this.levelNo, this.position);
}

class TreasureGame extends BaseGame {
  static const String PAUSED_STATE = 'PAUSED';
  static const String PLAYED_STATE = 'STARTED';


  String status = PAUSED_STATE;

  Background background;
  Foreground foreground;
  MagnifyingGlass magnifyingGlass;
  Treasure treasure;

  bool isRendered = false;
  List<Level> levels;
  int currentLevel = 0;

  TreasureGame(this.levels) {
    background = new Background();
    foreground = new Foreground();
    magnifyingGlass = new MagnifyingGlass();
    treasure = new Treasure(this.levels[this.currentLevel].position);

    add(foreground);
    add(background); //masked
    add(treasure);
    add(magnifyingGlass);

    handleInput(new DragUpdateDetails(globalPosition: new Offset(0, 0)), true);

    play();
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
  }

  /// Set game state to pause so that
  /// All components that implement [Pausable] can minimize itself
  void pause() {
    status = PAUSED_STATE;
  }

  /// Set game state to play so that
  /// All components that implement [Pausable] can maximize itself
  void play() {
    status = PLAYED_STATE;
  }

  void handleInput(DragUpdateDetails evt, bool begin) {
    background.followTouch(evt.globalPosition);
    magnifyingGlass.followTouch(evt.globalPosition);
    treasure.followTouch(evt.globalPosition);
    if (!begin) {
      magnifyingGlass.isTreasureFound(treasure);
    }
  }

  void nextLevel() {
    if (levels.length - 1 == currentLevel) {
      return;
    }
    play();
    currentLevel++;
    treasure.move(this.levels[this.currentLevel].position);
  }
}