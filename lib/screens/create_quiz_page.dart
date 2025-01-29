import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quiz_app/screens/question_form_page.dart';
import '../models/quiz_model.dart';
import '../util/validations.dart';

class CreateQuizPage extends StatefulWidget {
  const CreateQuizPage({super.key});

  @override
  State<CreateQuizPage> createState() => _CreateQuizPageState();
}

class _CreateQuizPageState extends State<CreateQuizPage> {
  // Controllers to capture input
  final TextEditingController _numQuestionsController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();


  @override
  void dispose() {
    // Clean up controllers when the widget is disposed
    _numQuestionsController.dispose();
    _timeController.dispose();
    _formKey.currentState?.dispose();
    super.dispose();
  }



  final _formKey = GlobalKey<FormState>();

  AutovalidateMode? isAutoValidActive;
  @override
  Widget build(BuildContext context) {
    print('isAutoValidActive $isAutoValidActive');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Quiz'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
            key: _formKey,
            autovalidateMode: isAutoValidActive,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                const Text(
                  "Set Quiz Details",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),

                // Title of Quiz
                const Text(
                  "Title of Quiz:",
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _titleController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText:
                        "Enter the title of the quiz", // Updated hint text
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    prefixIcon: const Icon(
                        Icons.title), // Changed icon to represent title input
                  ),
                  validator: Validations.titleValidator,
                ),
                const SizedBox(height: 16), // Number of Questions
                const Text(
                  "Number of Questions:",
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _numQuestionsController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                    hintText: "Enter number of questions",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    prefixIcon: const Icon(Icons.format_list_numbered),
                  ),
                  validator: Validations.numberValidator,
                ),
                const SizedBox(height: 16),

                // Time for the Quiz
                const Text(
                  "Time for the Quiz (minutes):",
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _timeController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "Enter time in minutes",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    prefixIcon: const Icon(Icons.timer),
                    // Show error message
                  ),
                  validator: Validations.numberValidator,
                ),
                const SizedBox(height: 24),

                // Submit Button

                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      _submitFun();
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "Create Quiz",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }

  Future<void> _submitFun() async {
    if (_formKey.currentState!.validate() == false) {
      isAutoValidActive = AutovalidateMode.always;
      setState(() {});
      return;
    }
    // Create a Quiz object
    final numQuestions = int.tryParse(_numQuestionsController.text)!;
    final quizTime = int.tryParse(_timeController.text) ?? 0;
    final quizTitle = _titleController.text;

    final quiz = Quiz(
      title: quizTitle,
      questions: [],
    );

    // Navigate to QuestionFormPage to add questions
    final updatedQuiz = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            QuestionFormPage(quiz: quiz, numQuestions: numQuestions),
      ),
    );

    // Handle the updated quiz (e.g., pass it to HomePage)
    if (updatedQuiz != null) {
      // Pass the updated quiz back to HomePage
      Navigator.pop(context, updatedQuiz);
    }
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:quiz_app/screens/question_form_page.dart';
//
// import '../models/question_model.dart';
// import '../models/quiz_model.dart';
// import '../util/validations.dart';
//
// class CreateQuizPage extends StatefulWidget {
//   const CreateQuizPage({super.key});
//
//   @override
//   State<CreateQuizPage> createState() => _CreateQuizPageState();
// }
//
// class _CreateQuizPageState extends State<CreateQuizPage> {
//   // Controllers to capture input
//   final TextEditingController _numQuestionsController = TextEditingController();
//   final TextEditingController _timeController = TextEditingController();
//   final TextEditingController _titleController = TextEditingController();
//   String _timeErrorText = ''; // Error message for invalid input
//   String _numQuestionsErrorText = ''; // Error message for invalid input
//
//   @override
//   void dispose() {
//     // Clean up controllers when the widget is disposed
//     _numQuestionsController.dispose();
//     _timeController.dispose();
//     _formKey.currentState?.dispose();
//     super.dispose();
//   }
//
//   bool _isFormValid() {
//     print('calling...');
//     final numQuestions = int.tryParse(_numQuestionsController.text);
//     final quizTime = int.tryParse(_timeController.text);
//     return numQuestions != null && quizTime != null;
//   }
//
//   void _validateTimeInput(String value) {
//     // Check if the input is a number
//     if (value.isNotEmpty && int.tryParse(value) == null) {
//       setState(() {
//         _timeErrorText = 'Please enter a valid number';
//       });
//     } else {
//       setState(() {
//         _timeErrorText = ''; // Reset the error message
//       });
//     }
//   }
//
//   final _formKey = GlobalKey<FormState>();
//   void _validateNumQuestionsInput(String value) {
//     //   Check if the input is a number
//     if (value.isNotEmpty && int.tryParse(value) == null) {
//       setState(() {
//         _numQuestionsErrorText = "Please enter a valid number";
//       });
//     } else {
//       setState(() {
//         _numQuestionsErrorText = "";
//       });
//     }
//   }
//
//   AutovalidateMode? isAutoValidActive;
//   @override
//   Widget build(BuildContext context) {
//     print('isAutoValidActive $isAutoValidActive');
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Create Quiz'),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//             key: _formKey,
//             autovalidateMode: isAutoValidActive,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Title
//                 const Text(
//                   "Set Quiz Details",
//                   style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//
//                 // Title of Quiz
//                 const Text(
//                   "Title of Quiz:",
//                   style: TextStyle(fontSize: 18),
//                 ),
//                 const SizedBox(height: 8),
//                 TextFormField(
//                   controller: _titleController,
//                   keyboardType: TextInputType.text,
//                   decoration: InputDecoration(
//                     hintText:
//                         "Enter the title of the quiz", // Updated hint text
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8.0),
//                     ),
//                     prefixIcon: const Icon(
//                         Icons.title), // Changed icon to represent title input
//                   ),
//                   validator: Validations.titleValidator,
//                 ),
//                 const SizedBox(height: 16), // Number of Questions
//                 const Text(
//                   "Number of Questions:",
//                   style: TextStyle(fontSize: 18),
//                 ),
//                 const SizedBox(height: 8),
//                 TextFormField(
//                   controller: _numQuestionsController,
//                   keyboardType: TextInputType.number,
//                   // onChanged: _validateNumQuestionsInput,
//                   inputFormatters: [FilteringTextInputFormatter.digitsOnly],
//                   decoration: InputDecoration(
//                     hintText: "Enter number of questions",
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8.0),
//                     ),
//                     prefixIcon: const Icon(Icons.format_list_numbered),
//                     // errorText: _numQuestionsErrorText.isNotEmpty
//                     //     ? _numQuestionsErrorText
//                     //     : null
//                   ),
//                   validator: Validations.numberValidator,
//                 ),
//                 const SizedBox(height: 16),
//
//                 // Time for the Quiz
//                 const Text(
//                   "Time for the Quiz (minutes):",
//                   style: TextStyle(fontSize: 18),
//                 ),
//                 const SizedBox(height: 8),
//                 TextFormField(
//                   controller: _timeController,
//                   keyboardType: TextInputType.number,
//                   onChanged:
//                       _validateTimeInput, // Validation on each input change
//                   decoration: InputDecoration(
//                     hintText: "Enter time in minutes",
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8.0),
//                     ),
//                     prefixIcon: const Icon(Icons.timer),
//                     // Show error message
//                   ),
//                   validator: Validations.numberValidator,
//                 ),
//                 const SizedBox(height: 24),
//
//                 // Submit Button
//
//                 Center(
//                   child: ElevatedButton(
//                     onPressed: () {
//                       _submitFun();
//                     },
//                     style: ElevatedButton.styleFrom(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 32, vertical: 16),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                     child: const Text(
//                       "Create Quiz",
//                       style: TextStyle(fontSize: 18),
//                     ),
//                   ),
//                 ),
//               ],
//             )),
//       ),
//     );
//   }
//
//   Future<void> _submitFun() async {
//     if (_formKey.currentState!.validate() == false) {
//       isAutoValidActive = AutovalidateMode.always;
//       setState(() {});
//       return;
//     }
//     // Create a Quiz object
//     final numQuestions = int.tryParse(_numQuestionsController.text)!;
//     final quizTime = int.tryParse(_timeController.text) ?? 0;
//     final quizTitle = _titleController.text;
//
//     final quiz = Quiz(
//       title: quizTitle,
//       questions: [],
//     );
//
//     // Navigate to QuestionFormPage to add questions
//     final updatedQuiz = await Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) =>
//             QuestionFormPage(quiz: quiz, numQuestions: numQuestions),
//       ),
//     );
//
//     // Handle the updated quiz (e.g., pass it to HomePage)
//     if (updatedQuiz != null) {
//       // Pass the updated quiz back to HomePage
//       Navigator.pop(context, updatedQuiz);
//     }
//   }
// }
