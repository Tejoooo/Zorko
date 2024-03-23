// ignore_for_file: prefer_const_constructors

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:zorko/components/bottomnavigationbar.dart';
import 'package:zorko/components/drawer.dart';
import 'package:zorko/components/itemdisplay.dart';
import 'package:zorko/components/topnavbar.dart';
import 'package:carousel_slider/carousel_slider.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  int userCoins = 100;
  bool isDark = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
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
              Text('$userCoins'), // Display user's coins
              SizedBox(width: 10), // Add some spacing between icons
            ],
          ),
        ],
      ),
      drawer: DrawerWt(),
      body: Stack(
        children: [
          Positioned(
            top: -300, // Move the circle up by adjusting this value
            left: -120, // Optional: Adjust left position if needed
            child: Container(
              width: 600, // Adjust width of the circle if needed
              height: 600, // Adjust height of the circle if needed
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Color(0xFFFFCE92), Color(0xFFED8F03)],
                ),
              ),
            ),
          ),
           
          // Text
          Positioned(
            top: 100,
            left: 0,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(15),
                  width: MediaQuery.of(context).size.width,
                  child: SearchAnchor(builder:
                      (BuildContext context, SearchController controller) {
                    return SearchBar(
                      controller: controller,
                      padding: const MaterialStatePropertyAll<EdgeInsets>(
                          EdgeInsets.symmetric(horizontal: 16.0)),
                      onTap: () {
                        controller.openView();
                      },
                      onChanged: (_) {
                        controller.openView();
                      },
                      leading: const Icon(Icons.search),
                      trailing: <Widget>[
                        const SizedBox(width: 8),
                        Tooltip(
                          message: 'Filter',
                          child: IconButton(
                            onPressed: () {
                              // Handle filter button press
                            },
                            icon: const Icon(Icons.filter_list),
                          ),
                        )
                      ],
                    );
                  }, suggestionsBuilder:
                      (BuildContext context, SearchController controller) {
                    return List<ListTile>.generate(5, (int index) {
                      final String item = 'item $index';
                      return ListTile(
                        title: Text(item),
                        onTap: () {
                          setState(() {
                            controller.closeView(item);
                          });
                        },
                      );
                    });
                  }),
                ),
                CarouselSlider(
                  options: CarouselOptions(
                    height: 200,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    aspectRatio: 16 / 9,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enableInfiniteScroll: true,
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    viewportFraction: 0.8,
                  ),
                  items: [
                    FoodItem(
                      imagePath: 'assets/h7.png',
                      itemName: 'Burger',
                      price: 10.0,
                    ),
                    FoodItem(
                      imagePath: 'assets/h6.png',
                      itemName: 'Burger',
                      price: 10.0,
                    ),
                    // Add more FoodItem widgets as needed
                  ].map((item) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            color: Colors.amber,
                          ),
                          child: item,
                        );
                      },
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
