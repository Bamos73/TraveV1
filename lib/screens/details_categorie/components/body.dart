import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopapp/screens/details_categorie/components/header_categorie.dart';
import 'package:shopapp/screens/details_categorie/components/product_categorie_card.dart';

class Body extends StatefulWidget {
  const Body({
    Key? key,
    required this.documentName,
    required this.Titre,
  }) : super(key: key);

  final String documentName;
  final String Titre;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late Stream<QuerySnapshot<Map<String, dynamic>>> _productsStream;
  late String _orderByField;
  late bool _croissant;

  // INITIALISATION DU FILTRE
  @override
  void initState() {
    super.initState();
    _orderByField = 'date';
    _croissant=true;
    _productsStream = FirebaseFirestore.instance
        .collection('Category')
        .doc(widget.documentName)
        .collection(widget.documentName)
        .orderBy(_orderByField, descending: _croissant)
        .snapshots();
  }
// POUR LE FILTRE
  Future<void> _onOrderByChanged(String value) async {
    if (value == 'PRIX BAS') {
      setState(() {
        _orderByField = 'price';
        _croissant=false;
      });
    } else if (value == 'PRIX HAUT') {
      setState(() {
        _orderByField = 'price';
        _croissant=true;

      });
    } else if (value == 'NOUVEAUTÉS') {
      setState(() {
        _orderByField = 'date';
        _croissant=true;
      });
    }
    _productsStream = FirebaseFirestore.instance
        .collection('Category')
        .doc(widget.documentName)
        .collection(widget.documentName)
        .orderBy(_orderByField, descending: _croissant)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          HeaderCategorie(titre_document: widget.Titre, onOrderByChanged: _onOrderByChanged),
          ProductsCategorieCard(productsStream: _productsStream, collectionName: widget.documentName),
        ],
      ),
    );
  }
}
