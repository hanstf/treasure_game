import 'background.dart';
import 'dart:ui';
import 'package:flame/components/component.dart';
import 'package:flutter/material.dart';

class Treasure extends SpriteComponent {
  static double treasureSize = 25;
  static double glassSize = Background.glassSize;
  static double yGap = Background.yGap;

  double treasurePosition;
  String treasureSrc;

  Offset touchPosition;

  Treasure(this.treasurePosition, this.treasureSrc) : super.square(treasureSize, treasureSrc);

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
      path.moveTo(touchPosition.dx, touchPosition.dy - yGap);
      path.relativeLineTo(0, -glassSize);
      path.relativeLineTo(-glassSize, 0);
      path.relativeLineTo(0, glassSize);
      path.close();
      canvas.clipPath(path);
      prepareCanvas(canvas);
      sprite.render(canvas, width, height);
    }
  }

  bool isCaptured(Offset position) {
    return this.toRect().contains(position);
  }
}
