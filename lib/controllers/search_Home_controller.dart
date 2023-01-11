import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';

import '../models/product.dart';
import '../views/hotel_travel_constants.dart';

class HomeSearchController extends FxController {
  TickerProvider ticker;
  HomeSearchController(this.ticker);

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> selectedChoices = [];
  RangeValues selectedRange = const RangeValues(200, 800);
  late AnimationController animationController;
  late Animation<double> fadeAnimation;
  List<Product>? products;

  late Tween<Offset> offset;

  List<String> categoryList = [
    "Theme Park",
    "Theme Park 1",
    "Theme Park 2",
    "Theme Park 3",
    "Theme Park 4",
    "Theme Park 5",
  ];

  void addChoice(String item) {
    selectedChoices.add(item);
    update();
  }

  void removeChoice(String item) {
    selectedChoices.remove(item);
    update();
  }

  void onChangePriceRange(RangeValues newRange) {
    selectedRange = newRange;
    update();
  }

  void fetchData() {
    // categories = HotelTravelCache.categories;
    products = HotelTravelCache.products;
    // selectedCategory = categories!.first;
  }

  @override
  void initState() {
    super.initState();
    fetchData();
    animationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: ticker,
    );

    fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeIn,
      ),
    );

    offset = Tween<Offset>(begin: const Offset(1, 0), end: const Offset(0, 0));

    animationController.forward();
  }

  void openEndDrawer() {
    scaffoldKey.currentState?.openEndDrawer();
  }

  void closeEndDrawer() {
    scaffoldKey.currentState?.openDrawer();
  }

  @override
  String getTag() {
    return "search_controller";
  }
}
