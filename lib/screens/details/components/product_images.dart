import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopapp/constants.dart';
import 'package:shopapp/size_config.dart';


class ProductImage extends StatefulWidget {
  const ProductImage({
    super.key,
    required this.product,
  });
  final DocumentSnapshot<Map<String, dynamic>> product;
  @override
  State<ProductImage> createState() => _ProductImageState();
}
class _ProductImageState extends State<ProductImage> {
  int selectedImage=0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width:double.infinity,
          height: getProportionateScreenHeight(550),
          child: Image.network(
            widget.product['images'][selectedImage],
            fit:BoxFit.cover,
            isAntiAlias: true,
            filterQuality: FilterQuality.high,
            colorBlendMode: BlendMode.color,
            repeat: ImageRepeat.repeat,
            matchTextDirection: true,
            gaplessPlayback: true,
            excludeFromSemantics: true,
            scale: 1.0,
          ),
        ),
        SizedBox(height:8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...List.generate(
                widget.product['images'].length,
                    (index) => buildSmallPreview(widget.product,index)
            ),
          ],
        ),
      ],
    );
  }

  GestureDetector buildSmallPreview(DocumentSnapshot<Map<String, dynamic>> product, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedImage=index;
        });
      },
      child: Container(
        margin:EdgeInsets.only(right: getProportionateScreenWidth(15)),
        width: getProportionateScreenWidth(48),
        height: getProportionateScreenHeight(48),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Colors.grey[300],
          border: Border.all(
              color: selectedImage == index
                  ? kPrimaryColor
                  : Colors.transparent),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Image.network(
            product['images'][index],
            fit: BoxFit.scaleDown,
            width: double.infinity,
            height: double.infinity,
            alignment: Alignment.center,
            errorBuilder: (context, error, stackTrace) => Icon(Icons.error),
            frameBuilder: (context, child, frame, wasSynchronouslyLoaded) => child,
            loadingBuilder: (context, child, loadingProgress) =>
            loadingProgress == null
                ? child
                : Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                          : null,
                    ),
            ),
            isAntiAlias: true,
            filterQuality: FilterQuality.high,
            colorBlendMode: BlendMode.color,
            repeat: ImageRepeat.repeat,
            matchTextDirection: true,
            gaplessPlayback: true,
            excludeFromSemantics: true,
            scale: 1.0,
          ),
        ),
      ),
    );
  }
}


