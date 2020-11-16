import 'package:Moodial/widgets/dial.dart';
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
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text('Hey Ryan!'),
            // Allows the user to reveal the app bar if they begin scrolling back
            // up the list of items.
            floating: true,
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                CircleAvatar(
                  radius: 50.0,
                  backgroundImage: NetworkImage(
                    'https://static.wikia.nocookie.net/avatar/images/7/79/Pilot_-_Aang.png/revision/latest/top-crop/width/360/height/360?cb=20120311133235',
                  ),
                ),
                Text('How are you feeling right now?'),
                Dial(),
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
