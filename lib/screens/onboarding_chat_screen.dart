import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:animate_do/animate_do.dart';
import '../models/user_model.dart';
import '../providers/user_provider.dart';
import '../providers/budget_provider.dart';
import 'dashboard_screen.dart';

class OnboardingChatScreen extends StatefulWidget {
  final String name;
  final String email;

  const OnboardingChatScreen({
    super.key,
    required this.name,
    required this.email,
  });

  @override
  State<OnboardingChatScreen> createState() => _OnboardingChatScreenState();
}

class _OnboardingChatScreenState extends State<OnboardingChatScreen> {
  final List<ChatMessage> _messages = [];
  int _currentStep = 0;
  
  String? _location;
  int? _familySize;
  String? _incomeRange;
  String? _primaryGoal;

  final List<OnboardingQuestion> _questions = [
    OnboardingQuestion(
      text: 'Hi! I\'m FinBot, your AI financial buddy! 🤖✨\n\nI\'m here to help you manage your budget and find the best local resources for your family.\n\nLet\'s get to know each other! Where do you currently live?',
      type: QuestionType.text,
      key: 'location',
    ),
    OnboardingQuestion(
      text: 'Great! How many people are in your family?',
      type: QuestionType.options,
      key: 'familySize',
      options: ['Just me', '2 people', '3 people', '4 people', '5+ people'],
    ),
    OnboardingQuestion(
      text: 'What\'s your monthly household income range? (This helps me provide better recommendations)',
      type: QuestionType.options,
      key: 'incomeRange',
      options: [
        'Under \$2000',
        '\$2000-\$3000',
        '\$3000-\$4000',
        '\$4000-\$5000',
        '\$5000+',
      ],
    ),
    OnboardingQuestion(
      text: 'What\'s your main financial goal right now?',
      type: QuestionType.options,
      key: 'primaryGoal',
      options: [
        'Save for emergency fund',
        'Reduce monthly expenses',
        'Pay off debt',
        'Save for children\'s education',
        'Build credit',
      ],
    ),
  ];

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), _askNextQuestion);
  }

  void _askNextQuestion() {
    if (_currentStep < _questions.length) {
      setState(() {
        _messages.add(ChatMessage(
          text: _questions[_currentStep].text,
          isBot: true,
          timestamp: DateTime.now(),
        ));
      });
    } else {
      _completeOnboarding();
    }
  }

  void _handleAnswer(String answer) {
    setState(() {
      _messages.add(ChatMessage(
        text: answer,
        isBot: false,
        timestamp: DateTime.now(),
      ));
    });

    // Store the answer
    final question = _questions[_currentStep];
    switch (question.key) {
      case 'location':
        _location = answer;
        break;
      case 'familySize':
        _familySize = _questions[_currentStep].options!.indexOf(answer) + 1;
        break;
      case 'incomeRange':
        _incomeRange = answer;
        break;
      case 'primaryGoal':
        _primaryGoal = answer;
        break;
    }

    _currentStep++;
    
    // Add a small delay before next question
    Future.delayed(const Duration(milliseconds: 800), () {
      if (_currentStep < _questions.length) {
        setState(() {
          _messages.add(ChatMessage(
            text: _getTransitionMessage(),
            isBot: true,
            timestamp: DateTime.now(),
          ));
        });
      }
      
      Future.delayed(const Duration(milliseconds: 600), _askNextQuestion);
    });
  }

  String _getTransitionMessage() {
    final messages = [
      'Perfect! 👍',
      'Got it! 📝',
      'Excellent! ✨',
      'Wonderful! 🎉',
    ];
    return messages[_currentStep % messages.length];
  }

  void _completeOnboarding() {
    setState(() {
      _messages.add(ChatMessage(
        text: 'Amazing! I\'ve learned a lot about you. 🎊\n\nI\'ve prepared a personalized dashboard with your budget, savings goals, and local recommendations just for you!\n\nLet\'s start building your financial future together! 💪',
        isBot: true,
        timestamp: DateTime.now(),
      ));
    });

    // Save user data
    final user = UserModel(
      name: widget.name,
      email: widget.email,
      location: _location!,
      familySize: _familySize!,
      incomeRange: _incomeRange!,
      primaryGoal: _primaryGoal!,
    );

    Provider.of<UserProvider>(context, listen: false).setUser(user);
    Provider.of<BudgetProvider>(context, listen: false).initializeBudget(_incomeRange!);

    // Navigate to dashboard after a delay
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const DashboardScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat with FinBot'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return FadeInUp(
                  duration: const Duration(milliseconds: 400),
                  child: _ChatBubble(message: _messages[index]),
                );
              },
            ),
          ),
          if (_currentStep < _questions.length && 
              _messages.isNotEmpty &&
              _messages.last.isBot)
            _buildInputArea(),
        ],
      ),
    );
  }

  Widget _buildInputArea() {
    final question = _questions[_currentStep];
    
    if (question.type == QuestionType.options) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: question.options!.map((option) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _handleAnswer(option),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    foregroundColor: Theme.of(context).colorScheme.primary,
                    elevation: 0,
                    padding: const EdgeInsets.all(16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(option),
                ),
              ),
            );
          }).toList(),
        ),
      );
    }

    // Text input
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Type your answer...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
              onSubmitted: _handleAnswer,
            ),
          ),
        ],
      ),
    );
  }
}

class _ChatBubble extends StatelessWidget {
  final ChatMessage message;

  const _ChatBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: message.isBot 
            ? MainAxisAlignment.start 
            : MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (message.isBot)
            Container(
              width: 40,
              height: 40,
              margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Text('🤖', style: TextStyle(fontSize: 20)),
              ),
            ),
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: message.isBot
                    ? Colors.grey[200]
                    : Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                message.text,
                style: TextStyle(
                  color: message.isBot ? Colors.black87 : Colors.white,
                  fontSize: 15,
                  height: 1.4,
                ),
              ),
            ),
          ),
          if (!message.isBot)
            Container(
              width: 40,
              height: 40,
              margin: const EdgeInsets.only(left: 8),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Text('👤', style: TextStyle(fontSize: 20)),
              ),
            ),
        ],
      ),
    );
  }
}

class ChatMessage {
  final String text;
  final bool isBot;
  final DateTime timestamp;

  ChatMessage({
    required this.text,
    required this.isBot,
    required this.timestamp,
  });
}

class OnboardingQuestion {
  final String text;
  final QuestionType type;
  final String key;
  final List<String>? options;

  OnboardingQuestion({
    required this.text,
    required this.type,
    required this.key,
    this.options,
  });
}

enum QuestionType { text, options }

