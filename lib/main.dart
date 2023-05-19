import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/provider/internet_provider.dart';
import 'package:shopapp/provider/sign_in_provider.dart';
import 'package:shopapp/routes.dart';
import 'package:shopapp/screens/splash_screen.dart';
import 'package:shopapp/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_performance/firebase_performance.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}
FirebasePerformance performance = FirebasePerformance.instance;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: ((context) => SignInProvider()),
        ),
        ChangeNotifierProvider(
          create: ((context) => InternetProvider()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Trave',
        theme: theme(),
        initialRoute: SplashScreen.routeName,
        routes: routes,
      ),
    );
  }
}
