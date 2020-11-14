import 'package:Moodial/models/activity.dart';

class Entry {
  String mood;
  String date;
  String time;
  List<Activity> linkedActivities;
  String notes;

  Entry({
    this.mood,
    this.date,
    this.linkedActivities,
    this.notes,
  });
}

List<Activity> linkedActivities = [
  Activity(
    imageUrl: 'testlink.jpg',
    name: 'music',
  ),
  Activity(
    imageUrl: 'testlink.jpg',
    name: 'jogging',
  ),
  Activity(
    imageUrl: 'testlink.jpg',
    name: 'friends',
  ),
];
