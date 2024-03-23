import 'dart:core';


class FoodItem {
  String? name;
  String? description;
  double? price;
  String? id;
  int? count;
  int? likes;
  String? image;
  List<String>? comments; // "Comments" changed to "comments" for Dart naming conventions

  FoodItem({
    this.name,
    this.description,
    this.price,
    this.id,
    this.count,
    this.likes,
    this.image,
    this.comments,
  });
}