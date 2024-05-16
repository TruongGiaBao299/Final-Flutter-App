import 'package:exam/db_connect.dart';
import 'package:flutter/material.dart';
import 'package:exam/constant.dart';
import 'package:exam/question_quiz_model.dart';
import 'package:exam/question_widget.dart';
// import 'package:exam/next_question_button.dart';
import 'package:exam/option_card.dart';
import 'package:exam/result_box.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  var db = DBconnect();
  late Future _questions;

  Future<List<Questions>> getData() async {
    return db.fetchQuestion();
  }

  @override
  void initState() {
    _questions = getData();
    super.initState();
  }
  // // List<Questions> _questions = [
  //   Questions(id: '1', title: 'What is the meaning of Fried Chicken', options: {
  //     'Thit heo': false,
  //     'Thit bo': false,
  //     'Ga ran': true,
  //     'Khong biet': false
  //   }),
  //   Questions(id: '2', title: 'What is the meaning of Fish', options: {
  //     'Thit heo': false,
  //     'Thit bo': false,
  //     'Ga ran': false,
  //     'Ca': true
  //   })
  // ];

  int index = 0;

  bool isPressed = false;

  int score = 0;

  bool isAlreadySelected = false;
  void nextQuestion(int questionLenth) {
    if (index == questionLenth - 1) {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (ctx) => ResultBox(
                result: score,
                questionLength: questionLenth,
                isPressed: startOver,
              ));
    } else if (isPressed) {
      setState(() {
        index++;
        isPressed = false;
        isAlreadySelected = false;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please select any option'),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.symmetric(vertical: 20.0),
      ));
    }
  }

  void checkAnswerandUpdateScore(bool value) {
    if (isAlreadySelected) {
      return;
    } else {
      if (value == true) {
        score++;
      }
      setState(() {
        isPressed = true;
        isAlreadySelected = true;
      });
    }
  }

  void startOver() {
    setState(() {
      index = 0;
      score = 0;
      isPressed = false;
      isAlreadySelected = false;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _questions as Future<List<Questions>>,
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Center(
              child: Text('${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            var extractedData = snapshot.data as List<Questions>;
            return Scaffold(
              backgroundColor: backGroundColor,
              appBar: AppBar(
                title: Text(
                  'Quiz',
                  style: TextStyle(fontSize: 20),
                ),
                shadowColor: Colors.transparent,
                actions: [
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      'Score: $score',
                      style: TextStyle(fontSize: 20),
                    ),
                  )
                ],
              ),
              body: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    QuestionWidget(
                        question: extractedData[index].title,
                        indexAction: index,
                        totalQuestions: extractedData.length),
                    Divider(
                      color: neutral,
                      thickness: 2,
                    ),
                    SizedBox(
                      height: 25,
                    ),  
                    for (int i = 0;
                        i < extractedData[index].options.length;
                        i++)
                      GestureDetector(
                        onTap: () => checkAnswerandUpdateScore(
                            extractedData[index].options.values.toList()[i]),
                        child: OptionCard(
                            option:
                                extractedData[index].options.keys.toList()[i],
                            color: isPressed
                                ? extractedData[index]
                                            .options
                                            .values
                                            .toList()[i] ==
                                        true
                                    ? correct
                                    : incorrect
                                : neutral),
                      )
                  ],
                ),
              ),
              // floatingActionButton: Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 10.0),
              //   child: NextButton(
              //     nextQuestion: nextQuestion,
              //     index: index,
              //   ),
              // ),
              floatingActionButton: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      nextQuestion(extractedData.length);
                    });
                  },
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: neutral,
                        borderRadius: BorderRadius.circular(10.0)),
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      'Next Question',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
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
