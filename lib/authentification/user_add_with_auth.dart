import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserAuth {
  late String firstname;
  late String lastname;
  late String phonenumber;
  late String address;
  String id;
  String email;
  String uid;

  UserAuth({
    this.id = '',
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
      'id': id,
      'Firstname': firstname,
      'Lastname': lastname,
      'Phonenumber': phonenumber,
      'Address': address,
      'Email': email,
      'UID': uid,
    };
  }

  // conversion la collection FireBase en objet
  factory UserAuth.fromJson(Map<String, dynamic> json) {
    return UserAuth(
      id: json['id'],
      firstname: json['Firstname'],
      lastname: json['Lastname'],
      phonenumber: json['Phonenumber'],
      address: json['Address'],
      email: json['Email'],
      uid: json['UID'],
    );
  }


}

// création d'un document Firebase pour la collection AddUserCollection
Future addUser(UserAuth user) async {
  final currentUser = FirebaseAuth.instance.currentUser;
  if (currentUser != null) {
    user.email = currentUser.email!;
    user.uid=currentUser.uid;

    final docUser = FirebaseFirestore.instance.collection("users").doc();
    user.id = docUser.id;

    await docUser.set(user.toJson());
  }
}
//modifier les données de l'utilisateur dans la page My Account

Future updateUser(UserAuth user) async {
  final currentUser = FirebaseAuth.instance.currentUser;
  if (currentUser != null) {
    user.email = currentUser.email!;
    user.uid = currentUser.uid;

    final snapshot = await FirebaseFirestore.instance
        .collection("users")
        .where("Email", isEqualTo: currentUser.email)
        .get();
    final docId = snapshot.docs[0].id;
    final docUser =
    FirebaseFirestore.instance.collection("users").doc(docId);

    await docUser.update(user.toJson());
  }
}

  Future <void> updateUserRecord(UserAuth user) async{
      await FirebaseFirestore.instance.collection("users").doc(user.id);
  }
