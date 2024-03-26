// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:zorko/firebase_options.dart';
import 'package:get/get.dart';
import 'package:zorko/pages/foodView.dart';
import 'package:zorko/pages/heatmaps.dart';
import 'package:zorko/pages/loginPage.dart';
import 'package:zorko/pages/otpNumberScreen.dart';
import 'package:zorko/pages/rewards.dart';
import 'package:zorko/pages/splashScreen.dart';
import 'package:zorko/getx/userController.dart';
import 'package:zorko/repository/authRepository.dart';


void main(){
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) => Get.put(AuthenticationRepository()));
      runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(UserController());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      debugShowMaterialGrid: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 238, 151, 22)),
        useMaterial3: true,
      ),
      initialRoute: "/splash",
      routes: {
        "/splash":(context) => SplashScreens(),
        "/login":(context) => LoginScreen(),
        "/otpscreen":(context) => OTPNumberScreen(),
        "/heatmaps":(context) => HeatMaps(),
        "/rewards":(context) => RewardsPage(),
        "/foodView":(context) =>FoodIteamView(),
      },
    );
  }
}