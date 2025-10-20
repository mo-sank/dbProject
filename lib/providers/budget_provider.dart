import 'package:flutter/foundation.dart';
import '../models/budget_model.dart';
import '../services/firebase_service.dart';

class BudgetProvider extends ChangeNotifier {
  List<BudgetCategory> _categories = [];
  SavingsGoal? _savingsGoal;
  bool _isLoading = false;
  FirebaseService? _firebaseService;

  List<BudgetCategory> get categories => _categories;
  SavingsGoal? get savingsGoal => _savingsGoal;
  bool get isLoading => _isLoading;

  double get totalBudget => _categories.fold(0, (sum, cat) => sum + cat.budgeted);
  double get totalSpent => _categories.fold(0, (sum, cat) => sum + cat.spent);
  double get totalRemaining => totalBudget - totalSpent;

  void setFirebaseService(FirebaseService service) {
    _firebaseService = service;
    loadBudgetData();
  }

  Future<void> loadBudgetData() async {
    if (_firebaseService == null) return;
    
    _isLoading = true;
    notifyListeners();
    
    try {
      final categories = await _firebaseService!.getBudgetCategories();
      if (categories != null) {
        _categories = categories;
      }
      
      final goal = await _firebaseService!.getSavingsGoal();
      if (goal != null) {
        _savingsGoal = goal;
      }
    } catch (e) {
      print('Error loading budget data: $e');
    }
    
    _isLoading = false;
    notifyListeners();
  }

  Future<void> initializeBudget(String incomeRange) async {
    // Initialize based on income range
    double income = _parseIncome(incomeRange);
    
    _categories = [
      BudgetCategory(
        name: 'Housing',
        budgeted: income * 0.30,
        spent: 0, // User will input actual amount
        icon: '🏠',
        color: 0xFF6C63FF,
      ),
      BudgetCategory(
        name: 'Childcare',
        budgeted: income * 0.20,
        spent: 0, // User will input actual amount
        icon: '👶',
        color: 0xFFFF6B9D,
      ),
      BudgetCategory(
        name: 'Groceries',
        budgeted: income * 0.15,
        spent: 0, // User will input actual amount
        icon: '🛒',
        color: 0xFF4CAF50,
      ),
      BudgetCategory(
        name: 'Transportation',
        budgeted: income * 0.10,
        spent: 0, // User will input actual amount
        icon: '🚗',
        color: 0xFFFF9800,
      ),
      BudgetCategory(
        name: 'Remittances',
        budgeted: income * 0.10,
        spent: 0, // User will input actual amount
        icon: '💸',
        color: 0xFF2196F3,
      ),
      BudgetCategory(
        name: 'Other',
        budgeted: income * 0.15,
        spent: 0, // User will input actual amount
        icon: '📦',
        color: 0xFF9C27B0,
      ),
    ];

    _savingsGoal = SavingsGoal(
      name: 'Emergency Fund',
      target: 500,
      current: 0,
      icon: '🎯',
    );

    notifyListeners();
    
    // Save to Firebase
    if (_firebaseService != null) {
      await _firebaseService!.saveBudgetCategories(_categories);
      await _firebaseService!.saveSavingsGoal(_savingsGoal!);
    }
  }

  double _parseIncome(String incomeRange) {
    // Parse income range string to approximate monthly income
    if (incomeRange.contains('2000-3000')) return 2500;
    if (incomeRange.contains('3000-4000')) return 3500;
    if (incomeRange.contains('4000-5000')) return 4500;
    if (incomeRange.contains('5000+')) return 6000;
    return 2000;
  }

  Future<void> addToSavings(double amount) async {
    if (_savingsGoal != null) {
      _savingsGoal!.current += amount;
      notifyListeners();
      
      // Save to Firebase
      if (_firebaseService != null) {
        await _firebaseService!.updateSavingsProgress(_savingsGoal!.current);
      }
    }
  }

  Future<void> updateSpending(String categoryName, double amount) async {
    final category = _categories.firstWhere((cat) => cat.name == categoryName);
    category.spent += amount;
    notifyListeners();
    
    // Save to Firebase
    if (_firebaseService != null) {
      await _firebaseService!.updateCategorySpending(categoryName, category.spent);
    }
  }

  Future<void> saveBudgetToFirebase() async {
    if (_firebaseService != null) {
      await _firebaseService!.saveBudgetCategories(_categories);
      if (_savingsGoal != null) {
        await _firebaseService!.saveSavingsGoal(_savingsGoal!);
      }
    }
    notifyListeners();
  }

  void updateCategoryBudget(String categoryName, double budgeted, double spent) {
    final category = _categories.firstWhere((cat) => cat.name == categoryName);
    category.budgeted = budgeted;
    category.spent = spent;
    notifyListeners();
  }
}

