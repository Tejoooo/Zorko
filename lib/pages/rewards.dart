// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:zorko/components/redeembox.dart';

class RewardsPage extends StatefulWidget {
  const RewardsPage({super.key});

  @override
  State<RewardsPage> createState() => _RewardsPageState();
}

class _RewardsPageState extends State<RewardsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Rewards'),
      // ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
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
              padding:
                  const EdgeInsets.only(top: 35.0, left: 35.0, right: 35.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.grey[350],
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Icon(Icons.arrow_back_ios_new_outlined),
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
                    SizedBox(
                      height: 80,
                    ),
                    Container(
                      decoration: BoxDecoration(),
                      child: Image.asset('assets/h15.png'),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      'REWARDS',
                      style: TextStyle(
                        fontSize: 54.0,
                        fontWeight: FontWeight.bold,
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 1.2
                          ..color = Colors.black54,
                        // color: Colors.red,
                      ),
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RewardCard(
                                rewardName: "burger",
                                rewardDescription: "5%",
                                rewardImage: "assets/h16.jpg",
                                rewardPoints: 10),
                            // RewardCard(rewardName: "pizza", rewardDescription: "5%", rewardImage: "assets/h5.png", rewardPoints: 200),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Text('@200 Zorco'),
                                // ElevatedButton(onPressed: null, child: Text('Redeem')),
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RewardCard(
                                rewardName: "drinks",
                                rewardDescription: "5%",
                                rewardImage: "assets/h18.jpeg",
                                rewardPoints: 200),
                            // RewardCard(rewardName: "cokes", rewardDescription: "5%", rewardImage: "assets/h5.png", rewardPoints: 200),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RewardCard(
                                rewardName: "drinks",
                                rewardDescription: "5%",
                                rewardImage: "assets/h17.jpg",
                                rewardPoints: 200),
                            // RewardCard(rewardName: "cokes", rewardDescription: "5%", rewardImage: "assets/h5.png", rewardPoints: 200),
                          ],
                        ),
                        SizedBox(height: 70,),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
