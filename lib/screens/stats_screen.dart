import 'package:Moodial/models/user.dart';
import 'package:Moodial/widgets/navbar.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';

class StatsScreen extends StatefulWidget {
  final User user;
  final Function navPosCallback;

  StatsScreen({
    this.user,
    this.navPosCallback,
  });

  @override
  _StatsScreenState createState() => _StatsScreenState(
        user: this.user,
        navPosCallback: this.navPosCallback,
      );
}

class _StatsScreenState extends State<StatsScreen> {
  int _currentTab = 1;
  User user;
  Function navPosCallback;

  _StatsScreenState({
    this.user,
    this.navPosCallback,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  FeatherIcons.bell,
                  color: Colors.white,
                ),
                onPressed: () => print('notif pressed'),
              )
            ],
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Text(
                  'Stats',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40.0,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: NavBar(
        currentTab: _currentTab,
        callback: navPosCallback,
      ),
    );
  }
}
