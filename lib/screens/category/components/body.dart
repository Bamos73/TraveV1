import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopapp/components/shimmer_box.dart';
import 'package:shopapp/constants.dart';
import 'package:shopapp/screens/details_categorie/details_categorie_screen.dart';
import 'package:shopapp/screens/home/components/home_header.dart';
import 'package:shopapp/size_config.dart';
import 'package:http/http.dart' as http;


class Body extends StatefulWidget {
  const Body({
    super.key,
  });

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool isLoading = true;
  late QueryDocumentSnapshot<Map<String, dynamic>> coverDoc;
  late List<QueryDocumentSnapshot<Map<String, dynamic>>> categoryDocs;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Column(
            children: [
              SizedBox(height: getProportionateScreenWidth(10)),
              HomeHeader(),
              SizedBox(height: getProportionateScreenWidth(10)),
              // Afficher l'image de la collection "Category_cover" dans Image.network
              FutureBuilder(
                future: checkImage(coverDoc.data()['image']),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return shimmer_cover();
                  } else if (snapshot.hasError || !snapshot.data!) {
                    return shimmer_cover();
                  } else {
                    return Image.network(
                      coverDoc.data()['image'] ?? "",
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                      height: getProportionateScreenHeight(200),
                    );
                  }
                },
              ),
              SizedBox(height: getProportionateScreenHeight(10)),
              ListView.builder(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemCount: categoryDocs.length,
                itemBuilder: (context, index) {
                  QueryDocumentSnapshot<Map<String, dynamic>> document = categoryDocs[index];
                  String title = document.data()['titre_categorie'] ?? "NOUVEAUTES";
                  String image = document.data()['image'] ?? "https://via.placeholder.com/150";
                  return Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.grey[300],
                          radius: 25,
                          backgroundImage: NetworkImage(image),
                        ),
                        title: Text(
                          title,
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        trailing: Icon(Icons.chevron_right, color: kSecondaryColor),
                        onTap: () {
                          Navigator.pushNamed(context, DetailCtgScreen.routeName,
                              arguments: {
                                'nom_document': document.id,
                                'titre_categorie': document['titre_categorie'],
                              });
                        },
                      ),
                      Divider(thickness: 1, height: 1),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }


  @override
  void initState() {
    super.initState();
    getData();
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
}