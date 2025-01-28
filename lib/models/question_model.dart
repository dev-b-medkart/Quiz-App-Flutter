class Question {
  String text;
  List<String> options;
  int correctOptionIndex;
  Question({
    required this.text,
    required this.options,
    required this.correctOptionIndex,
  });
  @override
  String toString() {
    return 'Question: $text\nOptions: $options\nCorrect Option: ${options[correctOptionIndex]}';
  }
}
