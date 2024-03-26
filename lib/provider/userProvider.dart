import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:zorko/models/userModel.dart';

class UserProvider extends ChangeNotifier {
  UserModel _user = UserModel(uid: "123", phoneNumber: "1234567890", name: "user", pincode: "515411", address: "address", profilepic: "dup", coins: "1000");

  UserModel get user => _user;

  void setUser(UserModel dup) {
    _user = dup;
    print(_user.coins);
    notifyListeners();
  }
}