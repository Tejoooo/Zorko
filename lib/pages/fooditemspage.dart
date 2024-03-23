// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:zorko/components/fooditemtile.dart';
import 'package:zorko/models/fooditems.dart';

class FoodItemPage extends StatefulWidget {
  const FoodItemPage({super.key});

  @override
  State<FoodItemPage> createState() => _FoodItemPageState();
}

class _FoodItemPageState extends State<FoodItemPage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: -270, // Move the circle up by adjusting this value
          left: -100, // Optional: Adjust left position if needed
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
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FoodItemTile(
                foodItem: FoodItem(
                    name: 'Pizza', description: 'Delicious pizza', price: 10,image: "assets/h7.png"),
              ),
              SizedBox(height: 16), // Add some spacing between the tiles
              FoodItemTile(
                foodItem: FoodItem(
                    name: 'Burger', description: 'Tasty burger', price: 8,image: "assets/h10.jpg"),
              ),
              SizedBox(height: 16), // Add some spacing between the tiles
              FoodItemTile(
                foodItem: FoodItem(
                    name: 'Pasta', description: 'Yummy pasta', price: 12,image: "assets/h6.png"),
              ),
              SizedBox(height: 16), // Add some spacing between the tiles
              FoodItemTile(
                foodItem: FoodItem(
                    name: 'Pasta', description: 'Yummy pasta', price: 12,image: "assets/h6.png"),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
