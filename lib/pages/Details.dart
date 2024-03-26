// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_const_constructors_in_immutables, prefer_final_fields, use_build_context_synchronously, must_be_immutable

import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:zorko/constants.dart';
import 'package:zorko/components/snackBar.dart';
import 'package:zorko/models/userModel.dart';
import 'package:zorko/provider/userProvider.dart';

class DetailsPage extends StatefulWidget {
  final Function setRegistered;
  DetailsPage({super.key,required this.setRegistered});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  TextEditingController _usernameController = TextEditingController();

  TextEditingController _emailController = TextEditingController();

  TextEditingController _addressController = TextEditingController();

  TextEditingController _pincodeController = TextEditingController();

  void _register() async{
    const apiURL = "${backendURL}api/user/";
    User? user = FirebaseAuth.instance.currentUser;
    String? token = user!.uid;
    String? phoneNumber = user.phoneNumber;
    final response = await http.post(Uri.parse(apiURL),body: {
      "userID" : token,
      "name": _usernameController.text,
      "ph_no": phoneNumber,
      "address": _addressController.text,
      "pincode": _pincodeController.text,
      "state":"dup",
    });
    if (response.statusCode == 201){
      UserModel userModel = UserModel.fromJson(jsonDecode(response.body),token);
        UserProvider userProvider = UserProvider();
        userProvider.setUser(userModel);
      widget.setRegistered(true);
    } else {
      ErrorSnackBar(context, response.body);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [Color(0xFFFFCE92), Color(0xFFED8F03)],
                    ),
                  ),
                  child: Image(
                    image: AssetImage('assets/registerProfile.png'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 60, top: 70),
                  child: Icon(
                    Icons.camera_alt,
                    size: 28,
                  ),
                )
              ]),
              SizedBox(
                height: 30,
              ),
              RegisterInputField(
                hintText: "UserName",
                icon: Icons.supervised_user_circle_rounded,
                controller: _usernameController,
              ),
              RegisterInputField(
                hintText: "Email Address",
                icon: Icons.email,
                controller: _emailController,
              ),
              RegisterInputField(
                hintText: "Address",
                icon: Icons.adb_rounded,
                controller: _addressController,
              ),
              RegisterInputField(
                hintText: "Pincode",
                icon: Icons.location_on,
                controller: _pincodeController,
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: (){
                  _register();
                },
                child: Container(
                  padding: EdgeInsets.only(top: 20,bottom: 20,left: 130,right: 130),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [Color(0xFFFFCE92), Color(0xFFED8F03)],
                    ),
                    borderRadius:BorderRadius.circular(100.0),
                  ),
                  child: Text("Proceed",style: TextStyle(color: Colors.white),),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class RegisterInputField extends StatelessWidget {
  String hintText;
  IconData icon;
  TextEditingController controller;
  RegisterInputField({
    super.key,
    required this.hintText,
    required this.icon,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 45.0, right: 45, top: 10, bottom: 10),
      child: Center(
          child: TextField(
            controller: controller,
        decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15),
              child: Icon(icon, size: 28),
            )),
      )),
    );
  }
}
