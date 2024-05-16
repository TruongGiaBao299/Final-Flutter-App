import 'package:flutter/material.dart';

class TypingWordQuestion extends StatelessWidget {
  final int indexAction;
  final int totalQuestion;
  final String givenTitle;
  final String hiddenWord;
  TypingWordQuestion(
      {super.key,
      required this.indexAction,
      required this.givenTitle,
      required this.hiddenWord,
      required this.totalQuestion});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(padding: EdgeInsets.only(top: 100)),
        Text('${indexAction + 1}/${totalQuestion}'),
        SizedBox(
          height: 12,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${givenTitle}',
              style: TextStyle(fontSize: 30),
            ),
          ],
        ),
        SizedBox(
          height: 25,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Complete the word: ${hiddenWord}',
              style: TextStyle(fontSize: 20),
            )
          ],
        ),
      ],
    );
  }
}
