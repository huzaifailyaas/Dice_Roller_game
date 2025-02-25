

import 'package:flutter/material.dart';
import 'dice_roller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        textTheme: Theme.of(context).textTheme.apply(fontFamily: 'Garamond'),
      ),
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.cyan,
          centerTitle: true,
          title: const Text(
            "Home Screen",
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
        body: Center(
          child: DiceRoller(), // Using the DiceRoller widget here
        ),
      ),
    );
  }
}
