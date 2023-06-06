import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:shopapp/screens/ORDER/components/custom_app_bar.dart';
import 'package:shopapp/size_config.dart';

class Body extends StatefulWidget {
  const Body({
    Key? key,
    required this.CodeCommande,
  }) : super(key: key);

  final String CodeCommande;

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
                          color: Colors.blue,
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
                            "Livré",
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
                          "Livré",
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
                        Text(
                          "Livré",
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
                            "MODE DE LIVRAISON",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: getProportionateScreenWidth(12),
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Text(
                          "Livré",
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
                            "MODE DE PAIEMENT",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: getProportionateScreenWidth(12),
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Text(
                          "Livré",
                          style: TextStyle(
                              fontSize: getProportionateScreenWidth(12),
                              color: Colors.black
                          ),
                        ),
                      ],
                    ),
                ],),
              )
            ],
          ),

          CustomAppBar(),
        ],
      ),
    );
  }
}
