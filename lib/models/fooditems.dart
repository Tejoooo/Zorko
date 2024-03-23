import 'dart:core';


class FoodItem {
  String? name;
  String? description;
  double? price;
  int? likes;
  List<String>? Comments;


  FoodItem({
    this.name,
    this.description,
    this.price,
    this.likes,
    this.Comments,
  });
}