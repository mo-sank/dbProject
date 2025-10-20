import 'package:flutter/foundation.dart';
import '../models/user_model.dart';
import '../services/firebase_service.dart';

class UserProvider extends ChangeNotifier {
  UserModel? _user;
  bool _isOnboarded = false;
  bool _isLoading = false;
  FirebaseService? _firebaseService;

  UserModel? get user => _user;
  bool get isOnboarded => _isOnboarded;
  bool get isLoading => _isLoading;

  void setFirebaseService(FirebaseService service) {
    _firebaseService = service;
    loadUserProfile();
  }

  Future<void> loadUserProfile() async {
    if (_firebaseService == null) return;
    
    _isLoading = true;
    notifyListeners();
    
    try {
      final profile = await _firebaseService!.getUserProfile();
      if (profile != null) {
        _user = profile;
        _isOnboarded = true;
      }
    } catch (e) {
      print('Error loading user profile: $e');
    }
    
    _isLoading = false;
    notifyListeners();
  }

  Future<void> setUser(UserModel user) async {
    _user = user;
    _isOnboarded = true;
    notifyListeners();
    
    // Save to Firebase
    if (_firebaseService != null) {
      await _firebaseService!.saveUserProfile(user);
    }
  }

  Future<void> updateUser(UserModel user) async {
    _user = user;
    notifyListeners();
    
    // Save to Firebase
    if (_firebaseService != null) {
      await _firebaseService!.saveUserProfile(user);
    }
  }
}

