import 'package:flutter/material.dart';
import 'typing_word_question_widget.dart';
import 'typing_word_question_model.dart';
import 'package:exam/result_box_type_word.dart';
import 'package:exam/db_connect.dart';

class TypeWordScreen extends StatefulWidget {
  const TypeWordScreen({super.key});

  @override
  State<TypeWordScreen> createState() => _TypeWordScreenState();
}

class _TypeWordScreenState extends State<TypeWordScreen> {
  TextEditingController userEntry = TextEditingController();

  var db = DBconnect();

  late Future _typeQuestions;

  Future<List<typeQuestion>> getData() async {
    return db.fetchTypingQuestion();
  }

  @override
  void initState() {
    _typeQuestions = getData();
    super.initState();
  }

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
    return FutureBuilder(
      future: _typeQuestions as Future<List<typeQuestion>>,
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Center(
              child: Text('${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            var extractedData = snapshot.data as List<typeQuestion>;
            return Scaffold(
              appBar: AppBar(
                title: Text('Fill in the blank'),
              ),
              body: Container(
                child: Column(
                  children: [
                    TypingWordQuestion(
                        indexAction: index,
                        givenTitle: extractedData[index].givenTitle,
                        hiddenWord: extractedData[index].hiddenWord,
                        totalQuestion: extractedData.length),
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
                        onPressed:
                            (userEntry.text == extractedData[index].titleAnswer)
                                ? (index == extractedData.length - 1)
                                    ? () {
                                        showDialog(
                                            context: context,
                                            builder: (ctx) => ResultBox(
                                                questionLength:
                                                    extractedData.length,
                                                isPressed: startOver));
                                      }
                                    : () {
                                        showDialog(
                                          context: context,
                                          builder: (ctx) => AlertDialog(
                                            title: Text('Congratulations!'),
                                            content: Text(
                                                'You completed the word correctly.'),
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
        } else {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Please wait a while Questions are loading...',
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      decoration: TextDecoration.none,
                      fontSize: 14),
                )
              ],
            ),
          );
        }
        return Center(
          child: Text('No data'),
        );
      },
    );
  }
}
