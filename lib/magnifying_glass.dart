import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flame/components/component.dart';
import 'package:lamaran/background.dart';
import './treasure.dart';

class MagnifyingGlass extends SpriteComponent {
  static double glassSize = Background.glassSize;
  static double yGap = Background.yGap;

  MagnifyingGlass(): super.square(glassSize, 'magnifying_glass.png');

  void followTouch(Offset position) {
    if (this.sprite.loaded() == true) {
      this.x = position.dx - glassSize;
      this.y = position.dy - glassSize - yGap;
    }
  }

  bool isTreasureFound(Treasure treasure) {
    if (treasure.x > 0 && treasure.y > 0) {
      return this.toRect().contains(new Offset(treasure.x, treasure.y));
    }
    return false;
  }
}