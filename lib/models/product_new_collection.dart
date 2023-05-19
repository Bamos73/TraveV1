import 'package:flutter/material.dart';

class NewCollectionProduct{
  final int id;
  final String title, description;
  final List<String> images;
  final List<Color> colors;
  final double rating, price;
  final bool isFavourite, isPopular;


  NewCollectionProduct({
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


List<NewCollectionProduct> NewCollectionArray = [
  NewCollectionProduct(
    id: 0,
    images: [
      "https://firebasestorage.googleapis.com/v0/b/singup-a9273.appspot.com/o/Voile%2FVL0001%2FIMG_4298.jpeg?alt=media&token=c0250456-00bf-41e0-a43a-fb8473d37b6a",
    ],
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ],
    title: "Wireles Controller for PS4™",
    price: 10000,
    description: "aucune description",
    rating: 4.8,
    isFavourite: true,
    isPopular: false,

  ),

  NewCollectionProduct(
    id: 1,
    images: [
      "https://firebasestorage.googleapis.com/v0/b/singup-a9273.appspot.com/o/Voile%2FVL0001%2FIMG_4299.jpeg?alt=media&token=f73d6ea7-d3c2-4bf9-b132-d48f76c7cfd4",
    ],
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ],
    title: "Wireles Controller for PS4™",
    price: 10000,
    description: "description",
    rating: 4.8,
    isFavourite: true,
    isPopular: false,

  ),

  NewCollectionProduct(
    id: 2,
    images: [
      "https://firebasestorage.googleapis.com/v0/b/singup-a9273.appspot.com/o/Voile%2FVL0001%2FIMG_4295.jpeg?alt=media&token=f6484766-cb12-450b-92fd-f40d7af4ce4c",
    ],
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ],
    title: "Wireles Controller for PS4™",
    price: 10000,
    description: "description",
    rating: 4.8,
    isFavourite: true,
    isPopular: false,

  ),

  NewCollectionProduct(
    id: 3,
    images: [
      "https://firebasestorage.googleapis.com/v0/b/singup-a9273.appspot.com/o/Voile%2FVL0001%2FIMG_4296.jpeg?alt=media&token=46e71fa7-1351-45c9-80ef-32ce6a12c42d",
    ],
    colors: [
      Color(0xFFF6625E),
      Color(0xFFB93D92),
      Color(0xFFDECB9C),
      Colors.white,
    ],
    title: "Wireles Controller for PS4™",
    price: 10000,
    description: "description",
    rating: 4.8,
    isFavourite: true,
    isPopular: false,

  ),
];

