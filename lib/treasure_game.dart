import 'package:audioplayers/audioplayers.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:lamaran/banner_story.dart';
import 'package:lamaran/bear_body.dart';
import 'package:lamaran/bear_head.dart';
import 'package:lamaran/bloc/AppBloc.dart';
import 'package:lamaran/event/App/NextLevelButtonPressed.dart';
import 'package:lamaran/event/App/TreasureFound.dart';
import 'package:lamaran/foreground.dart';
import 'package:lamaran/background.dart';
import 'package:lamaran/magnifying_glass.dart';
import 'package:lamaran/model/Audio.dart';
import 'package:lamaran/model/Level.dart';
import 'package:lamaran/data/states.dart';
import 'package:lamaran/state/App/AppCompleted.dart';
import 'package:lamaran/state/App/AppStarted.dart';
import 'package:lamaran/treasure.dart';
import 'package:sensors/sensors.dart';

class TreasureGame extends BaseGame {
  Level level;

  BannerStory bannerStory;
  Background background;
  Foreground foreground;
  MagnifyingGlass magnifyingGlass;
  Treasure treasure;

  Map<String, AudioPlayer> audios = {};

  BearHead bearHead;
  BearBody bearBody;

  AppBloc bloc;

  TreasureGame(this.bloc);

  void initiateGameStart(Level _level, AppStarted _state) {
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
      addAudio([
        new AudioToPlay('during_game.mp3', true, 1)
      ]);
    }

    if (_state.isBannerShown) {
      bannerStory = new BannerStory(_level.winningText);
      add(bannerStory);
      addAudio([
        new AudioToPlay('level_end.mp3', true, 0.5),
        new AudioToPlay('level_${_level.levelNo}.mp3', false, 1)
      ]);
    }

  }

  void initiateEnd() {
    addAudio([
      new AudioToPlay('end_game.mp3', true, 1)
    ]);
    this.destroyAllComponents();

    bearHead = new BearHead();
    add(bearHead);

    bearBody = new BearBody();
    add(bearBody);
  }

  void initiateMainMenu() {
    addAudio([
      new AudioToPlay('before_game.mp3', true, 1)
    ]);
  }

  void addAudio (List<AudioToPlay> audiosToPlay) async {
    AudioPlayer audio;

    for (int i = 0; i < audiosToPlay.length; i++) {
      AudioToPlay audioToPlay = audiosToPlay[i];
      if (!audios.containsKey(audioToPlay.filename)) {
        if (audioToPlay.isLooped) {
          audio = await Flame.audio.loop(audioToPlay.filename, volume: audioToPlay.volume);
        } else {
          audio = await Flame.audio.play(audioToPlay.filename, volume: audioToPlay.volume);
        }
        audios[audioToPlay.filename] = audio;
      } else {
        audio = audios[audioToPlay.filename];
        audio.resume();
      }
    }
    for (int i = 0; i < audios.keys.length; i++) {
      String key = audios.keys.toList()[i];
      bool isNotInAudioToPlayList = audiosToPlay.every((AudioToPlay audioToPlay) {
        if (audioToPlay.filename == key) {
          return false;
        }
        return true;
      });
      if (isNotInAudioToPlayList) {
        await audios[key].stop();
      }
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
    } else if (this.bloc.currentState is AppCompleted) {
      bearHead.followTouch(evt.globalPosition);
    }
  }

  void handleTap(TapDownDetails evt) {
    if (this.bloc == null) {
      return;
    }
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

  void handleGyroscopemeter(GyroscopeEvent evt) {
    print(evt);
  }
}
