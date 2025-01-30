import 'package:flutter/material.dart';
import 'package:quiz_app/models/quiz_model.dart';

class PlayQuizPage extends StatefulWidget {
  final Quiz quiz;
  const PlayQuizPage({super.key, required this.quiz});

  @override
  State<PlayQuizPage> createState() => _PlayQuizPageState();
}

PageController _pageController = PageController();

class _PlayQuizPageState extends State<PlayQuizPage> {
  late List<int> userAnswers; // Declare without initializing

  @override
  void initState() {
    super.initState(); // Call parent initState()
    userAnswers = List.filled(widget.quiz.questions.length,
        -1); // ✅ Correct: Assign value to instance variable
  }

  void onAnswer(int questionIndex, int option) {
    setState(() {
      userAnswers[questionIndex] = option;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Quiz:  ${widget.quiz.title}',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Colors.green[300],
        ),
        body: PageView.builder(
          scrollDirection: Axis.vertical,
          itemCount: widget.quiz.questions.length,
          itemBuilder: (context, index) {
            return QuestionCard(
                questionIndex: index,
                question: widget.quiz.questions[index].text,
                options: widget.quiz.questions[index].options,
                onAnswer: onAnswer,
                selectedOption: userAnswers[index]);
          },
        ),
      //  ElevatedButton(onPressed: () {
      //
      // }, child: Text('Submit Quiz',style: TextStyle(fontWeight: FontWeight.w500),)),
    );
  }
}

class QuestionCard extends StatefulWidget {
  final int questionIndex;
  final String question;
  final List<String> options;
  final void Function(int questionIndex, int option) onAnswer;
  final int selectedOption;
  const QuestionCard(
      {super.key,
      required this.questionIndex,
      required this.question,
      required this.options,
      required this.onAnswer,
      required this.selectedOption});

  @override
  State<QuestionCard> createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Question ${widget.questionIndex + 1}',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            widget.question,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.normal),
          ),
        ),
        Column(
          children: widget.options.asMap().entries.map((entry) {
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: OutlinedButton(
                onPressed: () {
                  widget.onAnswer(
                    widget.questionIndex,entry.key
                  );
                  print('option ${widget.selectedOption}');

                },
                style: OutlinedButton.styleFrom(
                  backgroundColor: widget.selectedOption==entry.key? Colors.blue:Colors.red[400],  // ✅ Background color
                  foregroundColor: Colors.white, // ✅ Text color
                  side: BorderSide(color: Colors.black, width: 1), // ✅ Border color
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24), // ✅ Padding
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), // ✅ Rounded corners

                ),

                child: Text(entry.value),
              ),
            );
          }).toList(),
        ),

      ],
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:quiz_app/models/quiz_model.dart';
//
// class PlayQuizPage extends StatefulWidget {
//   final Quiz quiz;
//   const PlayQuizPage({super.key, required this.quiz});
//
//   @override
//   State<PlayQuizPage> createState() => _PlayQuizPageState();
// }
//
// class _PlayQuizPageState extends State<PlayQuizPage> {
//   int currentQuestionIndex = 0;
//   int? selectedAnswerIndex;
//   List<int?> userAnswers = []; // To store user's selected answers
//   bool quizCompleted = false; // Flag to track if the quiz is completed
//
//   void submitQuiz() {
//     setState(() {
//       quizCompleted = true;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final currentQuestion = widget.quiz.questions[currentQuestionIndex];
//
//     return Scaffold(
//       backgroundColor: Colors.blueGrey[50],
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(120.0),
//         child: AppBar(
//           backgroundColor: Colors.deepPurpleAccent,
//           elevation: 10,
//           title: AnimatedDefaultTextStyle(
//             style: TextStyle(
//               fontSize: 24,
//               fontWeight: FontWeight.bold,
//               color: Colors.white.withOpacity(0.9),
//               letterSpacing: 1.5,
//             ),
//             duration: Duration(milliseconds: 300),
//             child: Text('Quiz: ${widget.quiz.title}'),
//           ),
//           centerTitle: true,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
//           ),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Progress Indicator
//             Container(
//               padding: EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(15),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.1),
//                     blurRadius: 8,
//                     offset: Offset(0, 2),
//                   ),
//                 ],
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Let\'s Play!',
//                     style: TextStyle(
//                       fontSize: 28,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.deepPurpleAccent,
//                     ),
//                   ),
//                   SizedBox(height: 10),
//                   LinearProgressIndicator(
//                     value: (currentQuestionIndex + 1) / widget.quiz.questions.length,
//                     backgroundColor: Colors.grey[200],
//                     valueColor: AlwaysStoppedAnimation(Colors.deepPurpleAccent),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 20),
//
//             // Current Question Content
//             Expanded(
//               child: Container(
//                 padding: EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(15),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.1),
//                       blurRadius: 8,
//                       offset: Offset(0, 2),
//                     ),
//                   ],
//                 ),
//                 child: quizCompleted
//                     ? _buildResults()
//                     : Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       currentQuestion.text,
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.deepPurpleAccent,
//                       ),
//                     ),
//                     SizedBox(height: 20),
//                     ...currentQuestion.options.asMap().entries.map((entry) {
//                       int index = entry.key;
//                       String option = entry.value;
//
//                       return GestureDetector(
//                         onTap: () {
//                           if (!quizCompleted) {
//                             setState(() {
//                               selectedAnswerIndex = index;
//                               userAnswers.add(index);
//                             });
//                           }
//                         },
//                         child: Container(
//                           padding: EdgeInsets.all(12),
//                           margin: EdgeInsets.symmetric(vertical: 5),
//                           decoration: BoxDecoration(
//                             color: selectedAnswerIndex == index
//                                 ? Colors.deepPurpleAccent.withOpacity(0.2)
//                                 : Colors.grey[200],
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           child: Text(
//                             option,
//                             style: TextStyle(
//                               fontSize: 16,
//                               color: Colors.black,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                         ),
//                       );
//                     }).toList(),
//                     Spacer(),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         if (currentQuestionIndex > 0)
//                           ElevatedButton(
//                             onPressed: () {
//                               setState(() {
//                                 currentQuestionIndex--;
//                                 selectedAnswerIndex = null;
//                               });
//                             },
//                             child: Text('Previous'),
//                           ),
//                         if (currentQuestionIndex < widget.quiz.questions.length - 1)
//                           ElevatedButton(
//                             onPressed: () {
//                               setState(() {
//                                 currentQuestionIndex++;
//                                 selectedAnswerIndex = null;
//                               });
//                             },
//                             child: Text('Next'),
//                           ),
//                         if (currentQuestionIndex == widget.quiz.questions.length - 1)
//                           ElevatedButton(
//                             onPressed: submitQuiz,
//                             child: Text('Submit'),
//                           ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildResults() {
//     int score = 0;
//     for (int i = 0; i < widget.quiz.questions.length; i++) {
//       if (userAnswers[i] == widget.quiz.questions[i].correctOptionIndex) {
//         score++;
//       }
//     }
//
//     return Center(
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Text(
//             'Quiz Completed!',
//             style: TextStyle(
//               fontSize: 28,
//               fontWeight: FontWeight.bold,
//               color: Colors.deepPurpleAccent,
//             ),
//           ),
//           SizedBox(height: 20),
//           Text(
//             'Your Score: $score/${widget.quiz.questions.length}',
//             style: TextStyle(
//               fontSize: 24,
//               fontWeight: FontWeight.bold,
//               color: Colors.deepPurpleAccent,
//             ),
//           ),
//           SizedBox(height: 40),
//           ElevatedButton(
//             onPressed: () {
//               // Optionally, go back or reset the quiz
//             },
//             child: Text('Retake Quiz'),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
