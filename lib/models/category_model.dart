
import 'package:flutter/material.dart';
import 'dart:math';

class Category {
  String id;
  String categoryName;
  String image;

  Category({
    required this.id,
    required this.categoryName,
    required this.image,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    final Random random = Random();
    final String image =
        'lib/assets/images/${json["categoryName"].toLowerCase()}_image.png';
    return Category(
      id: json['id'],
      categoryName: json['categoryName'],
      image: image,
    );
  }
}
