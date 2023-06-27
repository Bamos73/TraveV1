import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopapp/screens/category_details/components/header_categorie.dart';
import 'package:shopapp/screens/category_details/components/product_categorie_card.dart';

class Body extends StatefulWidget {
  const Body({
    Key? key,
    required this.documentName,
    required this.Titre,
    required this.FirstCollection,
  }) : super(key: key);

  final String documentName;
  final String Titre;
  final String FirstCollection;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late Stream<QuerySnapshot<Map<String, dynamic>>> _productsStream;
  late String _orderByField;
  late bool _croissant;
  late List<String> _colors = ['Noir', 'Blanc', 'Gris', 'Bleu', 'Rouge', 'Vert', 'Orange', 'Rose', 'Autres'];
  late List<String> _tailles = ['XXXL', 'XXL', 'XL', 'L', 'M', 'S'];
  late double _startPrice = 0.0;
  late double _endPrice = 100000.0;
  late List<bool> _isSelectedColor = List.generate(9, (index) => false);
  late List<bool> _isSelectedTaille = List.generate(6, (index) => false);

  // INITIALISATION DU FILTRE
  @override
  void initState() {
    super.initState();
    _orderByField = 'date';
    _croissant = true;
    _productsStream = FirebaseFirestore.instance
        .collection(widget.FirstCollection)
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
        _croissant = false;
      });
    } else if (value == 'PRIX HAUT') {
      setState(() {
        _orderByField = 'price';
        _croissant = true;
      });
    } else if (value == 'NOUVEAUTÉS') {
      setState(() {
        _orderByField = 'date';
        _croissant = true;
      });
    }

    _productsStream = FirebaseFirestore.instance
        .collection(widget.FirstCollection)
        .doc(widget.documentName)
        .collection(widget.documentName)
        .orderBy(_orderByField, descending: _croissant)
        .snapshots();
    print(widget.FirstCollection);
    print(widget.documentName);
  }

  void _onOrderByChangedFitre() {
    // Récupérer les filtres de couleur et de taille sélectionnés
    List<String> selectedColors = [];
    for (int i = 0; i < _isSelectedColor.length; i++) {
      if (_isSelectedColor[i]) {
        selectedColors.add(_colors[i]);
      }
    }

    List<String> selectedTailles = [];
    for (int i = 0; i < _isSelectedTaille.length; i++) {
      if (_isSelectedTaille[i]) {
        selectedTailles.add(_tailles[i]);
      }
    }
    _productsStream = FirebaseFirestore.instance
        .collection(widget.FirstCollection)
        .doc(widget.documentName)
        .collection(widget.documentName)
        .where('price', isGreaterThanOrEqualTo: _startPrice)
        .where('price', isLessThanOrEqualTo: _endPrice)
        .where('color', whereIn: _colors.asMap().entries.where((entry) => _isSelectedColor[entry.key]).map((entry) => entry.value).toList())
        .where('tailles', whereIn: _tailles.asMap().entries.where((entry) => _isSelectedColor[entry.key]).map((entry) => entry.value).toList())
        .orderBy(_orderByField, descending: _croissant)
        .snapshots();

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          HeaderCategorie(
            titre_document: widget.Titre,
            onOrderByChanged: _onOrderByChanged,
            colors: _colors,
            tailles: _tailles,
            SelectedColor: _isSelectedColor,
            SelectedTaille: _isSelectedTaille,
            startPrice: _startPrice,
            endPrice: _endPrice,
            onOrderByChangedFiltre: _onOrderByChangedFitre,
          ),
          ProductsCategorieCard(
            productsStream: _productsStream,
            collectionName: widget.documentName,
            firstcollectionName: widget.FirstCollection,
          ),
        ],
      ),
    );
  }

}
