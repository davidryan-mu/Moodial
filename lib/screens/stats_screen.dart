import 'package:Moodial/dummy_entries.dart';
import 'package:Moodial/models/entry.dart';
import 'package:Moodial/models/user.dart';
import 'package:Moodial/widgets/navbar.dart';
import 'package:Moodial/widgets/stats_screen/mood_history_chart.dart';
import 'package:Moodial/widgets/stats_screen/sleep_iritability_chart.dart';
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

  List<Entry> dummyEntries = DummyEntries.getList().list;

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
                Padding(
                  padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Statistics',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30.0,
                          ),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text('How you\'ve felt this week:'),
                              ),
                              Container(
                                width: double.infinity,
                                height: 200,
                                child: MoodHistoryChart(dummyEntries),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                    'Your sleep compared to your iritability:'),
                              ),
                              Container(
                                width: double.infinity,
                                height: 200,
                                child: SleepIritabilityChart(dummyEntries),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
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
