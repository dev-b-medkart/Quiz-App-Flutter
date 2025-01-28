import 'package:flutter/material.dart';
import 'package:quiz_app/models/question_model.dart';
import 'package:quiz_app/screens/create_quiz_page.dart';
import 'package:quiz_app/screens/play_quiz_page.dart';
import '../models/quiz_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  // const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Quiz> quizzes = [];
  @override
  void initState() {
    super.initState();
    // Generate quizzes in the initState
    quizzes = generateSampleQuizzes();
  }

  void deleteQuiz(int index) {
    print("----------------");

    setState(() {
      quizzes.removeAt(index);
    });
  }

  void createQuiz(Quiz quiz) {
    setState(() {
      quizzes.add(quiz);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Quizzes')),
        actions: [
          IconButton(
            onPressed: () async {
              print(quizzes);
              print("quizzes");
              Quiz? newQuiz = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreateQuizPage()),
              );
              
              if (newQuiz != null) {
                createQuiz(newQuiz);
              }
            },

            icon: Icon(Icons.add),
          )
        ],
      ),
      body: quizzes.isEmpty
          ? Center(child: Text("No Quizzes Created"))
          : ListView.builder(
        itemCount: quizzes.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: GestureDetector(
              onTap: () => PlayQuizPage(), // Optional: Tap on the card to play quiz
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                elevation: 4, // Adds subtle shadow
                color: Color(0xFFF3F4F6), // Light background for cards
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                  child: Row(
                    children: [
                      // Quiz Icon/Thumbnail
                      Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          color: Color(0xFF57955C).withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.quiz, color: Color(0xFF57955C), size: 36),
                      ),
                      const SizedBox(width: 16), // Space between icon and title

                      // Quiz Title and Subtitle
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              quizzes[index].title,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF2C2C2C),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${quizzes[index].questions.length} Questions',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF8E8E8E),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Action Buttons
                      Row(
                        children: [
                          Tooltip(
                            message: "Play Quiz",
                            child: InkWell(
                              onTap: () => PlayQuizPage(),
                              borderRadius: BorderRadius.circular(50),
                              splashColor: Colors.greenAccent.withOpacity(0.2),
                              child: Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Color(0xFF57955C).withOpacity(0.1),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(Icons.play_arrow, color: Color(0xFF57955C), size: 30),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Tooltip(
                            message: "Delete Quiz",
                            child: InkWell(
                              onTap: () => deleteQuiz(index),
                              borderRadius: BorderRadius.circular(50),
                              splashColor: Colors.redAccent.withOpacity(0.2),
                              child: Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Color(0xFFC84F4F).withOpacity(0.1),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(Icons.delete, color: Color(0xFFC84F4F), size: 28),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      )

    );
  }

  List<Quiz> generateSampleQuizzes() {
    List<Quiz> quizzes = [];

    for (int i = 1; i <= 15; i++) {
      List<Question> questions = [];
      for (int j = 1; j <= 15; j++) {
        questions.add(
          Question(
            text: 'Question $j in Quiz $i',
            options: [
              'Option A',
              'Option B',
              'Option C',
              'Option D',
            ],
            correctOptionIndex: j % 4, // Rotate correct options
          ),
        );
      }

      quizzes.add(
        Quiz(
          title: 'Quiz $i',
          questions: questions,
        ),
      );
    }

    return quizzes;
  }
}
