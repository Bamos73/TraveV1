
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopapp/screens/details_categorie/details_categorie_screen.dart';
import 'package:shopapp/size_config.dart';

class CardPopular extends StatelessWidget {
  const CardPopular({
    super.key,
    required this.documents,
  });

  final List<QueryDocumentSnapshot<Object?>> documents;

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
          // Largeur maximale d'une tuile
          mainAxisSpacing: getProportionateScreenWidth(20),
          // Espacement vertical entre les tuiles
          crossAxisSpacing: getProportionateScreenWidth(20),
          // Espacement horizontal entre les tuiles
          childAspectRatio: 1, // Ratio largeur/hauteur d'une tuile
        ),
        itemBuilder: (context, index) {
          final document = documents[index];
          final imageUrl = document['image'] ?? '';
          final title = document['titre_categorie'] ?? '';

          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, DetailCtgScreen.routeName,
                  arguments: {
                    'nom_document': document['nom_document'],
                    'titre_categorie': document['titre_categorie'],
                  });
            },
            child: Stack(
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
            ),
          );
        },
      ),
    );
  }
}
