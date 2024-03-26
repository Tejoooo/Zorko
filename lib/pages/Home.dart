// ignore_for_file: unnecessary_string_interpolations, prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zorko/components/foodListsComp.dart';
import 'package:zorko/components/snackBar.dart';
import 'package:zorko/constants.dart';
import 'package:zorko/getx/userController.dart';
import 'package:zorko/models/Itemmodel.dart';
import 'package:http/http.dart' as http;
import 'package:zorko/models/fooditems.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool isLoading = false;
  Map<String, List<Item>> categoriesMenu = {};

  void _init() async {
    setState(() {
      isLoading = true;
    });
    const apiURL = '${backendURL}api/home_items/';
    final response = await http.get(Uri.parse(apiURL));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      Map<String, List<Item>> dup1 = {};
      for (var i = 0; i < data.length; i++) {
        List<Item> dup2 = [];
        final List<dynamic> item = data[i];
        for (var j = 0; j < item.length; j++) {
          dup2.add(Item.fromJson(item[j]));
        }
        dup1[item[0]['category']] = dup2;
      }
      setState(() {
        categoriesMenu = dup1;
        isLoading = false;
      });
    } else {
      ErrorSnackBar(context, "Failed to load data. Please try again later.");
    }
  }

   @override
  void initState() {
    super.initState();
    _init();
    // UserController userController = Get.find()<UserController>();
    // categoriesMenu = userController.home_menu as Map<String, List<Item>>;
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
                  isLoading
                      ? Padding(
                          padding: const EdgeInsets.only(top: 60),
                          child: Center(child: CircularProgressIndicator()),
                        )
                      : TotalMenu(categoriesMenu),
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