// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:zorko/components/itemdisplay.dart';

class FoodList extends StatefulWidget {
  String foodName;
  FoodList({super.key,required this.foodName});

  @override
  State<FoodList> createState() => _FoodListState();
}

class _FoodListState extends State<FoodList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20,top: 5),
          child: Text(
            widget.foodName,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        SizedBox(height: 5),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SizedBox(width: 5),
              FoodItem(
                imagePath: 'assets/h7.png',
                itemName: 'Burger',
                price: 10.0,
              ),
              SizedBox(width: 10), // Add spacing between items
              FoodItem(
                imagePath: 'assets/h6.png',
                itemName: 'Burger',
                price: 10.0,
              ),
              SizedBox(width: 10),
              FoodItem(
                imagePath: 'assets/h7.png',
                itemName: 'Burger',
                price: 10.0,
              ),
              SizedBox(width: 10), // Add spacing between items
              FoodItem(
                imagePath: 'assets/h6.png',
                itemName: 'Burger',
                price: 10.0,
              ),
              // Add more FoodItem widgets as needed
            ],
          ),
        ),
      ],
    );
  }
}
