import 'dart:math';
import 'package:flutter/material.dart';

class DiceRoller extends StatefulWidget {
  const DiceRoller({super.key});

  @override
  State<DiceRoller> createState() => _DiceRollerState();
}

class _DiceRollerState extends State<DiceRoller> {
  int diceNumber = 1;
  Alignment _alignment = Alignment.center;

  void rollDice() {
    setState(() {
      // Generate a random dice number between 1 and 6.
      diceNumber = Random().nextInt(6) + 1;
      // Randomly choose an alignment: left or right.
      _alignment = Random().nextBool() ? Alignment.centerLeft : Alignment.centerRight;
    });
    print("Dice rolled to $diceNumber");

    // Return the dice image to the center after a short delay.
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        _alignment = Alignment.center;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // AnimatedAlign animates the alignment of the dice image.
        AnimatedAlign(
          alignment: _alignment,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: Image.asset('images/dice-$diceNumber.png', width: 200),
        ),
        const SizedBox(height: 5),
        OutlinedButton(
          onPressed: rollDice,
          child: const Text(
            "Roll Dice",
            style: TextStyle(fontSize: 20, color: Colors.amber),
          ),
        ),
      ],
    );
  }
}