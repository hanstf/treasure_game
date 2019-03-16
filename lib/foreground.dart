import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flame/components/component.dart';

class Foreground extends PositionComponent {

  @override
  void resize(Size size) {
    this.width = size.width;
    this.height = size.height;
  }

  @override
  void render(Canvas c) {
    c.drawColor(Colors.blue[400], BlendMode.dstATop);
  }

  @override
  void update(double t) {
  }
}