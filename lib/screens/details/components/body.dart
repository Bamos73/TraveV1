import 'package:capped_progress_indicator/capped_progress_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopapp/components/default_button.dart';
import 'package:shopapp/screens/details/components/custom_app_bar.dart';
import 'package:shopapp/screens/details/components/color_dots.dart';
import 'package:shopapp/screens/details/components/product_description.dart';
import 'package:shopapp/screens/details/components/product_images.dart';
import 'package:shopapp/screens/details/components/top_rounded_container.dart';
import 'package:shopapp/size_config.dart';


class Body extends StatefulWidget {
  final DocumentSnapshot<Map<String, dynamic>>? product; // les informations du produit

  const Body({
    super.key,
    required Future<DocumentSnapshot<Map<String, dynamic>>> productDocFuture, this.product,
  }) : _productDocFuture = productDocFuture;

  final Future<DocumentSnapshot<Map<String, dynamic>>> _productDocFuture;


  @override
  State<Body> createState() => _BodyState();
}
class _BodyState extends State<Body> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: widget._productDocFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularCappedProgressIndicator(strokeWidth: 10, strokeCap: StrokeCap.round),
            );
          } else if (snapshot.hasError || snapshot.data == null) {
            return Center(
                child: CircularCappedProgressIndicator(strokeWidth: 10, strokeCap: StrokeCap.round),
            );
          } else {
            final product = snapshot.data!;
            return  Stack(
              children: [
               SingleChildScrollView(
                child: Column(
                  children: [
                    ProductImage(product: product),
                    TopRoundedContainer(color: Colors.white,
                      child: Column(
                        children: [
                          ProductDescription(product: product, pressOnSeeMore: () {},),
                          TopRoundedContainer(
                            color: Color(0xFFF6F7F9),
                            child: Column(
                              children: [
                                ColorDots(product: product),
                                SizedBox(height:getProportionateScreenHeight(10)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
                CustomAppBar( product: product,)
          ]
            );
          }
        },
      ),
    );
  }
}




