import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:zerowaste/services/HomeController.dart';
import 'package:zerowaste/views/FirstPage.dart';
import 'package:zerowaste/views/ForgotPassword.dart';
import 'package:zerowaste/views/Home.dart';
import 'package:zerowaste/views/HomeComponents/PlaceOrder/billing.dart';
import 'package:zerowaste/views/HomeComponents/PlaceOrder/endOfOrder.dart';
import 'package:zerowaste/views/HomeComponents/PlaceOrder/placeOrder.dart';
import 'package:zerowaste/views/HomeComponents/ProductDetails/details_screen.dart';
import 'package:zerowaste/views/HomeComponents/location.dart';
import 'package:zerowaste/views/HomeComponents/sidebar/sidebar_layout.dart';
import 'package:zerowaste/views/SignUp.dart';
import 'package:zerowaste/views/Login.dart';
import 'package:zerowaste/views/VerifyEmail.dart';
import 'package:zerowaste/views/Welcome.dart';
import 'package:zerowaste/views/SliderTile.dart';
import 'package:zerowaste/views/phoneAuth.dart';
import 'package:zerowaste/widgets/provider_widget.dart';
import 'package:zerowaste/services/Authentication.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AuthProvider(
      auth: AuthService(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: <String, WidgetBuilder>{
          '/': (context) => FirstPage(),
          '/home': (BuildContext context) => Home(),
          '/homecontroller': (BuildContext context) => HomeController(),
          '/SliderTile': (context) => SliderTile(),
          '/Login': (context) => Login(),
          '/SignUp': (context) => SignUp(),
          '/Welcome': (context) => Welcome(),
          '/verifyEmail': (context) => VerifyEmail(),
          '/ForgotPassword': (context) => ForgotPassword(),
          '/SideBarLayout': (context) => SideBarLayout(),
          '/billing': (context) => Billing(),
          '/placeOrder': (context) => PlaceOrder(),
          '/endOfOrder': (context) => EndOfOrder(),
          '/phoneAuth': (context) => PhoneAuth(),
          '/location': (context) => Location(),
          '/detailsScreen': (context) => DetailsScreen(),
        },
      ),
    );
  }
}
