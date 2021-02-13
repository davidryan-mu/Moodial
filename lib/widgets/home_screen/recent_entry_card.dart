import 'package:Moodial/models/entry.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RecentEntryCard extends StatefulWidget {
  final Entry entry;

  RecentEntryCard({this.entry});

  @override
  _RecentEntryCardState createState() => _RecentEntryCardState(
        entry: this.entry,
      );
}

class _RecentEntryCardState extends State<RecentEntryCard> {
  Entry entry;
  DateFormat dateFormat = DateFormat('yyyy-MM-dd');

  _RecentEntryCardState({this.entry});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: InkWell(
        onTap: () => print('card tapped'),
        child: Container(
          width: 300,
          height: 130,
          child: Column(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 5.0, 0, 0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Mood ' + entry.mood.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25.0,
                            ),
                          ),
                          Text(
                            DateFormat('dd-MM-yyyy')
                                .format(dateFormat.parse(entry.date)),
                          ),
                          SizedBox(height: 20.0),
                          TextButton.icon(
                            onPressed: () {
                              print('edit pressed');
                            },
                            label: Text(
                              'View/Edit',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor),
                            ),
                            icon: Icon(
                              FeatherIcons.edit,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Medication:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(entry.medication.name +
                              ' - ' +
                              entry.medication.dose),
                          SizedBox(
                            height: 15.0,
                          ),
                          Text(
                            'Diet:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(entry.diet.food + ' - ' + entry.diet.amount),
                        ],
                      ),
                    ),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
