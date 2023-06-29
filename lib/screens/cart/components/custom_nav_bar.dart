import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopapp/components/default_button.dart';
import 'package:shopapp/constants.dart';
import 'package:shopapp/screens/cart/components/cart_empty.dart';
import 'package:shopapp/screens/cart/components/code_promo_box.dart';
import 'package:shopapp/screens/payment/payment_screen.dart';
import 'package:shopapp/size_config.dart';

class CheckOurCard extends StatefulWidget {
  const CheckOurCard({
    super.key,
  });

  @override
  State<CheckOurCard> createState() => _CheckOurCardState();
}

class MyAppState {
  static String CodeReductionPrecedent = "code";
}

class _CheckOurCardState extends State<CheckOurCard>
    with SingleTickerProviderStateMixin{
  bool _showSecondContainer = false;
  late AnimationController _animationController;
  late Animation<Offset> _animation;


  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _animation = Tween<Offset>(
      begin: Offset(0.0, 1.0),
      end: Offset(0.0, 0.5),
    ).animate(_animationController);

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleSecondContainer() {
    setState(() {
      _showSecondContainer = !_showSecondContainer;
      if (_showSecondContainer) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
            children:[
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: getProportionateScreenHeight(15),
                  horizontal: getProportionateScreenWidth(30),
                ),

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, -15),
                      blurRadius: 20,
                      color: Color(0xFFDADADA).withOpacity(0.15),
                    )
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          height: getProportionateScreenWidth(40),
                          width: getProportionateScreenWidth(40),
                          decoration: BoxDecoration(
                            color: Color(0xFFF5F6F9),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: SvgPicture.asset(
                            "assets/icons/receipt.svg",
                            color: kPrimaryColor,
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            _toggleSecondContainer();
                          },
                          child:_showSecondContainer
                              ? Icon(Icons.close, color: kPrimaryColor, size: 30,)
                              :Text("Ajouter un code promo"),
                        ),
                        const SizedBox(width: 10),
                        _showSecondContainer
                            ? Text("")
                            : Icon(
                          Icons.arrow_forward_ios,
                          size: 12,
                          color: kTextColor,
                        ),
                      ],
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      height: _showSecondContainer
                          ? getProportionateScreenHeight(70)
                          : getProportionateScreenHeight(20),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 100,
                          height: 50,
                          child:
                          StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('Card')
                                .doc(FirebaseAuth.instance.currentUser?.uid)
                                .collection(FirebaseAuth.instance.currentUser!.uid)
                                .snapshots(),
                            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (!snapshot.hasData) {
                                return Container();
                              } else if (snapshot.connectionState == ConnectionState.waiting) {
                                return Container();
                              } else if (snapshot.data!.docs.isEmpty) {
                                return Container(); // Ou tout autre widget vide
                              }

                              // Le document n'est pas vide, effectuer le traitement et afficher le contenu
                              final docs = snapshot.data!.docs;
                              num total = 0;
                              // Calculer la somme des prix
                              for (var doc in docs) {
                                final data = doc.data();
                                //On multiplie le prix par la quantité
                                final price = (data as Map<String, dynamic>?)?['price'] *
                                    (data as Map<String, dynamic>?)?['quantite'] ??
                                    0;
                                total += price;
                              }
                              return Text.rich(
                                TextSpan(
                                  text: "Total:\n",
                                  children: [
                                    TextSpan(
                                      text: "$total FCFA",
                                      style: TextStyle(
                                        fontSize: getProportionateScreenWidth(16),
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          width: getProportionateScreenWidth(190),
                          child: DefaultButton(
                            text: "Caisse",
                            press: () {
                              Navigator.pushNamed(context, PaymentScreen.routeName);
                            },
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SlideTransition(
                position: _animation,
                child: Align(
                  alignment: Alignment(0,0.5),
                  child: CodePromoBox(),
                ),
              ),
            ]
        ),
      ],
    );
  }
}
