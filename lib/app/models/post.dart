// To parse this JSON data, do
//
//     final post = postFromJson(jsonString);

import 'dart:convert';

Post postFromJson(String str) => Post.fromJson(json.decode(str));

String postToJson(Post data) => json.encode(data.toJson());

class Post {
  Post({
    this.id,
    this.title,
    this.imageUrl,
    this.content,
    this.date,
    this.uploader,
    this.profile,
    this.likes,
    this.comments,
  });

  String id;
  String title;
  String imageUrl;
  String content;
  String date;
  String uploader;
  String profile;
  List<String> likes;
  List<Comment> comments;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json["id"],
        title: json["title"],
        imageUrl: json["imageUrl"],
        content: json["content"],
        date: json["date"],
        uploader: json["uploader"],
        profile: json["profile"],
        likes: List<String>.from(json["likes"].map((x) => x)),
        comments: List<Comment>.from(
            json["comments"].map((x) => Comment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "imageUrl": imageUrl,
        "content": content,
        "date": date,
        "uploader": uploader,
        "profile": profile,
        "likes": List<dynamic>.from(likes.map((x) => x)),
        "comments": List<dynamic>.from(comments.map((x) => x.toJson())),
      };
}

class Comment {
  Comment({
    this.id,
    this.by,
    this.content,
    this.date,
  });

  String id;
  String by;
  String content;
  String date;

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json["id"],
        by: json["by"],
        content: json["content"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "by": by,
        "content": content,
        "date": date,
      };
}
