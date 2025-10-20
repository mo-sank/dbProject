import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../models/recommendation_model.dart';

class MapViewScreen extends StatelessWidget {
  final List<RecommendationModel> recommendations;
  final String userLocation;

  const MapViewScreen({
    super.key,
    required this.recommendations,
    required this.userLocation,
  });

  @override
  Widget build(BuildContext context) {
    // Default center (will be user's location in production)
    final center = LatLng(40.7128, -74.0060); // NYC as default

    // Generate markers for recommendations
    final markers = recommendations.map((rec) {
      // Generate random nearby coordinates for demo
      final random = (rec.distance * 0.01);
      return Marker(
        point: LatLng(
          center.latitude + (random * (rec.id.hashCode % 2 == 0 ? 1 : -1)),
          center.longitude + (random * (rec.id.hashCode % 3 == 0 ? 1 : -1)),
        ),
        width: 40,
        height: 40,
        child: GestureDetector(
          onTap: () {
            _showRecommendationDetails(context, rec);
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 6,
                ),
              ],
            ),
            child: Center(
              child: Text(
                rec.icon,
                style: const TextStyle(fontSize: 20),
              ),
            ),
          ),
        ),
      );
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Map View'),
        centerTitle: true,
        actions: [
          TextButton.icon(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.list),
            label: const Text('List'),
          ),
        ],
      ),
      body: FlutterMap(
        options: MapOptions(
          initialCenter: center,
          initialZoom: 13.0,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.finpath',
            maxZoom: 19,
          ),
          MarkerLayer(markers: markers),
        ],
      ),
    );
  }

  void _showRecommendationDetails(BuildContext context, RecommendationModel rec) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(rec.icon, style: const TextStyle(fontSize: 40)),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        rec.title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        rec.location,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              rec.description,
              style: const TextStyle(fontSize: 15),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.amber[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.star, size: 16, color: Colors.amber),
                      const SizedBox(width: 4),
                      Text(
                        '${rec.rating.toStringAsFixed(1)}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '${rec.distance.toStringAsFixed(1)} km',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const Spacer(),
                Text(
                  rec.priceRange,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.green[50],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.savings, color: Colors.green),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      rec.savingsInfo,
                      style: const TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

