import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shopapp/components/default_button.dart';
import 'package:shopapp/size_config.dart';

class shimmer_box_line extends StatelessWidget {
  const shimmer_box_line({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: getProportionateScreenWidth(120),
              height: getProportionateScreenHeight(240),
              decoration: BoxDecoration(
                color: Colors.grey[300],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                width: getProportionateScreenWidth(120),
                height: getProportionateScreenHeight(240),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                width: getProportionateScreenWidth(120),
                height: getProportionateScreenHeight(240),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

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

class shimmer_box_Category_Grid extends StatelessWidget {
  const shimmer_box_Category_Grid({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: getProportionateScreenHeight(20),
            crossAxisSpacing: getProportionateScreenHeight(20),
            mainAxisExtent: getProportionateScreenHeight(300),
          ),
          itemCount: 6,
          itemBuilder: (context, index) {
        return Container(
          child: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child:  Container(
                color: Colors.grey[300],
                height: getProportionateScreenHeight(50),
                  width: getProportionateScreenHeight(20),
          )
          ),
        );
        }
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

class ShimmerOrder extends StatelessWidget {
  const ShimmerOrder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 9,
      itemBuilder: (BuildContext context, int index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
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
                          Container(
                            height: getProportionateScreenHeight(19),
                            width: getProportionateScreenWidth(200),
                            color: Colors.grey[300],
                          ),
                          SizedBox(height: 4,),
                          Container(
                            height: getProportionateScreenHeight(18),
                            width: getProportionateScreenWidth(100),
                            color: Colors.grey[300],
                          ),
                          SizedBox(height: 4,),
                          Container(
                            height: getProportionateScreenHeight(18),
                            width: getProportionateScreenWidth(80),
                            color: Colors.grey[300],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                height: getProportionateScreenHeight(18),
                                width: getProportionateScreenWidth(80),
                                color: Colors.grey[300],
                              ),
                              SizedBox(height: 4,),
                              Container(
                                height: getProportionateScreenHeight(18),
                                width: getProportionateScreenWidth(50),
                                color: Colors.grey[300],
                              ),
                              SizedBox(height: 4,),
                              Container(
                                height: getProportionateScreenHeight(18),
                                width: getProportionateScreenWidth(70),
                                color: Colors.grey[300],
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
      },
    );
  }
}


class ShimmerPopular extends StatelessWidget {
  const ShimmerPopular({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Container(
        width: double.infinity,
        height: getProportionateScreenHeight(175),
        child: GridView.builder(
          itemCount: 8,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: getProportionateScreenWidth(64),
            mainAxisSpacing: getProportionateScreenWidth(20),
            crossAxisSpacing: getProportionateScreenWidth(20),
            childAspectRatio: 1,
          ),
          itemBuilder: (context, index) {
            return Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(50)
                ),

              ),
            );
          },
        ),
      ),
    );
  }
}



class shimmer_Popular_image extends StatelessWidget {
  const shimmer_Popular_image({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: getProportionateScreenHeight(64),
        width: getProportionateScreenWidth(64),
        decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(50)
        ),
      ),
    );
  }
}


class ShimmerHomeCover extends StatelessWidget {
  const ShimmerHomeCover({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: getProportionateScreenHeight(600),
        decoration: BoxDecoration(
            color: Colors.grey[300],
        ),
      ),
    );
  }
}


class ShimmerNouveaute extends StatelessWidget {
  const ShimmerNouveaute({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: getProportionateScreenHeight(7),
          crossAxisSpacing: getProportionateScreenHeight(7),
          mainAxisExtent: getProportionateScreenHeight(250),
        ),
        itemCount: 6,
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey[300],
              ),

            ),
          );
        },
      ),
    );
  }
}



class ShimmerNouveauteCard extends StatelessWidget {
  const ShimmerNouveauteCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: getProportionateScreenWidth(100),
              height: getProportionateScreenHeight(200),
              decoration: BoxDecoration(
                color: Colors.grey[300],
              ),
            ),
          );
  }
}


class ShimmerPaiementResume extends StatelessWidget {
  const ShimmerPaiementResume({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        children: [
          SizedBox(height: getProportionateScreenHeight(10)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: getProportionateScreenHeight(16),
                width: getProportionateScreenWidth(100),
                color: Colors.grey[300],
              ),
              Container(
                height: getProportionateScreenHeight(16),
                width: getProportionateScreenWidth(60),
                color: Colors.grey[300],
              ),
            ],
          ),
          SizedBox(height: getProportionateScreenHeight(10)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: getProportionateScreenHeight(16),
                width: getProportionateScreenWidth(90),
                color: Colors.grey[300],
              ),
              Container(
                height: getProportionateScreenHeight(16),
                width: getProportionateScreenWidth(60),
                color: Colors.grey[300],
              ),
            ],
          ),
          SizedBox(height: getProportionateScreenHeight(10)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: getProportionateScreenHeight(16),
                width: getProportionateScreenWidth(80),
                color: Colors.grey[300],
              ),
              Container(
                height: getProportionateScreenHeight(16),
                width: getProportionateScreenWidth(60),
                color: Colors.grey[300],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ShimmerPaiementCommande extends StatelessWidget {
  const ShimmerPaiementCommande({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text("Total:"),
              Container(
                height: getProportionateScreenHeight(18),
                width: getProportionateScreenWidth(70),
                color: Colors.grey[300],
              ),
            ],
          ),
          SizedBox(
            width: getProportionateScreenWidth(190),
            child: DefaultButton(
                text: "Commande", press: () {}
            ),
          ),
        ],
      ),
    );
  }
}

