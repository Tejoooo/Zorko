// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Posts extends StatefulWidget {
  const Posts({super.key});

  @override
  State<Posts> createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 12,
              ),
              Column(
                children: [
                  PostComponent(
                    PostURL: "assets/post1.png",
                    ProfileImage: "assets/profile.png",
                    ProfileName: "CB Praveen",
                    text:
                        "Food is very necessary in our daily life. Today we had a very delicious Alfredo cheese pasta and it tastes like heaven and very one should try this item from Zoroko.",
                  ),
                  PostComponent(
                    PostURL: "assets/post2.png",
                    ProfileImage: "assets/profile.png",
                    ProfileName: "Marvis Ighedosa",
                    text:
                        "Food is very necessary in our daily life. Today we had a very delicious Alfredo cheese pasta and it tastes like heaven and very one should try this item from Zoroko.",
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class PostComponent extends StatelessWidget {
  String PostURL;
  String text;
  String ProfileImage;
  String ProfileName;
  PostComponent(
      {super.key,
      required this.PostURL,
      required this.text,
      required this.ProfileImage,
      required this.ProfileName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: Column(
        children: [
          Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Row(
                    children: [
                      Image(image: AssetImage(ProfileImage)),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        ProfileName,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Image(
                  image: AssetImage(PostURL),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  child: Row(
                    children: [
                      Image(image: AssetImage('assets/unlike.png')),
                      SizedBox(
                        width: 15,
                      ),
                      Image(image: AssetImage('assets/comment.png')),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0, right: 8.0),
                  child: Text(text),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
