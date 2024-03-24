import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class RewardsPage extends StatefulWidget {
  const RewardsPage({super.key});

  @override
  State<RewardsPage> createState() => _RewardsPageState();
}

class _RewardsPageState extends State<RewardsPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Stack(
          children: [
            // Background image
            Positioned(
              top: -200, // Move the circle up by adjusting this value
              left: -100, // Optional: Adjust left position if needed
              child: Container(
                width: 600, // Adjust width of the circle if needed
                height: 600, // Adjust height of the circle if needed
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [Color(0xFFFFCE92), Color(0xFFED8F03)],
                  ),
                ),
              ),
            ),
            Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              // Carousel Slider
                Container(
                  decoration: BoxDecoration(),
                  child: Image.asset('assets/h15.png'),
                ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(25.0),
                ),
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Zorko Coins',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Spacer(),
                        Icon(
                          Icons.card_giftcard,
                          size: 30,
                        ),
                        Text(
                          '1000',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
            ),
          ],
        ),

    );
  }
}
