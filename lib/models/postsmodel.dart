import 'dart:convert';

class Post {
  final int id;
  final String image;
  final String description;
  String? location;
  final List<Comment> comments;
  final List<dynamic> likes;
  final DateTime createdAt;
  final UserDetails userDetails;

  Post({
    required this.id,
    required this.image,
    required this.description,
    required this.location,
    required this.comments,
    required this.likes,
    required this.createdAt,
    required this.userDetails,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    // Parse comments
    List<Comment> parsedComments = [];
    if (json['comments'] != null) {
      var commentsJson = json['comments'];
      if (commentsJson is List) {
        parsedComments = commentsJson.map((comment) => Comment.fromJson(comment)).toList();
      } else if (commentsJson is Map && commentsJson.containsKey('comments')) {
        var nestedCommentsJson = commentsJson['comments'];
        if (nestedCommentsJson is List) {
          parsedComments = nestedCommentsJson.map((comment) => Comment.fromJson(comment)).toList();
        }
      }
    }

    // Parse likes
    // List<dynamic> parsedLikes = [];
    // if (json['likes'] != null) {
    //   var likesJson = json['likes'];
    //   if (likesJson is List) {
    //     parsedLikes = List<int>.from(likesJson);
    //   } else if (likesJson is Map && likesJson.containsKey('likes')) {
    //     var nestedLikesJson = likesJson['likes'];
    //     if (nestedLikesJson is List) {
    //       parsedLikes = List<int>.from(nestedLikesJson);
    //     }
    //   }
    // }

    return Post(
      id: json['id'],
      image: json['image'],
      description: json['description'],
      location: json['location'] ?? '',
      comments: parsedComments,
      likes: json['likes']['likes'],
      createdAt: DateTime.parse(json['created_at']),
      userDetails: json['userDetails'] != null ? UserDetails.fromJson(json['userDetails']) : UserDetails(id: 0, username: '', profileImage: ''), // Adjust the default values as needed
    );
  }
}

class Comment {
  String id;
  String text;
  String image;
  DateTime time;
  String username;

  Comment({
    required this.id,
    required this.text,
    required this.image,
    required this.time,
    required this.username,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['userID'],
      text: json['comment'],
      image: json['image'],
      time: DateTime.parse(json['time']),
      username: json['username'],
    );
  }
}


class UserDetails {
  final int id;
  final String username;
  final String profileImage;

  UserDetails({
    required this.id,
    required this.username,
    required this.profileImage,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
      id: json['id'],
      username: json['name'] ?? '',
      profileImage: json['profilepic'] ?? '',
    );
  }
}
