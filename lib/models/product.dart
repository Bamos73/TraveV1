import 'package:flutter/material.dart';

class Product {
  final int id;
  final String title, description;
  final List<String> images;
  final List<Color> colors;
  final double rating, price;
  final bool isFavourite, isPopular;

  Product({
    required this.id,
    required this.images,
    required this.colors,
    this.rating = 0.0,
    this.isFavourite = false,
    this.isPopular = false,
    required this.title,
    required this.price,
    required this.description,
  });
}

List<Product> demoProducts = [
  Product(
    id: 0,
    images: [
      "assets/images/Image Popular Product 1.png",
    ],
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ],
    title: "Wireles Controller for PS4™",
    price: 10000,
    description: description,
    rating: 4.8,
    isFavourite: true,
    isPopular: false,

  ),
  Product(
    id: 1,
    images: [
      "assets/images/Image Popular Product 2.png",
    ],
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ],
    title: "Sac a main",
    price: 8000,
    description: description,
    rating: 4.1,
    isFavourite: true,
    isPopular: false,

  ),
  Product(
    id: 2,
    images: [
      "assets/images/Image Popular Product 3.png",
      "assets/images/Image Popular Product 1.png",
      "assets/images/Image Popular Product 2.png",
      "assets/images/Image Popular Product 3.png",
    ],
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ],
    title: "Gloves XC Omega - Polygon",
    price: 7000,
    description: description,
    rating: 4.1,
    isFavourite: false,
    isPopular: true,

  ),
  Product(
    id: 3,
    images: [
      "assets/images/wireless headset.png",
    ],
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ],
    title: "Logitech Head",
    price: 100000,
    description: description,
    rating: 4.1,
    isFavourite: false,
    isPopular: true,

  ),
];

const String description =
    "Wireless Controller for PS4™ gives you what you want in your gaming from over precision control your games to sharing …";






