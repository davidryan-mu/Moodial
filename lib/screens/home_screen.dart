import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                left: 20.0,
                right: 20.0,
              ),
              child: Text(
                'Hey Ryan!',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentTab,
        onTap: (int value) {
          setState(() {
            _currentTab = value;
          });
        },
        items: [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(
              FeatherIcons.home,
              size: 33,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Stats',
            icon: Icon(
              FeatherIcons.barChart2,
              size: 33,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Calendar',
            icon: Icon(
              FeatherIcons.calendar,
              size: 33,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Settings',
            icon: Icon(
              FeatherIcons.settings,
              size: 33,
            ),
          ),
        ],
      ),
    );
  }
}
