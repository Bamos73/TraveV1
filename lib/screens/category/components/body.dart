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
    required this.coverDoc,
    required this.categoryDocs,
  });

  final QueryDocumentSnapshot<Map<String, dynamic>> coverDoc;
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> categoryDocs;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {

  //VERIFIER SI L'URL DE L'IMAGE DES CATEGORIE EST BONNE
  Future<bool> checkImage(String url) async {
    try {
      final response = await http.head(Uri.parse(url));
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

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
                future: checkImage(widget.coverDoc.data()['image']),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return shimmer_cover();
                  } else if (snapshot.hasError || !snapshot.data!) {
                    return shimmer_cover();
                  } else {
                    return Image.network(
                      widget.coverDoc.data()['image'] ?? "",
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                      height: getProportionateScreenHeight(200),
                    );
                  }
                },
              ),
              SizedBox(height: getProportionateScreenHeight(10)),
              ListView(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                children: widget.categoryDocs.map((Document) {
                  String title = Document.data()['titre_categorie'] ?? "NOUVEAUTES";
                  String image = Document.data()['image'] ?? "https://via.placeholder.com/150";
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
                        trailing: Icon(Icons.chevron_right, color: kSecondaryColor, weight: 100, grade: 0,),
                        onTap: () {
                          Navigator.pushNamed(context, DetailCtgScreen.routeName,
                              arguments: {
                                'nom_document': Document.id,
                                'titre_categorie': Document['titre_categorie'],
                              });
                        },
                      ),
                      Divider(thickness: 1, height: 1),
                    ],
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}