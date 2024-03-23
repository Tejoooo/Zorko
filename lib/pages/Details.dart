// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  TextEditingController _usernameController = TextEditingController();

  TextEditingController _emailController = TextEditingController();

  TextEditingController _addressController = TextEditingController();

  TextEditingController _pincodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: Stack(
      //   children: [
      //     Positioned(
      //       top: -270, // Move the circle up by adjusting this value
      //       left: -100, // Optional: Adjust left position if needed
      //       child: Container(
      //         width: 600, // Adjust width of the circle if needed
      //         height: 600, // Adjust height of the circle if needed
      //         decoration: const BoxDecoration(
      //           shape: BoxShape.circle,
      //           gradient: LinearGradient(
      //             begin: Alignment.centerLeft,
      //             end: Alignment.centerRight,
      //             colors: [Color(0xFFFFCE92), Color(0xFFED8F03)],
      //           ),
      //         ),
      //       ),
      //     ),
      //     // ignore: avoid_unnecessary_containers
      //     Padding(padding: EdgeInsets.only(top: 100),child: Image(image: AssetImage('assets/registerProfile.png')),),
      //   ],
      // ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 40),
                child: Stack(children: [
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
              ),
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
              Container(
                
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
