// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:zorko/components/bottomnavigationbar.dart';
import 'package:zorko/components/filter.dart';
import 'package:zorko/components/fooditemtile.dart';
import 'package:zorko/components/snackBar.dart';
import 'package:zorko/constants.dart';
import 'package:zorko/models/fooditems.dart';
import 'package:zorko/pages/Details.dart';
import 'package:zorko/pages/fooditemspage.dart';
import 'package:zorko/pages/home.dart';
import 'package:zorko/pages/mapwithouturl.dart';
import 'package:zorko/pages/myprofile.dart';
import 'package:zorko/pages/posts.dart';
import 'package:zorko/components/drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

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
  String coins = "0";

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
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String? token = user.uid;
      String apiURL = backendURL + "api/user/";
      if (token != null) {
        apiURL = apiURL + "?userID=" + token;
      }
      final response = await http.get(Uri.parse(apiURL));
      if (response.statusCode == 200) {
        setRegistered(true);
        fetchUserDetails(token);
      }
    }
  }

  void updateCoins() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String? token = user.uid;
      fetchUserDetails(token);
    }
  }

  void fetchUserDetails(String token) async {
    String apiURL = backendURL + "api/user/" + "?userID=" + token;
    final response = await http.get(Uri.parse(apiURL));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      setState(() {
        coins = data['coins'].toString();
        print(coins);
      });
    } else {
      ErrorSnackBar(context, "user details unable to fetch");
    }
  }

  @override
  void initState() {
    super.initState();

    _pages = [
      Home(setIndex: setIndex,),
      HeatMaps(),
      FilteredItemsPage(),
      Posts(),
      MyProfile(),
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
    return !isRegistered
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
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Color(0xFFFFCE92), Color(0xFFED8F03)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight),
                  ),
                ),
                leading: IconButton(
                  icon: Icon(Icons.menu),
                  onPressed: () => _scaffoldKey.currentState?.openDrawer(),
                ),
                actions: [
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.shopping_cart),
                        onPressed: () {
                          // Navigate to cart screen or show cart items
                          Navigator.pushNamed(context, "/cart");
                        },
                      ),
                      SizedBox(width: 10), // Add some spacing between icons
                      IconButton(onPressed: () {
                        Map<String,dynamic> data = {
                        "coins":coins,
                        "userID":FirebaseAuth.instance.currentUser!.uid,
                      };
                        Navigator.pushNamed(context, "/rewards",arguments: data);updateCoins();}, icon: Icon(Icons.monetization_on)),
                      SizedBox(width: 5),
                      Text(coins), // Display user's coins
                      SizedBox(width: 10), // Add some spacing between icons
                    ],
                  ),
                ],
              ),
              drawer: DrawerWt(),
              body: _pages[_currentIndex],
              bottomNavigationBar: Container(
                height: 66,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(24)),
                  color: Colors.transparent,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.home,
                          color:
                              _currentIndex == 0 ? Colors.blue : Colors.grey),
                      onPressed: () => _onItemTapped(0),
                    ),
                    IconButton(
                      icon: Icon(Icons.pin_drop,
                          color:
                              _currentIndex == 1 ? Colors.blue : Colors.grey),
                      onPressed: () => _onItemTapped(1),
                    ),
                    IconButton(
                      icon: Icon(Icons.add,size: 40,
                          color:
                              _currentIndex == 2 ? Colors.blue : Colors.grey),
                      onPressed: () => _onItemTapped(2),
                    ),
                    IconButton(
                      icon: Icon(Icons.grid_on,
                          color:
                              _currentIndex == 3 ? Colors.blue : Colors.grey),
                      onPressed: () => _onItemTapped(3),
                    ),
                    IconButton(
                      icon: Icon(Icons.person,
                          color:
                              _currentIndex == 4 ? Colors.blue : Colors.grey),
                      onPressed: () => _onItemTapped(4),
                    ),
                  ],
                ),
              ),
              floatingActionButton: _currentIndex == 3
                  ? FloatingActionButton(
                      onPressed: () {
                        // Your action here
                        Navigator.pushNamed(context, "/upload");
                      },
                      child: Icon(Icons.add,size: 32,),
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white, // Set foreground color
                      elevation: 0, // Set elevation to 0 to remove shadow
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(10), // Set border radius
                      ),
                    )
                  : null,
            ),
          );
  }
}
