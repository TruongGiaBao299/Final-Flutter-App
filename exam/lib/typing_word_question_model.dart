class typeQuestion {
  final String givenTitle;
  final String hiddenWord;
  final String titleAnswer;

  typeQuestion(
      {
      required this.givenTitle,
      required this.titleAnswer,
      required this.hiddenWord,
      });

  @override
  String toString() {
    return 'typeQuestion( title: ${givenTitle}, hiddenWord: ${hiddenWord})';
  }
}
