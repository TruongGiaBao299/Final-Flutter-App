import 'package:flutter/material.dart';
import 'typing_word_question_widget.dart';
import 'typing_word_question_model.dart';
import 'package:exam/result_box_type_word.dart';

class TypeWordScreen extends StatefulWidget {
  const TypeWordScreen({super.key});

  @override
  State<TypeWordScreen> createState() => _TypeWordScreenState();
}

class _TypeWordScreenState extends State<TypeWordScreen> {
  TextEditingController userEntry = TextEditingController();

  List<typeQuestion> _questions = [
    typeQuestion(
        id: '1',
        givenTitle: 'GÀ RÁN',
        titleAnswer: 'Fried Chicken',
        hiddenWord: 'Fr___ Chi___'),
    typeQuestion(
        id: '2', givenTitle: 'CÁ', titleAnswer: 'Fish', hiddenWord: 'F____')
  ];

  int index = 0;

  void updateUserEntry(String value) {
    setState(() {
      userEntry.text = value;
    });
  }

  void startOver() {
    setState(() {
      index = 0;
      userEntry.clear();
      Navigator.pop(context);
    });
  }

  void nextQuestion() {
    setState(() {
      index++;
      userEntry.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fill in the blank'),
      ),
      body: Container(
        child: Column(
          children: [
            TypingWordQuestion(
                indexAction: index,
                givenTitle: _questions[index].givenTitle,
                hiddenWord: _questions[index].hiddenWord,
                totalQuestion: _questions.length),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: userEntry,
                onChanged: updateUserEntry,
                decoration: InputDecoration(
                  labelText: 'Your Answer',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            ElevatedButton(
                onPressed: (userEntry.text == _questions[index].titleAnswer)
                    ? (index == _questions.length - 1)
                        ? () {
                            showDialog(
                                context: context,
                                builder: (ctx) => ResultBox(
                                    questionLength: _questions.length,
                                    isPressed: startOver));
                          }
                        : () {
                            showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: Text('Congratulations!'),
                                content:
                                    Text('You completed the word correctly.'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      nextQuestion();
                                      Navigator.of(ctx).pop();
                                    },
                                    child: Text('Next question'),
                                  ),
                                ],
                              ),
                            );
                          }
                    : () {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: Text('Wrong!!!'),
                            content: Text('Try your best again'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(ctx).pop();
                                },
                                child: Text('OK'),
                              ),
                            ],
                          ),
                        );
                      },
                child: Text('Submit'))
          ],
        ),
      ),
    );
  }
}
