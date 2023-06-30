import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopapp/components/shimmer_box.dart';
import 'package:shopapp/constants.dart';
import 'package:shopapp/screens/favory/components/card_item_favorie.dart';
import 'package:shopapp/screens/favory/components/favorie_empty.dart';

class CardFavorie extends StatefulWidget {
  const CardFavorie({Key? key}) : super(key: key);

  @override
  State<CardFavorie> createState() => _CardFavorieState();
}

class _CardFavorieState extends State<CardFavorie> {
  late String currentUserID;

  @override
  void initState() {
    super.initState();
    currentUserID = FirebaseAuth.instance.currentUser?.uid ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(currentUserID)
          .collection('favourite')
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Expanded(
              child: ShimmerCard()
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Expanded(
              child: ShimmerCard()
          );
        } else if (snapshot.data!.docs.isEmpty) {

            // // Le document est vide, naviguer vers une autre page
            //   WidgetsBinding.instance.addPostFrameCallback((_) {
            //     Navigator.pushReplacement(
            //       context,
            //       MaterialPageRoute(builder: (context) => EmptyFavorie()),
            //     );
            //   });
            return Expanded(
                child: EmptyFavorie());

        }

        final List<DocumentSnapshot> userFavData = snapshot.data!.docs;

        return Expanded(
          child: ListView.builder(
            itemCount: userFavData.length,
            itemBuilder: (BuildContext context, int index) {
              final DocumentSnapshot favDoc = userFavData[index];
              final String firstCollection = favDoc['first_Collection'] as String;
              final String firstDocument = favDoc ['first_Document'] as String;
              final String nomDocument = favDoc['code_Document'] as String;

              return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance
                    .collection(firstCollection)
                    .doc(firstDocument)
                    .collection(firstDocument)
                    .doc(nomDocument)
                    .snapshots(),
                builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
                  if (!snapshot.hasData) {
                    return Container();
                  } else if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container();
                  }
                  final Map<String, dynamic>? cardData = snapshot.data!.data();
                  if (cardData == null) {
                    return Container();
                  }
                  return Dismissible(
                    key: Key(cardData['code'].toString()),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        gradient: kSecondaryGradientColor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          Spacer(),
                          SvgPicture.asset("assets/icons/Trash.svg"),
                        ],
                      ),
                    ),
                    onDismissed: (direction) {
                      // Supprimer le document correspondant ici
                      FirebaseFirestore.instance
                          .collection('users')
                          .doc(currentUserID)
                          .collection('favourite')
                          .where('code_Document', isEqualTo: cardData['code']) // Filtrez par le champ 'code'
                          .get()
                          .then((querySnapshot) {
                        querySnapshot.docs.forEach((document) {
                          document.reference.delete(); // Supprimez le document correspondant
                        });
                      });
                    },
                    child: Card_item_Favorie(
                      cardImages: cardData['images'][0],
                      cardTitles: cardData['title'],
                      cardStyles: cardData['style'],
                      cardColors: cardData['color'],
                      cardCodes: cardData['code'],
                      cardPrices: cardData['price'],
                      documentId: cardData['code'],
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
