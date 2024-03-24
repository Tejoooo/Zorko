// ignore_for_file: prefer_interpolation_to_compose_strings, unused_local_variable

import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zorko/components/profilecard.dart';
import 'package:zorko/components/snackBar.dart';
import 'package:zorko/constants.dart';
import 'package:http/http.dart' as http;

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {

  Map<String,dynamic>userData = {
    'name':'Nithin',
    'ph_no':'+917013313866',
    'image':'images/dup.png',
    'pincode':'515411',
    'coins':50
  };
  bool isLoading = false;
  
  void _init() async{
    setState(() {
      isLoading = true;
    });
    User? user = await FirebaseAuth.instance.currentUser;
    if (user !=null){
      String uid = user.uid;
      String apiURL = backendURL + "api/user/?userID="+ uid;
      final response = await http.get(Uri.parse(apiURL));
      if (response.statusCode == 200){
        Map<String,dynamic> data = jsonDecode(response.body);
        setState(() {
          userData = data;
          isLoading = false;
        });
      } else{
        ErrorSnackBar(context, "Something went wrong!");
      }
    }

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: isLoading ? Center(child: CircularProgressIndicator()) : SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  // Text('My Profile', style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),),
                  SizedBox(height: 20),
                  Text('Personal Details',style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),),
                  SizedBox(height: 40),
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.amber[300],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.network(backendURL + userData['profilepic'],
                        height: 100,
                        width: 100,
                        ),
                        // Divider(
                        //   color: Colors.black,
                        //   height: 100,
                        //   thickness: 2,
                        //   indent: 20,
                        //   endIndent: 20,
                        // ),
                        // Column(
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     Container(color: Colors.white,child: Text('Deepti',style: TextStyle(fontSize: 20),),), 
                        //     SizedBox(height: 5,),
                        //     Container(color: Colors.white,child: Text('deepti@gmail.com',style: TextStyle(fontSize: 20),),), 
                        //     SizedBox(height: 5,),
                        //     Container(color: Colors.white,child: Text('+91987654321',style: TextStyle(fontSize: 20),),), 
                        //   ],
                        // ),
                    
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  ProfileCard(name: 'Name',word: userData['name'],),
                  SizedBox(height: 20),
                  ProfileCard(name: 'Phone',word: userData['ph_no'],),
                  SizedBox(height: 20),
                  ProfileCard(name: 'pincode',word: userData['pincode'],),
                  SizedBox(height: 20),
                  ProfileCard(name: 'Coins',word: '10',),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ) 
    );
}
}