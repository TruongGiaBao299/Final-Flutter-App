import 'package:flutter/material.dart';
import 'package:exam/constant.dart';
import 'package:exam/question_quiz_model.dart';
import 'package:exam/question_widget.dart';
import 'package:exam/next_question_button.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  @override
  Widget build(BuildContext context) {
    List<Questions> _questions = [
      Questions(
          id: '1',
          title: 'What is the meaning of Fried Chicken',
          options: {
            'Thit heo': false,
            'Thit bo': false,
            'Ga ran': true,
            'Khong biet': false
          }),
      Questions(id: '2', title: 'What is the meaning of Fish', options: {
        'Thit heo': false,
        'Thit bo': false,
        'Ga ran': false,
        'Ca': true
      })
    ];
    int index = 0;
    void nextQuestion() {
      if (index == _questions.length - 1) {
        return;
      } else {
        setState(() {
          index++;
        });
      }
    }

    return Scaffold(
      backgroundColor: backGroundColor,
      appBar: AppBar(
        title: Text('Quiz'),
        shadowColor: Colors.transparent,
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            QuestionWidget(
                question: _questions[index].title,
                indexAction: index,
                totalQuestions: _questions.length),
            Divider(
              color: neutral,
              thickness: 2,
            )
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: NextButton(
          nextQuestion: nextQuestion,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
