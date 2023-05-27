import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopapp/components/shimmer_box.dart';
import 'package:shopapp/screens/details_categorie/details_categorie_screen.dart';
import 'package:shopapp/screens/home/components/card_popular.dart';
import 'package:shopapp/size_config.dart';

class CategoriePopular extends StatefulWidget {
  const CategoriePopular({
    super.key,
  });

  @override
  State<CategoriePopular> createState() => _CategoriePopularState();
}

class _CategoriePopularState extends State<CategoriePopular> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('Category')
          .where('isPopular', isEqualTo: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError || snapshot.data == null || snapshot.data!.docs.isEmpty) {
          return ShimmerPopular();
        }
        else if (snapshot.connectionState == ConnectionState.waiting) {
          return ShimmerPopular();
        }

        final documents = snapshot.data!.docs;
        return Padding(
          padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(20)),
          child: CardPopular(documents: documents),
        );
      },
    );
  }
}
