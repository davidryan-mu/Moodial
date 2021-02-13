import 'package:Moodial/api_service/api.dart';
import 'package:Moodial/models/user.dart';
import 'package:Moodial/widgets/home_screen/dial.dart';
import 'package:Moodial/widgets/home_screen/add_entry_button.dart';
import 'package:Moodial/widgets/home_screen/avatar.dart';
import 'package:Moodial/widgets/home_screen/recent_entry_card.dart';
import 'package:async/async.dart';
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
  int _dialState = 0;
  User user;

  AsyncMemoizer _memoizer = AsyncMemoizer();

  _HomeScreenState({
    this.user,
  });

  dialCallback(dialState) {
    setState(() {
      _dialState = dialState;
    });
  }

  _fetchLastEntry() {
    return this._memoizer.runOnce(() async {
      return ApiService.getEntry(user.userToken);
    });
  }

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
                Padding(
                  padding: const EdgeInsets.fromLTRB(15.0, 15.0, 0.0, 0.0),
                  child: Text(
                    user.username != null
                        ? 'Welcome back, ' + user.username + '!'
                        : 'Welcome to Moodial!',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30.0,
                    ),
                  ),
                ),
                Avatar(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Text('How are you feeling right now?'),
                ),
                Dial(
                  callback: this.dialCallback,
                ),
                AddEntryButton(
                  dialState: this._dialState,
                  key: UniqueKey(),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Text('Recent Entries',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                FutureBuilder(
                  future: _fetchLastEntry(),
                  builder: (context, snapshot) {
                    final entry = snapshot.data;
                    if (snapshot.connectionState == ConnectionState.done &&
                        snapshot.data != null) {
                      return RecentEntryCard(
                        entry: entry,
                      );
                    } else if (snapshot.connectionState ==
                            ConnectionState.done &&
                        snapshot.data == null) {
                      return Padding(
                        padding: EdgeInsets.fromLTRB(15.0, 5.0, 0, 0),
                        child: Text(
                            'Add your first entry to see recent entries here!'),
                      );
                    } else if (snapshot.hasError) {
                      return Padding(
                        padding: EdgeInsets.fromLTRB(15.0, 5.0, 0, 0),
                        child: Text('Error: ' + snapshot.error.toString()),
                      );
                    }
                    return Center(child: CircularProgressIndicator());
                  },
                )
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
