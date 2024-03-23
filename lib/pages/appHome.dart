// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:zorko/components/bottomnavigationbar.dart';
import 'package:zorko/components/fooditemtile.dart';
import 'package:zorko/components/snackBar.dart';
import 'package:zorko/constants.dart';
import 'package:zorko/models/fooditems.dart';
import 'package:zorko/pages/Details.dart';
import 'package:zorko/pages/fooditemspage.dart';
import 'package:zorko/pages/home.dart';
import 'package:zorko/pages/posts.dart';
import 'package:zorko/components/drawer.dart';
import 'package:zorko/pages/profile.dart';
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


  void _init() async{
    User? user = FirebaseAuth.instance.currentUser;
    if(user != null){
      String? token = await user.getIdToken();
      String apiURL = backendURL + "api/user/";
      if (token != null) {
        apiURL = apiURL + "?userID=" + token;
      }
      final response = await http.get(
        Uri.parse(apiURL)
      );
      if (response.statusCode == 200){
        setRegistered(true);
      }
      else {
        ErrorSnackBar(context, "Looks like something went wrong");
      }
    }
  }

  @override
  void initState() {
    super.initState();

    _pages = [
      Home(),
      Posts(),
      Posts(),
      FoodItemPage(),
      // DetailsPage()
      ProfilePage()
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
    return !isRegistered? DetailsPage(setRegistered: setRegistered,): WillPopScope(
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
            flexibleSpace: Container(decoration: BoxDecoration(gradient: LinearGradient(colors: [Color(0xFFFFCE92), Color(0xFFED8F03)],begin: Alignment.centerLeft,end: Alignment.centerRight),),),
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
                },
              ),
              SizedBox(width: 10), // Add some spacing between icons
              Icon(Icons.monetization_on),
              SizedBox(width: 5),
              Text('100'), // Display user's coins
              SizedBox(width: 10), // Add some spacing between icons
            ],
          ),
        ],
      ),
      drawer: DrawerWt(),
          body: _pages[_currentIndex],
          bottomNavigationBar: Container(
            height: 66, 
            padding: const EdgeInsets.all(9),
            // margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 22),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(24)),
              color: Colors.transparent,
              // boxShadow: [
              //   BoxShadow(
              //     color: Colors.black.withOpacity(0.3),
              //     blurRadius: 20,
              //     offset: Offset(0, -3),
              //   ),
              // ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.home,
                      color: _currentIndex == 0 ? Colors.blue : Colors.grey),
                  onPressed: () => _onItemTapped(0),
                ),
                IconButton(
                  icon: Icon(Icons.favorite,
                      color: _currentIndex == 1 ? Colors.blue : Colors.grey),
                  onPressed: () => _onItemTapped(1),
                ),
                IconButton(
                  icon: Icon(Icons.grid_on,
                      color: _currentIndex == 2 ? Colors.blue : Colors.grey),
                  onPressed: () => _onItemTapped(2),
                ),
                IconButton(
                  icon: Icon(Icons.shopping_cart,
                      color: _currentIndex == 3 ? Colors.blue : Colors.grey),
                  onPressed: () => _onItemTapped(3),
                ),
                IconButton(
                  icon: Icon(Icons.person,
                      color: _currentIndex == 4 ? Colors.blue : Colors.grey),
                  onPressed: () => _onItemTapped(4),
                ),
              ],
            ),
          ),
        ));
  }
}
