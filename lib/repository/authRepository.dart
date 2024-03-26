import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:zorko/pages/appHome.dart';
import 'package:zorko/pages/splashScreen.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;
  var verificationID = ''.obs;

  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    user == null ? Get.offAll(() => SplashScreens()) : Get.offAll(() => AppHome());
  }
}