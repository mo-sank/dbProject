class QuizQuestion {
  final String question;
  final List<String> options;
  final int correctAnswerIndex;
  final String explanation;
  final QuestionType type;

  QuizQuestion({
    required this.question,
    required this.options,
    required this.correctAnswerIndex,
    required this.explanation,
    this.type = QuestionType.multipleChoice,
  });
}

enum QuestionType {
  multipleChoice,
  trueFalse,
  fillInBlank,
}

class QuizLesson {
  final String id;
  final String title;
  final String description;
  final String category;
  final int duration;
  final int points;
  final String icon;
  final List<QuizQuestion> questions;
  bool isCompleted;

  QuizLesson({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.duration,
    required this.points,
    required this.icon,
    required this.questions,
    this.isCompleted = false,
  });

  int get totalQuestions => questions.length;
}

