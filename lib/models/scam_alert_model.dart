class ScamAlert {
  final String id;
  final String alert;
  final String tip;
  final String location;
  final String category;
  final DateTime createdAt;
  final int priority; // 1 = high, 2 = medium, 3 = low
  final bool isActive;

  ScamAlert({
    required this.id,
    required this.alert,
    required this.tip,
    required this.location,
    required this.category,
    required this.createdAt,
    this.priority = 2,
    this.isActive = true,
  });

  factory ScamAlert.fromJson(Map<String, dynamic> json) {
    return ScamAlert(
      id: json['id'] ?? '',
      alert: json['alert'] ?? '',
      tip: json['tip'] ?? '',
      location: json['location'] ?? '',
      category: json['category'] ?? 'General',
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      priority: json['priority'] ?? 2,
      isActive: json['isActive'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'alert': alert,
      'tip': tip,
      'location': location,
      'category': category,
      'createdAt': createdAt.toIso8601String(),
      'priority': priority,
      'isActive': isActive,
    };
  }

  ScamAlert copyWith({
    String? id,
    String? alert,
    String? tip,
    String? location,
    String? category,
    DateTime? createdAt,
    int? priority,
    bool? isActive,
  }) {
    return ScamAlert(
      id: id ?? this.id,
      alert: alert ?? this.alert,
      tip: tip ?? this.tip,
      location: location ?? this.location,
      category: category ?? this.category,
      createdAt: createdAt ?? this.createdAt,
      priority: priority ?? this.priority,
      isActive: isActive ?? this.isActive,
    );
  }

  @override
  String toString() {
    return 'ScamAlert(id: $id, alert: $alert, location: $location, priority: $priority)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ScamAlert && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
