import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:game_store_app/constants.dart';
import 'package:game_store_app/services/firebase_services.dart';
import 'package:game_store_app/widgets/custom_actionbar.dart';
import 'package:game_store_app/widgets/image_slider.dart';
import 'package:game_store_app/widgets/product_size.dart';

class ProductPage extends StatefulWidget {
  static final String id = "product_screen";
  String productId;
  ProductPage({this.productId});
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  FirebaseServices _firebaseServices = FirebaseServices();

  String _selectedProductSize = "0";

  Future _addToCart() {
    return _firebaseServices.usersRef
        .doc(_firebaseServices.getUserId())
        .collection("cart")
        .doc(widget.productId)
        .set({
      "Size": _selectedProductSize,
    });
  }

  Future _saveToCart() {
    return _firebaseServices.usersRef
        .doc(_firebaseServices.getUserId())
        .collection("saved")
        .doc(widget.productId)
        .set({
      "Size": _selectedProductSize,
    });
  }

  final SnackBar _snackBar = SnackBar(content: Text('Product added to cart'));
  final SnackBar _snackBars = SnackBar(content: Text('Product Saved'));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        FutureBuilder(
          future: _firebaseServices.productsRef.doc(widget.productId).get(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Scaffold(
                body: Center(
                  child: Text('Error ${snapshot.error}'),
                ),
              );
            }
            if (snapshot.connectionState == ConnectionState.done) {
              Map<String, dynamic> documentData = snapshot.data.data();
              List imageList = documentData['images'];
              List productSizes = documentData['console'];
              _selectedProductSize = productSizes[0];
              return ListView(
                padding: EdgeInsets.all(0),
                children: [
                  ImageSlider(
                    imageList: imageList,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 24.0,
                      bottom: 1.0,
                      right: 24.0,
                      left: 24.0,
                    ),
                    child: Text(
                      "${documentData['name']}" ?? "Product Name",
                      style: Constants.boldHeading,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 4.0, horizontal: 24.0),
                    child: Text(
                      "\$${documentData['price']}" ?? "Price",
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Theme.of(context).accentColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 4.0,
                      horizontal: 24.0,
                    ),
                    child: Text(
                      "${documentData['desc']}" ?? "Description",
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 24.0,
                      horizontal: 24.0,
                    ),
                    child: Text(
                      'Select Console',
                      style: Constants.regularHeading,
                    ),
                  ),
                  ProductSize(
                    productSizes: productSizes,
                    onSelected: (size) {
                      _selectedProductSize = size;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            await _saveToCart();
                            Scaffold.of(context).showSnackBar(_snackBars);
                          },
                          child: Container(
                            width: 60.0,
                            height: 60.0,
                            decoration: BoxDecoration(
                              color: Color(0xFFDCDCDC),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            alignment: Alignment.center,
                            child: Image(
                              image: AssetImage('images/tab_saved.png'),
                              height: 22.0,
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              await _addToCart();
                              Scaffold.of(context).showSnackBar(_snackBar);
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                left: 16.0,
                              ),
                              height: 50.0,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                'Add to Cart',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              );
            }
            //loading state
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
        ),
        CustomActionBar(
          hasBackArrow: true,
          hasTitle: false,
        )
      ],
    ));
  }
}
