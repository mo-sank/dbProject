class RecommendationModel {
  final String id;
  final String title;
  final String description;
  final String category;
  final String location;
  final double distance; // in km
  final String priceRange;
  final double rating;
  final String savingsInfo;
  final String icon;

  RecommendationModel({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.location,
    required this.distance,
    required this.priceRange,
    required this.rating,
    required this.savingsInfo,
    required this.icon,
  });
}

