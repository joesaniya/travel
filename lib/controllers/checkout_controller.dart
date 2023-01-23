import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';

import '../models/shipping_address.dart';

class Tab {
  String name;
  IconData iconData;

  Tab(this.name, this.iconData);
}

class CheckOutController extends FxController {
  TickerProvider ticker;
  CheckOutController(this.ticker);
  PageController pageController = PageController(initialPage: 0);
  int currentPage = 0;
  int numPages = 3;
  int paymentMethodSelected = 1;
  ShippingAddress? addressSelected;
  List<ShippingAddress>? addressList;

  List<Tab> tabs = [];
//form
  late Animation<double> fadeAnimation;
  late AnimationController animationController;

  late TextEditingController FnameTE, LnameTE, emailTE, reqTE;
  GlobalKey<FormState> formKey = GlobalKey();
  String? selectedname;
  final List<String> nameCodes = ['Mr.', 'Mrs.', 'Ms.'];
  String? selectedcountry;
  final List<String> countryCodes = ['India', 'UAE', 'France'];
  late AnimationController arrowController,
      firstnameController,
      lastnameController,
      emailController,
      reqController;
  late Animation<Offset> arrowAnimation,
      firstnameAnimation,
      lastnameAnimation,
      emailAnimation,
      reqAnimation;
  int firstnameCounter = 0;
  int lastnameCounter = 0;
  int emailCounter = 0;
  int reqCounter = 0;

  @override
  initState() {
    super.initState();
    currentPage = 0;
    addressList = ShippingAddress.shipping();
    addressSelected = addressList!.first;
    tabs = [
      Tab('Passenger Details', Icons.local_shipping_outlined),
      Tab('Payment', Icons.payment),
      Tab('Booked', Icons.check_circle_outline),
    ];
    FnameTE = TextEditingController();
    LnameTE = TextEditingController();
    emailTE = TextEditingController();
    reqTE = TextEditingController();

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

    arrowController = AnimationController(
        vsync: ticker, duration: const Duration(milliseconds: 500));
    firstnameController = AnimationController(
        vsync: ticker, duration: const Duration(milliseconds: 500));
    lastnameController = AnimationController(
        vsync: ticker, duration: const Duration(milliseconds: 500));
    emailController = AnimationController(
        vsync: ticker, duration: const Duration(milliseconds: 500));
    reqController = AnimationController(
        vsync: ticker, duration: const Duration(milliseconds: 500));

    //animation
    arrowAnimation =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(8, 0))
            .animate(CurvedAnimation(
      parent: arrowController,
      curve: Curves.easeIn,
    ));
    firstnameAnimation =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(8, 0))
            .animate(CurvedAnimation(
      parent: arrowController,
      curve: Curves.easeIn,
    ));
    lastnameAnimation =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(8, 0))
            .animate(CurvedAnimation(
      parent: arrowController,
      curve: Curves.easeIn,
    ));
    emailAnimation =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(8, 0))
            .animate(CurvedAnimation(
      parent: arrowController,
      curve: Curves.easeIn,
    ));
    reqAnimation =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(8, 0))
            .animate(CurvedAnimation(
      parent: arrowController,
      curve: Curves.easeIn,
    ));
    animationController.forward();

    //listener
    firstnameController.addStatusListener((status) {
      log(status.toString());
      if (status == AnimationStatus.completed) {
        firstnameController.reverse();
      }
      if (status == AnimationStatus.dismissed && firstnameCounter < 2) {
        firstnameController.forward();
        firstnameCounter++;
      }
    });
    lastnameController.addStatusListener((status) {
      log(status.toString());
      if (status == AnimationStatus.completed) {
        lastnameController.reverse();
      }
      if (status == AnimationStatus.dismissed && lastnameCounter < 2) {
        lastnameController.forward();
        lastnameCounter++;
      }
    });
    emailController.addStatusListener((status) {
      log(status.toString());
      if (status == AnimationStatus.completed) {
        emailController.reverse();
      }
      if (status == AnimationStatus.dismissed && emailCounter < 2) {
        emailController.forward();
        emailCounter++;
      }
    });
    reqController.addStatusListener((status) {
      log(status.toString());
      if (status == AnimationStatus.completed) {
        reqController.reverse();
      }
      if (status == AnimationStatus.dismissed && reqCounter < 2) {
        reqController.forward();
        reqCounter++;
      }
    });
  }

  void goBack() {
    Navigator.pop(context);
  }

  void selectPaymentMethod(int method) {
    paymentMethodSelected = method;
    update();
  }

  void selectShippingAddress(ShippingAddress address) {
    addressSelected = address;
    update();
  }

  nextPage() async {
    if (currentPage == numPages) {
      /*   Navigator.push(
          context, MaterialPageRoute(builder: (context) => FullApp()));*/
    } else {
      await pageController.animateToPage(
        currentPage + 1,
        duration: const Duration(milliseconds: 600),
        curve: Curves.ease,
      );
    }
  }

  previousPage() async {
    if (currentPage == 0) {
      /*   Navigator.push(
          context, MaterialPageRoute(builder: (context) => FullApp()));*/
    } else {
      await pageController.animateToPage(
        currentPage - 1,
        duration: const Duration(milliseconds: 600),
        curve: Curves.ease,
      );
    }
  }

  onPageChanged(int page, {bool fromUser = false}) async {
    if (!fromUser) currentPage = page;
    update();
    if (fromUser) {
      await pageController.animateToPage(
        page,
        duration: const Duration(milliseconds: 600),
        curve: Curves.ease,
      );
    }
  }

  @override
  void dispose() {
    if (pageController.hasClients) pageController.dispose();
    arrowController.dispose();
    firstnameController.dispose();
    lastnameController.dispose();
    emailController.dispose();
    reqController.dispose();
    animationController.dispose();
    super.dispose();
  }

  @override
  String getTag() {
    return "checkout_controller";
  }
}
