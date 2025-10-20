import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import '../models/recommendation_model.dart';

class PlacesService {
  // Using mock data for hackathon - no API key needed!
  // OpenStreetMap is used for maps (also free, no key needed)

  /// Search for nearby places based on category and location
  /// Using mock data for hackathon demo (no API key needed)
  Future<List<RecommendationModel>> searchNearbyPlaces({
    required String location,
    required String category,
    int radius = 5000,
  }) async {
    // For hackathon: return enhanced mock data based on location
    return _getFallbackRecommendations(category, location);
  }

  /// Map category to Google Places type
  String _getCategoryType(String category) {
    const categoryMap = {
      'Groceries': 'supermarket',
      'Childcare': 'school',
      'Transport': 'transit_station',
      'Banking': 'bank',
    };
    return categoryMap[category] ?? 'point_of_interest';
  }

  /// Get category icon
  String _getCategoryIcon(String category) {
    const iconMap = {
      'Groceries': '🛒',
      'Childcare': '👶',
      'Transport': '🚍',
      'Banking': '🏦',
    };
    return iconMap[category] ?? '📍';
  }

  /// Convert Google price level to display format
  String _getPriceRange(int? priceLevel) {
    if (priceLevel == null) return '\$\$';
    switch (priceLevel) {
      case 0:
        return '\$';
      case 1:
        return '\$';
      case 2:
        return '\$\$';
      case 3:
        return '\$\$\$';
      case 4:
        return '\$\$\$\$';
      default:
        return '\$\$';
    }
  }

  /// Generate savings info based on price level
  String _generateSavingsInfo(String category, int? priceLevel) {
    if (priceLevel == null || priceLevel <= 1) {
      return 'Budget-friendly option';
    } else if (priceLevel == 2) {
      return 'Moderately priced';
    } else {
      return 'Premium option';
    }
  }

  /// Curated recommendations with location-aware data
  List<RecommendationModel> _getFallbackRecommendations(String category, String location) {
    // Generate realistic mock data based on location
    final random = Random();
    final all = [
      RecommendationModel(
        id: '1',
        title: 'FreshMart Supermarket',
        description: 'Affordable groceries with weekly deals and family-friendly prices.',
        category: 'Groceries',
        location: 'Near $location',
        distance: 0.8 + (random.nextDouble() * 0.5),
        priceRange: '\$\$',
        rating: 4.3 + (random.nextDouble() * 0.5),
        savingsInfo: 'Save up to 15% compared to other stores',
        icon: '🛒',
      ),
      RecommendationModel(
        id: '1b',
        title: 'Value Foods Market',
        description: 'Bulk buying options and ethnic food section at great prices.',
        category: 'Groceries',
        location: 'In $location',
        distance: 1.5 + (random.nextDouble() * 0.8),
        priceRange: '\$',
        rating: 4.2 + (random.nextDouble() * 0.5),
        savingsInfo: 'Up to 20% savings on bulk items',
        icon: '🛒',
      ),
      RecommendationModel(
        id: '2',
        title: 'Little Stars Daycare',
        description: 'Quality childcare with flexible hours and multilingual staff.',
        category: 'Childcare',
        location: '456 Oak Ave',
        distance: 1.2,
        priceRange: '\$\$',
        rating: 4.8,
        savingsInfo: '\$200/month less than average',
        icon: '👶',
      ),
      RecommendationModel(
        id: '3',
        title: 'Metro Transit Pass',
        description: 'Unlimited public transport with family discounts available.',
        category: 'Transport',
        location: 'Citywide',
        distance: 0.0,
        priceRange: '\$',
        rating: 4.3,
        savingsInfo: 'Save \$150/month vs driving',
        icon: '🚍',
      ),
      RecommendationModel(
        id: '4',
        title: 'Community Credit Union',
        description: 'No-fee checking, low-cost remittances, and bilingual support.',
        category: 'Banking',
        location: '789 Park Blvd',
        distance: 1.5,
        priceRange: '\$',
        rating: 4.7,
        savingsInfo: 'No monthly fees',
        icon: '🏦',
      ),
    ];

    if (category == 'All') return all;
    return all.where((r) => r.category == category).toList();
  }
}

