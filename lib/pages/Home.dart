// ignore_for_file: unnecessary_string_interpolations, prefer_const_constructors, non_constant_identifier_names, unnecessary_new, unused_field, file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zorko/components/foodListsComp.dart';
import 'package:zorko/getx/userController.dart';
import 'package:zorko/models/Itemmodel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final UserController userController = Get.find<UserController>();

   @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Positioned(
              top: 100,
              left: 0,
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 250,
                    padding: EdgeInsets.all(15),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.orange[300],
                      image: DecorationImage(
                          image: AssetImage('assets/h8.png'),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(13),
                    ),
                  ),

                      GetBuilder<UserController>(builder: (controller){
                        var home_menu = controller.home_menu;
                        return TotalMenu(home_menu as Map<String, List>);
                      }),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget TotalMenu(Map<String, List> categoriesMenu) {
  List<Widget> columns = [];
  categoriesMenu.forEach((category, items) {
    columns.add(SizedBox(height: 10));
    columns.add(
        FoodList(foodName: category.toUpperCase(), items: items.cast<Item>()));
  });
  return Column(
    children: columns,
  );
}