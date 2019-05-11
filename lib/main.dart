import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lamaran/bloc/AppBloc.dart';
import 'package:sensors/sensors.dart';
import 'package:lamaran/state/App/AppCompleted.dart';
import 'package:lamaran/state/App/AppStarted.dart';
import 'package:lamaran/state/App/AppStopped.dart';
import 'package:lamaran/treasure_game.dart';
import 'package:flutter/gestures.dart';
import 'package:flame/flame.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lamaran/screen/main_menu.dart';
import 'package:permission/permission.dart';


void main() async {
  await Permission.getPermissionsStatus([PermissionName.Sensors, PermissionName.Camera]);
  await Permission.requestPermissions([PermissionName.Sensors, PermissionName.Camera]);
  Permission.openSettings;
  AppBloc bloc = AppBloc();
  TreasureGame game = TreasureGame(bloc);
  Flame.audio.disableLog();
  Flame.images.loadAll([
    'bg.jpg',
    'fg.png',
    'magnifying_glass.png',
    'bus.png',
    'polaroid.png',
    'flower.png',
    'btn_next_level.png',
    'bear_head.png',
    'bear_body.png'
  ]);
  Flame.audio.loadAll([
    'level_1.mp3',
    'level_2.mp3',
    'level_3.mp3',
    'before_game.mp3',
    'during_game.mp3',
    'end_game.mp3',
    'level_end.mp3'
  ]);
  runApp(new MyApp(game, bloc));
  PanGestureRecognizer panRecognizer = new PanGestureRecognizer()
    ..onUpdate = (DragUpdateDetails evt) => game.handlePan(evt, true);
  TapGestureRecognizer tapRecognizer = new TapGestureRecognizer()
    ..onTapDown = (TapDownDetails evt) => game.handleTap(evt);
  gyroscopeEvents.listen((GyroscopeEvent evt) {
    print('move');
    print(evt.toString());
  });
//  accelerometerEvents.listen((AccelerometerEvent evt) {
//    print('tilt');
//    print(evt.toString());
//  });
  Flame.util.addGestureRecognizer(panRecognizer);
  Flame.util.addGestureRecognizer(tapRecognizer);
  SystemChrome.setEnabledSystemUIOverlays([]);
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
                      game.initiateMainMenu();
                      return Scaffold(body: MainMenu());
                    } else if (state is AppStarted) {
                      game.initiateGameStart(state.level, state);
                      return Scaffold(body: game.widget);
                    } else if (state is AppCompleted) {
                      game.initiateEnd();
                      return Scaffold(body: game.widget);
                    }
                  }()));
        });
  }
}
