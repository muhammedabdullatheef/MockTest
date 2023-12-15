
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mocktest/HomeScreen.dart';
import 'package:mocktest/UserProfile.dart';

import 'MenuScreen.dart';

class UserBottomNav extends StatefulWidget {
  const UserBottomNav({super.key});

  @override
  State<UserBottomNav> createState() => _UserBottomNavState();
}

class _UserBottomNavState extends State<UserBottomNav> {
  int currentIndex = 1;
  late PageController _PageView;
   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _PageView = PageController(
      initialPage: currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.menu,
                size: 30,
                color: Colors.black38,
              ),
              label: ""),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home_filled,
                size: 30,
                color: Colors.black38,
              ),
              label: ""),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.account_circle,
                size: 30,
                color: Colors.black38,
              ),
              label: ""),
        ],
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
            _PageView.jumpToPage(index);
          });
        },
      ),
      body: PageView(
        controller: _PageView,
        children: [
          MenuScreen(),
          HomeScreen(),
          UserProfiled()
        ],
      ),
    );
  }
}
