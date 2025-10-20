import 'package:flutter/foundation.dart';
import '../models/quiz_question_model.dart';

class LessonProvider extends ChangeNotifier {
  final List<QuizLesson> _lessons = [
    QuizLesson(
      id: '1',
      title: 'Budgeting Basics for Families',
      description: 'Learn the 50/30/20 rule and how to manage your family budget effectively.',
      category: 'Budgeting',
      duration: 5,
      points: 50,
      icon: '💰',
      questions: [
        QuizQuestion(
          question: 'What is the 50/30/20 budgeting rule?',
          options: [
            '50% needs, 30% wants, 20% savings',
            '50% savings, 30% needs, 20% wants',
            '50% wants, 30% savings, 20% needs',
            '50% bills, 30% food, 20% fun',
          ],
          correctAnswerIndex: 0,
          explanation: 'The 50/30/20 rule allocates 50% to needs, 30% to wants, and 20% to savings and debt.',
        ),
        QuizQuestion(
          question: 'Which of these is a "need"?',
          options: [
            'Streaming subscriptions',
            'Rent payment',
            'Restaurant meals',
            'New clothes',
          ],
          correctAnswerIndex: 1,
          explanation: 'Rent is a necessity - you need shelter. The others are wants.',
        ),
        QuizQuestion(
          question: 'How much of your income should go to savings?',
          options: [
            '10%',
            '15%',
            '20%',
            '25%',
          ],
          correctAnswerIndex: 2,
          explanation: 'The 50/30/20 rule recommends 20% for savings and debt repayment.',
        ),
        QuizQuestion(
          question: 'Should you adjust the 50/30/20 rule based on your situation?',
          options: [
            'Yes, customize it for your family',
            'No, always follow it exactly',
          ],
          correctAnswerIndex: 0,
          explanation: 'Every family is different! Adjust the rule to fit your specific needs and goals.',
        ),
      ],
    ),
    QuizLesson(
      id: '2',
      title: 'Banking App Security',
      description: 'Protect yourself from scams and learn how to use banking apps securely.',
      category: 'Security',
      duration: 7,
      points: 75,
      icon: '🔒',
      questions: [
        QuizQuestion(
          question: 'Where should you download banking apps from?',
          options: [
            'Any website',
            'Text message links',
            'Official app stores only',
            'Email attachments',
          ],
          correctAnswerIndex: 2,
          explanation: 'Only download apps from official stores (Google Play, App Store) to avoid fake apps.',
        ),
        QuizQuestion(
          question: 'What is two-factor authentication (2FA)?',
          options: [
            'Using two different passwords',
            'An extra security step beyond password',
            'Logging in twice',
            'Using two devices',
          ],
          correctAnswerIndex: 1,
          explanation: '2FA adds an extra layer by requiring a code from your phone or email.',
        ),
        QuizQuestion(
          question: 'Should you share your banking PIN with family?',
          options: [
            'Yes, if you trust them',
            'No, never share it',
            'Only with your spouse',
            'Yes, for emergencies',
          ],
          correctAnswerIndex: 1,
          explanation: 'Never share your PIN with anyone - not even family. Banks will never ask for it.',
        ),
        QuizQuestion(
          question: 'A text says "Your account is locked, click here." What should you do?',
          options: [
            'Click the link immediately',
            'Call the bank directly',
            'Reply to the text',
            'Share it with friends',
          ],
          correctAnswerIndex: 1,
          explanation: 'This is likely a scam! Always contact your bank directly using their official number.',
        ),
      ],
    ),
    QuizLesson(
      id: '3',
      title: 'Spotting Scams',
      description: 'Recognize and avoid common scams targeting families.',
      category: 'Security',
      duration: 6,
      points: 60,
      icon: '⚠️',
      questions: [
        QuizQuestion(
          question: 'The IRS calls demanding payment in gift cards. Is this real?',
          options: [
            'Yes, pay immediately',
            'No, it\'s a scam',
            'Maybe, ask for ID',
            'Yes, if they know your name',
          ],
          correctAnswerIndex: 1,
          explanation: 'Scam! Government agencies NEVER ask for gift card payments. They send official letters.',
        ),
        QuizQuestion(
          question: 'An ad says "Make \$5000 working from home!" What should you think?',
          options: [
            'Great opportunity!',
            'Sounds too good to be true',
            'Sign up immediately',
            'Share with friends',
          ],
          correctAnswerIndex: 1,
          explanation: 'Be suspicious of "too good to be true" offers. Research thoroughly first.',
        ),
        QuizQuestion(
          question: 'Someone calls saying "Act now or lose your benefits!" Should you?',
          options: [
            'Act immediately',
            'Hang up and verify',
            'Give them information',
            'Transfer money',
          ],
          correctAnswerIndex: 1,
          explanation: 'Pressure tactics are a red flag! Real organizations don\'t rush you.',
        ),
        QuizQuestion(
          question: 'What\'s the best way to verify if a call is legitimate?',
          options: [
            'Ask for their name',
            'Give them a test question',
            'Hang up, call back on official number',
            'Trust caller ID',
          ],
          correctAnswerIndex: 2,
          explanation: 'Always hang up and call back using the official number from their website.',
        ),
      ],
    ),
    QuizLesson(
      id: '4',
      title: 'Smart Grocery Shopping',
      description: 'Save money on groceries with these practical tips.',
      category: 'Saving',
      duration: 5,
      points: 50,
      icon: '🛒',
      questions: [
        QuizQuestion(
          question: 'What saves the most money at the grocery store?',
          options: [
            'Shopping when hungry',
            'Making a list before you go',
            'Buying whatever looks good',
            'Going every day',
          ],
          correctAnswerIndex: 1,
          explanation: 'A shopping list prevents impulse buys and helps you stay on budget!',
        ),
        QuizQuestion(
          question: 'Store brands vs name brands - which is usually cheaper?',
          options: [
            'Name brands',
            'They cost the same',
            'Store brands',
            'It varies randomly',
          ],
          correctAnswerIndex: 2,
          explanation: 'Store brands are often 20-30% cheaper and usually the same quality!',
        ),
        QuizQuestion(
          question: 'When is produce usually cheapest?',
          options: [
            'When it\'s in season',
            'During winter',
            'On weekends',
            'At night',
          ],
          correctAnswerIndex: 0,
          explanation: 'Seasonal produce is abundant and cheaper. Buy strawberries in summer, not winter!',
        ),
        QuizQuestion(
          question: 'What should you compare to find the best deal?',
          options: [
            'Package size',
            'Brand names',
            'Unit price (per ounce/gram)',
            'Total price only',
          ],
          correctAnswerIndex: 2,
          explanation: 'Unit price shows the true value. Sometimes larger isn\'t actually cheaper!',
        ),
      ],
    ),
    QuizLesson(
      id: '5',
      title: 'Building an Emergency Fund',
      description: 'Start small and build financial security for your family.',
      category: 'Saving',
      duration: 6,
      points: 60,
      icon: '🎯',
      questions: [
        QuizQuestion(
          question: 'How many months of expenses should you save?',
          options: [
            '1 month',
            '3-6 months',
            '12 months',
            '24 months',
          ],
          correctAnswerIndex: 1,
          explanation: '3-6 months gives you a safety net for job loss or emergencies.',
        ),
        QuizQuestion(
          question: 'What\'s a good first emergency fund goal?',
          options: [
            '\$100',
            '\$500',
            '\$5,000',
            '\$10,000',
          ],
          correctAnswerIndex: 1,
          explanation: '\$500 can cover most small emergencies. Start small and build from there!',
        ),
        QuizQuestion(
          question: 'Where should you keep your emergency fund?',
          options: [
            'Under your mattress',
            'In your regular checking',
            'In a separate savings account',
            'Invested in stocks',
          ],
          correctAnswerIndex: 2,
          explanation: 'Keep it separate so you won\'t spend it, but accessible for true emergencies.',
        ),
        QuizQuestion(
          question: 'You get a \$1000 tax refund. What should you do?',
          options: [
            'Spend it on something fun',
            'Save at least part of it',
            'Buy lottery tickets',
            'Lend it to friends',
          ],
          correctAnswerIndex: 1,
          explanation: 'Windfalls are perfect for boosting your emergency fund! Save at least 50% of it.',
        ),
      ],
    ),
    QuizLesson(
      id: '6',
      title: 'Understanding Credit Cards',
      description: 'Use credit responsibly to build your credit history.',
      category: 'Credit',
      duration: 8,
      points: 80,
      icon: '💳',
      questions: [
        QuizQuestion(
          question: 'What is a credit card?',
          options: [
            'Free money from the bank',
            'A loan you must repay',
            'A gift from credit companies',
            'Your own money',
          ],
          correctAnswerIndex: 1,
          explanation: 'A credit card is a loan! You must repay everything you spend, plus interest if you don\'t pay in full.',
        ),
        QuizQuestion(
          question: 'How can you avoid paying interest?',
          options: [
            'Use it a lot',
            'Pay the minimum',
            'Pay full balance each month',
            'Never check your statement',
          ],
          correctAnswerIndex: 2,
          explanation: 'Pay your full balance every month to avoid interest charges - it\'s free money!',
        ),
        QuizQuestion(
          question: 'Your credit limit is \$1000. How much should you use?',
          options: [
            'All \$1000',
            '\$900',
            'Under \$300',
            'It doesn\'t matter',
          ],
          correctAnswerIndex: 2,
          explanation: 'Keep utilization under 30% of your limit. This helps your credit score!',
        ),
        QuizQuestion(
          question: 'What happens if you miss a payment?',
          options: [
            'Nothing',
            'Small fee only',
            'Late fee + credit score damage',
            'Card gets prettier',
          ],
          correctAnswerIndex: 2,
          explanation: 'Missing payments hurts your credit score and adds fees. Set up autopay!',
        ),
        QuizQuestion(
          question: 'You see a charge you didn\'t make. What now?',
          options: [
            'Ignore it',
            'Report it immediately',
            'Pay it anyway',
            'Wait a few months',
          ],
          correctAnswerIndex: 1,
          explanation: 'Report unauthorized charges right away! You\'re protected from fraud if you report it quickly.',
        ),
      ],
    ),
  ];

  int _totalPoints = 0;

  List<QuizLesson> get lessons => _lessons;
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

  List<QuizLesson> getRecommendedLessons(String? primaryGoal) {
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

