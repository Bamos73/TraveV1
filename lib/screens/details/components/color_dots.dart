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


class _ColorDotsState extends State<ColorDots> {

  User? user = FirebaseAuth.instance.currentUser;
  int selectedColor=0;

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



