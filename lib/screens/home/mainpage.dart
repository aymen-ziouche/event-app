import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:event_app/providers/reservationsProvider.dart';
import 'package:event_app/screens/home/homepage.dart';
import 'package:event_app/screens/home/reservationspage.dart';
import 'package:event_app/screens/home/searchpage.dart';
import 'package:event_app/screens/profile/profilepage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});
  static String id = "MainPage";

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  void _getCurrentpage(value) async {
    switch (value) {
      case 0:
        setState(() {
          _bottomNavIndex = value;
          _child = const HomePage();
        });
        break;
      case 1:
        setState(() {
          _bottomNavIndex = value;
          _child = ChangeNotifierProvider(
              create: (_) => ReservationsProvider(),
              child: const ReservationsPage());
        });
        break;
      case 2:
        setState(() {
          _bottomNavIndex = value;
          _child = const SearchPage();
        });
        break;
      case 3:
        setState(() {
          _bottomNavIndex = value;
          _child = ProfilePage();
        });
        break;
    }
  }

  Widget _child = const HomePage();

  var iconList = <IconData>[
    FontAwesomeIcons.house,
    FontAwesomeIcons.clockRotateLeft,
    FontAwesomeIcons.magnifyingGlass,
    FontAwesomeIcons.solidUser,
  ];

  var _bottomNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _child,
        bottomNavigationBar: AnimatedBottomNavigationBar(
          gapLocation: GapLocation.center,
          gapWidth: 0.0,
          backgroundColor: Colors.white,
          activeColor: Colors.indigo,
          inactiveColor: Colors.black38,
          height: 60,
          icons: iconList,
          activeIndex: _bottomNavIndex,
          onTap: (value) {
            _getCurrentpage(value);
          },
        ),
      ),
    );
  }
}
