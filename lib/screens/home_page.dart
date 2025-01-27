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

List<Quiz> generateSampleQuizzes() {
  List<Quiz> quizzes = [];

  for (int i = 1; i <= 10; i++) {
    List<Question> questions = [];
    for (int j = 1; j <= 10; j++) {
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

class _HomePageState extends State<HomePage> {
  List<Quiz> quizzes = [];
  @override
  void initState() {
    super.initState();
    // Generate quizzes in the initState
    quizzes = generateSampleQuizzes();
  }

  void deleteQuiz(int index) {
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
      ),
      body: quizzes.isEmpty
          ? Text("No Quizzes Created")
          : ListView.builder(
              itemCount: quizzes.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(quizzes[index].title),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.play_arrow),
                        onPressed: () => PlayQuizPage(),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => deleteQuiz(index),
                      ),
                    ],
                  ),
                );
              },
            ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () async {
            Quiz? newQuiz = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CreateQuizPage()),
            );
            if (newQuiz != null) {
              createQuiz(newQuiz);
            }
          },
        )
    );
  }
}
