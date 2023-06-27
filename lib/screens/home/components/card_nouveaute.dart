import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopapp/components/shimmer_box.dart';
import 'package:shopapp/provider/internet_provider.dart';
import 'package:shopapp/screens/category_details/details_categorie_screen.dart';
import 'package:shopapp/size_config.dart';

class CardNouveaute extends StatelessWidget {
  const CardNouveaute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('Category')
          .where('isNew', isEqualTo: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError || snapshot.data == null || snapshot.data!.docs.isEmpty) {
          return ShimmerNouveaute();
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return ShimmerNouveaute();
        }
        final documents = snapshot.data!.docs;
        return Container(
          width: double.infinity,
          child: GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: getProportionateScreenHeight(7),
              crossAxisSpacing: getProportionateScreenHeight(7),
              mainAxisExtent: getProportionateScreenHeight(250),
            ),
            itemCount: 6,
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
                        'first_collection': document['nom_first_collection'],
                      });
                },
                child: Stack(
                  children: [
                    Container(
                      width: double.maxFinite,
                      child: Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      top: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black54.withOpacity(0.1),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              title.toString().toUpperCase(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: getProportionateScreenWidth(20),
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              color: Colors.black,
                              width: getProportionateScreenWidth(80),
                              child: Center(
                                child: Text(
                                  "Magasine",
                                  style: TextStyle(
                                    fontSize:
                                    getProportionateScreenWidth(13),
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
