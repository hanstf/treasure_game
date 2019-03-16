import 'package:flutter/material.dart';
import '../main.dart';

class StartGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Main.game?.widget
    );
  }
}
