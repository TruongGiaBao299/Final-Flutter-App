import 'package:exam/typing_word_question_model.dart';
import 'package:http/http.dart' as http;
import 'package:exam/question_quiz_model.dart';
import 'dart:convert';

class DBconnect {
  final url = Uri.parse(
      'https://quizletapp-611b9-default-rtdb.asia-southeast1.firebasedatabase.app/questions.json');
  // Future<void> addQuestion(Questions questions) async {
  //   await http.post(url,
  //       body: json
  //           .encode({'title': questions.title, 'options': questions.options}));
  // }
  final url1 = Uri.parse(
      'https://quizletapp-611b9-default-rtdb.asia-southeast1.firebasedatabase.app/typingWord.json');
  // Future<void> addQuestion(typeQuestion questions) async {
  //   await http.post(url1,
  //       body: json.encode({
  //         'givenTitle': questions.givenTitle,
  //         'titleAnswer': questions.titleAnswer,
  //         'hiddenWord': questions.hiddenWord
  //       }));
  // }

  Future<List<Questions>> fetchQuestion() async {
    return http.get(url).then((response) {
      var data = json.decode(response.body) as Map<String, dynamic>;
      List<Questions> newQuestions = [];
      data.forEach((key, value) {
        var newQuestion = Questions(
            id: key,
            title: value['title'],
            options: Map.castFrom(value['options']));
        newQuestions.add(newQuestion);
      });
      return newQuestions;
    });
  }

  Future<List<typeQuestion>> fetchTypingQuestion() async {
    return http.get(url1).then((response) {
      var data = json.decode(response.body) as Map<String, dynamic>;
      List<typeQuestion> newTypeQuestions = [];
      data.forEach((key, value) {
        var newTypeQuestion = typeQuestion(
            givenTitle: value['givenTitle'],
            titleAnswer: value['titleAnswer'],
            hiddenWord: value['hiddenWord']);
        newTypeQuestions.add(newTypeQuestion);
      });
      return newTypeQuestions;
    });
  }
}
