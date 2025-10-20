import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:animate_do/animate_do.dart';
import '../models/recommendation_model.dart';
import '../providers/user_provider.dart';
import '../services/places_service.dart';
import '../widgets/map_preview.dart';
import 'map_view_screen.dart';

class RecommendationsScreen extends StatefulWidget {
  const RecommendationsScreen({super.key});

  @override
  State<RecommendationsScreen> createState() => _RecommendationsScreenState();
}

class _RecommendationsScreenState extends State<RecommendationsScreen> {
  String _selectedCategory = 'All';
  List<RecommendationModel> _recommendations = [];
  bool _isLoading = false;
  final PlacesService _placesService = PlacesService();

  final List<String> _categories = [
    'All',
    'Groceries',
    'Childcare',
    'Transport',
    'Banking',
  ];

  @override
  void initState() {
    super.initState();
    _loadRecommendations();
  }

  Future<void> _loadRecommendations() async {
    setState(() => _isLoading = true);
    
    final user = Provider.of<UserProvider>(context, listen: false).user;
    if (user == null) return;

    try {
      // Load recommendations for all categories
      final allRecs = <RecommendationModel>[];
      
      for (var category in _categories) {
        if (category == 'All') continue;
        
        final recs = await _placesService.searchNearbyPlaces(
          location: user.location,
          category: category,
        );
        allRecs.addAll(recs);
      }
      
      setState(() {
        _recommendations = allRecs;
        _isLoading = false;
      });
    } catch (e) {
      // Fallback to curated recommendations
      setState(() {
        _recommendations = _getFallbackRecommendations();
        _isLoading = false;
      });
    }
  }

  List<RecommendationModel> _getFallbackRecommendations() {
    return [
      RecommendationModel(
        id: '1',
        title: 'FreshMart Supermarket',
        description: 'Affordable groceries with weekly deals and family-friendly prices.',
        category: 'Groceries',
        location: '123 Main St',
        distance: 0.8,
        priceRange: '\$\$',
        rating: 4.5,
        savingsInfo: 'Save up to 15% compared to other stores',
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
      RecommendationModel(
        id: '5',
        title: 'Value Foods Market',
        description: 'Bulk buying options and ethnic food section at great prices.',
        category: 'Groceries',
        location: '321 Elm St',
        distance: 2.1,
        priceRange: '\$',
        rating: 4.4,
        savingsInfo: 'Up to 20% savings on bulk items',
        icon: '🛒',
      ),
      RecommendationModel(
        id: '6',
        title: 'Happy Kids Learning Center',
        description: 'After-school programs with homework help and activities.',
        category: 'Childcare',
        location: '654 Pine Rd',
        distance: 1.8,
        priceRange: '\$\$',
        rating: 4.6,
        savingsInfo: 'Flexible payment plans available',
        icon: '👶',
      ),
      RecommendationModel(
        id: '7',
        title: 'BikeShare Network',
        description: 'Affordable bike rentals throughout the city.',
        category: 'Transport',
        location: 'Multiple stations',
        distance: 0.5,
        priceRange: '\$',
        rating: 4.2,
        savingsInfo: 'First 30 mins free',
        icon: '🚲',
      ),
      RecommendationModel(
        id: '8',
        title: 'First Steps Bank',
        description: 'Special accounts for immigrants with low minimum balance.',
        category: 'Banking',
        location: '987 Broadway',
        distance: 2.3,
        priceRange: '\$',
        rating: 4.5,
        savingsInfo: 'No overdraft fees',
        icon: '🏦',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user!;
    final filteredRecommendations = _selectedCategory == 'All'
        ? _recommendations
        : _recommendations.where((r) => r.category == _selectedCategory).toList();

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.center,
            colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.background,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Local Deals',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => MapViewScreen(
                                  recommendations: filteredRecommendations,
                                  userLocation: user.location,
                                ),
                              ),
                            );
                          },
                          icon: const Icon(Icons.map_outlined),
                          color: Colors.white,
                          iconSize: 28,
                          tooltip: 'Map View',
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Affordable services near ${user.location}',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),

              // Category Filter
              Container(
                height: 50,
                margin: const EdgeInsets.only(bottom: 8),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: _categories.length,
                  itemBuilder: (context, index) {
                    final category = _categories[index];
                    final isSelected = category == _selectedCategory;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: FilterChip(
                        label: Text(category),
                        selected: isSelected,
                        onSelected: (selected) {
                          setState(() => _selectedCategory = category);
                        },
                        backgroundColor: Colors.white,
                        selectedColor: Theme.of(context).colorScheme.primary,
                        side: BorderSide(
                          color: isSelected 
                              ? Theme.of(context).colorScheme.primary
                              : Colors.white.withValues(alpha: 0.5),
                          width: isSelected ? 2 : 1,
                        ),
                        labelStyle: TextStyle(
                          color: isSelected ? Colors.white : Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 12),

              // Split View: Map (top half) + List (bottom half)
              Expanded(
                child: _isLoading
                    ? const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(color: Colors.white),
                            SizedBox(height: 16),
                            Text(
                              'Finding local deals...',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      )
                    : Column(
                        children: [
                          // Map View (Top Half)
                          Expanded(
                            flex: 1,
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                color: Colors.white,
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
                                child: MapPreview(
                                  recommendations: filteredRecommendations,
                                  userLocation: user.location,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          
                          // Recommendations List (Bottom Half)
                          Expanded(
                            flex: 1,
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '${filteredRecommendations.length} places found',
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        TextButton.icon(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (_) => MapViewScreen(
                                                  recommendations: filteredRecommendations,
                                                  userLocation: user.location,
                                                ),
                                              ),
                                            );
                                          },
                                          icon: const Icon(Icons.fullscreen, size: 18),
                                          label: const Text('Full Map'),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: filteredRecommendations.isEmpty
                                        ? Center(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                const Text('📍', style: TextStyle(fontSize: 48)),
                                                const SizedBox(height: 12),
                                                const Text(
                                                  'No places found',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                const SizedBox(height: 4),
                                                Text(
                                                  'Try a different category',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.grey[600],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        : ListView.builder(
                                            padding: const EdgeInsets.symmetric(horizontal: 20),
                                            itemCount: filteredRecommendations.length,
                                            itemBuilder: (context, index) {
                                              return FadeInUp(
                                                delay: Duration(milliseconds: 50 * index),
                                                child: _CompactRecommendationCard(
                                                  recommendation: filteredRecommendations[index],
                                                ),
                                              );
                                            },
                                          ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Compact card for split-view list
class _CompactRecommendationCard extends StatelessWidget {
  final RecommendationModel recommendation;

  const _CompactRecommendationCard({required this.recommendation});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(recommendation.icon, style: const TextStyle(fontSize: 20)),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  recommendation.title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    const Icon(Icons.star, size: 12, color: Colors.amber),
                    const SizedBox(width: 4),
                    Text(
                      '${recommendation.rating.toStringAsFixed(1)}',
                      style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.navigation, size: 10, color: Colors.blue),
                    const SizedBox(width: 4),
                    Text(
                      '${recommendation.distance.toStringAsFixed(1)} km',
                      style: const TextStyle(fontSize: 11, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Text(
            recommendation.priceRange,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}


