import 'package:flutter/material.dart';
import 'package:exam/constant.dart';

class ResultBox extends StatelessWidget {
  final int result;
  final int questionLength;
  final VoidCallback isPressed;
  ResultBox({super.key, required this.result, required this.questionLength, required this.isPressed});

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
                  '$result/$questionLength',
                  style: TextStyle(fontSize: 30),
                ),
                radius: 70.0,
                backgroundColor: result == questionLength / 2
                    ? Colors.yellow
                    : result < questionLength / 2
                        ? incorrect
                        : correct),
            SizedBox(
              height: 20,
            ),
            Text(
              result == questionLength / 2
                  ? 'Almost There'
                  : result < questionLength / 2
                      ? 'Try again'
                      : 'Great!',
              style: TextStyle(color: neutral, fontSize: 20),
            ),
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
