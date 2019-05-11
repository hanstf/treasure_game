import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lamaran/bloc/AppBloc.dart';
import 'package:lamaran/event/App/StartButtonPressed.dart';

class MainMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Welcome to hidden treasure game !',
                  style: TextStyle(fontFamily: 'Pacifico', color: Colors.blue[300], fontSize: 20),
                ),
                RaisedButton(
                  child: Text('go!!'),
                  onPressed: () {
                    BlocProvider.of<AppBloc>(context).dispatch(StartButtonPressed());
                  },
                )
              ],
            )
        ));
  }
}
