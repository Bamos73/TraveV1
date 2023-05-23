import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserAuth {
   String nom;
   String prenom;
   String phonenumber;
   String commune;
   String quartier;
  String code;


  UserAuth({
    this.code = '',
    this.nom = '',
     this.prenom = '',
     this.phonenumber = '',
     this.commune = '',
     this.quartier = '',

  });

  // conversion les objets en collection FireBase
  Map<String, dynamic> toJson() {
    return {
      'Nom': nom,
      'Prenom': prenom,
      'numero_de_livraison': phonenumber,
      'Commune': commune,
      'Quartier': quartier,
      'Code': code,
    };
  }

  // conversion la collection FireBase en objet
  factory UserAuth.fromJson(Map<String, dynamic> json) {
    return UserAuth(
      nom: json['Nom'],
      prenom: json['Prenom'],
      phonenumber: json['numero_de_livraison'],
      commune:  json['Commune'],
      quartier:  json['Quartier'],
      code: json['Code'],

    );
  }

}

// création d'un document Firebase pour la collection AddUserCollection
Future<int> getNbr() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getInt('nbr') ?? 1; // Valeur par défaut de Nbr est 1
}

Future<void> setNbr(int value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setInt('nbr', value);
}

Future<void> addUser(UserAuth user) async {
  final currentUser = FirebaseAuth.instance.currentUser?.uid;
  if (currentUser != null) {
    int nbr = await getNbr(); // Récupérer la valeur actuelle de Nbr

    user.code = 'adresse_livraison_$nbr';

    final docUser = FirebaseFirestore.instance
        .collection("users")
        .doc(currentUser)
        .collection('adresse_livraison')
        .doc('adresse_livraison_$nbr');

    await docUser.set(user.toJson(), SetOptions(merge: true));

    nbr++; // Incrémenter Nbr

    await setNbr(nbr); // Sauvegarder la nouvelle valeur de Nbr
  }
}

// Sauvegarder la nouvelle valeur du numero de livraison
Future<void> addUserNumber(UserAuth user) async {
  final currentUser = FirebaseAuth.instance.currentUser?.uid;
  if (currentUser != null) {
    final docUser = FirebaseFirestore.instance
        .collection("users")
        .doc(currentUser);

    await docUser.set(user.toJson(), SetOptions(merge: true));

  }
}



//modifier les données de l'utilisateur dans la page My Account

Future updateUser(UserAuth user) async {
  final currentUser = FirebaseAuth.instance.currentUser?.uid;
  if (currentUser != null) {


    final snapshot = await FirebaseFirestore.instance
        .collection("users")
        .where("uid", isEqualTo: currentUser)
        .get();

    final docUser =
    FirebaseFirestore.instance.collection("users").doc(currentUser);

    await docUser.update(user.toJson());
  }
}

  Future <void> updateUserRecord(UserAuth user) async{
    final currentUser = FirebaseAuth.instance.currentUser?.uid;
      await FirebaseFirestore.instance.collection("users").doc(currentUser);
  }


