// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zorko/components/itemdisplay.dart';
import 'package:zorko/models/Itemmodel.dart';

class FoodList extends StatefulWidget {
  String foodName;
  List<Item> items;
  FoodList({super.key,required this.foodName,required this.items});

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
          child: EachItemWithSpace(widget.items),
        ),
      ],
    );
  }
}

Widget EachItemWithSpace(List<Item> items){
  List<Widget> itemWidgets = [];
  items.forEach((element) {
    itemWidgets.add(SizedBox(height: 10,));
    itemWidgets.add(FoodItem(
      imagePath: element.image,
      id : element.id,
      itemName: element.name,
      price: double.parse(element.price),
      description: element.description,
    ));
    itemWidgets.add(SizedBox(width: 10));
  });
  return Row(children: itemWidgets,);
}

