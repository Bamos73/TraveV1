import 'package:flutter/material.dart';
import 'package:shopapp/constants.dart';
import 'package:shopapp/size_config.dart';


class PanierPayment extends StatefulWidget {
  const PanierPayment({
    super.key,
  });

  @override
  State<PanierPayment> createState() => _PanierPaymentState();
}

class _PanierPaymentState extends State<PanierPayment> {

  bool _isListViewVisible=false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.white,
          height: getProportionateScreenHeight(40),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        "PANIER",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: getProportionateScreenHeight(14),
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(width: getProportionateScreenWidth(20)),
                      Text(
                        "2 ARTICLE",
                        style: TextStyle(
                          color: kTextColor,
                          fontSize: getProportionateScreenHeight(14),
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      setState((){
                        _isListViewVisible= !_isListViewVisible;
                      });
                    },
                      child: Icon(_isListViewVisible==false
                          ?Icons.add
                          :Icons.remove,
                          size: getProportionateScreenWidth(15),
                          weight: 100)
                  ),
                ],
              ),
            ),
          ),
        ),
        Visibility(
          visible: _isListViewVisible,
            child: ListView(
              shrinkWrap: true,
              children: [
                Divider(height: 1,thickness: 1,),
                Container(
                  height: getProportionateScreenHeight(95),
                  width: double.infinity,
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
                    child: Row(
                      children: [
                        Container(
                          height: getProportionateScreenHeight(75),
                          width: getProportionateScreenWidth(48.75),
                          child: Image.asset("assets/images/Cover.jpeg",fit: BoxFit.cover,)
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
                          child: Container(
                            width: getProportionateScreenWidth(265),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                              Text("Voile",style: TextStyle(
                                  color: Colors.black,
                                  fontSize:getProportionateScreenWidth(13),
                                  fontWeight: FontWeight.bold
                              ),),
                              Text("COULEUR: BLANC",style: TextStyle(
                                  color: kTextColor,
                                  fontSize:getProportionateScreenWidth(12),
                                  fontWeight: FontWeight.w500
                              ),),
                              Text("TAILLE: 2m",style: TextStyle(
                                  color: kTextColor,
                                  fontSize:getProportionateScreenWidth(12),
                                  fontWeight: FontWeight.w500
                              ),),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("QTE 1",style: TextStyle(
                                        color: Colors.black,
                                        fontSize:getProportionateScreenWidth(13),
                                        fontWeight: FontWeight.bold
                                    ),
                                    ),
                                    Text("14500 FCFA",style: TextStyle(
                                        color: Colors.black,
                                        fontSize:getProportionateScreenWidth(13),
                                        fontWeight: FontWeight.bold
                                    )),
                                  ],
                                ),
                             ],
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
                Divider(height: 1,thickness: 1,),

              ],
            ),
        ),
      ],
    );
  }
}
