import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:lamaran/data/states.dart';
import 'package:lamaran/event/App/AppEvent.dart';
import 'package:lamaran/event/App/NextLevelButtonPressed.dart';
import 'package:lamaran/event/App/StartButtonPressed.dart';
import 'package:lamaran/event/App/StopButtonPressed.dart';
import 'package:lamaran/event/App/TreasureFound.dart';
import 'package:lamaran/state/App/AppStarted.dart';
import 'package:lamaran/state/App/AppState.dart';
import 'package:lamaran/state/App/AppStopped.dart';


class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc():super();

  @override
  AppState get initialState => AppStopped();

  @override
  Stream<AppState> mapEventToState(AppState currentState, AppEvent event) async* {
    if (event is StartButtonPressed) {
      yield AppStarted(0, GameState.STARTED, false);
    } else if (event is TreasureFound) {
      yield AppStarted((currentState as AppStarted).levelNum, GameState.PAUSED, true);
    } else if (event is NextLevelButtonPressed) {
      if ((currentState as AppStarted).isLastLevel()) {
        yield AppStopped();
      } else {
        yield AppStarted((currentState as AppStarted).getNextLevel(), GameState.STARTED, false);
      }
    } else if (event is StopButtonPressed) {
      yield AppStopped();
    }
  }

}