import 'package:flutter/material.dart';
import 'package:shopapp/screens/category_details/components/body.dart';

class DetailCtgScreen extends StatefulWidget {
  const DetailCtgScreen({Key? key}) : super(key: key);
  static String routeName = "/details_categorie";

  @override
  State<DetailCtgScreen> createState() => _DetailCtgScreenState();
}

class _DetailCtgScreenState extends State<DetailCtgScreen> {

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final nomDocument = args['nom_document'] as String;
    final titreCategorie = args['titre_categorie'] as String;
    final firstCollection = args['first_collection'] as String;

    return Scaffold(
      backgroundColor: Color(0xFFF5F6F9),
      body: Body(documentName: nomDocument, Titre: titreCategorie, FirstCollection: firstCollection,),
    );
  }

}
