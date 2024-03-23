import 'package:flutter/material.dart';
import 'package:zorko/models/fooditems.dart';

class FoodItemTile extends StatelessWidget {
  final FoodItem foodItem; // Pass FoodItem object to the widget
  const FoodItemTile({Key? key, required this.foodItem}) : super(key: key);

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
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Image(image: AssetImage(foodItem.image ?? 'assets/h5.png')),
            // You can display an image here if you have one in your FoodItem model
            // child: Image.network(foodItem.imageUrl), // Example if imageUrl is a property in your FoodItem model
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  foodItem.name ?? '', // Display food name from FoodItem object
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                const SizedBox(height: 4),
                Text(
                  foodItem.description ?? '', // Display food description from FoodItem object
                  style: Theme.of(context).textTheme.caption,
                ),
                const SizedBox(height: 4),
                Text(
                  '\$${foodItem.price ?? 0}', // Display food price from FoodItem object
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                
                
              ],
            ),
          ),
          Row(
            children: [
              IconButton(
            icon: Icon(
              foodItem.likes != null && foodItem.likes! > 0 ? Icons.favorite : Icons.favorite_border,
              color: foodItem.likes != null && foodItem.likes! > 0 ? Colors.red : null,
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
                        _showCommentsDialog(context, foodItem.Comments);
                      },
                    ),
            ],
          )
          
        ],
      ),
    );
  }
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