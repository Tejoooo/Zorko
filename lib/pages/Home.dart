// ignore_for_file: unnecessary_string_interpolations, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zorko/getx/userController.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(child: GetBuilder<UserController>(
          builder: (controller) {
            return Text(
              '${controller.user.value.coins}',
              style: TextStyle(fontSize: 24),
            );
          },
        ),),
      ],
    );
  }
}