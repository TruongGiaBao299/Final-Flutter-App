class typeQuestion {
  final String id;
  final String givenTitle;
  final String hiddenWord;
  final String titleAnswer;

  typeQuestion(
      {required this.id,
      required this.givenTitle,
      required this.titleAnswer,
      required this.hiddenWord,
      });

  @override
  String toString() {
    return 'typeQuestion(id: ${id}, title: ${givenTitle}, hiddenWord: ${hiddenWord})';
  }
}
