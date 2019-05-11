import 'package:flame/components/component.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as Ui;

class BearBody extends SpriteComponent {
  Ui.ParagraphBuilder paragraph = new Ui.ParagraphBuilder(
      new Ui.ParagraphStyle(textAlign: TextAlign.center));

  BearBody()
      : super.rectangle(100, 100, 'bear_body.png');

  Size screen;

  @override
  void resize(Size size) {
    this.screen = size;
    this.x = ((this.screen.width) / 2) - 50;
    this.y = ((this.screen.height) / 2) + 45;
  }

  @override
  render(Canvas canvas) {
    prepareCanvas(canvas);
    sprite.render(canvas, width, height);
    paragraph = new Ui.ParagraphBuilder(
        new Ui.ParagraphStyle(textAlign: TextAlign.center));
    Ui.TextStyle textStyle = new Ui.TextStyle(color: Colors.black54, fontSize: 20.0);
    paragraph.pushStyle(textStyle);
    paragraph.addText("Please look back, I have question for you");
    canvas.drawParagraph(
        paragraph.build()..layout(new Ui.ParagraphConstraints(width: 200.0)),
        new Offset(-50, -200));
  }
}
