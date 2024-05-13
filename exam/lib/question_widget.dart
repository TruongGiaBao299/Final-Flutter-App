import 'package:exam/constant.dart';
import 'package:flutter/material.dart';

class QuestionWidget extends StatelessWidget {
  final String question;
  final int indexAction;
  final int totalQuestions;
  QuestionWidget({super.key, required this.question, required this.indexAction, required this.totalQuestions});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text('Question ${indexAction + 1}/$totalQuestions: $question', style: TextStyle(fontSize: 24, color: neutral),),
    );
  }
}
