import 'package:box2d_flame/box2d.dart';
import 'package:flame/components/component.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as Ui;
import 'package:flame/position.dart' as FlamePosition;

class BannerStory extends SpriteComponent {
  static double bannerSize = 200;
  static int mod = 7;

  Ui.ParagraphBuilder paragraph = new Ui.ParagraphBuilder(
      new Ui.ParagraphStyle(textAlign: TextAlign.justify));
  Sprite btn = new Sprite('btn_next_level.png');

  String text;
  int timer = 0;
  int i = 1;

  BannerStory(this.text)
      : super.rectangle(bannerSize, bannerSize * 2, 'banner.png');

  @override
  void resize(Size size) {
    this.x = (size.width - bannerSize) / 2;
    this.y = (size.height - bannerSize) / 4;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    if (this.i == 0) {
      Ui.TextStyle textStyle =
          new Ui.TextStyle(color: Colors.black54, fontSize: 12.0);
      paragraph.pushStyle(textStyle);
    }

    paragraph.addText(this.text.substring(0, this.i));

    Ui.Paragraph p = paragraph.build()
      ..layout(new Ui.ParagraphConstraints(width: 160.0));
    canvas.drawParagraph(
        p,
        new Offset(
            this.width - bannerSize + 20, this.height - (bannerSize * 1.75)));

    if (this.i < this.text.length && this.timer % 2 == 0) {
      this.i++;
    }

    if (this.btn.loaded()) {
      btn.renderScaled(
          canvas, new FlamePosition.Position(0, this.y * 3.5), 0.15);
    }

    this.timer++;
  }

  bool isNextButtonPressed(Offset position) {
    if (this.btn == null) {
      return false;
    }
    return new Rect.fromLTWH(this.x, this.y + (this.y * 3.5), btn.size.times(0.15).x, btn.size.times(0.15).y).contains(position);
  }
}
