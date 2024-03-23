import 'package:flutter/material.dart';

class ProfileCard extends StatefulWidget {
  final String? name;
  const ProfileCard({
    Key? key,
    required this.name,
  }) : super(key: key);

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.amber[300],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${widget.name}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

             Icon(Icons.arrow_right_alt_outlined),
          ],
        ),
      ),
    );
  }
}
