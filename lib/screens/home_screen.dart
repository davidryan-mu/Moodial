import 'package:Moodial/api_service/api.dart';
import 'package:Moodial/models/user.dart';
import 'package:Moodial/widgets/home_screen/dial.dart';
import 'package:Moodial/widgets/home_screen/add_entry_button.dart';
import 'package:Moodial/widgets/home_screen/avatar.dart';
import 'package:Moodial/widgets/home_screen/recent_entry_card.dart';
import 'package:Moodial/widgets/navbar.dart';
import 'package:async/async.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final User user;
  final Function navPosCallback;

  HomeScreen({
    this.user,
    this.navPosCallback,
  });

  @override
  _HomeScreenState createState() => _HomeScreenState(
        user: this.user,
        navPosCallback: this.navPosCallback,
      );
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentTab = 0;
  int _dialState = 1;
  bool _firstLoadFlag = true;
  User user;
  Function navPosCallback;

  AsyncMemoizer _memoizer = AsyncMemoizer();

  _HomeScreenState({
    this.user,
    this.navPosCallback,
  });

  dialCallback(dialState) {
    setState(() {
      _dialState = dialState;
    });
  }

  modalCallback(flag) {
    setState(() {
      _firstLoadFlag = flag;
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
                        ? 'Good to see you, ' + user.username + '!'
                        : 'Welcome to Moodial!',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30.0,
                    ),
                  ),
                ),
                Avatar(user: user),
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
                  userToken: this.user.userToken,
                  callback: this.modalCallback,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15.0, 10.0, 0, 0),
                  child: Text('Recent Entries',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                FutureBuilder(
                  future: _firstLoadFlag
                      ? _fetchLastEntry()
                      : ApiService.getEntry(user.userToken),
                  builder: (context, snapshot) {
                    final entry = snapshot.data;
                    if (snapshot.connectionState == ConnectionState.done &&
                        snapshot.data != null) {
                      return RecentEntryCard(
                        entry: entry,
                        userToken: user.userToken,
                        callback: this.modalCallback,
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
      bottomNavigationBar: NavBar(
        currentTab: _currentTab,
        callback: navPosCallback,
      ),
    );
  }
}
