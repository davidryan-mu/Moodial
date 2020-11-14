import 'package:Moodial/screens/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Moodial',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF71E9A1),
        scaffoldBackgroundColor: Color(0xFFFEFEFE),
      ),
      home: HomeScreen(),
    );
  }
}
