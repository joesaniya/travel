import 'package:flutter/material.dart';
import 'package:flutx/core/state_management/controller.dart';

import '../models/category.dart';
import '../models/product.dart';
import '../views/full_app.dart';
import '../views/hotel_travel_constants.dart';

class SplashScreen2Controller extends FxController {
  @override
  void initState() {
    super.initState();
    goToFullApp();
  }

  goToFullApp() async {
    HotelTravelCache.products = await Product.getDummyList();
    HotelTravelCache.categories = await Category.getDummyList();
    // ShoppingCache.carts = await Cart.getDummyList();
    await Future.delayed(Duration(seconds: 1));

    Navigator.of(context, rootNavigator: true).pushReplacement(
      PageRouteBuilder(
          transitionDuration: Duration(seconds: 2),
          pageBuilder: (_, __, ___) => FullApp()),
    );
  }

  @override
  String getTag() {
    return "splash_screen_2";
  }
}
