import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:shopapp/screens/ORDER/components/custom_app_bar.dart';
import 'package:shopapp/screens/order_details/components/card_panier_order.dart';
import 'package:shopapp/size_config.dart';

class Body extends StatefulWidget {
  const Body({
    Key? key,
    required this.CodeCommande,
    required this.Quantite,
    required this.Montant,
    required this.statut,
    required this.nom_de_livraison,
    required this.adresse,
    required this.mode_livraison,
    required this.mode_paiement,
    required this.fraie_livraison,
    required this.code_promo,
    required this.numero,
    required this.date,
  }) : super(key: key);

  final String CodeCommande;
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
  final  date;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool _showContainer = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: getProportionateScreenHeight(60)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(17)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "COMMANDE\n${widget.CodeCommande}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: getProportionateScreenWidth(14),
                        color: Colors.black,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _showContainer = !_showContainer;
                        });
                      },
                      child: Text(
                        "CODE-BARRES",
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(10),),
              Center(
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  height: _showContainer ? getProportionateScreenHeight(50) : 10,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: BarcodeWidget(
                      barcode: Barcode.code128(),
                      data: '${widget.CodeCommande}',
                      drawText: false,
                      width: getProportionateScreenWidth(250),
                      height: getProportionateScreenHeight(50),
                    ),
                  ),
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(10),),
              Divider(height: 1,thickness: 1,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(17)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: getProportionateScreenHeight(10),),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: getProportionateScreenWidth(160),
                          height: getProportionateScreenHeight(40),
                          child: Text(
                            "STATUS",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: getProportionateScreenWidth(12),
                              color: Colors.black,
                            ),
                          ),
                        ),
                         Text(
                            "${widget.statut}",
                            style: TextStyle(
                              fontSize: getProportionateScreenWidth(12),
                              color: Colors.black
                            ),
                          ),
                      ],
                    ),
                    SizedBox(height: getProportionateScreenHeight(10),),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: getProportionateScreenWidth(160),
                          height: getProportionateScreenHeight(40),
                          child: Text(
                            "DATE",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: getProportionateScreenWidth(12),
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Text(
                          "${widget.date}",
                          style: TextStyle(
                              fontSize: getProportionateScreenWidth(12),
                              color: Colors.black
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: getProportionateScreenHeight(10),),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: getProportionateScreenWidth(160),
                          height: getProportionateScreenHeight(40),
                          child: Text(
                            "ADRESSE",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: getProportionateScreenWidth(12),
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${widget.nom_de_livraison}",
                              style: TextStyle(
                                  fontSize: getProportionateScreenWidth(12),
                                  color: Colors.black
                              ),
                            ),
                            Text(
                              "${widget.adresse}",
                              style: TextStyle(
                                  fontSize: getProportionateScreenWidth(12),
                                  color: Colors.black
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: getProportionateScreenHeight(10),),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: getProportionateScreenWidth(160),
                          height: getProportionateScreenHeight(40),
                          child: Text(
                            "MODE DE LIVRAISON",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: getProportionateScreenWidth(12),
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Text(
                          "${widget.mode_livraison}",
                          style: TextStyle(
                              fontSize: getProportionateScreenWidth(12),
                              color: Colors.black
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: getProportionateScreenHeight(10),),
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.start,
                      children: [
                        Container(
                          width: getProportionateScreenWidth(160),
                          height: getProportionateScreenHeight(40),
                          child: Text(
                            "MODE DE PAIEMENT",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: getProportionateScreenWidth(12),
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Text(
                          "${widget.mode_paiement}",
                          style: TextStyle(
                              fontSize: getProportionateScreenWidth(12),
                              color: Colors.black
                          ),
                          maxLines: 2,
                        ),
                      ],
                    ),
                ],),
              ),
              PanierOrder(CodeCommande: widget.CodeCommande,),

            ],
          ),

          CustomAppBar(),
        ],
      ),
    );
  }
}
