import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopapp/components/shimmer_box.dart';
import 'package:shopapp/screens/home/components/products_list.dart';
import 'package:shopapp/size_config.dart';

class CardCategorie extends StatelessWidget {
  const CardCategorie({
    Key? key,
    required this.products,
    required this.index,
  }) : super(key: key);

  final List<DocumentSnapshot<Object?>> products;
  final int index;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getProportionateScreenWidth(120),
      height: getProportionateScreenHeight(240),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: Color.fromRGBO(255, 0, 0, 0.0),
              ),
              child: FutureBuilder(
                future: checkImage(products[index]['images'][0]),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return shimmer_box();
                  } else if (snapshot.hasError || !snapshot.data!) {
                    return shimmer_box();
                  } else {
                    return Stack(
                      children: [
                        Container(
                          width: double.maxFinite,
                          child: Image.network(
                            products[index]['images'][0],
                            fit: BoxFit.cover,
                          ),
                        ),
                        if (products[index]['quantité'] == 0)
                          Positioned.fill(
                            child: Container(
                              color: Colors.black54.withOpacity(0.3),
                              child: Center(
                                child: Text(
                                  "ÉPUISÉ",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    );
                  }
                },
              ),
            ),
          ),
          const SizedBox(height: 5),
          Wrap(
            alignment: WrapAlignment.start,
            children: [
              Text(
                products[index]['title'] != null && products[index]['title'].isNotEmpty
                    ? "${products[index]['title']}"
                    : "titre non defini",
                style: TextStyle(color: Colors.black),
                maxLines: 1,
                textAlign: TextAlign.start,
              ),
            ],
          ),
          Row(
            children: [
              Text(
                products[index]['price'] != null
                    ? "${products[index]['price'].toInt()} FCFA"
                    : "prix non defini",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: getProportionateScreenWidth(15),
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
