import 'package:flutter/material.dart';

class TopNavgBar extends StatefulWidget {
  const TopNavgBar({Key? key}) : super(key: key);

  @override
  State<TopNavgBar> createState() => _TopNavgBarState();
}

class _TopNavgBarState extends State<TopNavgBar> {
  int userCoins = 100; // Example: Initial coins

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          );
        },
      ),
      actions: [
        Row(
          children: [
            IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                // Navigate to cart screen or show cart items
              },
            ),
            SizedBox(width: 10), // Add some spacing between icons
            Icon(Icons.monetization_on),
            SizedBox(width: 5),
            Text('$userCoins'), // Display user's coins
            SizedBox(width: 10), // Add some spacing between icons
          ],
        ),
      ],
    );
  }
}
