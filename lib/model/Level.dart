import 'dart:ui';

class Level {
  int levelNo;
  double position;
  String treasureImage;
  String winningText;
  String backgroundImage;
  Color foreGroundColor;

  Level(this.levelNo, this.position, this.treasureImage, this.winningText, this.backgroundImage, this.foreGroundColor);

  @override
  String toString() {
    return '${this.levelNo.toString()} ${this.position.toString()} ${this.treasureImage} ${this.winningText}';
  }
}