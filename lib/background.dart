import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flame/components/component.dart';
import 'package:flame/sprite.dart';

class Background extends SpriteComponent {
  // change the ratio or y-gap only to change the size
  static double glassRatio = 1.75;
  static double yGap = 25;

  static double defaultGlassSize = 100;
  static double glassSize = defaultGlassSize / glassRatio;

  Size size;

  Background(String bg)
      : super.fromSprite(
            glassSize,
            glassSize,
            Sprite(bg,
                x: 0, y: glassSize, width: glassSize, height: glassSize));

  void followTouch(Offset position) {
    if (this.sprite.loaded() == true && this.size != null) {
      num ratioX =
          this.sprite.image.width * (position.dx - glassSize) / this.size?.width;
      num ratioY =
          this.sprite.image.height * (position.dy - glassSize) / this.size?.height;
      num ratioWidth = this.sprite.image.width * glassSize / this.size?.width;
      num ratioHeight = this.sprite.image.height * glassSize / this.size?.height;
      this.sprite.src = new Rect.fromLTWH(ratioX, ratioY, ratioWidth, ratioHeight);
      this.x = position.dx - glassSize;
      this.y = position.dy - glassSize - yGap;
    }
  }

  @override
  void resize(Size _size) {
    this.size = _size;
  }

  @override
  render(Canvas canvas) {
    final path = Path();
    path.moveTo(0.0, yGap * -1);
    path.moveTo(15 / glassRatio, 0.0);
    path.lineTo(85 / glassRatio, 0.0);
    path.relativeLineTo(0, 15 / glassRatio);
    path.relativeQuadraticBezierTo(
        15 / glassRatio, 15 / glassRatio, 15 / glassRatio, 15 / glassRatio);
    path.relativeLineTo(0, 60 / glassRatio);
    path.relativeQuadraticBezierTo(
        -20 / glassRatio, 15 / glassRatio, -20 / glassRatio, 15 / glassRatio);
    path.lineTo(20 / glassRatio, 100 / glassRatio);
    path.relativeQuadraticBezierTo(
        -10 / glassRatio, 10 / glassRatio, -20 / glassRatio, -15 / glassRatio);
    path.lineTo(2 / glassRatio, 30 / glassRatio);
    path.relativeQuadraticBezierTo(
        10 / glassRatio, -7.5 / glassRatio, 15 / glassRatio, -15 / glassRatio);
    path.close();
    prepareCanvas(canvas);
    canvas.clipPath(path);
    sprite.render(canvas, width, height);
  }
}
