// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:zorko/models/Itemmodel.dart';

class FilteredItemsPage extends StatefulWidget {
  const FilteredItemsPage({Key? key}) : super(key: key);

  @override
  _FilteredItemsPageState createState() => _FilteredItemsPageState();
}

class _FilteredItemsPageState extends State<FilteredItemsPage> {
  final List<Item> foodItems = [
    Item(
      name: "Burger1",
      price: 2.99.toString(),
      id: 1.toString(),
      image: "assets/h7.png",
      description: "Juicy beef burger with cheese",
      category: "Burger",
    ),
    Item(
      name: "Fries1",
      price: 2.49.toString(),
      id: 1.toString(),
      image: "assets/h7.png",
      description: "Crispy french fries",
      category: "Fries",
    ),
    Item(
      name: "Burger1",
      price: 2.99.toString(),
      id: 1.toString(),
      image: "assets/h7.png",
      description: "Juicy beef burger with cheese",
      category: "Burger",
    ),
    Item(
      name: "Fries1",
      price: 2.49.toString(),
      id: 1.toString(),
      image: "assets/h7.png",
      description: "Crispy french fries",
      category: "Fries",
    ),
    Item(
      name: "Burger1",
      price: 2.99.toString(),
      id: 1.toString(),
      image: "assets/h7.png",
      description: "Juicy beef burger with cheese",
      category: "icecreams",
    ),
    Item(
      name: "Fries1",
      price: 2.49.toString(),
      id: 1.toString(),
      image: "assets/h7.png",
      description: "Crispy french fries",
      category: "Fries",
    ),
    Item(
      name: "Burger1",
      price: 2.99.toString(),
      id: 1.toString(),
      image: "assets/h7.png",
      description: "Juicy beef burger with cheese",
      category: "desserts",
    ),
    Item(
      name: "Fries1",
      price: 2.49.toString(),
      id: 1.toString(),
      image: "assets/h7.png",
      description: "Crispy french fries",
      category: "drinks",
    ),
    Item(
      name: "Combos",
      price: 2.49.toString(),
      id: 1.toString(),
      image: "assets/h7.png",
      description: "Crispy french fries",
      category: "Combos",
    ),
    // Add more items here
  ];

  Map<String, List<Item>> filteredItemsByCategory = {};
  late double budget;

  void updateFilteredItems() {
    // Default to 'Burger' category
    filterItems('Combos');
  }

  void filterItems(String category) {
    final Map<String, List<Item>> tempFilteredItems = {};

    foodItems.forEach((item) {
      if (item.category.toLowerCase() == category.toLowerCase() &&
          double.parse(item.price) <= budget) {
        if (!tempFilteredItems.containsKey(item.category)) {
          tempFilteredItems[item.category] = [];
        }
        tempFilteredItems[item.category]!.add(item);
      }
    });

    setState(() {
      filteredItemsByCategory = tempFilteredItems;
    });
  }

  @override
  void initState() {
    super.initState();
    budget = 0.0;
    updateFilteredItems();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              SizedBox(width: 10),
              Expanded(
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      budget = double.tryParse(value) ?? 0.0;
                      filterItems('');
                    });
                  },
                  onSubmitted: (value) {
                    setState(() {
                      budget = double.tryParse(value) ?? 0.0;
                      updateFilteredItems();
                    });
                  },
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    labelText: 'Enter Budget',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => filterItems('Combos'),
                style: ElevatedButton.styleFrom(
                  minimumSize:
                      Size(100, 50), // Change the width and height as needed
                ),
                child: Text('Combos'),
              ),
              SizedBox(
                width: 5,
              ),

              ElevatedButton(
                onPressed: () => filterItems('Burger'),
                style: ElevatedButton.styleFrom(
                  minimumSize:
                      Size(100, 50), // Change the width and height as needed
                ),
                child: Text('Burger'),
              ),
              SizedBox(
                width: 5,
              ),
              ElevatedButton(
                onPressed: () => filterItems('Fries'),
                style: ElevatedButton.styleFrom(
                  minimumSize:
                      Size(100, 50), // Change the width and height as needed
                ),
                child: Text('Fries'),
              ),
              SizedBox(
                width: 5,
              ),
              ElevatedButton(
                onPressed: () => filterItems('Desserts'),
                style: ElevatedButton.styleFrom(
                  minimumSize:
                      Size(100, 50), // Change the width and height as needed
                ),
                child: Text('Desserts'),
              ),
              SizedBox(
                width: 5,
              ),
              ElevatedButton(
                onPressed: () => filterItems('Drinks'),
                style: ElevatedButton.styleFrom(
                  minimumSize:
                      Size(100, 50), // Change the width and height as needed
                ),
                child: Text('Drinks'),
              ),
              SizedBox(
                width: 5,
              ),
              ElevatedButton(
                onPressed: () => filterItems('Icecreams'),
                style: ElevatedButton.styleFrom(
                  minimumSize:
                      Size(100, 50), // Change the width and height as needed
                ),
                child: Text('Icecreams'),
              ),
              // Add more buttons for other categories
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: filteredItemsByCategory.length,
            itemBuilder: (context, index) {
              final category = filteredItemsByCategory.keys.toList()[index];
              final items = filteredItemsByCategory[category]!;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: Text(
                      category,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return Padding(
                        padding: const EdgeInsets.only(left:20.0,right: 20,top: 15,bottom: 15),
                        child: GestureDetector(
                          onTap: () {
                            Map<String, dynamic> foodData = {
                            "name": item.name,
                            "image": item.image,
                            "price": item.price,
                            "description":item.description
                          };
                          Navigator.pushNamed(context, "/foodView",
                              arguments: foodData);
                          },
                          child: Container(
                            padding: EdgeInsets.only(top: 10,bottom: 10),
                            decoration: BoxDecoration(
                              border: Border.all(width: 1,color: const Color.fromARGB(255, 68, 62, 62)),
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Image(image: AssetImage(item.image),width: 100,height: 100,),
                                SizedBox(width: 20,),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                  Text(item.name,style: TextStyle(fontSize: 18),),
                                  SizedBox(height: 5,),
                                  Text(item.description,style: TextStyle(fontSize: 12),),
                                  SizedBox(height: 5,),
                                  Text(item.price,style: TextStyle(color: Colors.red),)
                                ],),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
