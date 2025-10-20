class LessonModel {
  final String id;
  final String title;
  final String description;
  final String category;
  final int duration; // in minutes
  final int points;
  final List<String> content;
  final String icon;
  bool isCompleted;

  LessonModel({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.duration,
    required this.points,
    required this.content,
    required this.icon,
    this.isCompleted = false,
  });
}

