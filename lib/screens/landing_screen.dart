import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:game_store_app/screens/home_screen.dart';
import 'package:game_store_app/screens/login_screen.dart';
import 'package:game_store_app/screens/splash_screen.dart';

import '../constants.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text('Error ${snapshot.error}'),
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, streamSnapshot) {
              if (streamSnapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text('Error:  ${streamSnapshot.error}'),
                  ),
                );
              }
              //checking if connection state is active
              if (streamSnapshot.connectionState == ConnectionState.active) {
                // getting the user data
                User _user = streamSnapshot.data;
                if (_user == null) {
                  return LoginScreen();
                } else {
                  return HomeScreen();
                }
              }
              return CircularProgressIndicator();
            },
          );
        }
        return CircularProgressIndicator();
      },
    );
  }
}
