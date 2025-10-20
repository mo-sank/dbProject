import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../models/recommendation_model.dart';

class MapPreview extends StatefulWidget {
  final List<RecommendationModel> recommendations;
  final String userLocation;

  const MapPreview({
    Key? key,
    required this.recommendations,
    required this.userLocation,
  }) : super(key: key);

  @override
  State<MapPreview> createState() => _MapPreviewState();
}

class _MapPreviewState extends State<MapPreview> {
  final MapController _mapController = MapController();
  late LatLng _center;

  @override
  void initState() {
    super.initState();
    _initializeMapCenter();
  }

  void _initializeMapCenter() {
    // Parse user location to get coordinates
    // For demo purposes, using default coordinates
    // In a real app, you'd geocode the user's location
    _center = const LatLng(40.7128, -74.0060); // New York City coordinates
  }

  @override
  Widget build(BuildContext context) {
    if (widget.recommendations.isEmpty) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.grey[100],
        ),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.map_outlined,
                size: 48,
                color: Colors.grey,
              ),
              SizedBox(height: 16),
              Text(
                'Select a category to see map',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            // Real Map Tiles
            FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                initialCenter: _center,
                initialZoom: 13.0,
                minZoom: 10.0,
                maxZoom: 18.0,
                interactionOptions: const InteractionOptions(
                  flags: InteractiveFlag.pinchZoom | InteractiveFlag.drag,
                ),
              ),
              children: [
                // OpenStreetMap tiles
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.finpath',
                  maxZoom: 18,
                ),
                // Markers layer
                MarkerLayer(
                  markers: _buildMarkers(),
                ),
              ],
            ),
            // Map overlay with legend and controls
            Positioned(
              top: 12,
              left: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.9),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'You',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      width: 12,
                      height: 12,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Places',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // GPS button
            Positioned(
              bottom: 12,
              right: 12,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: IconButton(
                  onPressed: () {
                    // Center map on user location
                    _mapController.move(_center, 15.0);
                  },
                  icon: const Icon(Icons.my_location, color: Colors.blue),
                  tooltip: 'Center on your location',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Marker> _buildMarkers() {
    List<Marker> markers = [];

    // Add user location marker
    markers.add(
      Marker(
        point: _center,
        width: 40,
        height: 40,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.blue,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 3),
            boxShadow: [
              BoxShadow(
                color: Colors.blue.withValues(alpha: 0.3),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: const Icon(
            Icons.person,
            color: Colors.white,
            size: 20,
          ),
        ),
      ),
    );

    // Add recommendation markers
    for (int i = 0; i < widget.recommendations.length; i++) {
      final recommendation = widget.recommendations[i];
      final offset = _getMarkerOffset(i);
      final markerPoint = LatLng(
        _center.latitude + offset.latitude,
        _center.longitude + offset.longitude,
      );

      markers.add(
        Marker(
          point: markerPoint,
          width: 32,
          height: 32,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
              boxShadow: [
                BoxShadow(
                  color: Colors.red.withValues(alpha: 0.3),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(
              _getCategoryIcon(recommendation.category),
              color: Colors.white,
              size: 16,
            ),
          ),
        ),
      );
    }

    return markers;
  }

  LatLng _getMarkerOffset(int index) {
    // Distribute markers around the user location in a circle
    final double radius = 0.01; // Adjust this to control marker spread
    
    return LatLng(
      radius * (index % 2 == 0 ? 1 : -1) * (0.5 + (index % 3) * 0.3),
      radius * (index % 3 == 0 ? 1 : -1) * (0.5 + (index % 2) * 0.3),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'grocery':
        return Icons.shopping_cart;
      case 'childcare':
        return Icons.child_care;
      case 'transportation':
        return Icons.directions_bus;
      case 'banking':
        return Icons.account_balance;
      case 'healthcare':
        return Icons.local_hospital;
      default:
        return Icons.place;
    }
  }
}