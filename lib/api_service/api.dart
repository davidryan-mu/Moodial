import 'dart:convert';
import '../models/user.dart';
import 'package:http/http.dart' as http;

class URLS {
  static const String BASE_URL = 'http://10.0.2.2:5000';
}

class ApiService {
  static Future<User> login(username, password) async {
    final response = await http.post(
      '${URLS.BASE_URL}/login',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
      }),
    );
    if (response.statusCode == 200) {
      //Successful log in

      return User.fromJSON(jsonDecode(response.body));
    } else if (response.statusCode == 401) {
      //Invalid username/password
      return User.fromJSON(jsonDecode(response.body));
    } else {
      throw Exception('Failed to log in due to server error.');
    }
  }

  static Future<int> register(username, email, password) async {
    final response = await http.post(
      '${URLS.BASE_URL}/register',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'email': email,
        'password': password,
      }),
    );
    if (response.statusCode == 201) {
      //Successful registration
      return 201;
    } else if (response.statusCode == 400) {
      // Error message
      return 400;
    } else {
      return 404;
    }
  }
}
