import 'package:flutter/material.dart';
import 'package:shopapp/screens/order/components/status_text.dart';
import 'package:shopapp/size_config.dart';

import '../../order_details/order_detail_screen.dart';


class card_item_order extends StatefulWidget {
  const card_item_order({
    super.key,
    required this.CodeCommande,
    required this.Quantite,
    required this.Montant,
    required this.statut,
    required this.formattedDate,
    required this.formattedTime,
    required this.nom_de_livraison,
    required this.adresse,
    required this.mode_livraison,
    required this.mode_paiement,
    required this.fraie_livraison,
    required this.code_promo,
    required this.numero,
  });

  final  CodeCommande;
  final  Quantite;
  final  Montant;
  final  statut;
  final  nom_de_livraison;
  final  adresse;
  final  mode_livraison;
  final  mode_paiement;
  final  fraie_livraison;
  final  code_promo;
  final  numero;
  final String formattedDate;
  final String formattedTime;

  @override
  State<card_item_order> createState() => _card_item_orderState();
}

class _card_item_orderState extends State<card_item_order> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, OrderDetailScreen.routeName,
            arguments: {
              'code_commande': widget.CodeCommande,
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
                      Text("COMMANDE N° ${widget.CodeCommande}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: getProportionateScreenWidth(13),
                            color: Colors.black
                        ),
                      ),
                      Text(widget.Quantite==1
                          ?"${widget.Quantite} ARTICLE"
                          :"${widget.Quantite} ARTICLES",
                        style: TextStyle(
                            fontSize: getProportionateScreenWidth(12),
                            color: Colors.black
                        ),
                      ),
                      Text("${widget.Montant} FCFA",
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
                          StatusText(statut: "${widget.statut}"),
                          Text("${widget.formattedDate}",
                            style: TextStyle(
                                fontSize: getProportionateScreenWidth(12),
                                color: Colors.black
                            ),
                          ),
                          Text("${widget.formattedTime}",
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