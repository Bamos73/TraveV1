import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopapp/components/rounded_icon_btn.dart';
import 'package:shopapp/constants.dart';
import 'package:shopapp/size_config.dart';

class ColorDots extends StatefulWidget {
  const ColorDots({
    Key? key,
    required this.product,
  });

  final DocumentSnapshot<Map<String, dynamic>> product;

  @override
  State<ColorDots> createState() => _ColorDotsState();
}
class MyAppState {
  static int nmbreArticleState = 1;
}


class _ColorDotsState extends State<ColorDots> {
  // Récupère l'utilisateur actif
  User? user = FirebaseAuth.instance.currentUser;
  int selectedColor=0;
  int NmbreArticle = 1; // ajout d'un état pour le nombre d'articles

  void addItemCount(DocumentSnapshot<Map<String, dynamic>> product) async{
    if(NmbreArticle< product['quantité']){
      setState(() {
        NmbreArticle++;
      });
      return addItemInCard(product);
    }
  }


  void removeItemCount(DocumentSnapshot<Map<String, dynamic>> product) async{
    if (NmbreArticle > 1) {
      setState(() {
        NmbreArticle--;
      });
      return addItemInCard(product);
    }
  }


  void addItemInCard(DocumentSnapshot<Map<String, dynamic>> product) {
  if (product == null) {
  print("erreur");
  } else {
    setState(() {
  MyAppState.nmbreArticleState = NmbreArticle;
    });
  // Naviguez vers l'écran suivant ou appelez une autre méthode
  }
  }


  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20),),
      child: Row(
        children: [
          ...List.generate(
              widget.product['autre_couleur'].length,
                  (index) => buildColorDot(widget.product,index)
          ),
          Spacer(),
          RoundedIconBtn(iconData: Icons.remove, press: () => removeItemCount(widget.product)),
          SizedBox(width: getProportionateScreenWidth(10),),
          Text(NmbreArticle.toString().padLeft(2, '0'), // afficher le nombre d'articles
            style: TextStyle(
              fontSize: getProportionateScreenWidth(19),
              fontWeight: FontWeight.w500,
              color: kPrimaryColor,
            ),
          ),
          SizedBox(width: getProportionateScreenWidth(10),),
          RoundedIconBtn(iconData: Icons.add, press: () => addItemCount(widget.product)), // ajouter l'appel de la fonction addItemCount()
        ],
      ),
    );
  }

  GestureDetector buildColorDot(DocumentSnapshot<Map<String, dynamic>> product, int index) {
    return GestureDetector(
      onTap: (){
        setState(() {
          selectedColor=index;
        });
      },
      child: Container(
        padding:EdgeInsets.all(8) ,
        height: getProportionateScreenWidth(40),
        width: getProportionateScreenWidth(40),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
              color: selectedColor == index
                  ? kPrimaryColor
                  : Colors.transparent
          ),
        ),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Color(product['autre_couleur'][index],),
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}



