// ignore_for_file: non_constant_identifier_names, prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({super.key});

  @override
  State<MyProfilePage> createState() => MyProfilePageState();
}

class MyProfilePageState extends State<MyProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 30.0, right: 30, top: 40, bottom: 40),
      child: Column(
        children: [
          Container(
            height: 100,
            child: Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image(
                    image: AssetImage('assets/rectangle.png'),
                    height: 72,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "John Doe",
                        style:
                            TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "Dosamarvis@gmail.com",
                        style: TextStyle(fontSize: 11),
                      ),
                      Text(
                        "+91 7013313866",
                        style: TextStyle(fontSize: 11),
                      ),
                      Text(
                        "No 15 uti street off ovie palace road, warri, delta state.",
                        style: TextStyle(fontSize: 11),
                        maxLines: 5,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          CardButton("Orders", "/orders"),
          CardButton("Contact", "/orders"),
          CardButton("Help", "/orders"),
        ],
      ),
    );
  }
}

Widget CardButton(String title, String NavigationRoute) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 19),
        ),
        Icon(Icons.arrow_forward_ios)
      ],
    ),
  );
}
