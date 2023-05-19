
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shopapp/screens/home/components/home_header.dart';
import 'package:shopapp/size_config.dart';


class category_shimmer extends StatelessWidget {
  const category_shimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.withOpacity(0.25),
      highlightColor: Colors.grey.withOpacity(0.6),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            child: Column(
              children: [
                SizedBox(height: getProportionateScreenWidth(10)),
                HomeHeader(),
                SizedBox(height: getProportionateScreenWidth(10)),
                // Afficher l'image de la collection "Category_cover" dans Image.network
                Container(
                  height: getProportionateScreenHeight(200),
                  color: Colors.grey[300],
                ),
                SizedBox(height: getProportionateScreenHeight(10)),
                ListView.builder(
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.grey[300],
                          ),
                          title: Row(

                            children: [
                              Container(
                                height: 20,
                                width: getProportionateScreenWidth(120),
                                color: Colors.grey[300],
                              ),
                              Spacer(),
                              Container(
                                height: 20,
                                width: 20,
                                color: Colors.grey[300],
                              ),
                            ],
                          ),
                        ),
                        Divider(),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
