import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopapp/screens/home/components/categories.dart';
import 'package:shopapp/screens/home/components/discount_banner.dart';
import 'package:shopapp/screens/home/components/home_cover.dart';
import 'package:shopapp/screens/home/components/home_header.dart';
import 'package:shopapp/screens/home/components/products_list.dart';
import 'package:shopapp/screens/home/components/section_title.dart';
import 'package:shopapp/screens/home/components/special_offers.dart';
import 'package:shopapp/size_config.dart';

class Body extends StatefulWidget {
  const Body({
    Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late Future<DocumentSnapshot<Map<String, dynamic>>> _HomecoverDocFuture1;
  late Future<DocumentSnapshot<Map<String, dynamic>>> _HomecoverDocFuture2;
  late Future<DocumentSnapshot<Map<String, dynamic>>> _HomecoverDocFuture3;
  late Future<DocumentSnapshot<Map<String, dynamic>>> _HomecoverDocFuture4;
  late Stream<QuerySnapshot<Map<String, dynamic>>> _productsStream1;
  late Stream<QuerySnapshot<Map<String, dynamic>>> _productsStream2;
  late Stream<QuerySnapshot<Map<String, dynamic>>> _productsStream3;
  late Stream<QuerySnapshot<Map<String, dynamic>>> _productsStream4;

  @override
  void initState() {
    super.initState();
    _HomecoverDocFuture1 = _getHomeCoverData('HomeCover_1');
    _HomecoverDocFuture2 = _getHomeCoverData('HomeCover_2');
    _HomecoverDocFuture3 = _getHomeCoverData('HomeCover_3');
    _HomecoverDocFuture4 = _getHomeCoverData('HomeCover_4');
    _productsStream1 = FirebaseFirestore.instance.collection('Home_Collection').doc("Home_NewCollection_product").collection('Home_NewCollection_product').snapshots();
    _productsStream2 = FirebaseFirestore.instance.collection('Home_Collection').doc("Home_WomanCollection_product").collection('Home_WomanCollection_product').snapshots();
    _productsStream3 = FirebaseFirestore.instance.collection('Home_Collection').doc("Home_MenCollection_product").collection('Home_MenCollection_product').snapshots();
    _productsStream4 = FirebaseFirestore.instance.collection('Home_Collection').doc("Home_AccessoireCollection_product").collection('Home_AccessoireCollection_product').snapshots();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> _getHomeCoverData(String docId) async {
    try{
      DocumentSnapshot<Map<String, dynamic>> homeCover = await FirebaseFirestore.instance
          .collection('Home')
          .doc(docId)
          .get();
      return homeCover;
    }catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: getProportionateScreenWidth(20),),
            HomeHeader(),
            SizedBox(height: getProportionateScreenWidth(30),),
            DiscountBanner(),
            SizedBox(height: getProportionateScreenWidth(30),),
            Categories(),
            SizedBox(height: getProportionateScreenWidth(30),),
            SpecialOffers(),
            SizedBox(height: getProportionateScreenWidth(30),),
            SectionTitle(text: "Nouvelle Collection", press: (){},),
            SizedBox(height: getProportionateScreenWidth(20),),
            ProductsList(productsStream: _productsStream1, collectionName: 'Home_NewCollection_product',),
            SizedBox(height: getProportionateScreenWidth(30),),
            HomeCover_1(HomecoverDocFuture1: _HomecoverDocFuture1),
            SizedBox(height: getProportionateScreenWidth(30),),
            SectionTitle(text: "Collection Femme", press: (){},),
            SizedBox(height: getProportionateScreenWidth(20),),
            ProductsList(productsStream: _productsStream2, collectionName: 'Home_WomanCollection_product',),
            SizedBox(height: getProportionateScreenWidth(30),),
            HomeCover_1(HomecoverDocFuture1: _HomecoverDocFuture2),
            SizedBox(height: getProportionateScreenWidth(30),),
            SectionTitle(text: "Collection Homme", press: (){},),
            SizedBox(height: getProportionateScreenWidth(20),),
            ProductsList(productsStream: _productsStream3, collectionName: 'Home_MenCollection_product',),
            SizedBox(height: getProportionateScreenWidth(30),),
            HomeCover_1(HomecoverDocFuture1: _HomecoverDocFuture3),
            SizedBox(height: getProportionateScreenWidth(30),),
            SectionTitle(text: "Accessoire", press: (){},),
            SizedBox(height: getProportionateScreenWidth(20),),
            ProductsList(productsStream: _productsStream4, collectionName: 'Home_AccessoireCollection_product',),
            SizedBox(height: getProportionateScreenWidth(30),),
            HomeCover_1(HomecoverDocFuture1: _HomecoverDocFuture4),
            SizedBox(height: getProportionateScreenWidth(30),),
            ],
          ),
        ),
    );
  }
}





