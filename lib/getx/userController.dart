import 'package:get/get.dart';
import 'package:zorko/models/Itemmodel.dart';
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

  var home_menu = {}.obs;

  void updateUser(UserModel newUser) {
    user.value = newUser;
  }

  void updateHomeMenu(Map<String, List<Item>> newMenu) {
    home_menu.value = newMenu;
  }
}
