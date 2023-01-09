import 'dart:convert';
import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:hotel_travel/extensions/extensions.dart';

class Product {
  String name, image, description, location, types;
  double price, rating;
  int review, quantity;
  Color color;
  bool favorite;

  Product(
      this.name,
      this.image,
      this.description,
      this.rating,
      this.price,
      this.review,
      this.quantity,
      this.color,
      this.favorite,
      this.location,
      this.types);

  static Future<List<Product>> getDummyList() async {
    dynamic data = json.decode(await getData());
    return getListFromJson(data);
  }

  static Future<Product> getOne() async {
    return (await getDummyList())[0];
  }

  static Product fromJson(Map<String, dynamic> jsonObject) {
    String name = jsonObject['name'].toString();
    String image = jsonObject['image'].toString();
    String description = jsonObject['description'].toString();
    double rating = double.parse(jsonObject['rating'].toString());
    double price = double.parse(jsonObject['price'].toString());
    int review = int.parse(jsonObject['review'].toString());
    int quantity = int.parse(jsonObject['quantity'].toString());
    Color color = jsonObject['review'].toString().toColor;
    bool favorite = jsonObject['favorite'].toString().toBool();
    String location = jsonObject['location'].toString();
    String types = jsonObject['types'].toString();

    return Product(name, image, description, rating, price, review, quantity,
        color, favorite, location, types);
  }

  static List<Product> getListFromJson(List<dynamic> jsonArray) {
    List<Product> list = [];
    for (int i = 0; i < jsonArray.length; i++) {
      list.add(Product.fromJson(jsonArray[i]));
    }
    return list;
  }

  static Future<String> getData() async {
    return await rootBundle.loadString('lib/dummy_data/data/products.json');
    // .loadString('lib/full_apps/shopping/data/products.json');
  }
}
