import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopapp/components/shimmer_box.dart';
import 'package:shopapp/screens/details_categorie/details_categorie_screen.dart';
import 'package:shopapp/screens/home/components/categorie_popular.dart';
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

  late Stream<QuerySnapshot<Map<String, dynamic>>> _productsStream1;
  late Stream<QuerySnapshot<Map<String, dynamic>>> _productsStream2;
  late Stream<QuerySnapshot<Map<String, dynamic>>> _productsStream3;
  late Stream<QuerySnapshot<Map<String, dynamic>>> _productsStream4;

  @override
  void initState() {
    super.initState();
    _productsStream1 =
        FirebaseFirestore.instance.collection('Home_Collection').doc(
            "Home_NewCollection_product").collection(
            'Home_NewCollection_product').snapshots();
    _productsStream2 =
        FirebaseFirestore.instance.collection('Home_Collection').doc(
            "Home_WomanCollection_product").collection(
            'Home_WomanCollection_product').snapshots();
    _productsStream3 =
        FirebaseFirestore.instance.collection('Home_Collection').doc(
            "Home_MenCollection_product").collection(
            'Home_MenCollection_product').snapshots();
    _productsStream4 =
        FirebaseFirestore.instance.collection('Home_Collection').doc(
            "Home_AccessoireCollection_product").collection(
            'Home_AccessoireCollection_product').snapshots();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> _getHomeCoverData(
      String docId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> homeCover = await FirebaseFirestore
          .instance
          .collection('Home')
          .doc(docId)
          .get();
      return homeCover;
    } catch (e) {
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
            SpecialOffers(),
            SizedBox(height: getProportionateScreenWidth(30),),
            SectionTitle(text: "Catégorie Populaire", press: () {},),
            SizedBox(height: getProportionateScreenWidth(20),),
            CategoriePopular(),
            SizedBox(height: getProportionateScreenWidth(20),),
            SectionTitle(text: "Nouvelle Collection", press: () {},),
            SizedBox(height: getProportionateScreenWidth(20),),
            ProductsList(productsStream: _productsStream1,
              collectionName: 'Home_NewCollection_product',),
            SizedBox(height: getProportionateScreenWidth(30),),
            HomeCover(homeCoverStream: FirebaseFirestore.instance.collection('Home').doc("HomeCover_1").snapshots()),
            SizedBox(height: getProportionateScreenWidth(30),),
            SectionTitle(text: "Collection Femme", press: () {},),
            SizedBox(height: getProportionateScreenWidth(20),),
            ProductsList(productsStream: _productsStream2,
              collectionName: 'Home_WomanCollection_product',),
            SizedBox(height: getProportionateScreenWidth(30),),
            HomeCover(homeCoverStream: FirebaseFirestore.instance.collection('Home').doc("HomeCover_2").snapshots()),
            SizedBox(height: getProportionateScreenWidth(30),),
            SectionTitle(text: "Collection Homme", press: () {},),
            SizedBox(height: getProportionateScreenWidth(20),),
            ProductsList(productsStream: _productsStream3,
              collectionName: 'Home_MenCollection_product',),
            SizedBox(height: getProportionateScreenWidth(30),),
            HomeCover(homeCoverStream: FirebaseFirestore.instance.collection('Home').doc("HomeCover_3").snapshots()),
            SizedBox(height: getProportionateScreenWidth(30),),
            SectionTitle(text: "Accessoire", press: () {},),
            SizedBox(height: getProportionateScreenWidth(20),),
            ProductsList(productsStream: _productsStream4,
              collectionName: 'Home_AccessoireCollection_product',),
            SizedBox(height: getProportionateScreenWidth(30),),
            HomeCover(homeCoverStream: FirebaseFirestore.instance.collection('Home').doc("HomeCover_4").snapshots()),
            SizedBox(height: getProportionateScreenWidth(30),),
            Text("Nouveautés a la mode",style: TextStyle(
              fontSize: getProportionateScreenWidth(18),
              color: Colors.black,
            ),
            ),
            SizedBox(height: getProportionateScreenWidth(20),),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('Category')
                  .where('isNew', isEqualTo: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError || snapshot.data == null || snapshot.data!.docs.isEmpty) {
                  return ShimmerNouveaute();
                }
                else if (snapshot.connectionState == ConnectionState.waiting) {
                  return ShimmerNouveaute();
                }
                final documents = snapshot.data!.docs;
                return Container(
                  width: double.infinity,
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: getProportionateScreenHeight(7),
                      crossAxisSpacing: getProportionateScreenHeight(7),
                      mainAxisExtent: getProportionateScreenHeight(250),
                    ),
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      final document = documents[index];
                      final imageUrl = document['image'] ?? '';
                      final title = document['titre_categorie'] ?? '';

                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, DetailCtgScreen.routeName,
                              arguments: {
                                'nom_document': document['nom_document'],
                                'titre_categorie': document['titre_categorie'],
                              });
                        },
                        child: FutureBuilder(
                            future: checkImage(imageUrl),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return ShimmerNouveaute();
                              } else if (snapshot.hasError || snapshot.data == null) {
                                return ShimmerNouveaute();
                              }  else {
                                return Stack(
                            children: [
                              Container(
                                width: double.maxFinite,
                                child: Image.network(
                                  imageUrl,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                top: 0,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black54.withOpacity(0.1),
                                  ),
                                  padding: EdgeInsets.symmetric(vertical: 8),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        title.toString().toUpperCase(),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: getProportionateScreenWidth(20),
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(height: 5,),
                                      Container(
                                        color: Colors.black,
                                        width: getProportionateScreenWidth(80),
                                        child: Center(
                                          child: Text("Magasine",
                                            style: TextStyle(
                                              fontSize: getProportionateScreenWidth(13),
                                              color: Colors.white,
                                            ),),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                      }
                      }
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}








