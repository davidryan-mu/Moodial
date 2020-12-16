import 'package:Moodial/screens/home_screen.dart';
import 'package:Moodial/screens/landing_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(Moodial());

class Moodial extends StatefulWidget {
  @override
  _MoodialState createState() => _MoodialState();
}

class _MoodialState extends State<Moodial> {
  bool _isLoggedIn = false;

  callback(value) {
    setState(() {
      _isLoggedIn = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Moodial',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF71E9A1),
        scaffoldBackgroundColor: Color(0xFFFEFEFE),
        textTheme: GoogleFonts.montserratTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: _isLoggedIn
          ? HomeScreen()
          : LandingScreen(
              callback: this.callback,
              isLoggedIn: this._isLoggedIn,
            ),
    );
  }
}
