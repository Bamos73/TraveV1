import 'package:flutter/material.dart';
import 'package:shopapp/components/default_button.dart';
import 'package:shopapp/size_config.dart';

class CustomNavBarPayment extends StatefulWidget {
  const CustomNavBarPayment({Key? key}) : super(key: key);

  @override
  State<CustomNavBarPayment> createState() => _CustomNavBarPaymentState();
}

class _CustomNavBarPaymentState extends State<CustomNavBarPayment> {
  bool _isListViewVisible = false;

  double _getContainerHeight() {
    if (_isListViewVisible) {
      return getProportionateScreenHeight(230);
    } else {
      return getProportionateScreenHeight(150);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _getContainerHeight(),
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Divider(height: 1, thickness: 1),
          SizedBox(height: getProportionateScreenHeight(10)),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "RESUME DE LA COMMANDE",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: getProportionateScreenHeight(14),
                    color: Colors.black87,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isListViewVisible = !_isListViewVisible;
                    });
                  },
                  child: Icon(
                    _isListViewVisible
                        ? Icons.expand_more
                        : Icons.expand_less_rounded,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(10)),
          Visibility(
            visible: _isListViewVisible,
            child: Container(
              height: getProportionateScreenHeight(80),
              width: double.infinity,
              color: Colors.white,
              padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20),
              ),
              child: Column(
                children: [
                  SizedBox(height: getProportionateScreenHeight(10)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Sous-Total :",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: getProportionateScreenHeight(14),
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        "14500 FCFA",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: getProportionateScreenHeight(14),
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: getProportionateScreenHeight(10)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Livraison :",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: getProportionateScreenHeight(14),
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        "500 FCFA",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: getProportionateScreenHeight(14),
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Divider(height: 1, thickness: 1),
          Container(
            height: getProportionateScreenHeight(105),
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(20),
            ),
            color: Colors.white,
            child: Column(
              children: [
                SizedBox(height: getProportionateScreenHeight(10)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "TOTAL",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: getProportionateScreenHeight(15),
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      "15000 FCFA",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: getProportionateScreenHeight(15),
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: getProportionateScreenHeight(15)),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20),
                  ),
                  child: DefaultButton(text: "PASSER LA COMMANDE", press: () {}),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}