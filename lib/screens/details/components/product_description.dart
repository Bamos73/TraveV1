import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopapp/constants.dart';
import 'package:shopapp/size_config.dart';


class ProductDescription extends StatelessWidget {
  const ProductDescription({
    super.key,
    required this.product, required this.pressOnSeeMore,
  });

  final DocumentSnapshot<Map<String, dynamic>> product;
  final GestureTapCallback pressOnSeeMore;

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20),
          ),
          child: Text(
            product['title'],
            style: Theme.of(context).textTheme.titleLarge,
            maxLines: 1,
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(20)),
          child: Text(
            "${product['price'].toInt()} FCFA",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: getProportionateScreenWidth(17),
            ),
            maxLines: 1,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: getProportionateScreenWidth(320),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: getProportionateScreenWidth(20),
                        right: getProportionateScreenWidth(15)
                    ),
                    child: Text(
                      product['description'],
                      maxLines: 3,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal:getProportionateScreenWidth(20),
                      vertical: 10,
                    ),
                    child: GestureDetector(
                      onTap:pressOnSeeMore,
                      child: Row(
                        children: const [
                          Text("voir plus de detail", style: TextStyle(
                              color:kPrimaryColor,
                              fontWeight: FontWeight.w600
                          ),
                          ),
                          SizedBox(width:5),
                          Icon(Icons.arrow_forward_ios,size: 12,color: kPrimaryColor,)
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding:EdgeInsets.all(getProportionateScreenWidth(10),),
              width: getProportionateScreenWidth(55),
              decoration: BoxDecoration(
                  color: product['isFavourite']
                      ? Color(0xFFFFE6E6)
                      : Color(0xFFF5F6F9),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
              ),
              child: GestureDetector(
                onTap: () {
                  addToFavourite(product);
                },
                child: Icon(Icons.favorite,
                  size: 25,
                  color: product['isFavourite']
                      ? Color(0xFFFF4848)
                      : Color(0xFFDBDEE4),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void addToFavourite(DocumentSnapshot<Map<String, dynamic>>? product) async {
    if (product == null) {
      return;
    }
    User? user = FirebaseAuth.instance.currentUser;
    final userId = user?.uid;

    final userRef = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('favourite')
        .doc(product['code'].toString());

    final userCardDoc = await userRef.get();
    if (userCardDoc.exists) {
      final userCardData = userCardDoc.data();
    }else{
      await userRef.set({
        'first_Collection': product['first_collection'],
        'first_Document': product['first_document'],
        'code_Document': product['code'],
      });
    }
  }

}