class UserModel {
  final String name;
  final String email;
  final String location;
  final int familySize;
  final String incomeRange;
  final String primaryGoal;
  final List<String> expenses;

  UserModel({
    required this.name,
    required this.email,
    required this.location,
    required this.familySize,
    required this.incomeRange,
    required this.primaryGoal,
    this.expenses = const [],
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'location': location,
        'familySize': familySize,
        'incomeRange': incomeRange,
        'primaryGoal': primaryGoal,
        'expenses': expenses,
      };

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        name: json['name'] ?? '',
        email: json['email'] ?? '',
        location: json['location'] ?? '',
        familySize: json['familySize'] ?? 1,
        incomeRange: json['incomeRange'] ?? '',
        primaryGoal: json['primaryGoal'] ?? '',
        expenses: List<String>.from(json['expenses'] ?? []),
      );
}

