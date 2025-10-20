import 'package:flutter/material.dart';
import '../services/firebase_service.dart';

class LanguageProvider extends ChangeNotifier {
  Locale _locale = const Locale('en');
  FirebaseService? _firebaseService;

  Locale get locale => _locale;

  void setFirebaseService(FirebaseService service) {
    _firebaseService = service;
    _loadLanguagePreference();
  }

  Future<void> _loadLanguagePreference() async {
    if (_firebaseService == null) return;
    
    try {
      final langCode = await _firebaseService!.getLanguagePreference();
      if (langCode != null) {
        _locale = Locale(langCode);
        notifyListeners();
      }
    } catch (e) {
      print('Error loading language preference: $e');
    }
  }

  Future<void> setLocale(Locale locale) async {
    if (_locale != locale) {
      _locale = locale;
      notifyListeners();
      
      // Save to Firebase
      if (_firebaseService != null) {
        await _firebaseService!.saveLanguagePreference(locale.languageCode);
      }
    }
  }

  Future<void> setLanguage(String languageCode) async {
    await setLocale(Locale(languageCode));
  }
}

