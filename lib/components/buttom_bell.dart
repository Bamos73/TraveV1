import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopapp/size_config.dart';

class ButtomBell extends StatefulWidget {
  const ButtomBell({
    super.key,
    required this.svgSrc,
    this.numOfItems =0,
    required this.press, required this.height, required this.width, required this.padding,
  });

  final String svgSrc;
  final int numOfItems;
  final GestureTapCallback press;
  final double height, width,padding;

  @override
  State<ButtomBell> createState() => _ButtomBellState();
}

class _ButtomBellState extends State<ButtomBell> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.press,
      borderRadius: BorderRadius.circular(50),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(widget.padding)) ,
              height: widget.height,
              width:widget.width,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(widget.svgSrc)
          ),
          if (widget.numOfItems != 0)
            Positioned(
              top: -3,
              right: 0,
              child: Container(
                height: getProportionateScreenWidth(16),
                width: getProportionateScreenHeight(16),
                decoration: BoxDecoration(
                  color: Color(0xFFFF4848),
                  shape: BoxShape.circle,
                  border: Border.all(width: 1.5, color: Colors.white),
                ),
                child: Center(
                  child: Text("${widget.numOfItems}",
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(10),
                      height: 1,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),

        ],
      ),
    );
  }
}
