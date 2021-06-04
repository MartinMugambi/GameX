import 'package:flutter/material.dart';
import 'package:game_store_app/screens/cart_screen.dart';
import 'package:game_store_app/screens/home_screen.dart';
import 'package:game_store_app/screens/landing_screen.dart';
import 'package:game_store_app/screens/login_screen.dart';
import 'package:game_store_app/screens/product_screen.dart';
import 'package:game_store_app/screens/register_screen.dart';
import 'package:game_store_app/screens/splash_screen.dart';
import 'package:game_store_app/tabs/saved_tab.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
        accentColor: Color(0xFFFF1E00),
      ),
      home: LandingPage(),
      routes: {
        LoginScreen.id: (context) => LoginScreen(),
        RegisterScreen.id: (context) => RegisterScreen(),
        ProductPage.id: (context) => ProductPage(),
        CartScreen.id: (context) => CartScreen(),
        SavedTab.id: (context) => CartScreen(),
        HomeScreen.id: (context) => HomeScreen(),
      },
    );
  }
}
