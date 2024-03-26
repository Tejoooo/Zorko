// ignore_for_file: prefer_const_constructors, use_super_parameters, unused_local_variable, await_only_futures

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zorko/components/snackBar.dart';
import 'package:zorko/constants.dart';
import 'package:http/http.dart' as http;
import 'package:zorko/getx/userController.dart';
import 'package:zorko/models/fooditems.dart';

class FoodItemWidget extends StatefulWidget {
  final String imagePath;
  final String itemName;
  final double price;
  final String description;
  final String id;

  FoodItemWidget({
    Key? key,
    required this.imagePath,
    required this.itemName,
    required this.price,
    required this.description,
    required this.id,
  }) : super(key: key);

  @override
  State<FoodItemWidget> createState() => _FoodItemWidgetState();
}

class _FoodItemWidgetState extends State<FoodItemWidget> {
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
      "itemID": widget.id,
      'userID': uid.toString(),
    });
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  int count = 0;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Row(
          children: [
            Container(
              width: 196,
              height: 230,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(13),
              ),
              child: Column(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Map<String, dynamic> foodData = {
                            "name": widget.itemName,
                            "image": widget.imagePath,
                            "price": widget.price,
                            "description":widget.description
                          };
                          Navigator.pushNamed(context, "/foodView",
                              arguments: foodData);
                        },
                        child: Image.network(
                          backendURL+ widget.imagePath,
                          width: 138,
                          height: 100,
                          // fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        widget.itemName,
                        style: TextStyle(
                          color: Color(0xFF000000),
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(
                        height: 1,
                      ),
                      Text(
                        'Price: \$${widget.price}',
                        style: TextStyle(
                          color: Color(0xFFFA4A0C),
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  count == 0
                      ? SizedBox(
                          height: 40,
                          width: 150,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  10), // Set the border radius
                              color: Color(
                                  0xFFEF7931), // Set the background color to EF7931
                            ),
                            child: ElevatedButton(
                              onPressed: () async{
                                // Add your onPressed logic here
                                if (await cartFunction(1)){
                                  setState(() {
                                    count++;
                                  });
                                } else{
                                  // ErrorSnackBar(context, "Operation not done");
                                  debugPrint("Operation not done");
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.black,
                                backgroundColor: Colors.transparent,
                                padding: EdgeInsets.all(
                                    8), // Adjust padding as needed
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      10), // Adjust the border radius as needed
                                ),
                                elevation: 0, // Set text color
                              ),
                              child: Text(
                                'ADD',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                        )
                      : SizedBox(
                          height: 40,
                          width: 150,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      10), // Set the border radius
                                  color: Color(
                                      0xFFEF7931), // Set the background color to EF7931
                                ),
                                child: ElevatedButton(
                                  onPressed: () async{
                                    if (await cartFunction(-1)){
                                  setState(() {
                                    count--;
                                  });
                                } else{
                                  ErrorSnackBar(context, "Operation not done");
                                }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.black,
                                    backgroundColor: Colors.transparent,
                                    padding: EdgeInsets.all(
                                        8), // Adjust padding as needed
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
                                count.toString(),
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700),
                              ),
                              Container(
                                width: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      10), // Set the border radius
                                  color: Color(
                                      0xFFEF7931), // Set the background color to EF7931
                                ),
                                child: ElevatedButton(
                                  onPressed: () async{
                                    if (await cartFunction(1)){
                                  setState(() {
                                    count++;
                                  });
                                } else{
                                  ErrorSnackBar(context, "Operation not done");
                                }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.black,
                                    backgroundColor: Colors.transparent,
                                    padding: EdgeInsets.all(
                                        8), // Adjust padding as needed
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
              ),
            ),
          ],
        ),
      ],
    );
  }
}
