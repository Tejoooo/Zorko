// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zorko/components/foodComponent.dart';
import 'package:zorko/models/Itemmodel.dart';
import 'package:zorko/models/fooditems.dart';

class FoodList extends StatefulWidget {
  String foodName;
  List<FoodItem> items;
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

Widget EachItemWithSpace(List<FoodItem> items){
  List<Widget> itemWidgets = [];
  items.forEach((element) {
    itemWidgets.add(SizedBox(height: 10,));
    itemWidgets.add(FoodItemWidget(
      imagePath: element.image ?? "",
      id : element.id ?? "",
      itemName: element.name ?? "",
      price: double.parse(element.price as String),
      description: element.description ?? "",
      count: element.count ?? 0,
    ));
    itemWidgets.add(SizedBox(width: 10));
  });
  return Row(children: itemWidgets,);
}

