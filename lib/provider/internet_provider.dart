import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

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
