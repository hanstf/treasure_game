import 'package:flame/components/component.dart';
import '../main.dart';
import '../treasure_game.dart';

abstract class Pauseable {
  factory Pauseable._() => null;
  void updateOnPause(SpriteComponent component, double defaultSize) {
    if (Main.game.status == TreasureGame.PAUSED_STATE) {
      component.width = 0;
      component.height = 0;
    } else if (Main.game.status == TreasureGame.PLAYED_STATE) {
      component.width = defaultSize;
      component.height = defaultSize;
    }
  }
}