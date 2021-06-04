import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:game_store_app/constants.dart';
import 'package:game_store_app/screens/product_screen.dart';

class ProductCart extends StatelessWidget {
  final Function onPressed;
  final String imageUrl;
  final String title;
  final String price;
  final String productId;
  ProductCart(
      {this.onPressed, this.imageUrl, this.title, this.price, this.productId});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 20.0),
        elevation: 4.0,
        color: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(24.0))),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  child: CachedNetworkImage(
                    placeholder: (context, url) =>
                        Image.asset("images/spinner.gif"),
                    imageUrl: "$imageUrl",
                    height: 200,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 8.0,
                    left: 8.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: Constants.regularHeading,
                      ),
                      Text(
                        price,
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).accentColor,
                        ),
                      )
                    ],
                  ),
                )
              ]),
        ),
      ),
    );
  }
}
