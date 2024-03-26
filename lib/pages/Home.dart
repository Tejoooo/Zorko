import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zorko/provider/userProvider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    final userDetails = userProvider.user;
    return Column(
      children: [
        Center(child: Text(userDetails.coins),),
      ],
    );
  }
}