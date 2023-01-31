import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../models/Country_modal.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  // var jsonResponse;
  // late LoginModal Logindata;
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
      log(body.toString());
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

  void saveToken(data) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("token", data['token']);
    sharedPreferences.setInt("userId", data['userId']);
  }

  // //login
  // Future login(String email, String Password) async {
  //   try {
  //     var body = {
  //       "email": email,
  //       "password": Password,
  //       // "country": countryid.toString(),
  //     };
  //     var response = await http.post(
  //         Uri.parse(
  //           'https://a.walletbot.online/api/v1/users/login',
  //         ),
  //         headers: {'Content-Type': 'application/json'},
  //         body: jsonEncode(body));
  //     if (response.statusCode == 200) {
  //       //todo
  //       Logindata = convert.jsonDecode(response.body);
  //       Logindata = LoginModal.fromJson(jsonResponse);
  //       log("Token: ${Logindata.jwtToken}");
  //       SharedPreferences prefs = await SharedPreferences.getInstance();
  //       prefs.setString(AppConstants.KEY_ACCESS_TOKEN, Logindata.jwtToken);

  //       return Logindata;
  //       //
  //       // return response.body;
  //     }
  //     //  else if (response.statusCode == 400) {
  //     //   log('else if');
  //     //   return response.body;
  //     // }

  //     else {
  //       var jsondata = jsonDecode(response.body);
  //       log(jsondata['error']);
  //     }
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

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
            'https://a.walletbot.online/api/v1/users/login',
          ),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(body));
      if (response.statusCode == 200) {
        return response.body;

        // //todo
        // var body = jsonDecode(response.body);
        // // print(body);
        // var data = body['user'];
        // // print(data);
        // LoginModal loginuser = LoginModal.fromJson(data);
        // log(loginuser.jwtToken);
        // log('jwttoken');
        // await _saveUser(int.parse(loginuser.jwtToken).toString());
        // // await _saveUser(int.parse(loginuser.jwtToken), loginuser.user);
        // return loginuser;
      }
      //  else if (response.statusCode == 400) {
      //   log('else if');
      //   return response.body;
      // }

      else {
        var jsondata = jsonDecode(response.body);
        log(jsondata['error']);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _saveUser(String accessToken) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // sharedPreferences.setInt('id', id);
    sharedPreferences.setString('access_token', accessToken);
  }

  //getcountry

  Future<CountryModal?> getCountry() async {
    try {
      var response = await http.get(
        Uri.parse(
          'https://a.walletbot.online/api/v1/home/initial-data',
        ),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        log(response.body);
        return countryModalFromJson(response.body);
      } else {
        var jsondata = jsonDecode(response.body);
        log(jsondata['error']);
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List?> countryget() async {
    const standardUrl = 'https://a.walletbot.online/api/v1/home/initial-data';
    final response = await http.get(Uri.parse(standardUrl));
    if (response.statusCode == 200) {
      final standardData = countryModalFromJson(response.body);
      final List<Country?>? standards = standardData!.countries;
      return standards;
    } else {
      return <Country>[];
    }
  }
}
