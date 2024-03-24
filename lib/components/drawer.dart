import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:zorko/components/snackBar.dart';
import 'package:zorko/constants.dart';

class DrawerWt extends StatefulWidget {
  const DrawerWt({super.key});

  @override
  State<DrawerWt> createState() => _DrawerWtState();
}

class _DrawerWtState extends State<DrawerWt> {
  bool isLoading = false;

  Map<String, dynamic> userData = {
    "name": "John Doe",
    "ph_no": "1234567890",
    "profilepic": "assets/logo.png"
  };

  void _init() async {
    setState(() {
      isLoading = true;
    });
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String uid = user!.uid;
      print(uid);
      final resposne = await http.get(Uri.parse(backendURL+"api/user/?userID="+uid));
      if (resposne.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(resposne.body);
        setState(() {
          userData = data;
        });
      } else {
        ErrorSnackBar(context, "Un able to fetch user data");}
    }
    setState(() {
      isLoading = false;
    });
  }
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: isLoading ? Center(child: CircularProgressIndicator(),) : ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(userData['name'] ?? "John Doe"),
            accountEmail: Text(userData['ph_no'] ?? "1234567890"),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(backendURL + userData['profilepic']),
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
}