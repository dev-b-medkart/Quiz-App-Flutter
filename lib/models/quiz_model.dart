import 'package:quiz_app/models/question_model.dart';
class Quiz {
  String title;
   List<Question> questions;
  Quiz({
    required this.title,
    required this.questions,
  });
}
