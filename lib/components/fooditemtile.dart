// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:zorko/components/snackBar.dart';
import 'package:zorko/constants.dart';
import 'package:zorko/models/fooditems.dart';
import 'package:http/http.dart' as http;

class FoodItemTile extends StatefulWidget {
  final FoodItem foodItem; // Pass FoodItem object to the widget
  const FoodItemTile({Key? key, required this.foodItem}) : super(key: key);

  @override
  State<FoodItemTile> createState() => _FoodItemTileState();
}

class _FoodItemTileState extends State<FoodItemTile> {
  get http => null;

  late int count ;


  Future<bool> cartFunction(int count) async {
    String apiURL = backendURL + "api/";
    if (count == 1) {
      apiURL += "add_to_cart/";
    } else if (count == -1) {
      apiURL += "delete_from_cart/";
    }
    User? user = await FirebaseAuth.instance.currentUser;
    String? token = user?.uid;
    final response = await http.post(Uri.parse(apiURL), body: {
      "itemID": widget.foodItem.id.toString(),
      'userID': token.toString()
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
    setState(() {
      count = widget.foodItem.count ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
        children: <Widget>[
          GestureDetector(
            onTap: (){
              Map<String, dynamic> foodData = {
                            "name": widget.foodItem.name,
                            "image": widget.foodItem.image,
                            "price": widget.foodItem.price,
                            "description":widget.foodItem.description
                          };
                          Navigator.pushNamed(context, "/foodView",
                              arguments: foodData);
            },
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(8),
              ),
              child:
                  Image(image: NetworkImage(backendURL + (widget.foodItem.image ?? ''))),
              // You can display an image here if you have one in your FoodItem model
              // child: Image.network(foodItem.imageUrl), // Example if imageUrl is a property in your FoodItem model
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  widget.foodItem.name ?? '', // Display food name from FoodItem object
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                const SizedBox(height: 4),
                Text(
                  widget.foodItem.description ??
                      '', // Display food description from FoodItem object
                  style: Theme.of(context).textTheme.caption,
                ),
                const SizedBox(height: 4),
                Text(
                  '\$${widget.foodItem.price ?? 0}', // Display food price from FoodItem object
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                const SizedBox(height: 4),
                SizedBox(
                  height: 40,
                  width: 120,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              10), // Set the border radius
                          color: Color(
                              0xFFEF7931), // Set the background color to EF7931
                        ),
                        child: ElevatedButton(
                          onPressed: () async {
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
                            padding:
                                EdgeInsets.all(8), // Adjust padding as needed
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
                        width: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              10), // Set the border radius
                          color: Color(
                              0xFFEF7931), // Set the background color to EF7931
                        ),
                        child: ElevatedButton(
                          onPressed: () async {
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
                            padding:
                                EdgeInsets.all(8), // Adjust padding as needed
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
          Row(
            children: [
              IconButton(
                icon: Icon(
                  widget.foodItem.likes != null && widget.foodItem.likes! > 0
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: widget.foodItem.likes != null && widget.foodItem.likes! > 0
                      ? Colors.red
                      : null,
                ),
                onPressed: () {
                  // Handle like button tap
                },
              ),
              const SizedBox(width: 1),
              IconButton(
                icon: Icon(Icons.comment),
                onPressed: () {
                  // Show comments or navigate to a screen to view comments
                  _showCommentsDialog(context,["no comments"]);
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  toList() {}
}

void _showCommentsDialog(BuildContext context, List<String>? comments) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Comments'),
        content: comments != null && comments.isNotEmpty
            ? Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: comments.map((comment) {
                  return Text(comment);
                }).toList(),
              )
            : Text('No comments available'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Close'),
          ),
        ],
      );
    },
  );
}
