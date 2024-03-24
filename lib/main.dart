import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zorko/firebase_options.dart';
import 'package:zorko/pages/ImagePicker.dart';
import 'package:zorko/pages/appHome.dart';
import 'package:zorko/pages/cartPage.dart';
import 'package:zorko/pages/contact.dart';
import 'package:zorko/pages/foodView.dart';
import 'package:zorko/pages/otpscreen.dart';
import 'package:zorko/pages/rewards.dart';
import 'package:zorko/repository/authentication_repository.dart';
import 'pages/splashScreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options:DefaultFirebaseOptions.currentPlatform).then((value) => Get.put(AuthenticationRepository()));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      debugShowMaterialGrid: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 238, 151, 22)),
        useMaterial3: true,
      ),
      initialRoute: "/splash",
      routes: {
        "/splash": (context) => Screens(),
        "/login" : (context) => OTPScreen(),
        "/foodView":(context) => FoodIteamView(),
        "/cart":(context) => CartPage(),
        "/upload":(context) => ImagePickerWidget(),
        "/rewards":(context) => RewardsPage(),
        "/contact":(context) => ContactPage(),
        "/home" : (context) => AppHome(),
      },
    );
  }
}
