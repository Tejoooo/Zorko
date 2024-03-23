import 'package:flutter/material.dart';

class FoodItem extends StatefulWidget {
  final String imagePath;
  final String itemName;
  final double price;

  const FoodItem({
    Key? key,
    required this.imagePath,
    required this.itemName,
    required this.price,
  }) : super(key: key);

  @override
  State<FoodItem> createState() => _FoodItemState();
}

class _FoodItemState extends State<FoodItem> {
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
                      Image.asset(
                        widget.imagePath,
                        width: 138,
                        height: 100,
                        // fit: BoxFit.cover,
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
                  SizedBox(
                    height: 40,
                    width: 150,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(10), // Set the border radius
                        color: Color(
                            0xFFEF7931), // Set the background color to EF7931
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          // Add your onPressed logic here
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
                          'ADD',
                          style: TextStyle(fontSize: 10),
                        ),
                      ),
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
