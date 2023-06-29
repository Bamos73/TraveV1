import 'package:flutter/material.dart';
import 'package:shopapp/components/main_screens.dart';
import 'package:shopapp/screens/Privacy_Policy/Privacy_Policy_Screen.dart';
import 'package:shopapp/screens/Term_And_Condition/term_and_condition_screen.dart';
import 'package:shopapp/screens/address/address_screen.dart';
import 'package:shopapp/screens/address/components/adresse_new_livraison.dart';
import 'package:shopapp/screens/cart/cart_screen.dart';
import 'package:shopapp/screens/cart/components/cart_empty.dart';
import 'package:shopapp/screens/category/category_screen.dart';
import 'package:shopapp/screens/complete_profile/complete_profile_screen.dart';
import 'package:shopapp/screens/details/details_screen.dart';
import 'package:shopapp/screens/category_details/details_categorie_screen.dart';
import 'package:shopapp/screens/favory/components/favorie_empty.dart';
import 'package:shopapp/screens/favory/favorie_screen.dart';
import 'package:shopapp/screens/forgot_password/forgot_password_screen.dart';
import 'package:shopapp/screens/home/home_screen.dart';
import 'package:shopapp/screens/my_account/my_account_screen.dart';
import 'package:shopapp/screens/order/order_screen.dart';
import 'package:shopapp/screens/order_details/order_detail_screen.dart';
import 'package:shopapp/screens/otp/otp_screen.dart';
import 'package:shopapp/screens/payment/components/commande_valide.dart';
import 'package:shopapp/screens/payment/payment_screen.dart';
import 'package:shopapp/screens/plus/profil_screen.dart';
import 'package:shopapp/screens/sign_in/sign_in_screen.dart';
import 'package:shopapp/screens/sign_up/sign_up_screen.dart';
import 'package:shopapp/screens/special_offers/special_screen.dart';
import 'package:shopapp/screens/splash_screen.dart';
import 'package:shopapp/screens/splash_screen_first.dart';

final Map<String, WidgetBuilder> routes = {
        SplashScreen.routeName : (context) => SplashScreen(),
        SplashScreenFirst.routeName : (context) => SplashScreenFirst(),
        SignInScreen.routeName: (context) => SignInScreen(),
        ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
        SignUpScreen.routeName:(context) => SignUpScreen(),
        TermAndConditionScreen.routeName: (context) =>  TermAndConditionScreen(),
        PrivacyPolicyScreen.routeName:(context) => PrivacyPolicyScreen(),
        CompleteProfileScreen.routeName:(context) => CompleteProfileScreen(),
        OTPScreen.routeName:(context) => OTPScreen(),
        HomeScreen.routeName:(context) => HomeScreen(),
        DetailsScreen.routeName:(context) => DetailsScreen(productId: '', product: null, collectionName: '', FirstcollectionName: '',),
        CartScreen.routeName:(context) => CartScreen(),
        ProfileScreen.routeName:(context) => ProfileScreen(),
        MyAccountScreen.routeName:(context) => MyAccountScreen(),
        MainScreen.routeName:(context) => MainScreen(),
        CategoryScreen.routeName:(context) => CategoryScreen(),
        DetailCtgScreen.routeName:(context) => DetailCtgScreen(),
        EmptyCart.routeName:(context) => EmptyCart(),
        EmptyFavorie.routeName:(context) => EmptyFavorie(),
        CommandeValide.routeName:(context) => CommandeValide(),
        PaymentScreen.routeName:(context) => PaymentScreen(),
        AddressScreen.routeName:(context) => AddressScreen(),
        FavorieScreen.routeName:(context) => FavorieScreen(),
        OrderScreen.routeName:(context) => OrderScreen(),
        OrderDetailScreen.routeName:(context) =>OrderDetailScreen(),
        AddressScreen.routeName:(context) =>AddressScreen(),
        NewAdresse.routeName:(context) =>NewAdresse(),
        SpecialScreen.routeName:(context) =>SpecialScreen(),

};