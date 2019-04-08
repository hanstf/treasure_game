import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:lamaran/banner_story.dart';
import 'package:lamaran/bloc/AppBloc.dart';
import 'package:lamaran/event/App/NextLevelButtonPressed.dart';
import 'package:lamaran/event/App/TreasureFound.dart';
import 'package:lamaran/foreground.dart';
import 'package:lamaran/background.dart';
import 'package:lamaran/magnifying_glass.dart';
import 'package:lamaran/model/Level.dart';
import 'package:lamaran/data/states.dart';
import 'package:lamaran/state/App/AppStarted.dart';
import 'package:lamaran/treasure.dart';

class TreasureGame extends BaseGame {
  Level level;

  BannerStory bannerStory;
  Background background;
  Foreground foreground;
  MagnifyingGlass magnifyingGlass;
  Treasure treasure;

  AppBloc bloc;

  TreasureGame(this.bloc);

  void initiate(Level _level, AppStarted _state) {
    this.destroyAllComponents();

    foreground = new Foreground(_level.foreGroundColor);
    add(foreground);

    if (_state.status == GameState.STARTED) {
      background = new Background(_level.backgroundImage);
      add(background);
      treasure = new Treasure(_level.position, _level.treasureImage);
      add(treasure);
      magnifyingGlass = new MagnifyingGlass();
      add(magnifyingGlass);
    }

    if (_state.isBannerShown) {
      bannerStory = new BannerStory(_level.winningText);
      add(bannerStory);
    }

  }

  void destroyAllComponents() {
    components.removeWhere((_) => true);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
  }

  @override
  void resize(Size size) {
    super.resize(size);
  }

  @override
  void update(double t) {
    super.update(t);
  }

  void handlePan(DragUpdateDetails evt, bool begin) {
    if (this.bloc == null) {
      return;
    }
    if (this.bloc.currentState is AppStarted &&
        (this.bloc.currentState as AppStarted).status == GameState.STARTED) {
      background.followTouch(evt.globalPosition);
      magnifyingGlass.followTouch(evt.globalPosition);
      treasure.followTouch(evt.globalPosition);
    }
  }

  void handleTap(TapDownDetails evt) {
    if (this.bloc == null) {
      return;
    }
    print(evt);
    if (this.bloc.currentState is AppStarted) {
      if ((this.bloc.currentState as AppStarted).isBannerShown == false) {
        if (treasure.isCaptured(evt.globalPosition) && magnifyingGlass.isTreasureFound(treasure)) {
          this.bloc.dispatch(TreasureFound());
        }
      } else {
        if (bannerStory.isNextButtonPressed(evt.globalPosition)) {
          this.bloc.dispatch(NextLevelButtonPressed());
        }
      }
    }
  }
}
