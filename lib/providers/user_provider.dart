
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ig_clone/resources/auth_methods.dart';

import '../models/custom_user.dart';

class UserProvider with ChangeNotifier {
  CustomUser? _user;
  CustomUser get getUser => _user!;
  final AuthMethods _authMethods = AuthMethods();

  Future<void> refreshUser() async {
    CustomUser user = await _authMethods.getUserDetails();
    _user = user;
    notifyListeners();
  }

}
