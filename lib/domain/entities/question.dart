class Question {
  final String word;
  final String correctAnswer;
  final List<String> options;

  Question._({
    required this.word,
    required this.correctAnswer,
    required this.options,
  });

  factory Question({required String word, required String correctAnswer}) {
    return Question._(
      word: word,
      correctAnswer: correctAnswer,
      options: ['Der', 'Die', 'Das'],
    );
  }
}
