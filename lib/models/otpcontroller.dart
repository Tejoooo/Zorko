import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:zorko/pages/splashScreen.dart';
import 'package:zorko/repository/authentication_repository.dart';

class OTPController extends GetxController{
  static OTPController get instance => Get.find();
  void verifyOTP(String otp) async{
    var isverified = await AuthenticationRepository.instance.verififyOTP(otp);
    isverified ? Get.offAll(Screens()) : Get.back();
    
  }

}