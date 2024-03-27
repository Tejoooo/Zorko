import 'dart:core';


class FoodItem {
  String? name;
  String? description;
  double? price;
  String? image;
  String? id;
  String category;
  int? count;
  int? likes;

  FoodItem({
    this.name,
    this.description,
    this.price,
    this.id,
    this.count,
    this.likes,
    this.image,
    required this.category,
  });

  factory FoodItem.fromJson(Map<String, dynamic> json) {
    return FoodItem(
      name: json['name'],
      description: json['description'],
      price: double.parse(json['price'].toString()),
      id: json['id'].toString(),
      count: json['count'],
      likes: json['likes'] ?? 0,
      image: json['image'],
      category: json['category'],
    );
  }
}