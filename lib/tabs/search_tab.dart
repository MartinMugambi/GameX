import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:game_store_app/constants.dart';
import 'package:game_store_app/screens/product_screen.dart';
import 'package:game_store_app/services/firebase_services.dart';
import 'package:game_store_app/widgets/custom_actionbar.dart';
import 'package:game_store_app/widgets/custom_input.dart';
import 'package:game_store_app/widgets/product_cart.dart';

class SearchTab extends StatefulWidget {
  @override
  _SearchTabState createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  FirebaseServices _firebaseServices = FirebaseServices();
  String _searchString = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      body: Container(
        child: Stack(
          children: [
            if (_searchString.isEmpty)
              Center(
                child: Container(
                  child: Text(
                    'Search Results',
                    style: Constants.regularHeading,
                  ),
                ),
              )
            else
              FutureBuilder<QuerySnapshot>(
                future: _firebaseServices.productsRef
                    .orderBy("search_string")
                    .startAt([_searchString]).endAt(
                        ["$_searchString\uf8ff"]).get(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Scaffold(
                      body: Center(
                        child: Text("Error: ${snapshot.error}"),
                      ),
                    );
                  }

                  //displaying data from database
                  if (snapshot.connectionState == ConnectionState.done) {
                    // display a list of data inside the database
                    return ListView(
                      padding: EdgeInsets.only(
                        top: 108.0,
                        bottom: 12.0,
                      ),
                      children: snapshot.data.docs.map((document) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ProductCart(
                            title: document.data()['name'],
                            imageUrl: document.data()['images'][0],
                            price: "\$${document.data()['price']}",
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProductPage(
                                            productId: document.id,
                                          )));
                            },
                          ),
                        );
                      }).toList(),
                    );
                  }
                  SizedBox(
                    height: 30.0,
                  );
                  return Scaffold(
                    body: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                },
              ),
            Padding(
              padding: EdgeInsets.only(
                top: 45.0,
              ),
              child: CustomInput(
                hintText: 'Search Games',
                onSubmitted: (value) {
                  setState(() {
                    _searchString = value.toLowerCase();
                  });
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
