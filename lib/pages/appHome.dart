// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:zorko/components/bottomnavigationbar.dart';
import 'package:zorko/pages/home.dart';
import 'package:zorko/pages/posts.dart';

class AppHome extends StatefulWidget {
  const AppHome({super.key});

  @override
  State<AppHome> createState() => _AppHomeState();
}

class _AppHomeState extends State<AppHome> {
  var _currentIndex = 0;

  late final List<Widget> _pages;

  void setIndex(int val) {
    setState(() {
      _currentIndex = val;
    });
  }

  @override
  void initState() {
    super.initState();

    _pages = [
      Home(),
      Posts(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
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
          body: _pages[_currentIndex],
          bottomNavigationBar: Container(
            // height: 66, 
            padding: const EdgeInsets.all(9),
            // margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 22),
            decoration: BoxDecoration(
              // borderRadius: const BorderRadius.all(Radius.circular(24)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 20,
                  offset: Offset(0, -3),
                ),
              ],
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
