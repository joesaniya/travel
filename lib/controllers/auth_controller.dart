import 'dart:developer';

import 'package:hotel_travel/models/Country_modal.dart';
import 'package:hotel_travel/services/auth_service.dart';

class AuthController {
  Future register(
      String name,
      String email,
      // int countryid,
      String countryid,
      String phoneNumber,
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

  Future login(
    String email,
    String password,
  ) async {
    try {
      var data = await AuthService().login(email, password);
      if (data != null) {
        log(data);
      }
    } catch (e) {
      rethrow;
    }
  }

  List<CountryModal> countryList = <CountryModal>[];
  bool isCountryListLoading = true;
  Future getCountryList() async {
    // isCountryListLoading = true;
    try {
      var data = await AuthService().getCountry();
      countryList.clear();
      if (data != null) {
        countryList.add(data);
        // isCountryListLoading = false;
        return true;
      } else {
        return false;
      }
    } catch (e) {
      rethrow;
    }
  }
}
