import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:game_store_app/constants.dart';
import 'package:game_store_app/services/firebase_services.dart';
import 'package:game_store_app/tabs/home_tab.dart';
import 'package:game_store_app/tabs/saved_tab.dart';
import 'package:game_store_app/tabs/search_tab.dart';
import 'package:game_store_app/widgets/bottom_tabs.dart';

class HomeScreen extends StatefulWidget {
  static final String id = "home_screen";
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController _pageController;
  int _selectedTab = 0;
  FirebaseServices _firebaseServices = FirebaseServices();
  @override
  void initState() {
    // print("User ID:  ${_firebaseServices.getUserId()}");
    _pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
            child: Expanded(
          child: PageView(
            controller: _pageController,
            onPageChanged: (num) {
              setState(() {
                _selectedTab = num;
              });
            },
            children: [
              HomeTab(),
              SearchTab(),
              SavedTab(),
            ],
          ),
        )),
        BottomTabs(
          selectedTab: _selectedTab,
          clicked: (num) {
            setState(() {
              _pageController.animateToPage(
                num,
                duration: Duration(milliseconds: 300),
                curve: Curves.easeOutCubic,
              );
            });
          },
        ),
      ],
    ));
  }
}
