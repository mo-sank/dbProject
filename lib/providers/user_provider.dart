import 'package:flutter/foundation.dart';
import '../models/user_model.dart';

class UserProvider extends ChangeNotifier {
  UserModel? _user;
  bool _isOnboarded = false;

  UserModel? get user => _user;
  bool get isOnboarded => _isOnboarded;

  void setUser(UserModel user) {
    _user = user;
    _isOnboarded = true;
    notifyListeners();
  }

  void updateUser(UserModel user) {
    _user = user;
    notifyListeners();
  }
}

