// ignore_for_file: unnecessary_string_interpolations, prefer_const_constructors, non_constant_identifier_names, unnecessary_new, unused_field, file_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zorko/components/foodListsComp.dart';
import 'package:zorko/components/snackBar.dart';
import 'package:zorko/constants.dart';
import 'package:zorko/getx/userController.dart';
import 'package:zorko/models/Itemmodel.dart';
import 'package:http/http.dart' as http;

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
    return RefreshIndicator(
      onRefresh: () async {
        const String apiURL = "${backendURL}api/home_items/";
        final response = await http.get(Uri.parse(apiURL));
        if (response.statusCode == 200) {
          final List<dynamic> data = jsonDecode(response.body);
          Map<String, List<Item>> homeMenu = {};
          for (var i = 0; i < data.length; i++) {
            List<Item> temp = [];
            final List<dynamic> item = data[i];
            for (var j = 0; j < item.length; j++) {
              temp.add(Item.fromJson(item[j]));
            }
            homeMenu[item[0]['category']] = temp;
            UserController userController = Get.find<UserController>();
            userController.updateHomeMenu(homeMenu);
          }
        } else {
          ErrorSnackBar(context, "Unable to fetch the Menu, Please try again");
        }
      },
      child: Padding(
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
                    GetBuilder<UserController>(builder: (controller) {
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
