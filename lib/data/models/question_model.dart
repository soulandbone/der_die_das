class QuestionModel {
  QuestionModel({required this.word, required this.correctAnswer});
  final String word;
  final String correctAnswer;

  factory QuestionModel.fromMap(Map<String, dynamic> map) => QuestionModel(
    word: map['word'] as String,
    correctAnswer: map['correctAnswer'] as String,
  );
}
