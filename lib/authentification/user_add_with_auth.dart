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
  String image_url;


  UserAuth({
    this.provider = '',
    this.image_url = '',
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
      'image_url': image_url,
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
      image_url: json['image_url'],
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
    user.image_url='';
    final docUser = FirebaseFirestore.instance.collection("users").doc(user.uid);

    await docUser.set(user.toJson());
  }
}



