import 'dart:convert';

import 'package:flutter/services.dart';

class Countrylist {
  String countrycode, countryname, currencycode, isonumeric;

  Countrylist(
      this.countrycode, this.countryname, this.currencycode, this.isonumeric);

  static Future<List<Countrylist>> getDummyList() async {
    dynamic data = json.decode(await getData());
    return getListFromJson(data);
  }

  static Future<String> getData() async {
    return await rootBundle.loadString('lib/dummy_data/data/countries.json');
    // .loadString('lib/full_apps/shopping/data/products.json');
  }

  static List<Countrylist> getListFromJson(List<dynamic> jsonArray) {
    List<Countrylist> list = [];
    for (int i = 0; i < jsonArray.length; i++) {
      list.add(Countrylist.fromJson(jsonArray[i]));
    }
    return list;
  }

  static Countrylist fromJson(Map<String, dynamic> jsonObject) {
    String countrycode = jsonObject['countrycode'].toString();
    String countryname = jsonObject['countryname'].toString();
    String currencycode = jsonObject['currencycode'].toString();
    String isonumeric = jsonObject['isonumeric'].toString();

    return Countrylist(countrycode, countryname, currencycode, isonumeric);
  }

  static Future<Countrylist> getOne() async {
    return (await getDummyList())[0];
  }
}
