import 'package:flutter/material.dart';

import '../../domain/entities/user_entity.dart';

class UserViewModel extends ChangeNotifier {
  UserEntity? _loggedInUser;

  UserEntity? get loggedInUser => _loggedInUser;

  void setLoggedInUser(UserEntity user) {
    _loggedInUser = user;
    notifyListeners();
  }

  void clearLoggedInUser() {
    _loggedInUser = null;
    notifyListeners();
  }
}
