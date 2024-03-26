import 'package:get/get.dart';
import 'package:zorko/models/fooditems.dart';
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

  RxMap<String, List<dynamic>> home_menu = RxMap<String, List<dynamic>>();

  get value => null;

  void updateUser(UserModel newUser) {
    user.value = newUser;
  }

  void updateHomeMenu(Map<String, List<FoodItem>> newMenu) {
    Map<String, List<dynamic>> convertedMenu = newMenu.map((key, value) => MapEntry(key, value.toList()));
    home_menu.assignAll(convertedMenu); 
  }
}
