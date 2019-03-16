import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flame/components/component.dart';
import 'package:lamaran/background.dart';
import './treasure.dart';
import './banner_story.dart';
import './main.dart';
import './mixins/pauseable.dart';

class MagnifyingGlass extends SpriteComponent with Pauseable {
  static double glassSize = Background.glassSize;

  bool treasureFound = false;
  double treasureFoundTime = 0;
  BannerStory bannerStory;

  MagnifyingGlass(): super.square(glassSize, 'magnifying_glass.png');

  void followTouch(Offset position) {
    if (this.sprite.loaded() == true) {
      this.x = position.dx - glassSize;
      this.y = position.dy - glassSize;
    }
  }

  void reset() {
    treasureFound = false;
    treasureFoundTime = 0;
  }

  void isTreasureFound(Treasure treasure) {
    treasureFound = this.toRect().contains(new Offset(treasure.x, treasure.y));
  }

  @override
  void update(double t) {
    if (bannerStory == null) {
      if (treasureFound) {
        treasureFoundTime += 1;
      } else {
        treasureFoundTime = 0;
      }
    } else {
      treasureFoundTime += 1;
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    updateOnPause(this, glassSize);
    if (treasureFoundTime > 200) {
      if (bannerStory != null) {
        bannerStory.removeMe();
        bannerStory = null;
        Main.game.nextLevel();
      } else {
        bannerStory = new BannerStory();
        Main.game.add(bannerStory);
        reset();
        Main.game.pause();
      }
    }
  }
}