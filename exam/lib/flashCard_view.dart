import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

class FlashCardView extends StatelessWidget {
  final String text;

  FlashCardView({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 50),
        ),
      ),
    );
  }
}
