import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopapp/screens/home/components/card_categorie.dart';
import 'package:shopapp/components/shimmer_box.dart';
import 'package:shopapp/screens/details/details_screen.dart';
import 'package:shopapp/size_config.dart';


class ProductsCategorieCard extends StatefulWidget {
  const ProductsCategorieCard({
    super.key,
    required Stream<QuerySnapshot<Map<String, dynamic>>> productsStream, required this.collectionName,
  }) : _productsStream = productsStream;

  final Stream<QuerySnapshot<Map<String, dynamic>>> _productsStream;
  final String collectionName;

  @override
  State<ProductsCategorieCard> createState() => _ProductsCategorieCardState();
}

class _ProductsCategorieCardState extends State<ProductsCategorieCard> {
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
                stream: widget._productsStream,
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
                        return GestureDetector(
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => DetailsScreen(
                                productId: products[index].id,
                                product: products[index] as DocumentSnapshot<Map<String, dynamic>>?,
                                collectionName: widget.collectionName,
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