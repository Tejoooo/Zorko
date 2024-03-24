// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:zorko/components/snackBar.dart';
import 'package:zorko/constants.dart';
import 'package:zorko/models/Itemmodel.dart';
import 'package:http/http.dart' as http;

class FilteredItemsPage extends StatefulWidget {
  const FilteredItemsPage({Key? key}) : super(key: key);

  @override
  _FilteredItemsPageState createState() => _FilteredItemsPageState();
}

class _FilteredItemsPageState extends State<FilteredItemsPage> {
  bool isLoading = false;
  List<Item> foodItems = [];
  Map<String, List<Item>> filteredItemsByCategory = {};
  late double budget;
  List<String> categories = [
    'Combos',
    'Burger',
    'Fries',
    'Desserts',
    'Drinks',
    'Icecreams'
  ];

  // void updateFilteredItems() {
  //   // Check if foodItems is not empty before filtering
  //   if (foodItems.isNotEmpty) {
  //     // Default to 'Combos' category
  //     filterItems('Combos');
  //   }
  // }

  Map<String, List<Item>> categorizeItems(List<Item> items, double budget) {
    Map<String, List<Item>> categorizedItems = {};

    for (Item item in items) {
      if (double.parse(item.price) <= budget) {
        String category = item.category;
        categorizedItems.putIfAbsent(category, () => []);
        categorizedItems[category]!.add(item);
      }
    }

    return categorizedItems;
  }

  void filterItems(String category) {
    final Map<String, List<Item>> tempFilteredItems = {};

    foodItems.forEach((item) {
      if (item.category.toLowerCase() == category.toLowerCase() &&
          double.parse(item.price) <= budget) {
        tempFilteredItems.putIfAbsent(item.category, () => []);
        tempFilteredItems[item.category]!.add(item);
      }
    });

    setState(() {
      filteredItemsByCategory = tempFilteredItems;
    });
  }

  void _init() async {
    setState(() {
      isLoading = true;
    });
    String apiURL = backendURL + "api/menu/";
    final response = await http.get(Uri.parse(apiURL));

    if (response.statusCode == 200) {
      List<dynamic> responseData = jsonDecode(response.body);

      List<Item> finalData =
          responseData.map<Item>((json) => Item.fromJson(json)).toList();

      setState(() {
        foodItems = finalData;
        filteredItemsByCategory = categorizeItems(foodItems, budget);
      });
      List<String> dup2 = [];
      for (String key in filteredItemsByCategory.keys) {
        dup2.add(key);
      }
      setState(() {
        categories = dup2;
      });
      // updateFilteredItems(); // Call updateFilteredItems after data is fetched
    } else {
      ErrorSnackBar(context, "Something Went Wrong please try again");
    }
    setState(() {
      isLoading = false;
    });
  }

  Widget buildCategoryButtons(List<String> categories) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: categories.map((category) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 4.0, right: 4),
              child: ElevatedButton(
                onPressed: () => filterItems(category),
                style: ElevatedButton.styleFrom(
                  minimumSize:
                      Size(110, 50), // Change the width and height as needed
                ),
                child: Text(category),
              ),
            ),
          ],
        );
      }).toList(),
    );
  }

  @override
  void initState() {
    super.initState();
    budget = 100000.0;
    _init();
  }

  @override
  Widget build(BuildContext context) {
    return  isLoading ? Center(child: CircularProgressIndicator(),) : Column(
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
                      // updateFilteredItems();
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
          child: buildCategoryButtons(categories),
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
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20, top: 15, bottom: 15),
                        child: GestureDetector(
                          onTap: () {
                            Map<String, dynamic> foodData = {
                              "name": item.name,
                              "image": item.image,
                              "price": item.price,
                              "description": item.description
                            };
                            Navigator.pushNamed(context, "/foodView",
                                arguments: foodData);
                          },
                          child: Container(
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1,
                                  color: const Color.fromARGB(255, 68, 62, 62)),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Image(
                                  image: NetworkImage(backendURL + item.image),
                                  width: 100,
                                  height: 100,
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.name,
                                      style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width -
                                          180, // Adjust width as needed
                                      child: Text(
                                        item.description,
                                        style: TextStyle(fontSize: 12),
                                        maxLines: 5,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      item.price,
                                      style: TextStyle(color: Colors.red),
                                    )
                                  ],
                                ),
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
