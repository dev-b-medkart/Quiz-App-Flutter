import 'package:flutter/material.dart';
import 'package:quiz_app/models/quiz_model.dart';
import 'package:quiz_app/models/question_model.dart';

class QuestionFormPage extends StatefulWidget {
  final Quiz quiz;
  final int numQuestions;

  const QuestionFormPage({
    super.key,
    required this.quiz,
    required this.numQuestions,
  });

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

  bool _isQuizComplete() {
    for (var question in _questions) {
      if (question.text.isEmpty ||
          question.options.any((option) => option.isEmpty) ||
          question.correctOptionIndex == -1) {
        return false;
      }
    }
    return true;
  }

  void _submitQuiz() {
    if (_isQuizComplete()) {
      widget.quiz.questions = _questions;
      Navigator.pop(context, widget.quiz);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill all questions before submitting."),
          backgroundColor: Colors.red,
        ),
      );
    }
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
      floatingActionButton: (_pageController.page == widget.numQuestions - 1)
          ? FloatingActionButton(
        onPressed: _submitQuiz,
        tooltip: 'Submit Quiz',
        child: const Icon(Icons.check),
      )
          : null,
    );
  }
}

class QuestionForm extends StatefulWidget {
  final int questionIndex;
  final Question question;
  final Function(int, String, List<String>, int) onSave;

  const QuestionForm({
    super.key,
    required this.questionIndex,
    required this.question,
    required this.onSave,
  });

  @override
  _QuestionFormState createState() => _QuestionFormState();
}

class _QuestionFormState extends State<QuestionForm> {
  late TextEditingController _questionController;
  late List<TextEditingController> _optionControllers;
  int? _selectedOptionIndex;

  @override
  void initState() {
    super.initState();
    _questionController = TextEditingController(text: widget.question.text);
    _optionControllers =
        List.generate(4, (index) => TextEditingController(text: widget.question.options[index]));
    _selectedOptionIndex = widget.question.correctOptionIndex == -1 ? null : widget.question.correctOptionIndex;
  }

  @override
  void dispose() {
    _questionController.dispose();
    for (var controller in _optionControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _onSave() {
    widget.onSave(
      widget.questionIndex,
      _questionController.text,
      _optionControllers.map((controller) => controller.text).toList(),
      _selectedOptionIndex!,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Question ${widget.questionIndex + 1}'),
          TextField(
            controller: _questionController,
            decoration: const InputDecoration(labelText: 'Question Text'),
            onChanged: (_) => _onSave(),
          ),
          ...List.generate(4, (index) {
            return TextField(
              controller: _optionControllers[index],
              decoration: InputDecoration(labelText: 'Option ${String.fromCharCode(65 + index)}'),
              onChanged: (_) => _onSave(),
            );
          }),
          DropdownButtonFormField<int>(
            value: _selectedOptionIndex,
            onChanged: (value) {
              setState(() {
                _selectedOptionIndex = value;
              });
              _onSave();
            },
            items: List.generate(4, (index) {
              return DropdownMenuItem(
                value: index,
                child: Text('Option ${String.fromCharCode(65 + index)}'),
              );
            }),
            decoration: const InputDecoration(labelText: 'Correct Answer'),
          ),
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:quiz_app/models/quiz_model.dart';
// import 'package:quiz_app/models/question_model.dart';
//
// class QuestionFormPage extends StatefulWidget {
//   final Quiz quiz;
//   final int numQuestions;
//
//   const QuestionFormPage(
//       {super.key, required this.quiz, required this.numQuestions});
//
//   @override
//   State<QuestionFormPage> createState() => _QuestionFormPageState();
// }
//
// class _QuestionFormPageState extends State<QuestionFormPage> {
//   late PageController _pageController;
//   late List<Question> _questions;
//
//   @override
//   void initState() {
//     super.initState();
//     _pageController = PageController();
//     _questions = List.generate(
//       widget.numQuestions,
//       (index) => Question(
//         text: '',
//         options: ['', '', '', ''],
//         correctOptionIndex: -1,
//       ),
//     );
//   }
//
//   void _saveQuestion(
//       int index, String text, List<String> options, int correctOptionIndex) {
//     setState(() {
//       _questions[index] = Question(
//         text: text,
//         options: options,
//         correctOptionIndex: correctOptionIndex,
//       );
//     });
//   }
//
//   void _submitQuiz() {
//     widget.quiz.questions = _questions;
//     Navigator.pop(context, widget.quiz);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Add Questions'),
//         centerTitle: true,
//       ),
//       body: PageView.builder(
//         controller: _pageController,
//         itemCount: widget.numQuestions,
//         itemBuilder: (context, index) {
//           return QuestionForm(
//             questionIndex: index,
//             question: _questions[index],
//             onSave: _saveQuestion,
//           );
//         },
//       ),
//       // floatingActionButton: FloatingActionButton(
//       //   onPressed: _submitQuiz,
//       //   tooltip: 'Submit Quiz',
//       //   child: Icon(Icons.check),
//       // ),
//     );
//   }
// }
//
// class QuestionForm extends StatelessWidget {
//   final int questionIndex;
//   final Question question;
//   final Function(int, String, List<String>, int) onSave;
//
//   QuestionForm({
//     super.key,
//     required this.questionIndex,
//     required this.question,
//     required this.onSave,
//   });
// // QuestionForm({
// //     Key? key,
// //     required this.questionIndex,
// //     required this.question,
// //     required this.onSave,
// //   }) : super(key: key);
//
//   final TextEditingController _questionController = TextEditingController();
//   final List<TextEditingController> _optionControllers =
//       List.generate(4, (_) => TextEditingController());
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text('Question ${questionIndex + 1}'),
//           TextField(
//             controller: _questionController..text = question.text,
//             decoration: InputDecoration(labelText: 'Question Text'),
//           ),
//           ...List.generate(4, (index) {
//             return TextField(
//               controller: _optionControllers[index]
//                 ..text = question.options[index],
//               decoration: InputDecoration(
//                   labelText: 'Option ${String.fromCharCode(65 + index)}'),
//             );
//           }),
//           DropdownButtonFormField<int>(
//             value: question.correctOptionIndex != -1
//                 ? question.correctOptionIndex
//                 : null,
//             onChanged: (value) {
//               onSave(
//                 questionIndex,
//                 _questionController.text,
//                 _optionControllers
//                     .map((controller) => controller.text)
//                     .toList(),
//                 value!,
//               );
//             },
//             items: List.generate(4, (index) {
//               return DropdownMenuItem(
//                 value: index,
//                 child: Text('Option ${String.fromCharCode(65 + index)}'),
//               );
//             }),
//           ),
//
//         ],
//       ),
//
//     );
//
//   }
// }
