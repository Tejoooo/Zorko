// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, use_build_context_synchronously, await_only_futures, unnecessary_cast, must_be_immutable

import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zorko/components/snackBar.dart';
import 'package:zorko/constants.dart';
import 'package:http/http.dart' as http;
import 'package:zorko/getx/userController.dart';
import 'package:zorko/models/fooditems.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<FoodItem> items = [];
  bool isLoading = false;

  void _init() async {
    setState(() {
      isLoading = true;
    });
    User? user = await FirebaseAuth.instance.currentUser;
    if (user != null) {
      String? uid = user.uid;
      String apiURL = "${backendURL}api/cart/";
      final response = await http.post(Uri.parse(apiURL), body: {
        "userID": uid,
      });
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        List<FoodItem> dup = [];
        for (var i = 0; i < data.length; i++) {
          dup.add(FoodItem(
            name: data[i]['item']['name'],
            description: data[i]['item']['description'],
            price: (data[i]['item']['price'] is int)
                ? (data[i]['item']['price'] as int).toDouble()
                : data[i]['item']['price'].toDouble(),
            id: data[i]['item']['id'].toString(),
            image: data[i]['item']['image'],
            count: data[i]['quantity'],
          ));
        }
        setState(() {
          items = dup;
        });
      } else if (response.statusCode == 404) {
      } else {
        ErrorSnackBar(context as BuildContext, "unable to fetch cart items");
      }
      setState(() {
        isLoading = false;
      });
    }
  }

  double calculatedTotal() {
    double total = 0;
    for (var i = 0; i < items.length; i++) {
      double a = items[i].price!.toDouble();
      double b = items[i].count!.toDouble();

      total += a * b;
    }
    return total;
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
            child: Column(
                children: [
                  Column(
                    children: items
                        .map((item) => OrderItemCard(
                              foodItem: item,
                            ))
                        .toList(),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text("Total: ${calculatedTotal().toString()}"),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        User? user = await FirebaseAuth.instance.currentUser;
                        if (user != null) {
                          String? uid = user.uid;
                          String apiURL = "${backendURL}api/order/";
                          final response =
                              await http.post(Uri.parse(apiURL), body: {
                            "userID": uid,
                          });
                          if (response.statusCode == 200) {
                            Navigator.pop(context);
                          } else {
                            ErrorSnackBar(context, "unable to place order");
                          }
                        }
                      },
                      child: Text("Buy Now")),
                  SizedBox(
                    height: 80,
                  ),
                ],
              ),
          ),
    );
  }
}

class OrderItemCard extends StatefulWidget {
  FoodItem foodItem;
  OrderItemCard({super.key, required this.foodItem});

  @override
  State<OrderItemCard> createState() => _OrderItemCardState();
}

class _OrderItemCardState extends State<OrderItemCard> {
  Future<bool> cartFunction(int count) async {
    String apiURL = "${backendURL}api/";
    if (count == 1) {
      apiURL += "add_to_cart/";
    } else if (count == -1) {
      apiURL += "delete_from_cart/";
    }
    UserController userController = Get.find<UserController>();
    String uid = userController.user.value.uid;
    final response = await http.post(Uri.parse(apiURL), body: {
      "itemID": widget.foodItem.id,
      'userID': uid.toString(),
    });
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image(
              image: NetworkImage(backendURL + (widget.foodItem.image ?? '')),
              height: 72,
            ),
            GestureDetector(
              onTap: () {
                Map<String, dynamic> foodData = {
                  "name": widget.foodItem.name,
                  "image": widget.foodItem.image,
                  "price": widget.foodItem.price,
                  "description": widget.foodItem.description
                };
                Navigator.pushNamed(context, "/foodView", arguments: foodData);
              },
              child: Text(
                widget.foodItem.name ?? "Nachos",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Column(
              children: [
                Text(widget.foodItem.price.toString()),
                widget.foodItem.count == 0
                    ? SizedBox(
                        height: 30,
                        width: 75,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: Color(0xFFEF7931),
                          ),
                          child: ElevatedButton(
                            onPressed: () async {
                              if (await cartFunction(1)) {
                                setState(() {
                                  widget.foodItem.count =
                                      (widget.foodItem.count ?? 0) + 1;
                                });
                              } else {
                                debugPrint("Operation not done");
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.black,
                              backgroundColor: Colors.transparent,
                              // padding:
                              //     EdgeInsets.all(8), // Adjust padding as needed
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    10), // Adjust the border radius as needed
                              ),
                              elevation: 0, // Set text color
                            ),
                            child: Text(
                              'ADD',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      )
                    : SizedBox(
                        height: 25,
                        width: 85,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 25,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    5), // Set the border radius
                                color: Color(
                                    0xFFEF7931), // Set the background color to EF7931
                              ),
                              child: ElevatedButton(
                                onPressed: () async {
                                  bool result = await cartFunction(-1);
                                  if (result) {
                                    setState(() {
                                      widget.foodItem.count =
                                          (widget.foodItem.count ?? 0) - 1;
                                    });
                                  } else {
                                    debugPrint("Operation not done");
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.black,
                                  backgroundColor: Colors.transparent,
                                  padding: EdgeInsets.all(
                                      0), // Adjust padding as needed
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        10), // Adjust the border radius as needed
                                  ),
                                  elevation: 0, // Set text color
                                ),
                                child: Text(
                                  '-',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                            Text(
                              widget.foodItem.count.toString(),
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700),
                            ),
                            Container(
                              width: 25,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    5), // Set the border radius
                                color: Color(
                                    0xFFEF7931), // Set the background color to EF7931
                              ),
                              child: ElevatedButton(
                                onPressed: () async {
                                  bool result = await cartFunction(1);
                                  if (result) {
                                    setState(() {
                                      widget.foodItem.count =
                                          (widget.foodItem.count ?? 0) + 1;
                                    });
                                  } else {
                                    debugPrint("Operation not done");
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.black,
                                  backgroundColor: Colors.transparent,
                                  padding: EdgeInsets.all(
                                      0), // Adjust padding as needed
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        10), // Adjust the border radius as needed
                                  ),
                                  elevation: 0, // Set text color
                                ),
                                child: Text(
                                  '+',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
              ],
            )
          ],
        ));
  }
}
