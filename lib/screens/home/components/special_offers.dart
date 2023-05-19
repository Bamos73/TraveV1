import 'package:flutter/material.dart';
import 'package:shopapp/screens/home/components/section_title.dart';
import 'package:shopapp/size_config.dart';

class SpecialOffers extends StatelessWidget {
  const SpecialOffers({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(

      children: [
        SectionTitle(
          text: "Special for you",
          press: () {},),
        SizedBox(height: getProportionateScreenWidth(20),),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SpecialOfferCard(
                image: "assets/images/Image Banner 2.png",
                category: "Accessoires",
                numOfBrands: 18,
                press: () {},
              ),
              SpecialOfferCard(
                image: "assets/images/Image Banner 3.png",
                category: "Fashion",
                numOfBrands: 24,
                press: () {},
              ),
              SizedBox(width: getProportionateScreenWidth(20),)
            ],
          ),
        ),
      ],
    );
  }
}

class SpecialOfferCard extends StatelessWidget {
  const SpecialOfferCard({
    super.key,
    required this.category,
    required this.image,
    required this.numOfBrands,
    required this.press,
  });

  final String category, image;
  final int numOfBrands;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
      child: SizedBox(
        width: getProportionateScreenWidth(242),
        height: getProportionateScreenHeight(100),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              Image.asset(
                image,// pour l'image des offres speciaux
                fit:BoxFit.cover ,
              ),
              Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Color(0xFF343434).withOpacity(0.4),
                      Color(0xFF343434).withOpacity(0.15),
                    ],)
                ),
              ),
              Padding(
                padding:  EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(15),
                    vertical: getProportionateScreenHeight(10)
                ),
                child: Text.rich(
                  TextSpan(
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    children: [
                      TextSpan(
                        text:"$category\n",
                        style: TextStyle(
                          fontSize: getProportionateScreenWidth(18),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                          text: "$numOfBrands Brands"
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
