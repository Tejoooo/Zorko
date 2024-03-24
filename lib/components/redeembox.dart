import 'package:flutter/material.dart';

class RewardCard extends StatefulWidget {
  final String? rewardName;
  final String? rewardDescription;
  final String? rewardImage;
  final int? rewardPoints;
  const RewardCard({
    Key? key,
    required this.rewardName,
    required this.rewardDescription,
    required this.rewardImage,
    required this.rewardPoints,
  }) : super(key: key);

  

  @override
  State<RewardCard> createState() => _RewardCardState();
}

class _RewardCardState extends State<RewardCard> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        padding: EdgeInsets.all(1),
        height: 200,
        width: 350,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              '${widget.rewardImage}',
              width: 380,
              height: 140,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(onPressed: null, child: Text('Redeem'),style: ElevatedButton.styleFrom(
    backgroundColor: Colors.red, // Change the background color to red
  minimumSize: Size(double.infinity, 50),),),

                // Text(
                //   '${widget.rewardName}',
                //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                // ),
                // Text(
                //   '${widget.rewardDescription}',
                //   style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                // ),
                // Text(
                //   ' ${widget.rewardPoints} Zorko Coins',
                //   style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,color: Colors.orange[500]),
                // ),
              ],
            ),
            
          ],
        ),
      ),
    );
  }
}