import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_model.dart';
import '../models/budget_model.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get current user ID
  String? get currentUserId => _auth.currentUser?.uid;

  // Authentication
  Future<User?> signUpWithEmail(String email, String password, String name) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      // Update display name
      await credential.user?.updateDisplayName(name);
      
      return credential.user;
    } catch (e) {
      print('Sign up error: $e');
      rethrow;
    }
  }

  Future<User?> signInWithEmail(String email, String password) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } catch (e) {
      print('Sign in error: $e');
      rethrow;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  // User Profile
  Future<void> saveUserProfile(UserModel user) async {
    if (currentUserId == null) return;
    
    await _firestore.collection('users').doc(currentUserId).set({
      'name': user.name,
      'email': user.email,
      'location': user.location,
      'familySize': user.familySize,
      'incomeRange': user.incomeRange,
      'primaryGoal': user.primaryGoal,
      'expenses': user.expenses,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  Future<UserModel?> getUserProfile() async {
    if (currentUserId == null) return null;
    
    try {
      final doc = await _firestore.collection('users').doc(currentUserId).get();
      if (!doc.exists) return null;
      
      final data = doc.data()!;
      return UserModel(
        name: data['name'] ?? '',
        email: data['email'] ?? '',
        location: data['location'] ?? '',
        familySize: data['familySize'] ?? 1,
        incomeRange: data['incomeRange'] ?? '',
        primaryGoal: data['primaryGoal'] ?? '',
        expenses: List<String>.from(data['expenses'] ?? []),
      );
    } catch (e) {
      print('Error getting user profile: $e');
      return null;
    }
  }

  // Budget
  Future<void> saveBudgetCategories(List<BudgetCategory> categories) async {
    if (currentUserId == null) return;
    
    final categoriesData = categories.map((cat) => {
      'name': cat.name,
      'budgeted': cat.budgeted,
      'spent': cat.spent,
      'icon': cat.icon,
      'color': cat.color,
    }).toList();
    
    await _firestore.collection('users').doc(currentUserId).update({
      'budgetCategories': categoriesData,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<List<BudgetCategory>?> getBudgetCategories() async {
    if (currentUserId == null) return null;
    
    try {
      final doc = await _firestore.collection('users').doc(currentUserId).get();
      if (!doc.exists || doc.data()?['budgetCategories'] == null) return null;
      
      final categoriesData = List<Map<String, dynamic>>.from(doc.data()!['budgetCategories']);
      return categoriesData.map((data) => BudgetCategory(
        name: data['name'],
        budgeted: (data['budgeted'] as num).toDouble(),
        spent: (data['spent'] as num).toDouble(),
        icon: data['icon'],
        color: data['color'],
      )).toList();
    } catch (e) {
      print('Error getting budget categories: $e');
      return null;
    }
  }

  Future<void> updateCategorySpending(String categoryName, double newSpent) async {
    if (currentUserId == null) return;
    
    try {
      final doc = await _firestore.collection('users').doc(currentUserId).get();
      if (!doc.exists) return;
      
      final categoriesData = List<Map<String, dynamic>>.from(doc.data()!['budgetCategories'] ?? []);
      final categoryIndex = categoriesData.indexWhere((cat) => cat['name'] == categoryName);
      
      if (categoryIndex != -1) {
        categoriesData[categoryIndex]['spent'] = newSpent;
        await _firestore.collection('users').doc(currentUserId).update({
          'budgetCategories': categoriesData,
          'updatedAt': FieldValue.serverTimestamp(),
        });
      }
    } catch (e) {
      print('Error updating category spending: $e');
    }
  }

  // Savings Goal
  Future<void> saveSavingsGoal(SavingsGoal goal) async {
    if (currentUserId == null) return;
    
    await _firestore.collection('users').doc(currentUserId).update({
      'savingsGoal': {
        'name': goal.name,
        'target': goal.target,
        'current': goal.current,
        'icon': goal.icon,
      },
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<SavingsGoal?> getSavingsGoal() async {
    if (currentUserId == null) return null;
    
    try {
      final doc = await _firestore.collection('users').doc(currentUserId).get();
      if (!doc.exists || doc.data()?['savingsGoal'] == null) return null;
      
      final data = doc.data()!['savingsGoal'] as Map<String, dynamic>;
      return SavingsGoal(
        name: data['name'],
        target: (data['target'] as num).toDouble(),
        current: (data['current'] as num).toDouble(),
        icon: data['icon'],
      );
    } catch (e) {
      print('Error getting savings goal: $e');
      return null;
    }
  }

  Future<void> updateSavingsProgress(double newCurrent) async {
    if (currentUserId == null) return;
    
    try {
      final doc = await _firestore.collection('users').doc(currentUserId).get();
      if (!doc.exists) return;
      
      final goalData = Map<String, dynamic>.from(doc.data()!['savingsGoal'] ?? {});
      goalData['current'] = newCurrent;
      
      await _firestore.collection('users').doc(currentUserId).update({
        'savingsGoal': goalData,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error updating savings progress: $e');
    }
  }

  // Lessons Progress
  Future<void> saveLessonProgress(Map<String, bool> completedLessons, int totalPoints) async {
    if (currentUserId == null) return;
    
    await _firestore.collection('users').doc(currentUserId).update({
      'completedLessons': completedLessons,
      'totalPoints': totalPoints,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<Map<String, dynamic>?> getLessonProgress() async {
    if (currentUserId == null) return null;
    
    try {
      final doc = await _firestore.collection('users').doc(currentUserId).get();
      if (!doc.exists) return null;
      
      return {
        'completedLessons': Map<String, bool>.from(doc.data()?['completedLessons'] ?? {}),
        'totalPoints': doc.data()?['totalPoints'] ?? 0,
      };
    } catch (e) {
      print('Error getting lesson progress: $e');
      return null;
    }
  }

  // Language Preference
  Future<void> saveLanguagePreference(String languageCode) async {
    if (currentUserId == null) return;
    
    await _firestore.collection('users').doc(currentUserId).update({
      'languagePreference': languageCode,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<String?> getLanguagePreference() async {
    if (currentUserId == null) return null;
    
    try {
      final doc = await _firestore.collection('users').doc(currentUserId).get();
      return doc.data()?['languagePreference'] as String?;
    } catch (e) {
      print('Error getting language preference: $e');
      return null;
    }
  }
}

