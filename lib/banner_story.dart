import 'background.dart';
import 'dart:ui';
import 'package:flame/components/component.dart';
import 'package:flutter/material.dart';

class BannerStory extends SpriteComponent {
  static double bannerSize = 200;
  bool isRemoved = false;
  BannerStory() : super.square(bannerSize, 'banner.png');

  @override
  void resize(Size size) {
    this.x = (size.width - bannerSize) / 2;
    this.y = (size.height - bannerSize) / 2;;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
  }

  void removeMe() {
    isRemoved = true;
  }

  @override
  bool destroy() {
    return isRemoved;
  }
}
