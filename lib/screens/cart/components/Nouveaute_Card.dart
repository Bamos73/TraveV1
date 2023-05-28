import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopapp/screens/home/components/card_categorie.dart';
import 'package:shopapp/components/shimmer_box.dart';
import 'package:shopapp/screens/details/details_screen.dart';
import 'package:shopapp/size_config.dart';


class Nouveaute_card extends StatefulWidget {
  const Nouveaute_card({
    super.key,
  }) ;


  @override
  State<Nouveaute_card> createState() => _Nouveaute_cardState();
}

class _Nouveaute_cardState extends State<Nouveaute_card> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(
          left: getProportionateScreenWidth(15),
          top: getProportionateScreenWidth(5),
          right: getProportionateScreenWidth(15),
        ),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('Category')
                    .where('isNew', isEqualTo: true)
                    .snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError || snapshot.data == null || snapshot.data!.docs.isEmpty) {
                    return SizedBox.shrink();
                  }
                  else if (snapshot.connectionState == ConnectionState.waiting) {
                    return SizedBox.shrink();
                  }
                  else {
                    List<DocumentSnapshot> products = snapshot.data!.docs;
                    return GridView.builder(
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: getProportionateScreenHeight(20),
                        crossAxisSpacing: getProportionateScreenHeight(20),
                        mainAxisExtent: getProportionateScreenHeight(300),
                      ),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final documents = snapshot.data!.docs;
                        final document = documents[index];
                        final imageUrl = document['image'] ?? '';
                        final title = document['titre_categorie'] ?? '';

                        return GestureDetector(
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => DetailsScreen(
                                productId: products[index].id,
                                product: products[index] as DocumentSnapshot<Map<String, dynamic>>?,
                                collectionName: document[index],
                                FirstcollectionName: 'Category',
                              ),
                            ),
                          ),
                          child: GridTile(
                            child: CardCategorie(products: products, index: index,),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}