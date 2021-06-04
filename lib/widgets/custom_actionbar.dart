import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:game_store_app/constants.dart';
import 'package:game_store_app/screens/cart_screen.dart';
import 'package:game_store_app/services/firebase_services.dart';

class CustomActionBar extends StatelessWidget {
  final String title;
  final bool hasBackArrow;
  final hasTitle;
  final bool hasBackgroundColor;
  CustomActionBar(
      {this.title, this.hasBackArrow, this.hasTitle, this.hasBackgroundColor});
  FirebaseServices _firebaseServices = FirebaseServices();
  final CollectionReference _usersRef =
      FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    bool _hasBackArrow = hasBackArrow ?? false;
    bool _hasTitle = hasTitle ?? true;
    bool _hasBackgroundolor = hasBackgroundColor ?? true;
    return Container(
      decoration: BoxDecoration(
          gradient: _hasBackgroundolor
              ? LinearGradient(
                  colors: [
                    Colors.white,
                    Colors.white.withOpacity(0),
                  ],
                  begin: Alignment(0, 0),
                  end: Alignment(0, 1),
                )
              : null),
      padding: EdgeInsets.only(
        top: 56.0,
        left: 24.0,
        right: 24.0,
        bottom: 24.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (_hasBackArrow)
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: 42.0,
                height: 42.0,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                alignment: Alignment.center,
                child: Image(
                  image: AssetImage('images/back_arrow.png'),
                  width: 10,
                  height: 10.0,
                ),
              ),
            ),
          if (_hasTitle)
            Text(
              title ?? 'Action Bar',
              style: Constants.boldHeading,
            ),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacementNamed(context, CartScreen.id);
            },
            child: Container(
                width: 42.0,
                height: 42.0,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                alignment: Alignment.center,
                child: StreamBuilder<QuerySnapshot>(
                  stream: _usersRef
                      .doc(_firebaseServices.getUserId())
                      .collection('cart')
                      .snapshots(),
                  builder: (context, snapshot) {
                    int _totalItems = 0;
                    if (snapshot.connectionState == ConnectionState.active) {
                      List _documents = snapshot.data.docs;
                      _totalItems = _documents.length;
                    }
                    return Text(
                      '$_totalItems' ?? '0',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    );
                  },
                )),
          )
        ],
      ),
    );
  }
}
