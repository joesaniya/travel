import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

class AuthService {
  Future register(
      String name,
      String email,
      // int countryid,
      String countryid,
      String phoneNumber,
      String Password) async {
    try {
      var body = {
        "name": name,
        "email": email,
        "password": Password,
        // "country": countryid.toString(),
        "country": countryid,
        "phoneNumber": phoneNumber
      };
      var response = await http.post(
          Uri.parse(
            'https://a.walletbot.online/api/v1/users/signup',
          ),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(body));
      if (response.statusCode == 200) {
        return response.body;
      } else {
        var jsondata = jsonDecode(response.body);
        log(jsondata['error']);
      }
    } catch (e) {
      rethrow;
    }
  }

  //login
  Future login(String email, String Password) async {
    try {
      var body = {
        "email": email,
        "password": Password,
        // "country": countryid.toString(),
      };
      var response = await http.post(
          Uri.parse(
            'https://a.walletbot.online/api/v1/users/signup',
          ),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(body));
      if (response.statusCode == 200) {
        return response.body;
      } else {
        var jsondata = jsonDecode(response.body);
        log(jsondata['error']);
      }
    } catch (e) {
      rethrow;
    }
  }
}
