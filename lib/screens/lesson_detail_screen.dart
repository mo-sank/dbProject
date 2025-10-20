import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:animate_do/animate_do.dart';
import 'package:confetti/confetti.dart';
import '../models/lesson_model.dart';
import '../providers/lesson_provider.dart';

class LessonDetailScreen extends StatefulWidget {
  final LessonModel lesson;

  const LessonDetailScreen({super.key, required this.lesson});

  @override
  State<LessonDetailScreen> createState() => _LessonDetailScreenState();
}

class _LessonDetailScreenState extends State<LessonDetailScreen> {
  late ConfettiController _confettiController;
  int _currentStep = 0;
  bool _hasCompleted = false;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 3));
    _hasCompleted = widget.lesson.isCompleted;
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  void _completeLesson() {
    if (!_hasCompleted) {
      Provider.of<LessonProvider>(context, listen: false)
          .completeLesson(widget.lesson.id);
      _confettiController.play();
      setState(() => _hasCompleted = true);

      // Show completion dialog
      Future.delayed(const Duration(milliseconds: 500), () {
        showDialog(
          context: context,
          builder: (context) => _CompletionDialog(points: widget.lesson.points),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 200,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    widget.lesson.icon,
                    style: const TextStyle(fontSize: 32),
                  ),
                  background: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Theme.of(context).colorScheme.primary,
                          Theme.of(context).colorScheme.secondary,
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FadeInDown(
                        child: Text(
                          widget.lesson.title,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      FadeInDown(
                        delay: const Duration(milliseconds: 100),
                        child: Text(
                          widget.lesson.description,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      FadeInDown(
                        delay: const Duration(milliseconds: 200),
                        child: Row(
                          children: [
                            _InfoChip(
                              icon: '⏱️',
                              label: '${widget.lesson.duration} min',
                            ),
                            const SizedBox(width: 12),
                            _InfoChip(
                              icon: '🏆',
                              label: '${widget.lesson.points} pts',
                            ),
                            const SizedBox(width: 12),
                            _InfoChip(
                              icon: '📚',
                              label: widget.lesson.category,
                            ),
                          ],
                        ),
                      ),
                      if (_hasCompleted)
                        FadeInDown(
                          delay: const Duration(milliseconds: 300),
                          child: Container(
                            margin: const EdgeInsets.only(top: 16),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.green[50],
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.green),
                            ),
                            child: const Row(
                              children: [
                                Text('✅', style: TextStyle(fontSize: 24)),
                                SizedBox(width: 12),
                                Text(
                                  'Completed!',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      const SizedBox(height: 32),
                      const Text(
                        'Key Points',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ...widget.lesson.content.asMap().entries.map((entry) {
                        final index = entry.key;
                        final content = entry.value;
                        return FadeInUp(
                          delay: Duration(milliseconds: 100 * index),
                          child: _ContentCard(
                            number: index + 1,
                            content: content,
                            isRevealed: _currentStep >= index,
                            onTap: () {
                              if (_currentStep == index) {
                                setState(() => _currentStep++);
                                
                                // Complete when all content is revealed
                                if (_currentStep >= widget.lesson.content.length) {
                                  Future.delayed(const Duration(milliseconds: 500), _completeLesson);
                                }
                              }
                            },
                          ),
                        );
                      }),
                      const SizedBox(height: 80),
                    ],
                  ),
                ),
              ),
            ],
          ),
          // Confetti
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirection: 3.14 / 2,
              emissionFrequency: 0.05,
              numberOfParticles: 20,
              gravity: 0.1,
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.all(20),
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
        child: SafeArea(
          child: SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: _currentStep < widget.lesson.content.length
                  ? null
                  : () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Colors.white,
                disabledBackgroundColor: Colors.grey[300],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                _currentStep < widget.lesson.content.length
                    ? 'Tap cards to continue'
                    : 'Back to Lessons',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final String icon;
  final String label;

  const _InfoChip({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(icon, style: const TextStyle(fontSize: 16)),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}

class _ContentCard extends StatelessWidget {
  final int number;
  final String content;
  final bool isRevealed;
  final VoidCallback onTap;

  const _ContentCard({
    required this.number,
    required this.content,
    required this.isRevealed,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isRevealed ? null : onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isRevealed ? Colors.white : Colors.grey[200],
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isRevealed
                ? Theme.of(context).colorScheme.primary
                : Colors.grey[300]!,
          ),
          boxShadow: isRevealed
              ? [
                  BoxShadow(
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ]
              : null,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: isRevealed
                    ? Theme.of(context).colorScheme.primary
                    : Colors.grey[400],
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '$number',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                isRevealed ? content : 'Tap to reveal',
                style: TextStyle(
                  fontSize: 15,
                  color: isRevealed ? Colors.black87 : Colors.grey,
                  fontStyle: isRevealed ? FontStyle.normal : FontStyle.italic,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CompletionDialog extends StatelessWidget {
  final int points;

  const _CompletionDialog({required this.points});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ZoomIn(
              child: const Text(
                '🎉',
                style: TextStyle(fontSize: 80),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Congratulations!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'You earned $points points!',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.all(16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Awesome!',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

