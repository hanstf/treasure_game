import 'package:flutter/material.dart';
import 'package:lamaran/banner_story.dart';
import 'package:lamaran/bloc/AppBloc.dart';
import 'package:lamaran/data/states.dart';
import 'package:lamaran/state/App/AppStarted.dart';
import 'package:lamaran/state/App/AppStopped.dart';
import 'package:lamaran/treasure_game.dart';
import 'package:flutter/gestures.dart';
import 'package:flame/flame.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lamaran/screen/main_menu.dart';

void main() async {
  AppBloc bloc = AppBloc();
  TreasureGame game = TreasureGame(bloc);
  Flame.audio.disableLog();
  Flame.images.loadAll([
    'bg.jpg',
    'fg.png',
    'magnifying_glass.png',
    'treasure.png',
    'polaroid.png',
    'flower.png',
    'btn_next_level.png'
  ]);
  runApp(new MyApp(game, bloc));
  PanGestureRecognizer panRecognizer = new PanGestureRecognizer()
    ..onUpdate = (DragUpdateDetails evt) => game.handlePan(evt, true);
  TapGestureRecognizer tapRecognizer = new TapGestureRecognizer()
    ..onTapDown = (TapDownDetails evt) => game.handleTap(evt);
  Flame.util.addGestureRecognizer(tapRecognizer);
  Flame.util.addGestureRecognizer(panRecognizer);
}

class MyApp extends StatelessWidget {
  AppBloc bloc;
  TreasureGame game;

  MyApp(this.game, this.bloc);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: bloc,
        builder: (context, state) {
          return BlocProvider<AppBloc>(
              bloc: bloc,
              child: MaterialApp(
                  title: 'Treasure Game!!',
                  theme: ThemeData(
                    primarySwatch: Colors.blue,
                  ),
                  home: () {
                    if (state is AppStopped) {
                      print('in AppStopped');
                      return MainMenu();
                    } else if (state is AppStarted) {
                      game.initiate(state.level, state);
                      return game.widget;
                    }
                  }()));
        });
  }
}
