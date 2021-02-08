class User {
  final String loginStatus;
  final String userToken;
  String username;

  User({
    this.loginStatus,
    this.userToken,
    this.username,
  });

  // ignore: empty_constructor_bodies
  factory User.fromJSON(Map<String, dynamic> json) {
    return User(
      loginStatus: json['message'],
      userToken: json['JWT'],
    );
  }
}
