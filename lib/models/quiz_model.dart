// import 'package:quiz_app/models/question_model.dart';
// class Quiz {
//   String title;
//    List<Question> questions;
//   Quiz({
//     required this.title,
//     required this.questions,
//   });
//   @override
//   String toString() {
//     return 'Quiz Title: $title\nQuestions:\n${questions.map((q) => q.toString()).join('\n')}';
//   }
//
// }


import 'package:hive/hive.dart';
import 'question_model.dart';

part 'quiz_model.g.dart'; // Required for generated adapter

@HiveType(typeId: 1)
class Quiz {
  @HiveField(0)
  String title;

  @HiveField(1)
  List<Question> questions;

  Quiz({
    required this.title,
    required this.questions,
  });
}
