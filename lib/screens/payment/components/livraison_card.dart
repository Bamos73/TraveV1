import 'package:flutter/material.dart';
import 'package:shopapp/constants.dart';
import 'package:shopapp/size_config.dart';

class ListPaymentLivraison extends StatefulWidget {
  const ListPaymentLivraison({
    super.key,
  });

  @override
  State<ListPaymentLivraison> createState() => _ListPaymentLivraisonState();
}


class _ListPaymentLivraisonState extends State<ListPaymentLivraison> {
  @override
  Widget build(BuildContext context) {
    String _selectedOption="";


    return Container(
      color: Colors.white,
      height: getProportionateScreenHeight(65),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(Icons.check_circle,size: getProportionateScreenWidth(18),),
                SizedBox(width: getProportionateScreenWidth(12)),
                Container(
                  width: getProportionateScreenWidth(170),
                  height: getProportionateScreenHeight(53),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text("MODE DE LIVRAISON",style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: getProportionateScreenHeight(14),
                            color: Colors.black87,
                          ),),
                        ],
                      ),
                      const SizedBox(height: 5,),
                      Row(
                        children: [
                          Text( _selectedOption == ""
                              ?"REGULIER"
                              :_selectedOption,
                            maxLines: 2,
                            style: TextStyle(
                              color: kTextColor,
                              fontSize: getProportionateScreenHeight(13),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ) ,
            GestureDetector(
              onTap: () {
                showCustomDialog(context);
              },
              child: Text("MODIFIER",style: TextStyle(
                fontSize: getProportionateScreenHeight(13),
                color: Colors.black87,
              ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showCustomDialog(BuildContext context) {
    String _selectedOption="";
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Container(
            padding: EdgeInsets.all(15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'MODE DE LIVRAISON',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: getProportionateScreenWidth(14),
                      color: Colors.black87,
                      fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(10)),
                Divider(thickness: 1,height: 1,),
                RadioListTile(
                  title: Text("Livraison régulière"),
                  subtitle: Text('1 à 3 jours ouvrables'),
                  value: 'REGULIER',
                  groupValue: _selectedOption,
                  onChanged: (value) {
                    setState(() {
                      _selectedOption = value as String;
                    });
                    Navigator.of(context).pop();
                    print(_selectedOption);
                  },
                ),
                RadioListTile(
                  title: Text("Livraison express"),
                  value: 'EXPRESS',

                  subtitle: Text('2 à 8 heures'),
                  groupValue: _selectedOption,
                  onChanged: (value) {
                    setState(() {
                      _selectedOption=value as String;
                    });
                    Navigator.of(context).pop();
                    print(_selectedOption);
                  },
                ),

              ],
            ),
          ),
        );
      },
    );
  }

}
