import 'package:flutter/material.dart';

class ImageSlider extends StatefulWidget {
  final imageList;
  ImageSlider({this.imageList});
  @override
  _ImageSliderState createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  int _selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280.0,
      child: Stack(
        children: [
          PageView(
            onPageChanged: (num) {
              setState(() {
                _selectedPage = num;
              });
            },
            children: [
              for (var i = 0; i < widget.imageList.length; i++)
                Container(
                  child: Image.network(
                    "${widget.imageList[i]}",
                  ),
                ),
            ],
          ),
          Positioned(
            bottom: 20.0,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var i = 0; i < widget.imageList.length; i++)
                  AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeOutCubic,
                    margin: EdgeInsets.symmetric(
                      horizontal: 5.0,
                    ),
                    width: _selectedPage == i ? 25.0 : 10.0,
                    height: 12.0,
                    decoration: BoxDecoration(
                      color: Theme.of(context).accentColor.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
