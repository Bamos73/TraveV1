import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class InternetProvider extends ChangeNotifier {
  bool _hasInternet = false;
  bool get hasInternet => _hasInternet;

  InternetProvider() {
    checkInternetConnection();
  }

  Future checkInternetConnection() async {
    var result = await (Connectivity().checkConnectivity());
    if (result == ConnectivityResult.mobile || result == ConnectivityResult.wifi) {
      _hasInternet = true;
      print('L\'utilisateur est connecté à Internet');
    } else {
      _hasInternet = false;
      print('L\'utilisateur n\'est pas connecté à Internet');
    }
    notifyListeners();
  }
}

//VERIFIER SI L'URL DE L'IMAGE DES CATEGORIE EST BONNE
Future<bool> checkImage(String url) async {
  try {
    final response = await http.head(Uri.parse(url));
    return response.statusCode == 200;
  } catch (e) {
    return false;
  }
}
