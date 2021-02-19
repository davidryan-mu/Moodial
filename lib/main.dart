import 'package:Moodial/screens/home_screen.dart';
import 'package:Moodial/screens/landing_screen.dart';
import 'package:Moodial/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'models/user.dart';

void main() => runApp(Moodial());

class Moodial extends StatefulWidget {
  @override
  _MoodialState createState() => _MoodialState();
}

class _MoodialState extends State<Moodial> {
  bool _isLoggedIn = false;
  User _user;
  int _navPos = 0;

  landingCallback(isLoggedIn, user) {
    setState(() {
      _isLoggedIn = isLoggedIn;
      _user = user;
    });
  }

  navPosCallback(navPos) {
    setState(() {
      _navPos = navPos;
    });
  }

  logOutCallback() {
    setState(() {
      _isLoggedIn = false;
    });
  }

  buildScreenOnNav(_navPos) {
    switch (_navPos) {
      case 0:
        return HomeScreen(
          user: this._user,
          navPosCallback: this.navPosCallback,
        );
      case 1:
        return Text('stats');
      case 2:
        return Text('calendar');
      case 3:
        return SettingsScreen(
          user: this._user,
          navPosCallback: this.navPosCallback,
          logOutCallback: this.logOutCallback,
        );
      default:
        return HomeScreen(
          user: this._user,
          navPosCallback: this.navPosCallback,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Moodial',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF71E9A2),
        scaffoldBackgroundColor: Color(0xFFFEFEFE),
        textTheme: GoogleFonts.montserratTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: _isLoggedIn
          ? buildScreenOnNav(_navPos)
          : LandingScreen(
              callback: this.landingCallback,
              isLoggedIn: this._isLoggedIn,
              user: this._user,
            ),
    );
  }
}
