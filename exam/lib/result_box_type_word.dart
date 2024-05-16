import 'package:flutter/material.dart';
import 'package:exam/constant.dart';

class ResultBox extends StatelessWidget {
  final int questionLength;
  final VoidCallback isPressed;
  ResultBox({super.key, required this.questionLength, required this.isPressed});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color.fromARGB(255, 3, 84, 151),
      content: Padding(
        padding: EdgeInsets.all(70),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Result',
              style: TextStyle(color: neutral, fontSize: 22),
            ),
            SizedBox(
              height: 20,
            ),
            CircleAvatar(
                child: Text(
                  'Done',
                  style: TextStyle(fontSize: 30),
                ),
                radius: 70.0,
                backgroundColor: Colors.blue),
            SizedBox(
              height: 25,
            ),
            GestureDetector(
              onTap: isPressed,
              child: Text(
                'Start over',
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}
