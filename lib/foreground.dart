import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flame/components/component.dart';

class Foreground extends PositionComponent {
  Color color = Colors.blue[400];

  Foreground(this.color);

  @override
  void resize(Size size) {
    this.width = size.width;
    this.height = size.height;
  }

  @override
  void render(Canvas c) {
    c.drawColor(this.color, BlendMode.dstATop);
  }

  @override
  void update(double t) {
  }
}