import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopapp/screens/Category/components/body.dart';
import 'package:shopapp/screens/Category/components/category_shimmer.dart';

class CategoryScreen extends StatefulWidget {
  static const String routeName = "/category";
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  bool isLoading = true;
  late QueryDocumentSnapshot<Map<String, dynamic>> coverDoc;
  late List<QueryDocumentSnapshot<Map<String, dynamic>>> categoryDocs;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    try {
      // Récupérer le document de la collection "Category_cover" qui contient l'image pour Image.network
      QuerySnapshot<Map<String, dynamic>> CategoryCover = await FirebaseFirestore.instance.collection('Category_cover').get();

      // Récupérer les documents de la collection "Category" pour la ListView
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
      await FirebaseFirestore.instance.collection('Category').get();

      // Attendre un court instant pour simuler un chargement
      await Future.delayed(Duration(seconds: 2));

      // Mettre à jour l'état pour arrêter l'affichage du Shimmer effect
      setState(() {
        isLoading = false;
        categoryDocs = querySnapshot.docs;
        coverDoc = CategoryCover.docs.first;
      });
    } catch (e) {
      print(e.toString());
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F6F9),
      body: isLoading
          ? category_shimmer()
          : Body(),
    );
  }


}



