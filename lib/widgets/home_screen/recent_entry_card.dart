import 'package:flutter/material.dart';

class RecentEntryCard extends StatefulWidget {
  @override
  _RecentEntryCardState createState() => _RecentEntryCardState();
}

class _RecentEntryCardState extends State<RecentEntryCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () => print('card tapped'),
        child: Container(
          width: 300,
          height: 100,
        ),
      ),
    );
  }
}
