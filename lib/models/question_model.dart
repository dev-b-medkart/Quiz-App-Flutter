// class Question {
//   String text;
//   List<String> options;
//   int correctOptionIndex;
//   Question({
//     required this.text,
//     required this.options,
//     required this.correctOptionIndex,
//   });
//   @override
//   String toString() {
//     return 'Question: $text\nOptions: $options\nCorrect Option: ${options[correctOptionIndex]}';
//   }
// }



import 'package:hive/hive.dart';

part 'question_model.g.dart'; // Required for generated adapter

@HiveType(typeId: 0)
class Question {
  @HiveField(0)
  String text;

  @HiveField(1)
  List<String> options;

  @HiveField(2)
  int correctOptionIndex;

  Question({
    required this.text,
    required this.options,
    required this.correctOptionIndex,
  });
}
