import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopapp/components/shimmer_box.dart';
import 'package:shopapp/size_config.dart';

import '../../../provider/internet_provider.dart';


class HomeCover extends StatefulWidget {
  const HomeCover({
    required this.homeCoverStream,
  });

  final Stream<DocumentSnapshot<Map<String, dynamic>>> homeCoverStream;

  @override
  State<HomeCover> createState() => _HomeCoverState();
}

class _HomeCoverState extends State<HomeCover> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: widget.homeCoverStream,
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.hasError || !snapshot.hasData) {
          return ShimmerHomeCover();
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return ShimmerHomeCover();
        }
        final data = snapshot.data!.data();
        final imageUrl = data?['Image'] as String?;
        return FutureBuilder(
            future: checkImage(imageUrl!),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return ShimmerHomeCover();
              } else if (snapshot.hasError || snapshot.data == null) {
                return ShimmerHomeCover();
              }  else {
                return Container(
                          width: double.infinity,
                          child: Image.network(
                            imageUrl ?? "",
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.cover,
                            height: getProportionateScreenHeight(600),
            ),
          );
         }
         }
        );
      },
    );
  }
}
