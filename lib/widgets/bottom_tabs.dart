import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:game_store_app/screens/login_screen.dart';

class BottomTabs extends StatefulWidget {
  final int selectedTab;
  BottomTabs({this.selectedTab, this.clicked});
  final Function(int) clicked;
  @override
  _BottomTabsState createState() => _BottomTabsState();
}

class _BottomTabsState extends State<BottomTabs> {
  int _selectedTab = 0;
  User _user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    _selectedTab = widget.selectedTab ?? 0;
    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black87.withOpacity(0.05),
                spreadRadius: 1.0,
                blurRadius: 5.0,
              ),
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BottomTabBtn(
              imagePath: 'images/tab_home.png',
              selected: _selectedTab == 0 ? true : false,
              onPressed: () {
                widget.clicked(0);
              },
            ),
            BottomTabBtn(
              imagePath: 'images/tab_search.png',
              selected: _selectedTab == 1 ? true : false,
              onPressed: () {
                widget.clicked(1);
              },
            ),
            BottomTabBtn(
              imagePath: 'images/tab_saved.png',
              selected: _selectedTab == 2 ? true : false,
              onPressed: () {
                widget.clicked(2);
              },
            ),
            BottomTabBtn(
              imagePath: 'images/tab_logout.png',
              selected: _selectedTab == 3 ? true : false,
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
            ),
          ],
        ));
  }
}

class BottomTabBtn extends StatelessWidget {
  final String imagePath;
  final bool selected;
  final Function onPressed;
  BottomTabBtn({this.imagePath, this.selected, this.onPressed});
  @override
  Widget build(BuildContext context) {
    bool _selectedTab = selected ?? false;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 20.0,
          horizontal: 10.0,
        ),
        decoration: BoxDecoration(
            border: Border(
                top: BorderSide(
          color:
              _selectedTab ? Theme.of(context).accentColor : Colors.transparent,
          width: 2.0,
        ))),
        child: Image(
          image: AssetImage(
            imagePath ?? 'images/tab_home.png',
          ),
          width: 22.0,
          height: 22.0,
          color: _selectedTab ? Theme.of(context).accentColor : Colors.black,
        ),
      ),
    );
  }
}
