import 'package:flutter/foundation.dart';
import '../models/lesson_model.dart';

class LessonProvider extends ChangeNotifier {
  final List<LessonModel> _lessons = [
    LessonModel(
      id: '1',
      title: 'Budgeting Basics for Single Parents',
      description: 'Learn the 50/30/20 rule and how to manage your family budget effectively.',
      category: 'Budgeting',
      duration: 5,
      points: 50,
      icon: '💰',
      content: [
        'The 50/30/20 rule is a simple budgeting method.',
        '50% of income goes to needs (housing, food, utilities)',
        '30% goes to wants (entertainment, dining out)',
        '20% goes to savings and debt repayment',
        'Adjust based on your family\'s specific needs',
        'Track your spending to stay on budget',
      ],
    ),
    LessonModel(
      id: '2',
      title: 'Using Local Banking Apps Safely',
      description: 'Protect yourself from scams and learn how to use banking apps securely.',
      category: 'Security',
      duration: 7,
      points: 75,
      icon: '🔒',
      content: [
        'Always download apps from official app stores',
        'Enable two-factor authentication',
        'Never share your PIN or passwords',
        'Check for HTTPS in website URLs',
        'Be cautious of unsolicited messages',
        'Review transactions regularly',
        'Report suspicious activity immediately',
      ],
    ),
    LessonModel(
      id: '3',
      title: 'Spotting Common Scams',
      description: 'Recognize and avoid common scams targeting immigrant families.',
      category: 'Security',
      duration: 6,
      points: 60,
      icon: '⚠️',
      content: [
        'Government agencies won\'t ask for payment via gift cards',
        'Be suspicious of "too good to be true" offers',
        'Verify identities before sharing personal information',
        'Don\'t click links in unexpected emails or texts',
        'Real companies won\'t pressure you to act immediately',
        'Research any unfamiliar organization before engaging',
      ],
    ),
    LessonModel(
      id: '4',
      title: 'Smart Grocery Shopping',
      description: 'Save money on groceries with these practical tips.',
      category: 'Saving',
      duration: 5,
      points: 50,
      icon: '🛒',
      content: [
        'Make a list before shopping to avoid impulse buys',
        'Buy store brands instead of name brands',
        'Shop seasonal produce for better prices',
        'Use coupons and loyalty programs',
        'Compare unit prices, not just package prices',
        'Plan meals around weekly sales',
      ],
    ),
    LessonModel(
      id: '5',
      title: 'Building an Emergency Fund',
      description: 'Start small and build financial security for your family.',
      category: 'Saving',
      duration: 6,
      points: 60,
      icon: '🎯',
      content: [
        'Aim to save 3-6 months of expenses',
        'Start with a goal of \$500',
        'Automate savings with direct deposit',
        'Keep emergency funds in a separate account',
        'Save windfalls like tax refunds',
        'Celebrate small milestones to stay motivated',
      ],
    ),
    LessonModel(
      id: '6',
      title: 'Understanding Credit Cards',
      description: 'Use credit responsibly to build your credit history.',
      category: 'Credit',
      duration: 8,
      points: 80,
      icon: '💳',
      content: [
        'Credit cards are loans, not free money',
        'Pay your full balance each month to avoid interest',
        'Keep utilization below 30% of your limit',
        'Never miss a payment - set up autopay',
        'Review statements for unauthorized charges',
        'Building good credit takes time',
        'Consider a secured card if you\'re starting out',
      ],
    ),
  ];

  int _totalPoints = 0;

  List<LessonModel> get lessons => _lessons;
  int get totalPoints => _totalPoints;
  int get completedLessons => _lessons.where((l) => l.isCompleted).length;

  void completeLesson(String lessonId) {
    final lesson = _lessons.firstWhere((l) => l.id == lessonId);
    if (!lesson.isCompleted) {
      lesson.isCompleted = true;
      _totalPoints += lesson.points;
      notifyListeners();
    }
  }

  List<LessonModel> getRecommendedLessons(String? primaryGoal) {
    // Return lessons based on user's primary goal
    if (primaryGoal == null) return _lessons.take(3).toList();
    
    if (primaryGoal.toLowerCase().contains('save')) {
      return _lessons.where((l) => l.category == 'Saving').toList();
    } else if (primaryGoal.toLowerCase().contains('budget')) {
      return _lessons.where((l) => l.category == 'Budgeting').toList();
    }
    
    return _lessons.take(3).toList();
  }
}

