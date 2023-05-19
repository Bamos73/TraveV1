import 'package:flutter/material.dart';
import 'package:shopapp/size_config.dart';

class TopRoundedContainer extends StatelessWidget {
  const TopRoundedContainer({
    super.key, required this.color, required this.child,
  });
  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: getProportionateScreenWidth(20)),
      padding: EdgeInsets.only(top: getProportionateScreenWidth(20)),
      width:double.infinity,
      decoration:  BoxDecoration(
        color: color,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(40),
          topLeft: Radius.circular(40),
        ),
      ),
      child: child,

    );
  }
}
