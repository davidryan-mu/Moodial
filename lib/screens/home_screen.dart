import 'package:Moodial/models/user.dart';
import 'package:Moodial/widgets/home_screen/dial.dart';
import 'package:Moodial/widgets/home_screen/add_entry_button.dart';
import 'package:Moodial/widgets/home_screen/avatar.dart';
import 'package:Moodial/widgets/home_screen/recent_entry_card.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final User user;

  HomeScreen({
    this.user,
  });

  @override
  _HomeScreenState createState() => _HomeScreenState(
        user: this.user,
      );
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentTab = 0;
  User user;

  _HomeScreenState({
    this.user,
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
                onPressed: () => print(user.username),
              )
            ],
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 15.0, 0.0, 0.0),
                  child: Text(
                    user.username != '' ? 'Hey ' + user.username + '!' : 'Hey!',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30.0,
                    ),
                  ),
                ),
                Avatar(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text('How are you feeling right now?'),
                ),
                Dial(),
                AddEntryButton(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text('Recent Entries'),
                ),
                RecentEntryCard(),
              ],
            ),
          )
        ],
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
