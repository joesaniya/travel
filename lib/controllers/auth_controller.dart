import 'dart:developer';

import 'package:hotel_travel/services/auth_service.dart';

class AuthController {
  Future register(String name, String email, int countryid, String phoneNumber,
      String Password) async {
    try {
      var data = await AuthService()
          .register(name, email, countryid, phoneNumber, Password);
      if (data != null) {
        log(data);
      }
    } catch (e) {
      rethrow;
    }
  }
}
