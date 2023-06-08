import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shopapp/authentification/user_add_livraison_address.dart';
import 'package:shopapp/components/default_button.dart';
import 'package:shopapp/components/form_error.dart';
import 'package:shopapp/constants.dart';
import 'package:shopapp/size_config.dart';

class NewAdresse extends StatefulWidget {
  const NewAdresse({Key? key}) : super(key: key);
  static String routeName = "address/components";

  @override
  State<NewAdresse> createState() => _NewAdresseState();
}

class _NewAdresseState extends State<NewAdresse> {
  final _formKey = GlobalKey<FormState>();
  final List<String?> errors = [];

  final _ctrfirstname = TextEditingController();
  final _ctrlastname = TextEditingController();
  final _ctrphonenumber = TextEditingController();
  String? _selectedCommune;
  String? _selectedQuartier;

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

  late GoogleMapController mapController;
  late LatLng currentPosition;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  void _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      currentPosition = LatLng(position.latitude, position.longitude);
    });
  }

  List<String> communes = [
    'Abobo',
    'Adjamé',
    'Attécoubé',
    'Anyama',
    'Bingerville',
    'Cocody',
    'Koumassi',
    'Marcory',
    'Plateau',
    'Port-Bouët',
    'Treichville',
    'Yopougon',
  ];

  Map<String, List<String>> quartiers = {
    'Abobo': ['Abobo-Doumé', 'Abobo-Sagbé', 'Abobo-Baoulé', 'Abobo-Avocatier'],
    'Adjamé': ['Plateau Dokui', 'Williamsville', 'Alafiarou', 'Abattoirs'],
    'Attécoubé': ['Camp Militaire', 'Belleville', 'Sainte Cécile', 'Banco'],
    'Anyama': ['Quartier 1', 'Quartier 2', 'Quartier 3', 'Quartier 4'],
    'Bingerville': ['Quartier 1', 'Quartier 2', 'Quartier 3', 'Quartier 4'],
    'Cocody': ['Angré', 'Deux-Plateaux', 'Riviera', 'Cocody-les-Deux-Plateaux'],
    'Koumassi': ['Koumassi Remblais', 'Vridi Cité', 'Koumassi Port', 'Koumassi Sicogi'],
    'Marcory': ['Zone 4', 'Biétry', 'Zone 3', 'Anoumabo'],
    'Plateau': ['Plateau Centre', 'Plateau Dokui', 'Plateau Saint Michel', 'Plateau Attoban'],
    'Port-Bouët': ['Gonzagueville','Vridi', 'Port-Bouët Centre', 'Port-Bouët Cité', 'Port-Bouët Wharf',],
    'Treichville': ['Treichville Centre', 'Treichville Wharf', 'Treichville Zone 1', 'Treichville Zone 3'],
    'Yopougon': ['Yopougon Siporex', 'Yopougon Niangon', 'Yopougon Maroc', 'Yopougon Selmer'],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F9),
      appBar: AppBar(
        title: Text(
          "AJOUTER UNE NOUVELLE ADRESSE",
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
        children: [
          Container(
            height: getProportionateScreenHeight(340),
            width: double.infinity,
            child:GoogleMap(
              onMapCreated: (GoogleMapController controller) {
                mapController = controller;
              },
              initialCameraPosition: CameraPosition(
                target: currentPosition ?? LatLng(0, 0), // Default position if not available
                zoom: 15,
              ),
              markers: Set<Marker>.from([
                Marker(
                  markerId: MarkerId('currentPosition'),
                  position: currentPosition ?? LatLng(0, 0), // Default position if not available
                  infoWindow: InfoWindow(
                    title: 'Ma position',
                  ),
                ),
              ]),
            ),

          ),
          Positioned(
            top: getProportionateScreenHeight(300),
            child: Container(
              width: getProportionateScreenWidth(375),
              height: getProportionateScreenHeight(350),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),)
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(height: getProportionateScreenWidth(30)),
                      buildFirstName(),
                      SizedBox(height: getProportionateScreenWidth(30)),
                      buildLastName(),
                      SizedBox(height: getProportionateScreenWidth(30)),
                      buildNumber(),
                      SizedBox(height: getProportionateScreenWidth(30)),
                      buildCommuneDropdown(),
                      SizedBox(height: getProportionateScreenWidth(30)),
                      buildQuartierDropdown(),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(30)),
                        child: FormError(errors: errors),
                      ),
                      SizedBox(height: getProportionateScreenWidth(30)),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
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
                prenom: _ctrlastname.text,
                phonenumber: _ctrphonenumber.text.trim(),
                commune: _selectedCommune!,
                quartier: _selectedQuartier!,
              );
              addUser(user);
              _ctrfirstname.text = '';
              _ctrlastname.text = '';
              _ctrphonenumber.text = '';
              _selectedCommune = null;
              _selectedQuartier = null;
              Navigator.pop(context);
            }
          },
        ),
      ),
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
          labelText: "Nom",
          hintText: "Entrer votre nom",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.person_pin_circle),
        ),
      ),
    );
  }

  Padding buildLastName() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(30)),
      child: TextFormField(
        controller: _ctrlastname,
        onChanged: (value) {
          if (value.isNotEmpty) {
            removeError(error: kLastNamelNullError);
          } else {
            addError(error: kLastNamelNullError);
          }
        },
        validator: (value) {
          if (value!.isEmpty) {
            addError(error: kLastNamelNullError);
            return "";
          }
          return null;
        },
        decoration: const InputDecoration(
          labelText: "Prénom",
          hintText: "Entrer votre prénom",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.person_pin_circle),
        ),
      ),
    );
  }

  Padding buildCommuneDropdown() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(30)),
      child: DropdownButtonFormField<String>(
        value: _selectedCommune,
        onChanged: (newValue) {
          setState(() {
            _selectedCommune = newValue!;
            _selectedQuartier = null; // Réinitialiser le quartier sélectionné
          });
        },
        items: communes
            .map<DropdownMenuItem<String>>(
              (value) => DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          ),
        )
            .toList(),
        validator: (value) {
          if (value == null) {
            addError(error: kCommuneNullError);
            return "";
          }
          return null;
        },
        decoration: const InputDecoration(
          labelText: "Commune",
          hintText: "Sélectionner votre commune",
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ),
      ),
    );
  }


  Padding buildQuartierDropdown() {
    List<String>? quartierList = quartiers[_selectedCommune];
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(30)),
      child: DropdownButtonFormField<String>(
        value: _selectedQuartier,
        onChanged: (newValue) {
          setState(() {
            _selectedQuartier = newValue!;
          });
        },
        items: quartierList
            ?.map<DropdownMenuItem<String>>(
              (value) => DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          ),
        )
            .toList(),
        validator: (value) {
          if (value == null) {
            addError(error: kQuartierNullError);
            return "";
          }
          return null;
        },
        decoration: const InputDecoration(
          labelText: "Quartier",
          hintText: "Sélectionner votre quartier",
          floatingLabelBehavior: FloatingLabelBehavior.always,
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
          suffixIcon: Icon(Icons.call),
        ),
      ),
    );
  }
}

