import 'package:quiz_app/models/question_model.dart';
class Quiz {
  String title;
   List<Question> questions;
  Quiz({
    required this.title,
    required this.questions,
  });
  @override
  String toString() {
    return 'Quiz Title: $title\nQuestions:\n${questions.map((q) => q.toString()).join('\n')}';
  }

}
