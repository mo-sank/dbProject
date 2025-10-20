import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:animate_do/animate_do.dart';
import '../models/recommendation_model.dart';
import '../providers/user_provider.dart';

class RecommendationsScreen extends StatefulWidget {
  const RecommendationsScreen({super.key});

  @override
  State<RecommendationsScreen> createState() => _RecommendationsScreenState();
}

class _RecommendationsScreenState extends State<RecommendationsScreen> {
  String _selectedCategory = 'All';

  final List<String> _categories = [
    'All',
    'Groceries',
    'Childcare',
    'Transport',
    'Banking',
  ];

  List<RecommendationModel> _getRecommendations() {
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
    final recommendations = _getRecommendations();
    final filteredRecommendations = _selectedCategory == 'All'
        ? recommendations
        : recommendations.where((r) => r.category == _selectedCategory).toList();

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
                    const Text(
                      'Local Deals',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
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
              SizedBox(
                height: 50,
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
                        backgroundColor: Colors.white.withOpacity(0.2),
                        selectedColor: Colors.white,
                        labelStyle: TextStyle(
                          color: isSelected ? Theme.of(context).colorScheme.primary : Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),

              // Recommendations List
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: ListView.builder(
                    padding: const EdgeInsets.all(20),
                    itemCount: filteredRecommendations.length,
                    itemBuilder: (context, index) {
                      return FadeInUp(
                        delay: Duration(milliseconds: 50 * index),
                        child: _RecommendationCard(
                          recommendation: filteredRecommendations[index],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RecommendationCard extends StatelessWidget {
  final RecommendationModel recommendation;

  const _RecommendationCard({required this.recommendation});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      recommendation.icon,
                      style: const TextStyle(fontSize: 32),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              recommendation.title,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.amber[100],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.star,
                                  size: 14,
                                  color: Colors.amber,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '${recommendation.rating}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        recommendation.description,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.location_on, size: 14, color: Colors.grey),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              recommendation.location,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          if (recommendation.distance > 0) ...[
                            const SizedBox(width: 8),
                            Text(
                              '${recommendation.distance} km',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.green[50],
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.savings,
                  size: 16,
                  color: Colors.green,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    recommendation.savingsInfo,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.green,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text(
                  recommendation.priceRange,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

