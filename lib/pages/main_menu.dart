import "package:flutter/material.dart";
import 'package:sanalira_test/pages/top_up/topup.dart';
import 'package:sanalira_test/utility/colors.dart';

import '../utility/custom_icons.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  int _selectedIndex = 3;
  static const List<Widget> _pages = <Widget>[
    Tab(icon: Icon(CustomIcons.customHome)),
    Tab(
        icon: Icon(
      CustomIcons.customTransactions,
      color: Colors.black,
    )),
    Tab(icon: Icon(CustomIcons.customMenu)),
    TopUpMenu(),
    Tab(icon: Icon(CustomIcons.customUser)),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _pages.elementAt(_selectedIndex), //New
      ),
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: sanaLiraGreen,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          unselectedItemColor: Colors.grey,
          backgroundColor: Colors.white,
          elevation: 0,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(CustomIcons.customHome), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(CustomIcons.customTransactions), label: "xd"),
            BottomNavigationBarItem(
                icon: Container(
                    decoration: const BoxDecoration(
                      color: navigationMenuColor,
                      shape: BoxShape.circle,
                    ),
                    height: 56,
                    width: 56,
                    child: Icon(
                      CustomIcons.customMenu,
                      color: Colors.white,
                    )),
                label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(CustomIcons.customCard), label: "dd"),
            BottomNavigationBarItem(
                icon: Icon(CustomIcons.customUser), label: "dd")
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped),
    );
  }
}
