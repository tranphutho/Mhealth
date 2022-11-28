// To parse this JSON data, do
//
//     final category = categoryFromMap(jsonString);

import 'dart:convert';

Category categoryFromMap(String str) => Category.fromMap(json.decode(str));

String categoryToMap(Category data) => json.encode(data.toMap());

class Category {
  Category({
    this.id,
    this.name,
    this.image,
    this.slug,
  });

  int id;
  String name;
  String image;
  String slug;

  factory Category.fromMap(Map<String, dynamic> json) => Category(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    image: json["image"] == null ? null : json["image"],
    slug: json["slug"] == null ? null : json["slug"],
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "image": image == null ? null : image,
    "slug": slug == null ? null : slug,
  };
}
