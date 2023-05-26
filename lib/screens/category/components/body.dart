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
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            child: Column(
              children: [
                SizedBox(height: getProportionateScreenWidth(10)),
                HomeHeader(),
                SizedBox(height: getProportionateScreenWidth(10)),
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
                        categoryDocs[index].data()['titre_categorie'] ?? "NOUVEAUTES";
                    String image =
                        categoryDocs[index].data()['image'] ?? "https://via.placeholder.com/150";
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
                          trailing: Icon(
                            Icons.chevron_right,
                            color: kSecondaryColor,
                          ),
                          onTap: () {
                            Navigator.pushNamed(context, DetailCtgScreen.routeName,
                                arguments: {
                                  'nom_document': categoryDocs[index].id,
                                  'titre_categorie': categoryDocs[index]['titre_categorie'],
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
