import 'package:flutter/material.dart';
import 'package:zorko/components/profilecard.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                        Image.asset('assets/h4.png',
                        height: 100,
                        width: 100,
                        ),
                        Divider(
                          color: Colors.black,
                          height: 100,
                          thickness: 2,
                          indent: 20,
                          endIndent: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(color: Colors.white,width: 10,child: Text('Deepti',style: TextStyle(fontSize: 20),),), 
                            SizedBox(height: 5,),
                            Container(color: Colors.white,width: 10,child: Text('deepti@gmail.com',style: TextStyle(fontSize: 20),),), 
                            SizedBox(height: 5,),
                            Container(color: Colors.white,width: 10,child: Text('+91987654321',style: TextStyle(fontSize: 20),),), 
                          ],
                        ),
          
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  ProfileCard(name: 'ORDERS'),
                  SizedBox(height: 20),
                  ProfileCard(name: 'REVIEWS'),
                  SizedBox(height: 20),
                  ProfileCard(name: 'ORDERS'),
                  SizedBox(height: 20),
                  ProfileCard(name: 'REVIEWS'),
                  SizedBox(height: 20),
                ],
              ),
      ),
    );
}
}