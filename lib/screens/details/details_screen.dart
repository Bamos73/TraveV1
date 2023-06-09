import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopapp/screens/details/components/custom_nav_bar.dart';
import 'package:shopapp/screens/details/components/body.dart';

class DetailsScreen extends StatefulWidget {
  static const routeName = '/details';

  const DetailsScreen({
    Key? key,
    required this.productId,
    this.product, required this.collectionName,
  }) : super(key: key);

  final String productId; // l'identifiant unique du produit
  final DocumentSnapshot<Map<String, dynamic>>? product; // les informations du produit
  final String collectionName;

  factory DetailsScreen.fromProductId(String productId) {
    return DetailsScreen(
      productId: productId,
      product: null as DocumentSnapshot<Map<String, dynamic>>,
      collectionName: '', // Remarque : il faut initialiser le document snapshot à une valeur null car on ne peut pas le récupérer avec seulement l'ID.
    );
  }

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}
class _DetailsScreenState extends State<DetailsScreen> {
  late Future<DocumentSnapshot<Map<String, dynamic>>> _productDocFuture;

  @override
  void initState() {
    super.initState();
    _productDocFuture = _getProductData(widget.productId);
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> _getProductData(String productId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> product =
      await FirebaseFirestore.instance
          .collection(widget.collectionName)
          .doc(productId)
          .get();
      return product;
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F6F9),
      body: Body(productDocFuture: _productDocFuture,),
      bottomNavigationBar: CustomNavBar(product: widget.product,),
    );
  }
}
