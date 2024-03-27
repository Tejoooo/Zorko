// ignore_for_file: prefer_const_constructors, sort_child_properties_last, unnecessary_new, file_names, deprecated_member_use

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:zorko/components/drawer.dart';
import 'package:zorko/components/snackBar.dart';
import 'package:zorko/getx/userController.dart';
import 'package:zorko/models/Itemmodel.dart';
import 'package:zorko/models/fooditems.dart';
import 'package:zorko/pages/Details.dart';
import 'package:zorko/pages/Home.dart';
import 'package:zorko/pages/heatmaps.dart';
import 'package:zorko/models/userModel.dart';
import 'package:zorko/constants.dart';
import 'package:zorko/pages/posts.dart';
import 'package:zorko/pages/profilePage.dart';

class AppHome extends StatefulWidget {
  const AppHome({super.key});

  @override
  State<AppHome> createState() => _AppHomeState();
}

class _AppHomeState extends State<AppHome> {
  var _currentIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  late final List<Widget> _pages;
  bool isRegistered = false;
  bool isLoading = false;

  void setIndex(int val) {
    setState(() {
      _currentIndex = val;
    });
  }

  void setRegistered(bool val) {
    setState(() {
      isRegistered = val;
    });
  }

  void _init() async {
    setState(() {
      isLoading = true;
    });
    User? user = FirebaseAuth.instance.currentUser;
    // fetching user data
    if (user != null) {
      String token = user.uid;
      final String apiURL = "${backendURL}api/user/?userID=$token";
      final response = await http.get(Uri.parse(apiURL));
      if (response.statusCode == 200) {
        setRegistered(true);
        UserModel userModel =
            UserModel.fromJson(jsonDecode(response.body), token);
        UserController userController = Get.find<UserController>();
        userController.updateUser(userModel);
      } else{
        ErrorSnackBar(context, "Unable to fetch the User Data, Please try again");
      }
    }
    // fetch Home Menu once
    const String apiURL = "${backendURL}api/home_items/";
    final response = await http.post(Uri.parse(apiURL),body: {
      "userID": FirebaseAuth.instance.currentUser!.uid,
    });
    if (response.statusCode == 200){
      final List<dynamic> data = jsonDecode(response.body);
      Map<String, List<FoodItem>> homeMenu = {};
      for (var i = 0; i < data.length; i++) {
        List<FoodItem> temp = [];
        final List<dynamic> item = data[i];
        for (var j = 0; j < item.length; j++) {
          temp.add(FoodItem.fromJson(item[j]));
        }
        homeMenu[item[0]['category']] = temp;
        UserController userController = Get.find<UserController>();
        userController.updateHomeMenu(homeMenu);
      }
    } else{
      ErrorSnackBar(context, "Unable to fetch the Menu, Please try again");
    }
    setState(() {
      isLoading = false;
    });
  }


  @override
  void initState() {
    super.initState();
    _pages = [
      HomePage(),
      HeatMaps(),
      // FilteredItemsPage(),
      MyProfilePage(),
      Posts(),
      MyProfilePage(),
    ];
    _init();
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Scaffold(body: Center(child: CircularProgressIndicator()))
        : !isRegistered
            ? DetailsPage(
                setRegistered: setRegistered,
              )
            : WillPopScope(
                onWillPop: () async {
                  if (_currentIndex != 0) {
                    setState(() {
                      _currentIndex = 0;
                    });
                    return Future(() => false);
                  }
                  bool res = await showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Warning'),
                      content: const Text('Do you really want to exit'),
                      actions: [
                        TextButton(
                          child: const Text('Yes'),
                          onPressed: () => Navigator.pop(context, true),
                        ),
                        TextButton(
                          child: const Text('No'),
                          onPressed: () => Navigator.pop(context, false),
                        ),
                      ],
                    ),
                  );
                  return Future.value(res);
                },
                child: Scaffold(
                  key: _scaffoldKey,
                  appBar: AppBar(
                    flexibleSpace: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Color(0xFFFFCE92), Color(0xFFED8F03)],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight),
                      ),
                    ),
                    leading: IconButton(
                      icon: const Icon(Icons.menu),
                      onPressed: () => _scaffoldKey.currentState?.openDrawer(),
                    ),
                    actions: [
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.shopping_cart),
                            onPressed: () {
                              Navigator.pushNamed(context, "/cart");
                            },
                          ),
                          const SizedBox(width: 10),
                          IconButton(
                              onPressed: () {
                                UserController userController = Get.find<UserController>();
                                Map<String, dynamic> data = {
                                  "coins":userController.user.value.coins,
                                  "userID":
                                      FirebaseAuth.instance.currentUser!.uid,
                                };
                                Navigator.pushNamed(context, "/rewards",
                                    arguments: data);
                              },
                              icon: const Icon(Icons.monetization_on)),
                          const SizedBox(width: 5),
                          // Consumer<UserProvider>(builder: (context,value,child){
                          //   return Text(value.user.coins);
                          // }),
                          GetBuilder<UserController>(
                            builder: (controller) {
                              return Text(
                                controller.user.value.coins,
                                style: TextStyle(fontSize: 24),
                              );
                            },
                          ),
                          const SizedBox(width: 10),
                        ],
                      ),
                    ],
                  ),
                  drawer: const DrawerWt(),
                  body: _pages[_currentIndex],
                  bottomNavigationBar: Container(
                    height: 66,
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(24)),
                      color: Colors.transparent,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.home,
                              color: _currentIndex == 0
                                  ? Colors.blue
                                  : Colors.grey),
                          onPressed: () => _onItemTapped(0),
                        ),
                        IconButton(
                          icon: Icon(Icons.pin_drop,
                              color: _currentIndex == 1
                                  ? Colors.blue
                                  : Colors.grey),
                          onPressed: () => _onItemTapped(1),
                        ),
                        IconButton(
                          icon: Icon(Icons.add,
                              size: 40,
                              color: _currentIndex == 2
                                  ? Colors.blue
                                  : Colors.grey),
                          onPressed: () => _onItemTapped(2),
                        ),
                        IconButton(
                          icon: Icon(Icons.grid_on,
                              color: _currentIndex == 3
                                  ? Colors.blue
                                  : Colors.grey),
                          onPressed: () => _onItemTapped(3),
                        ),
                        IconButton(
                          icon: Icon(Icons.person,
                              color: _currentIndex == 4
                                  ? Colors.blue
                                  : Colors.grey),
                          onPressed: () => _onItemTapped(4),
                        ),
                      ],
                    ),
                  ),
                  floatingActionButton: _currentIndex == 3
                      ? FloatingActionButton(
                          onPressed: () {
                            Navigator.pushNamed(context, "/upload");
                          },
                          child: Icon(
                            Icons.add,
                            size: 32,
                          ),
                          backgroundColor: Colors.orange,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        )
                      : null,
                ),
              );
  }
}
