import 'package:flutter/material.dart';
import 'package:exam/constant.dart';

class OptionCard extends StatelessWidget {
  final String option;
  final Color color;
  OptionCard({super.key, required this.option, required this.color});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      child: ListTile(
        title: Text(
          option,
          style: TextStyle(
              fontSize: 22,
              color: color.red != color.green ? neutral : Colors.black),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
