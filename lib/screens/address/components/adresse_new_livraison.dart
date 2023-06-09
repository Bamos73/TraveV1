import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong2/latlong.dart';
import 'package:shopapp/authentification/user_add_livraison_address.dart';
import 'package:shopapp/components/default_button.dart';
import 'package:shopapp/constants.dart';
import 'package:shopapp/size_config.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';


class NewAdresse extends StatefulWidget {
  const NewAdresse({Key? key}) : super(key: key);
  static String routeName = "address/components";

  @override
  State<NewAdresse> createState() => _NewAdresseState();
}

class _NewAdresseState extends State<NewAdresse> {
  final _formKey = GlobalKey<FormState>();
  final List<String?> errors = [];
  List<Marker> markers = [];

  final _ctrfirstname = TextEditingController();
  final _ctrphonenumber = TextEditingController();
  final _ctrLocalisation = TextEditingController();

  MapController mapController = MapController();
  Position? _currentPosition;
  bool ignorePointer =true;
  LatLng markerPosition = LatLng(5.3517217, -3.9617874);
  LatLng lastPosition = LatLng(5.3517217, -3.9617874);
  LatLng CurrentPosition = LatLng(5.3517217, -3.9617874);
  String _selectedCommune='Abidjan, Coco';
  bool isLoading = false;


  void addError({required String error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({required String error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }



  Future<void> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Vérifier si le service de localisation est activé
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await Geolocator.openLocationSettings();
      if (!serviceEnabled) {
        return;
      }
    }

    // Vérifier si l'autorisation de localisation est accordée
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        showCustomSnackBar(context, "Autorisation de localisation non approuvée", ContentType.warning);
        return;
      }
    }

    // Obtenir la localisation de l'utilisateur
    _currentPosition = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
    );

    // Récupérer l'adresse à partir des coordonnées
    List<Placemark> placemarks = await placemarkFromCoordinates(
      _currentPosition?.latitude ?? 5.3517217,
      _currentPosition?.longitude ?? -3.9617874,
    );

    if (placemarks.isNotEmpty) {
      setState(() {
        Placemark placemark = placemarks.last;
        _selectedCommune = placemark.locality.toString() + " "+placemark.subLocality.toString() ;
        _ctrLocalisation.text = _selectedCommune;
        print('Commune ${_selectedCommune}');
        _currentPosition = _currentPosition;
        ignorePointer;
        CurrentPosition = LatLng(_currentPosition?.latitude ?? 5.3517217, _currentPosition?.longitude ?? -3.9617874);
      });
    }
  }


  @override
  void initState() {
    super.initState();
    getCurrentLocation();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F9),
      appBar: AppBar(
        title: Text(
          "NOUVELLE ADRESSE DE LIVRAISON",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: getProportionateScreenWidth(15),
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back_ios, weight: 100),
        ),
      ),
      body: Stack(
        clipBehavior: Clip.none,
        fit: StackFit.expand,
        children: [
          Container(
            height: getProportionateScreenHeight(340),
            width: double.infinity,
            child:  IgnorePointer(
              ignoring: ignorePointer,
              child: FlutterMap(
                mapController: mapController,
                options: MapOptions(
                  center: CurrentPosition,
                  maxZoom: 25,
                  zoom: 18,
                  interactiveFlags: InteractiveFlag.all & ~InteractiveFlag.rotate,
                  onPositionChanged: (position, hasGesture) {
                    updateLocation(LatLng(position.center!.latitude, position.center!.longitude));
                  },

                ),
                children: <Widget>[
                  TileLayer(
                    urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                    subdomains: ['a', 'b', 'c'],
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        width: 80,
                        height: 80,
                        point:CurrentPosition,
                        builder: (ctx) =>
                            Container(
                              child: Icon(
                                Icons.location_on, color: kPrimaryColor,size: getProportionateScreenWidth(15),),
                            ),
                      )
                    ],
                  ),
                  MarkerClusterLayerWidget(
                    options: MarkerClusterLayerOptions(
                      maxClusterRadius: 45,
                      size:const Size(40, 40),
                      anchor: AnchorPos.align(AnchorAlign.center),
                      fitBoundsOptions: const FitBoundsOptions(
                        padding: EdgeInsets.all(50),
                        maxZoom: 15,
                      ),
                      markers: markers,
                      builder: (context, markers) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.blue,
                          ),
                          child: Text(
                            markers.length.toString(),
                            style: const TextStyle(color: Colors.white),
                          ),
                        );
                      },

                    ),
                  )
                ],
              ),
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            top: MediaQuery.of(context).viewInsets.bottom > 0
                ? getProportionateScreenHeight(140)
                : (ignorePointer
                ?getProportionateScreenHeight(300)
                :  getProportionateScreenHeight(510)),
            child: Container(
              width: getProportionateScreenWidth(375),
              height: getProportionateScreenHeight(500),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: getProportionateScreenHeight(10)),
                    Text(
                      'ADRESSE',
                      style: TextStyle(
                          color: kPrimaryColor,
                          fontSize: getProportionateScreenWidth(16)),
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          SizedBox(height: getProportionateScreenWidth(20)),
                          if (isLoading)
                            buildLocalisation()
                          else buildLocalisation2(),
                          SizedBox(height: getProportionateScreenWidth(30)),
                          buildFirstName(),
                          SizedBox(height: getProportionateScreenWidth(30)),
                          buildNumber(),
                          SizedBox(height: getProportionateScreenWidth(30)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.only(
            top: getProportionateScreenHeight(10),
            left: getProportionateScreenWidth(80),
            right: getProportionateScreenWidth(80),
            bottom: getProportionateScreenHeight(10),
          ),
          child: DefaultButton(
            text: "AJOUTER UNE ADRESSE",
            press: () {
              if (_formKey.currentState!.validate()) {
                final user = UserAuth(
                    nom: _ctrfirstname.text.trim(),
                    phonenumber: _ctrphonenumber.text.trim(),
                    commune: _ctrLocalisation.text.trim()
                );
                addUser(user);
                _ctrfirstname.text = '';
                _ctrphonenumber.text = '';
                Navigator.pop(context);
                setState(() {

                });
              }
            },
          ),
        ),
      ),
    );
  }

  Stack buildLocalisation() {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(30)),
          child: TextFormField(
            controller: _ctrLocalisation,
            enabled: !ignorePointer,
            onChanged: (value) {
              if (value.isNotEmpty) {
                removeError(error: kNamelNullError);
              } else {
                addError(error: kNamelNullError);
              }
            },
            validator: (value) {
              if (value!.isEmpty) {
                addError(error: kNamelNullError);
                return "";
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: "Votre localisation",
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
          ),
        ),
        Positioned(
          left: getProportionateScreenWidth(280),
          top: getProportionateScreenHeight(20),
          child: GestureDetector(
            onTap: () {
              setState(() {
                ignorePointer = !ignorePointer;
              });
            },
            child: Text(
              ignorePointer ?  "Modifier" : "Valider",
              style: TextStyle(
                color: Colors.red,
                fontSize: getProportionateScreenWidth(14),
              ),
            ),
          ),
        ),

      ],
    );
  }

  Stack buildLocalisation2() {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(30)),
          child: TextFormField(
            controller: _ctrLocalisation,
            enabled: !ignorePointer,
            onChanged: (value) {
              if (value.isNotEmpty) {
                removeError(error: kNamelNullError);
              } else {
                addError(error: kNamelNullError);
              }
            },
            validator: (value) {
              if (value!.isEmpty) {
                addError(error: kNamelNullError);
                return "";
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: "Votre localisation",
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
          ),
        ),
        Positioned(
          left: getProportionateScreenWidth(280),
          top: getProportionateScreenHeight(20),
          child: GestureDetector(
            onTap: () {
              setState(() {
                ignorePointer = !ignorePointer;
              });
            },
            child: Text(
              ignorePointer ?  "Modifier" : "Valider",
              style: TextStyle(
                color: kPrimaryColor,
                fontSize: getProportionateScreenWidth(14),
              ),
            ),
          ),
        ),

      ],
    );
  }


  Padding buildFirstName() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(30)),
      child: TextFormField(
        controller: _ctrfirstname,
        onChanged: (value) {
          if (value.isNotEmpty) {
            removeError(error: kNamelNullError);
          } else {
            addError(error: kNamelNullError);
          }
        },
        validator: (value) {
          if (value!.isEmpty) {
            addError(error: kNamelNullError);
            return "";
          }
          return null;
        },
        decoration: const InputDecoration(
          labelText: "Nom et prénom",
          hintText: "Entrer votre nom",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.person_pin_circle,color: kPrimaryColor,),
        ),
      ),
    );
  }



  Padding buildNumber() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(30)),
      child: TextFormField(
        controller: _ctrphonenumber,
        keyboardType: TextInputType.number,
        onChanged: (value) {
          if (value.isNotEmpty) {
            removeError(error: kPhoneNumberNullError);
          } else {
            addError(error: kPhoneNumberNullError);
          }
        },
        validator: (value) {
          if (value!.isEmpty) {
            addError(error: kPhoneNumberNullError);
            return "";
          }
          return null;
        },
        decoration: const InputDecoration(
          labelText: "Numéro",
          hintText: "Entrer votre numéro de téléphone",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.call,color: kPrimaryColor,),
        ),
      ),
    );
  }
  void showCustomSnackBar(BuildContext context, String message,
      ContentType contentType) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.fixed,
        backgroundColor: Color(0x00FFFFFF),
        elevation: 0,
        content: AwesomeSnackbarContent(
          title: 'Ohh Ohh!!',
          message: message,
          contentType: contentType,
          messageFontSize: getProportionateScreenWidth(15),
        ),
      ),
    );
  }

  void updateLocation(LatLng position) async {
    if (mounted) {
      setState(() {
        CurrentPosition = position;
        isLoading = true; // Activer l'animation de chargement
      });
    }

    // Vérifier si la position a changé
    if (position != lastPosition) {
      lastPosition = position;

      // Récupérer l'adresse à partir des nouvelles coordonnées
      List<Placemark> placemarks = await placemarkFromCoordinates(
        CurrentPosition.latitude,
        CurrentPosition.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks.last;
        String selectedCommune = placemark.locality.toString() + "," + placemark.subLocality.toString();

        setState(() {
          _selectedCommune = selectedCommune;
          _ctrLocalisation.text = _selectedCommune;
          isLoading = false; // Désactiver l'animation de chargement
        });
      }
    }
  }

}