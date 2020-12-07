import 'package:flutter/material.dart';
import 'package:Moodial/api_service/api.dart';

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
          child: FutureBuilder(
            future: ApiService.login(),
            builder: (context, snapshot) {
              final response = snapshot.data;
              if (snapshot.connectionState == ConnectionState.done) {
                return Text(response['msg']);
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
