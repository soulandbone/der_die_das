class UpdateScore {
  int call({required bool isCorrect, required int currentScore}) {
    return isCorrect ? currentScore + 100 : currentScore;
  }
}
