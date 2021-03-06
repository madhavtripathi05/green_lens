import 'dart:convert';

Crop cropFromJson(String str) => Crop.fromJson(json.decode(str));

String cropToJson(Crop data) => json.encode(data.toJson());

class Crop {
  Crop({
    this.id,
    this.title,
    this.imageUrl,
    this.color,
  });

  String id;
  String title;
  String imageUrl;
  String color;

  factory Crop.fromJson(Map<String, dynamic> json) => Crop(
        id: json["id"],
        title: json["title"],
        imageUrl: json["imageUrl"],
        color: json["color"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "imageUrl": imageUrl,
        "color": color,
      };
}
