import 'dart:math' as math;
import 'package:flame/components/component.dart';
import 'package:flame/palette.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart';

class BearHead extends SpriteComponent {

  BearHead()
      : super.rectangle(100, 100, 'bear_head.png');


  Size screen;
  double radian = 0;

  @override
  void resize(Size size) {
    this.screen = size;
    this.x = ((this.screen.width) / 2);
    this.y = ((this.screen.height) / 2) + 55;
  }

  void followTouch(Offset position) {
    if (this.sprite.loaded() == true) {
      double midWidth = this.screen.width / 2;
      double midHeight = this.screen.height / 2;
      double heightDiff = (midHeight - position.dy);
      double widthDiff = (position.dx - midWidth);
      double rad = math.atan(heightDiff / widthDiff);
      double deg = rad * 180.0 / math.pi;
      if ((midWidth - position.dx) > 0) {
        deg = 270 - deg;
      } else {
        deg = 90 - deg;
      }
      if ((midHeight - position.dy) > 0) {
        this.radian = radians(deg);
      }
    }
  }

  @override
  render(Canvas canvas) {
    canvas.translate(this.x, this.y);
    canvas.rotate(this.radian);
    sprite.renderRect(canvas, new Rect.fromLTWH(-width/2, -height, width, height));
  }
}
