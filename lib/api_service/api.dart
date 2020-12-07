import 'dart:convert';

import 'package:http/http.dart' as http;

class URLS {
  static const String BASE_URL = 'http://10.0.2.2:5000';
}

class ApiService {
  static Future login() async {
    final response = await http.get('${URLS.BASE_URL}/entry');
    if (response.statusCode == 401) {
      return json.decode(response.body);
    } else {
      return null;
    }
  }
}
