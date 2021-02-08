import 'package:Moodial/screens/home_screen.dart';
import 'package:Moodial/screens/landing_screen.dart';
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

  callback(isLoggedIn, user) {
    setState(() {
      _isLoggedIn = isLoggedIn;
      _user = user;
    });
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
          ? HomeScreen(
              user: this._user,
            )
          : LandingScreen(
              callback: this.callback,
              isLoggedIn: this._isLoggedIn,
              user: this._user,
            ),
    );
  }
}
