import 'package:flutter/material.dart';

class Product {
  final String category, name, description;
  final int price;
  final List<String> images, features, features_values;

  Product ({
    required this.category,
    required this.name,
    required this.description,
    required this.price,
    required this.images,
    required this.features,
    required this.features_values
});
}