import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserAuth {
  late String firstname;
  late String lastname;
  late String phonenumber;
  late String address;
  String email;
  String uid;
  String provider;

  UserAuth({
    this.provider = '',
    required this.firstname,
    required this.lastname,
    required this.phonenumber,
    required this.address,
    required this.email,
    required this.uid,
  });

  // conversion les objets en collection FireBase
  Map<String, dynamic> toJson() {
    return {
      'provider': provider,
      'name': firstname ,
      'Lastname': lastname,
      'Phonenumber': phonenumber,
      'Address': address,
      'email': email,
      'uid': uid,
    };
  }

  // conversion la collection FireBase en objet
  factory UserAuth.fromJson(Map<String, dynamic> json) {
    return UserAuth(
      provider: json['provider'],
      firstname: json['name'] ,
      lastname: json['Lastname'],
      phonenumber: json['Phonenumber'],
      address: json['Address'],
      email: json['email'],
      uid: json['uid'],
    );
  }
}

// création d'un document Firebase pour la collection AddUserCollection
Future addUser(UserAuth user) async {
  final currentUser = FirebaseAuth.instance.currentUser;
  if (currentUser != null) {
    user.email = currentUser.email!;
    user.uid=currentUser.uid;
    user.provider='TraveSignUp';
    final docUser = FirebaseFirestore.instance.collection("users").doc(user.uid);

    await docUser.set(user.toJson());
  }
}



