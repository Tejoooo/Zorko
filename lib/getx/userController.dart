import 'package:get/get.dart';
import 'package:zorko/models/userModel.dart';

class UserController extends GetxController {
  var user = UserModel(
    uid: '',
    phoneNumber: '',
    name: '',
    pincode: '',
    address: '',
    profilepic: '',
    coins: '',
  ).obs;

  void updateUser(UserModel newUser) {
    user.value = newUser;
  }
}
