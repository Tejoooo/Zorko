// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:zorko/components/filter.dart';
import 'package:zorko/components/list.dart';
import 'package:zorko/components/snackBar.dart';
import 'package:zorko/constants.dart';
import 'package:http/http.dart' as http;
import 'package:zorko/models/Itemmodel.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Map<String, List<Item>> categoriesMenu = {};

  int userCoins = 100;
  bool isDark = false;

  void _init() async {
    const apiURL = backendURL + 'api/home_items/';
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
      });
    } else {
      ErrorSnackBar(context, "Failed to load data. Please try again later.");
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
    // _init();
          return  Padding(
            padding: const EdgeInsets.all(8.0),
            child: FilteredItemsPage()
          );
    // return Padding(
    //   padding: const EdgeInsets.all(10.0),
    //   child: SingleChildScrollView(
    //     scrollDirection: Axis.vertical,
    //     child: Column(
    //       children: [
    //         SizedBox(
    //           height: 10,
    //         ),
    //           // Column(
    //           //   children: [
    //           //     SizedBox(
    //           //       height: 10,
    //           //     ),
    //           //     Container(
    //           //       height: 200,
    //           //       padding: EdgeInsets.all(15),
    //           //       width: MediaQuery.of(context).size.width,
    //           //       decoration: BoxDecoration(
    //           //         color: Colors.orange[300],
    //           //         image: DecorationImage(
    //           //             image: AssetImage('assets/h8.png'),
    //           //             fit: BoxFit.cover),
    //           //         borderRadius: BorderRadius.circular(13),
    //           //       ),
    //           //     ),
    //           //     TotalMenu(categoriesMenu),
    //           //   ],
    //           // ),
    //       ],
    //     ),
    //   ),
    // );
  }
}

Widget TotalMenu(Map<String, List> categoriesMenu) {
  List<Widget> columns = [];
  categoriesMenu.forEach((category, items) {
    columns.add(SizedBox(height: 10));
    columns.add(FoodList(foodName:category,items:items.cast<Item>()));
  });
  return Column(
    children: columns,
  );
}
