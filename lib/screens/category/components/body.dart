import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopapp/components/shimmer_box.dart';
import 'package:shopapp/constants.dart';
import 'package:shopapp/screens/Category/components/category_shimmer.dart';
import 'package:shopapp/screens/category_details/details_categorie_screen.dart';
import 'package:shopapp/screens/home/components/home_header.dart';
import 'package:shopapp/size_config.dart';
import 'package:http/http.dart' as http;

class Body extends StatefulWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool isLoading = true;
  late QueryDocumentSnapshot<Map<String, dynamic>> coverDoc;
  late List<QueryDocumentSnapshot<Map<String, dynamic>>> categoryDocs;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return category_shimmer();
    } else {
      return SafeArea(
        child: Stack(
          children: [
           SingleChildScrollView(
            child: Container(
              width: double.infinity,
              child: Column(
                children: [
                  SizedBox(height: getProportionateScreenHeight(70)),
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
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: categoryDocs.length,
                    itemBuilder: (context, index) {
                      String title =
                          categoryDocs[index].data()['titre_categorie'] ?? "Nouveauté";
                      String image =
                          categoryDocs[index].data()['image'] ?? "https://firebasestorage.googleapis.com/v0/b/singup-a9273.appspot.com/o/Cat%C3%A9gorie%2FAbaya%2FAY0001%2Fjilbab.jpg?alt=media&token=0537c680-7fed-443b-963a-61e43f7eec2d";
                      String collectionName =
                          categoryDocs[index].data()['nom_first_collection'] ?? "Category"; // Récupérer le nom de la collection
                      return Column(
                        children: [
                          SizedBox(height: getProportionateScreenHeight(5),),
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
                            trailing: Icon(
                              Icons.chevron_right,
                              color: kSecondaryColor,
                            ),
                            onTap: () {
                              Navigator.pushNamed(context, DetailCtgScreen.routeName,
                                  arguments: {
                                    'nom_document': categoryDocs[index].id,
                                    'titre_categorie': categoryDocs[index]['titre_categorie'],
                                    'first_collection': collectionName,
                                  });
                            },
                          ),
                          SizedBox(height: getProportionateScreenHeight(5),),
                          Divider(thickness: 1, height: 1),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
            HomeHeader(),
          ],
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

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
      QuerySnapshot<Map<String, dynamic>> CategoryCover =
      await FirebaseFirestore.instance.collection('Category_cover').get();

      QuerySnapshot<Map<String, dynamic>> querySnapshot =
      await FirebaseFirestore.instance.collection('Category').get();

      await Future.delayed(Duration(seconds: 2));

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
