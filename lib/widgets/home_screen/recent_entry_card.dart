import 'package:flutter/material.dart';
import 'package:Moodial/api_service/api.dart';

class RecentEntryCard extends StatefulWidget {
  @override
  _RecentEntryCardState createState() => _RecentEntryCardState();
}

class _RecentEntryCardState extends State<RecentEntryCard> {
  String username = 'david';
  String password = 'abc123';

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () => print('card tapped'),
        child: Container(
          width: 300,
          height: 100,
          child: FutureBuilder(
            future: ApiService.login(username, password),
            builder: (context, snapshot) {
              final user = snapshot.data;
              if (snapshot.connectionState == ConnectionState.done) {
                return Text(user.loginStatus);
              } else if (snapshot.hasError) {
                return Text('Error');
              }
              return Center(
                child: CircularProgressIndicator(), //loading
              );
            },
          ),
        ),
      ),
    );
  }
}
