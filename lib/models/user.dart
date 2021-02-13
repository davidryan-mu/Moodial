import 'package:Moodial/models/entry.dart';

class User {
  final String loginStatus;
  final String userToken;
  String username;
  Entry lastEntry;

  User({
    this.loginStatus,
    this.userToken,
    this.username,
    this.lastEntry,
  });

  // ignore: empty_constructor_bodies
  factory User.fromJSON(Map<String, dynamic> json) {
    return User(
      loginStatus: json['message'],
      userToken: json['JWT'],
    );
  }
}
