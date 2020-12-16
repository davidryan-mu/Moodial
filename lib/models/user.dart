class User {
  final String loginStatus;
  final String userToken;

  User({this.loginStatus, this.userToken});

  // ignore: empty_constructor_bodies
  factory User.fromJSON(Map<String, dynamic> json) {
    return User(
      loginStatus: json['message'],
      userToken: json['JWT'],
    );
  }
}
