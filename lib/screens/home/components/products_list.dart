import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shopapp/screens/home/components/card_categorie.dart';
import 'package:shopapp/components/shimmer_box.dart';
import 'package:shopapp/screens/details/details_screen.dart';
import 'package:shopapp/size_config.dart';


class ProductsList extends StatefulWidget {
  final Stream<QuerySnapshot<Map<String, dynamic>>> productsStream;
  final String collectionName;

  const ProductsList({Key? key,
    required this.productsStream,
    required this.collectionName}) : super(key: key);

  @override
  State<ProductsList> createState() => _ProductsListState();
}
//VERIFIER SI L'URL DE L'IMAGE DES CATEGORIE EST BONNE
Future<bool> checkImage(String url) async {
  try {
    final response = await http.head(Uri.parse(url));
    return response.statusCode == 200;
  } catch (e) {
    return false;
  }
}

class _ProductsListState extends State<ProductsList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: widget.productsStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError || snapshot.data == null || snapshot.data!.docs.isEmpty) {
          return shimmer_box_line();
        }
        else if (snapshot.connectionState == ConnectionState.waiting) {
          return shimmer_box_line();
        }
        else {
          List<DocumentSnapshot> products = snapshot.data!.docs;
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                products.length,
                    (index) => Padding(
                  padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => DetailsScreen(
                          productId: products[index].id,
                          product: products[index] as DocumentSnapshot<Map<String, dynamic>>?,
                          collectionName: widget.collectionName,
                          FirstcollectionName: 'Home_Collection',
                        ),
                      ),
                    ),
                    child: CardCategorie(products: products, index: index,),
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
