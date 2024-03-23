class Item {
  String name;
  String description;
  String price;
  String image;
  String id;
  String category;

  Item({
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    required this.id,
    required this.category,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      price: json['price'].toString() ?? '12',
      image: json['image'] ?? '',
      id: json['id'].toString() ?? '0',
      category: json['category'] ?? '',
    );
  }
}
