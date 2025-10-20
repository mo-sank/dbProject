import 'package:flutter/foundation.dart';
import '../models/budget_model.dart';

class BudgetProvider extends ChangeNotifier {
  List<BudgetCategory> _categories = [];
  SavingsGoal? _savingsGoal;

  List<BudgetCategory> get categories => _categories;
  SavingsGoal? get savingsGoal => _savingsGoal;

  double get totalBudget => _categories.fold(0, (sum, cat) => sum + cat.budgeted);
  double get totalSpent => _categories.fold(0, (sum, cat) => sum + cat.spent);
  double get totalRemaining => totalBudget - totalSpent;

  void initializeBudget(String incomeRange) {
    // Initialize based on income range
    double income = _parseIncome(incomeRange);
    
    _categories = [
      BudgetCategory(
        name: 'Housing',
        budgeted: income * 0.30,
        spent: income * 0.28,
        icon: '🏠',
        color: 0xFF6C63FF,
      ),
      BudgetCategory(
        name: 'Childcare',
        budgeted: income * 0.20,
        spent: income * 0.15,
        icon: '👶',
        color: 0xFFFF6B9D,
      ),
      BudgetCategory(
        name: 'Groceries',
        budgeted: income * 0.15,
        spent: income * 0.12,
        icon: '🛒',
        color: 0xFF4CAF50,
      ),
      BudgetCategory(
        name: 'Transportation',
        budgeted: income * 0.10,
        spent: income * 0.08,
        icon: '🚗',
        color: 0xFFFF9800,
      ),
      BudgetCategory(
        name: 'Remittances',
        budgeted: income * 0.10,
        spent: income * 0.10,
        icon: '💸',
        color: 0xFF2196F3,
      ),
      BudgetCategory(
        name: 'Other',
        budgeted: income * 0.15,
        spent: income * 0.10,
        icon: '📦',
        color: 0xFF9C27B0,
      ),
    ];

    _savingsGoal = SavingsGoal(
      name: 'Emergency Fund',
      target: 500,
      current: 125,
      icon: '🎯',
    );

    notifyListeners();
  }

  double _parseIncome(String incomeRange) {
    // Parse income range string to approximate monthly income
    if (incomeRange.contains('2000-3000')) return 2500;
    if (incomeRange.contains('3000-4000')) return 3500;
    if (incomeRange.contains('4000-5000')) return 4500;
    if (incomeRange.contains('5000+')) return 6000;
    return 2000;
  }

  void addToSavings(double amount) {
    if (_savingsGoal != null) {
      _savingsGoal!.current += amount;
      notifyListeners();
    }
  }

  void updateSpending(String categoryName, double amount) {
    final category = _categories.firstWhere((cat) => cat.name == categoryName);
    category.spent += amount;
    notifyListeners();
  }
}

