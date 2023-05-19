import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopapp/size_config.dart';

class HomeCover_4 extends StatefulWidget {
  const HomeCover_4({
    super.key,
    required Future<DocumentSnapshot<Map<String, dynamic>>> HomecoverDocFuture4,
  }) : _HomecoverDocFuture4 = HomecoverDocFuture4;

  final Future<DocumentSnapshot<Map<String, dynamic>>> _HomecoverDocFuture4;

  @override
  State<HomeCover_4> createState() => _HomeCover_4State();
}

class _HomeCover_4State extends State<HomeCover_4> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget._HomecoverDocFuture4,
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return Container(
              width: double.infinity,
              child: Image.network(
                snapshot.data?.data()?['Image'] ?? "",
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
                height: getProportionateScreenHeight(600),
              ),
            );
          }
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}


class HomeCover_3 extends StatefulWidget {
  const HomeCover_3({
    super.key,
    required Future<DocumentSnapshot<Map<String, dynamic>>> HomecoverDocFuture3,
  }) : _HomecoverDocFuture3 = HomecoverDocFuture3;

  final Future<DocumentSnapshot<Map<String, dynamic>>> _HomecoverDocFuture3;

  @override
  State<HomeCover_3> createState() => _HomeCover_3State();
}

class _HomeCover_3State extends State<HomeCover_3> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget._HomecoverDocFuture3,
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return Container(
              width: double.infinity,
              child: Image.network(
                snapshot.data?.data()?['Image'] ?? "",
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
                height: getProportionateScreenHeight(600),
              ),
            );
          }
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}





class HomeCover_2 extends StatefulWidget {
  const HomeCover_2({
    super.key,
    required Future<DocumentSnapshot<Map<String, dynamic>>> HomecoverDocFuture2,
  }) : _HomecoverDocFuture2 = HomecoverDocFuture2;

  final Future<DocumentSnapshot<Map<String, dynamic>>> _HomecoverDocFuture2;

  @override
  State<HomeCover_2> createState() => _HomeCover_2State();
}

class _HomeCover_2State extends State<HomeCover_2> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget._HomecoverDocFuture2,
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return Container(
              width: double.infinity,
              child: Image.network(
                snapshot.data?.data()?['Image'] ?? "",
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
                height: getProportionateScreenHeight(600),
              ),
            );
          }
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}



class HomeCover_1 extends StatefulWidget {
  const HomeCover_1({
    super.key,
    required Future<DocumentSnapshot<Map<String, dynamic>>> HomecoverDocFuture1,
  }) : _HomecoverDocFuture1 = HomecoverDocFuture1;

  final Future<DocumentSnapshot<Map<String, dynamic>>> _HomecoverDocFuture1;

  @override
  State<HomeCover_1> createState() => _HomeCover_1State();
}

class _HomeCover_1State extends State<HomeCover_1> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget._HomecoverDocFuture1,
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return Container(
              width: double.infinity,
              child: Image.network(
                snapshot.data?.data()?['Image'] ?? "",
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
                height: getProportionateScreenHeight(600),
              ),
            );
          }
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
