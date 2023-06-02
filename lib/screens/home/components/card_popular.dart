
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopapp/components/shimmer_box.dart';
import 'package:shopapp/screens/details_categorie/details_categorie_screen.dart';
import 'package:shopapp/size_config.dart';

import '../../../provider/internet_provider.dart';

class CardPopular extends StatefulWidget {
  const CardPopular({
    super.key,
    required this.documents,
  });

  final List<QueryDocumentSnapshot<Object?>> documents;

  @override
  State<CardPopular> createState() => _CardPopularState();
}


class _CardPopularState extends State<CardPopular> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: getProportionateScreenHeight(175),
      child: GridView.builder(
        itemCount: 8,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: getProportionateScreenWidth(64),
          mainAxisSpacing: getProportionateScreenWidth(20),
          crossAxisSpacing: getProportionateScreenWidth(20),
          childAspectRatio: 1, // Ratio largeur/hauteur d'une tuile
        ),
        itemBuilder: (context, index) {
          final document = widget.documents[index];
          final imageUrl = document['image'] ?? 'Nouveauté';
          final title = document['titre_categorie'] ?? 'https://firebasestorage.googleapis.com/v0/b/singup-a9273.appspot.com/o/Cat%C3%A9gorie%2FAbaya%2FAY0001%2Fjilbab.jpg?alt=media&token=0537c680-7fed-443b-963a-61e43f7eec2d';
          final collectionName = document['nom_first_collection'] ?? 'Category';

          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, DetailCtgScreen.routeName,
                  arguments: {
                    'nom_document': document['nom_document'],
                    'titre_categorie': document['titre_categorie'],
                    'first_collection': collectionName,
                  });
            },
            child: FutureBuilder(
              future: checkImage(imageUrl),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return shimmer_Popular_image();
                  } else if (snapshot.hasError || snapshot.data == null) {
                    return shimmer_Popular_image();
                  }  else {
              return Stack(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.transparent,
                    child: ClipOval(
                      child: Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        width: getProportionateScreenWidth(68),
                        height: getProportionateScreenWidth(68),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    top: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.black54.withOpacity(0.3),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Center(
                        child: Text(
                          title,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              );
              }
              }
            ),
          );
        },
      ),
    );
  }
}
