import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';

import '../models/cart.dart';
import '../views/hotel_travel_constants.dart';

class SavedController extends FxController {
  TickerProvider ticker;
  SavedController(this.ticker);
  bool showLoading = true, uiLoading = true;
  List<Cart>? carts;
  late double order, tax = 30, offer = 50, total;
  late AnimationController animationController, fadeController;
  late Animation<Offset> animation;
  late Animation<double> fadeAnimation;

  @override
  void initState() {
    super.initState();
    fetchData();
    animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: ticker,
    );
    fadeController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: ticker,
    );
    animation =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(15, 0))
            .animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeIn,
      ),
    );
    fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: fadeController,
        curve: Curves.easeIn,
      ),
    );
    fadeController.forward();
    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationController.reset();
      }
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    fadeController.dispose();
    super.dispose();
  }

  bool increaseAble(Cart cart) {
    return cart.person < cart.product.person;
  }

  bool decreaseAble(Cart cart) {
    return cart.person > 1;
  }

  void increment(Cart cart) {
    if (!increaseAble(cart)) return;
    cart.person++;
    calculateBilling();
    update();
  }

  void decrement(Cart cart) {
    if (!decreaseAble(cart)) return;
    cart.person--;
    calculateBilling();
    update();
  }

  void fetchData() async {
    carts = HotelTravelCache.carts;
    // carts = HotelTravelCache.carts!.cast<Cart>();
    log('fetch');
    log(carts!.length.toString());
    calculateBilling();
    showLoading = false;
    uiLoading = false;
    update();
  }

  void calculateBilling() {
    order = 0;
    for (Cart cart in carts!) {
      order = order + (cart.product.price * cart.person);
    }

    total = order + tax - offer;
  }

  Future<void> goToCheckout() async {
    animationController.forward();
    await Future.delayed(const Duration(seconds: 1));
    // Navigator.of(context, rootNavigator: true).push(
    //   MaterialPageRoute(
    //     builder: (context) => CheckOutScreen(),
    //   ),
    // );
  }

  @override
  String getTag() {
    return "cart_controller";
  }
}
