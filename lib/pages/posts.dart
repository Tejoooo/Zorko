// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers, must_be_immutable, sort_child_properties_last, sized_box_for_whitespace, unnecessary_cast

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:zorko/components/snackBar.dart';
import 'package:zorko/constants.dart';

import '../models/postsmodel.dart';

class Posts extends StatefulWidget {
  const Posts({super.key});

  @override
  State<Posts> createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  List<Post> fetchedPosts = [];
  bool isLoading = false;

  void _init() async {
    setState(() {
      isLoading = true;
    });
    const apiURL = "${backendURL}api/posts/";
    final response = await http.get(Uri.parse(apiURL));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      setState(() {
        fetchedPosts = jsonData.map((data) => Post.fromJson(data)).toList();
        isLoading = false;
      });
    } else {
      ErrorSnackBar(context as BuildContext, "Looks like something went wrong");
    }
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: isLoading ? Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.black)),) : SingleChildScrollView(
          child: Column(
                  children: [
                    SizedBox(
                      height: 12,
                    ),
                    Column(
                      children: fetchedPosts
                          .map((post) => PostComponent(
                                postDetails: post,
                              ))
                          .toList(),
                    )
                  ],
                ),
        ),
    );
  }
}

class PostComponent extends StatefulWidget {
  Post postDetails;
  PostComponent({
    super.key,
    required this.postDetails,
  });

  @override
  State<PostComponent> createState() => _PostComponentState();
}

class _PostComponentState extends State<PostComponent> {
  bool isLiked = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: Column(
        children: [
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Row(
                    children: [
                      Container(
                        child: ClipOval(
                          child: Image(
                            image: NetworkImage(backendURL +
                                widget.postDetails.userDetails.profileImage),
                            fit: BoxFit.cover,
                          ),
                        ),
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(shape: BoxShape.circle),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        widget.postDetails.userDetails.username,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.maxFinite, 
                  height: 350,
                  decoration: BoxDecoration(color: Color.fromARGB(255, 66, 63, 63)),
                  child: Image(
                    image: NetworkImage(
                      backendURL + widget.postDetails.image,
                    ),
                    fit: BoxFit.cover,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      } else {
                        return Center(
                          child:
                              CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white)
                              ),
                        );
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  child: Row(
                    children: [
                      GestureDetector(
                          onTap: () {
                            setState(() {
                              isLiked = !isLiked;
                            });
                          },
                          child: Image(
                              image: AssetImage(isLiked
                                  ? 'assets/like.png'
                                  : 'assets/unlike.png'))),
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
                  child: Text(widget.postDetails.description),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
