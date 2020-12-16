import 'package:Moodial/widgets/landing_screen/login_form.dart';
import 'package:flutter/material.dart';

class LandingScreen extends StatefulWidget {
  final Function callback;
  final bool isLoggedIn;

  LandingScreen({this.isLoggedIn, this.callback});

  @override
  _LandingScreenState createState() =>
      _LandingScreenState(callback: this.callback, isLoggedIn: this.isLoggedIn);
}

class _LandingScreenState extends State<LandingScreen> {
  Function callback;
  bool isLoggedIn;
  _LandingScreenState({this.callback, this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text(
              'Login or Sign Up',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 30.0,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                LoginForm(
                  callback: this.callback,
                  isLoggedIn: this.isLoggedIn,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
