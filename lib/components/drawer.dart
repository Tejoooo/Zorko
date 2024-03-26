// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:zorko/constants.dart';
import 'package:zorko/getx/userController.dart';
import 'package:zorko/models/userModel.dart';

class DrawerWt extends StatefulWidget {
  const DrawerWt({super.key});

  @override
  State<DrawerWt> createState() => _DrawerWtState();
}

class _DrawerWtState extends State<DrawerWt> {

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(
      builder: (controller) {
        UserModel userData = controller.user.value;
      return Drawer(
        child:ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(userData.name),
              accountEmail: Text(userData.phoneNumber),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(backendURL + userData.profilepic),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.pushNamed(context, "/home");
                // Handle drawer item tap for Home
              },
            ),
            ListTile(
              leading: Icon(Icons.perm_contact_cal),
              title: Text('Contact'),
              onTap: () {
                Navigator.pushNamed(context, "/contact");
                // Handle drawer item tap for Settings
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () async{
                // Handle drawer item tap for Logout
                await FirebaseAuth.instance.signOut();
              },
            ),
          ],
        ),
      );
      }
    );
  }
}