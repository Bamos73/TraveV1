// import 'package:flutter/material.dart';
// import 'package:shopapp/components/product_card.dart';
// import 'package:shopapp/models/product_new_collection.dart';
// import 'package:shopapp/screens/details/details_product_screen.dart';
// import 'package:shopapp/screens/home/components/section_title.dart';
// import 'package:shopapp/size_config.dart';
//
// class NouvelleCollectionBox extends StatelessWidget {
//   const NouvelleCollectionBox({
//     super.key,
//     required this.titre, required this.press,
//   });
//
//   final String titre;
//   final GestureTapCallback press;
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         SectionTitle(text: titre, press: press,),
//         SizedBox(height: getProportionateScreenWidth(20),),
//         SingleChildScrollView(
//           scrollDirection: Axis.horizontal,
//           child: Row(
//             children: [
//               ...List.generate(
//                 NewCollectionArray.length,
//                     (index) => NewCollectionCard(
//                       widthCard: 120,
//                       heightCard: 240,
//                       product: NewCollectionArray[index],
//                       press:() => Navigator.pushNamed(context,
//                           DetailProductScreen.routeName,
//                           arguments: NewCollectionDetailsArguments(
//                               product: NewCollectionArray[index])),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
//
