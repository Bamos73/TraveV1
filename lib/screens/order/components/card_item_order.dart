import 'package:flutter/material.dart';
import 'package:shopapp/screens/order/components/status_text.dart';
import 'package:shopapp/size_config.dart';

import '../../order_details/order_detail_screen.dart';


class card_item_order extends StatelessWidget {
  const card_item_order({
    super.key,
    required this.CodeCommande,
    required this.Quantite,
    required this.Montant,
    required this.statut,
    required this.formattedDate,
    required this.formattedTime,
  });

  final  CodeCommande;
  final  Quantite;
  final  Montant;
  final  statut;
  final String formattedDate;
  final String formattedTime;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, OrderDetailScreen.routeName,
            arguments: {
              'code_commande': CodeCommande,
            });
      },
      child: Container(
        color: Colors.transparent,
        child: Column(
          children: [
            SizedBox(height: 10,),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(17)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Text("COMMANDE N° $CodeCommande",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: getProportionateScreenWidth(13),
                            color: Colors.black
                        ),
                      ),
                      Text(Quantite==1
                          ?"$Quantite ARTICLE"
                          :"$Quantite ARTICLES",
                        style: TextStyle(
                            fontSize: getProportionateScreenWidth(12),
                            color: Colors.black
                        ),
                      ),
                      Text("$Montant FCFA",
                        style: TextStyle(
                            fontSize: getProportionateScreenWidth(12),
                            color: Colors.black
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          StatusText(statut: "$statut"),
                          Text("$formattedDate",
                            style: TextStyle(
                                fontSize: getProportionateScreenWidth(12),
                                color: Colors.black
                            ),
                          ),
                          Text("$formattedTime",
                            style: TextStyle(
                                fontSize: getProportionateScreenWidth(12),
                                color: Colors.black
                            ),
                          ),
                        ],
                      ),
                      Icon(Icons.chevron_right),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 10,),
            Divider(height: 1,thickness: 1,)
          ],
        ),
      ),
    );
  }
}