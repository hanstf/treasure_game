import 'package:lamaran/data/states.dart';
import 'package:lamaran/state/App/AppState.dart';
import 'package:lamaran/model/Level.dart';
import 'package:lamaran/data/levels.dart' as levels;

class AppStarted extends AppState {
  final List<Level> _levels = levels.list;
  int _currentLevel = 0;
  GameState _status = GameState.STARTED;
  bool _isBannerShown = false;

  AppStarted(this._currentLevel, this._status, this._isBannerShown): super([_currentLevel, _status, _isBannerShown]);

  @override
  String toString() => 'AppStarted';

  int countLevels() {
    return this._levels.length;
  }

  Level get level {
    return this._levels[this._currentLevel];
  }

  int get levelNum {
    return this._currentLevel;
  }

  bool get isBannerShown {
    return this._isBannerShown;
  }

  GameState get status {
    return this._status;
  }

  bool isLastLevel() {
    return this._currentLevel >= this.countLevels() - 1;
  }

  int getNextLevel() {
    return this._currentLevel + 1;
  }
}