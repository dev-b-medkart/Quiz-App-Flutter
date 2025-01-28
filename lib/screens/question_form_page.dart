import 'package:flutter/material.dart';
import 'package:quiz_app/models/quiz_model.dart';
import 'package:quiz_app/models/question_model.dart';

class QuestionFormPage extends StatefulWidget {
  final Quiz quiz;
  final int numQuestions;

  const QuestionFormPage(
      {super.key, required this.quiz, required this.numQuestions});

  @override
  State<QuestionFormPage> createState() => _QuestionFormPageState();
}

class _QuestionFormPageState extends State<QuestionFormPage> {
  late PageController _pageController;
  late List<Question> _questions;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _questions = List.generate(
      widget.numQuestions,
      (index) => Question(
        text: '',
        options: ['', '', '', ''],
        correctOptionIndex: -1,
      ),
    );
  }

  void _saveQuestion(
      int index, String text, List<String> options, int correctOptionIndex) {
    setState(() {
      _questions[index] = Question(
        text: text,
        options: options,
        correctOptionIndex: correctOptionIndex,
      );
    });
  }

  void _submitQuiz() {
    widget.quiz.questions = _questions;
    Navigator.pop(context, widget.quiz);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Questions'),
        centerTitle: true,
      ),
      body: PageView.builder(
        controller: _pageController,
        itemCount: widget.numQuestions,
        itemBuilder: (context, index) {
          return QuestionForm(
            questionIndex: index,
            question: _questions[index],
            onSave: _saveQuestion,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _submitQuiz,
        tooltip: 'Submit Quiz',
        child: Icon(Icons.check),
      ),
    );
  }
}

class QuestionForm extends StatelessWidget {
  final int questionIndex;
  final Question question;
  final Function(int, String, List<String>, int) onSave;

  QuestionForm({
    super.key,
    required this.questionIndex,
    required this.question,
    required this.onSave,
  });
// QuestionForm({
//     Key? key,
//     required this.questionIndex,
//     required this.question,
//     required this.onSave,
//   }) : super(key: key);

  final TextEditingController _questionController = TextEditingController();
  final List<TextEditingController> _optionControllers =
      List.generate(4, (_) => TextEditingController());
  // final TextEditingController _correctOptionController =
  //     TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Question ${questionIndex + 1}'),
          TextField(
            controller: _questionController..text = question.text,
            decoration: InputDecoration(labelText: 'Question Text'),
          ),
          ...List.generate(4, (index) {
            return TextField(
              controller: _optionControllers[index]
                ..text = question.options[index],
              decoration: InputDecoration(
                  labelText: 'Option ${String.fromCharCode(65 + index)}'),
            );
          }),
          DropdownButtonFormField<int>(
            value: question.correctOptionIndex != -1
                ? question.correctOptionIndex
                : null,
            onChanged: (value) {
              onSave(
                questionIndex,
                _questionController.text,
                _optionControllers
                    .map((controller) => controller.text)
                    .toList(),
                value!,
              );
            },
            items: List.generate(4, (index) {
              return DropdownMenuItem(
                value: index,
                child: Text('Option ${String.fromCharCode(65 + index)}'),
              );
            }),
          ),
        ],
      ),
    );
  }
}
