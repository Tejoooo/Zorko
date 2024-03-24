import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zorko/components/fooditemtile.dart';
import 'package:zorko/components/snackBar.dart';
import 'package:zorko/constants.dart';
import 'package:http/http.dart' as http;
import 'package:zorko/models/Itemmodel.dart';
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
      String apiURL = backendURL + "api/cart/";
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
        ErrorSnackBar(context, "unable to fetch cart items");
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
    // TODO: implement initState
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          child: isLoading ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(child: CircularProgressIndicator()),
            ],
          ): Column(
            children: [
              Column(
                children: items.map((item) => FoodItemTile(foodItem: item)).toList(),
              ),
              SizedBox(height: 30,),
              Text("Total: ${calculatedTotal().toString()}"),
              SizedBox(height: 20,),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/upload");
                },
                child: ElevatedButton(onPressed: () async{
                  User? user = await FirebaseAuth.instance.currentUser;
                  if (user != null) {
                    String? uid = user.uid;
                    String apiURL = backendURL + "api/order/";
                    final response = await http.post(Uri.parse(apiURL), body: {
                      "userID": uid,
                    });
                    if (response.statusCode == 200) {
                      Navigator.pop(context);
                    } else {
                      ErrorSnackBar(context, "unable to place order");
                    }
                  }
                },child: Text("Buy Now")),
              ),
              SizedBox(height: 80,),
            ],
          ),
        ),
      ),
    );
  }
}
