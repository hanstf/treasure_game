import 'background.dart';
import 'dart:ui';
import 'package:flame/components/component.dart';
import 'package:flutter/material.dart';
import './mixins/pauseable.dart';

class Treasure extends SpriteComponent with Pauseable {
  static double treasureSize = 25;
  double treasurePosition;
  static double glassSize = Background.glassSize;

  Offset touchPosition;

  Treasure(this.treasurePosition) : super.square(treasureSize, 'treasure.png');

  void followTouch(Offset position) {
    this.touchPosition = position;
  }

  void move(double size) {
    treasurePosition = size;
    this.x = treasurePosition;
    this.y = treasurePosition;
  }

  @override
  void resize(Size size) {
    this.x = treasurePosition;
    this.y = treasurePosition;
  }

  @override
  void render(Canvas canvas) {
    if (this.touchPosition != null) {
      final path = Path();
      path.moveTo(touchPosition.dx, touchPosition.dy);
      path.relativeLineTo(0, -glassSize);
      path.relativeLineTo(-glassSize, 0);
      path.relativeLineTo(0, glassSize);
      path.close();
      canvas.clipPath(path);
      prepareCanvas(canvas);
      sprite.render(canvas, width, height);
      updateOnPause(this, treasureSize);
    }
  }
}
