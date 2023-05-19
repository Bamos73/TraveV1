import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shopapp/size_config.dart';


class shimmer_box extends StatelessWidget {
  const shimmer_box({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: getProportionateScreenWidth(120),
        height: getProportionateScreenHeight(240),
        decoration: BoxDecoration(
          color: Colors.grey[300],
        ),
      ),
    );
  }
}



class shimmer_cover extends StatelessWidget {
  const shimmer_cover({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: double.infinity,
        height: getProportionateScreenHeight(200),
        decoration: BoxDecoration(
          color: Colors.grey[300],
        ),
      ),
    );
  }
}

class shimmer_detail extends StatelessWidget {
  const shimmer_detail({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: double.infinity,
        height: getProportionateScreenHeight(600),
        decoration: BoxDecoration(
          color: Colors.grey[300],
        ),
      ),
    );
  }
}

class ShimmerCard extends StatelessWidget {
  const ShimmerCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 3,
      itemBuilder: (BuildContext context, int index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: getProportionateScreenHeight(5)),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: getProportionateScreenHeight(200),
                      width: getProportionateScreenWidth(130),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                      ),
                    ),
                    SizedBox(width: getProportionateScreenHeight(10),),
                    Container(
                      height: getProportionateScreenHeight(200),
                      width: getProportionateScreenWidth(205),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                height: getProportionateScreenWidth(12),
                                width: getProportionateScreenWidth(150),
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: getProportionateScreenHeight(5),),
                          Row(
                            children: [
                              Container(
                                height: getProportionateScreenWidth(12),
                                width: getProportionateScreenWidth(120),
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: getProportionateScreenHeight(5),),
                          Row(
                            children: [
                              Container(
                                height: getProportionateScreenWidth(12),
                                width: getProportionateScreenWidth(90),
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: getProportionateScreenHeight(5),),
                          Row(
                            children: [
                              Container(
                                height: getProportionateScreenWidth(12),
                                width: getProportionateScreenWidth(60),
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: getProportionateScreenWidth(12),
                                width: getProportionateScreenWidth(30),
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                ),
                              ),
                              Container(
                                height: getProportionateScreenWidth(12),
                                width: getProportionateScreenWidth(60),
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                ),
                              ),
                            ],
                          ),

                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(height: getProportionateScreenHeight(10),),
                Divider(thickness: 1, height: 1,)
              ],
            ),
          ),
        );
      },

    );
  }
}


