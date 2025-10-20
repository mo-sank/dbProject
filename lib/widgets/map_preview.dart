import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../models/recommendation_model.dart';
import 'mini_map_painter.dart';

class MapPreview extends StatelessWidget {
  final List<RecommendationModel> recommendations;
  final String userLocation;

  const MapPreview({
    super.key,
    required this.recommendations,
    required this.userLocation,
  });

  @override
  Widget build(BuildContext context) {
    if (recommendations.isEmpty) {
      return Container(
        color: Colors.grey[100],
        child: const Center(
          child: Text(
            '🗺️\nSelect a category to see map',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ),
      );
    }

    return Stack(
      children: [
        // Background map
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xFF6C63FF).withValues(alpha: 0.05),
                const Color(0xFF4CAF50).withValues(alpha: 0.05),
              ],
            ),
          ),
          child: CustomPaint(
            painter: MiniMapPainter(),
            size: Size.infinite,
          ),
        ),
        
        // User location marker (center)
        Positioned(
          left: MediaQuery.of(context).size.width * 0.5 - 60,
          top: MediaQuery.of(context).size.height * 0.25 - 40,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 3),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withValues(alpha: 0.3),
                  blurRadius: 12,
                  spreadRadius: 4,
                ),
              ],
            ),
            child: const Icon(
              Icons.person_pin_circle,
              color: Colors.white,
              size: 24,
            ),
          ),
        ),
        
        // Recommendation markers
        ...recommendations.take(5).toList().asMap().entries.map((entry) {
          final index = entry.key;
          final rec = entry.value;
          final random = math.Random(rec.id.hashCode);
          
          // Position markers around the user
          final angle = (index * 2 * math.pi / 5);
          final radius = 60.0 + random.nextDouble() * 40;
          
          final left = MediaQuery.of(context).size.width * 0.5 - 60 + 
                      (math.cos(angle) * radius);
          final top = MediaQuery.of(context).size.height * 0.25 - 40 + 
                     (math.sin(angle) * radius);
          
          return Positioned(
            left: left,
            top: top,
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.red.withValues(alpha: 0.4),
                    blurRadius: 8,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Text(
                rec.icon,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          );
        }),
        
        // Legend
        Positioned(
          top: 16,
          left: 16,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 8,
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.person_pin_circle, color: Colors.blue, size: 16),
                const SizedBox(width: 6),
                const Text(
                  'You',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                ),
                const SizedBox(width: 12),
                Container(
                  width: 16,
                  height: 16,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                const Text(
                  'Places',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

