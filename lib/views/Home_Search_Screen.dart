import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';
import 'package:hotel_travel/views/search_screens/search_place.dart';
import 'package:hotel_travel/widgets/top_attractions.dart';

import '../controllers/home_controller.dart';
import '../models/category.dart';
import '../models/product.dart';
import '../theme/app_theme.dart';

class HomeScreen extends StatefulWidget {
  // const HomeScreen({required this.size});
  // final Size size;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late ThemeData theme, theme1;

  late HomeController controller;
  String _tabbed = '1';

  @override
  void initState() {
    super.initState();
    theme = AppTheme.shoppingTheme;
    theme1 = AppTheme.learningTheme;

    controller = FxControllerStore.put(HomeController(this));
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // addCategories();
    });
  }

//top suggestion
  Widget _buildSingleCategory(Category category) {
    bool selected = category == controller.selectedCategory;
    bool last = controller.categories!.last == category;
    return FxContainer(
      // width: MediaQuery.of(context).size.width / controller.categories!.length,
      width: 110,
      margin: FxSpacing.right(last ? 0 : 12),
      onTap: () {
        controller.changeSelectedCategory(category);
        // selected = !selected;
        // setState(() {});
        log(selected.toString());
      },
      borderRadiusAll: 4,
      // color: Colors.red,
      color: selected ? theme.colorScheme.primaryContainer : null,
      paddingAll: 12,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(
            image: AssetImage(category.icon),
            height: 20,
            color: selected
                ? theme.colorScheme.primary
                : theme.colorScheme.onBackground.withAlpha(220),
            width: 20,
          ),
          FxText.titleMedium(
            category.name,
            letterSpacing: 0.3,
            fontWeight: 700,
            color: selected
                ? theme.colorScheme.primary
                : theme.colorScheme.onBackground.withAlpha(220),
            // color: theme.colorScheme.primary,
          ),
        ],
      ),
    );
  }

  Widget _buildProductList() {
    List<Widget> list = [];

    for (Product product in controller.products!) {
      list.add(FadeTransition(
        opacity: controller.fadeAnimation,
        child: FxContainer(
          onTap: () {
            controller.goToSingleProduct(product);
          },
          borderRadiusAll: 4,
          paddingAll: 16,
          color: Colors.white,
          // color: Colors.green,
          margin: FxSpacing.bottom(20),
          child: Column(
            children: [
              // Align(
              //   alignment: Alignment.centerRight,
              //   child: Hero(
              //     tag: product.types,
              //     child: FxContainer(
              //       borderRadiusAll: 2,
              //       padding: FxSpacing.xy(8, 4),
              //       color: theme.colorScheme.primary,
              //       child: FxText.bodySmall(
              //         product.types.toString(),
              //         fontWeight: 600,
              //         color: theme.colorScheme.onPrimary,
              //       ),
              //     ),
              //   ),
              // ),
              Row(
                children: [
                  FxContainer(
                    paddingAll: 0,
                    borderRadiusAll: 4,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Hero(
                      tag: "product_image_" + product.name,
                      child: Image(
                        image: AssetImage(product.image),
                        height: 80,
                        width: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  FxSpacing.width(20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Hero(
                                tag: "product_" + product.name,
                                child: FxText.bodyMedium(
                                  product.name,
                                ),
                              ),
                            ),
                            // Icon(
                            //   product.favorite
                            //       ? Icons.favorite_rounded
                            //       : Icons.favorite_outline_rounded,
                            //   size: 18,
                            //   color: theme.colorScheme.primary,
                            // ),
                          ],
                        ),
                        FxSpacing.height(4),
                        Hero(
                          tag: product.name + "_" + product.price.toString(),
                          child: FxText.labelLarge(
                            // '\$' + product.price.toString(),
                            product.price.toString() + " " + "USD",
                            // "\$" + product.price.toString() + "/hour",
                            fontWeight: 700,
                          ),
                        ),
                        FxSpacing.height(6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Hero(
                              tag: product.name +
                                  "_" +
                                  product.rating.toString(),
                              child: FxContainer(
                                borderRadiusAll: 2,
                                padding: FxSpacing.xy(8, 4),
                                color: theme.colorScheme.primary,
                                child: Row(
                                  children: [
                                    Icon(
                                      FeatherIcons.star,
                                      color: theme.colorScheme.onPrimary,
                                      size: 12,
                                    ),
                                    FxSpacing.width(4),
                                    FxText.bodySmall(
                                      product.rating.toString(),
                                      fontWeight: 600,
                                      color: theme.colorScheme.onPrimary,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // FxContainer.bordered(
                            //   paddingAll: 4,
                            //   borderRadiusAll: 4,
                            //   child: Icon(
                            //     FeatherIcons.plus,
                            //     size: 14,
                            //     color: theme.colorScheme.onBackground,
                            //   ),
                            // ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ));
    }

    return Column(
      children: list,
    );
  }

  //top suggestionss

  // Future<void> addCategories() async {
  //   Future ft = Future(() {});
  //   if (controller.newCategories.length == 0) {
  //     for (int i = 0; i < controller.categories!.length; i++) {
  //       ft = ft.then((_) {
  //         return Future.delayed(Duration(milliseconds: 100), () {
  //           controller.newCategories
  //               .add(_buildSingleCategory(controller.categories![i]));
  //           controller.listKey.currentState!.insertItem(i);
  //         });
  //       });
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FxBuilder<HomeController>(
        controller: controller,
        builder: (controller) {
          return _buildBody();
        });
  }

  Widget _buildBody() {
    double width = MediaQuery.of(context).size.width;
    double containerWidth = width / 2;
    /* if (controller.uiLoading) {
      return Scaffold(
          body: Padding(
          padding: FxSpacing.top(FxSpacing.safeAreaTop(context) + 20),
          child: LoadingEffect.getSearchLoadingScreen(context, theme, theme.colorScheme),
      ));
    } else {*/
    return WillPopScope(
      onWillPop: () => controller.onWillPop(),
      child: Scaffold(
        backgroundColor: Color(0xfff5f5f5),
        body: ListView(
          padding: FxSpacing.fromLTRB(
              20, FxSpacing.safeAreaTop(context) + 20, 20, 0),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Hero(
                  tag: "splash_username",
                  child: FxText.titleLarge(
                    'Hey Nency,',
                    fontWeight: 700,
                  ),
                ),
                RotationTransition(
                  turns: controller.bellAnimation,
                  key: controller.intro.keys[0],
                  child: InkWell(
                    onTap: () {
                      controller.goToNotification();
                    },
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Icon(
                          FeatherIcons.bell,
                          color: theme.colorScheme.onBackground,
                          size: 20,
                        ),
                        Positioned(
                          bottom: -2,
                          right: -2,
                          child: FxContainer.rounded(
                            paddingAll: 3,
                            color: theme.colorScheme.primary,
                            child: Center(
                                child: FxText.bodySmall(
                              '2',
                              color: theme.colorScheme.onPrimary,
                              fontSize: 8,
                            )),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            FxSpacing.height(4),
            FadeTransition(
              opacity: controller.fadeAnimation,
              child: FxText.bodySmall(
                'Begin your Travel !!',
                xMuted: true,
              ),
            ),
            FxSpacing.height(20),
            //slanding widget
            // Stack(
            //   children: <Widget>[
            //     Image(
            //       width: double.infinity,
            //       height: MediaQuery.of(context).size.height * 0.35,
            //       fit: BoxFit.fill,
            //       image: AssetImage("assets/images/apps/hotel/hotelbg.jpg"),
            //     ),
            //     SearchPlace()
            //     // LogInScreen()
            //     // buildSearchBar(MediaQuery.of(context).size, "long"),
            //     // buildTitle(size),
            //   ],
            // ),
            SearchPlace(),
            FxSpacing.height(20),
            //scroll
            Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              // color: Colors.yellow,
              // child: Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   crossAxisAlignment: CrossAxisAlignment.center,
              //   children: [
              //     Container(width: containerWidth, color: Colors.red),
              //     Container(width: containerWidth, color: Colors.green),
              //     Container(width: containerWidth, color: Colors.blue),
              //     Container(width: containerWidth, color: Colors.purple),
              //   ],
              // ),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      log('Attraction');
                      _tabbed = '1';
                      setState(() {});
                    },
                    child: Container(
                      // width: 100,
                      decoration: new BoxDecoration(
                          color: _tabbed == '1'
                              ? Color(0xff1529e8)
                              // theme1.colorScheme.primary
                              : Colors.transparent,
                          border: Border.all(
                              color: _tabbed == '1'
                                  ? Colors.transparent
                                  : theme1.colorScheme.primaryContainer,
                              width: _tabbed == '1' ? 0.0 : 1.0),
                          // borderRadius:
                          //     new BorderRadius.all(Radius.elliptical(90, 45)),
                          // borderRadius: BorderRadius.only(
                          //     topLeft: Radius.circular(20),
                          //     topRight: Radius.circular(20))
                          borderRadius: BorderRadius.circular(20.0)),
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                              "assets/images/apps/shopping2/icons/attraction.png",
                              height: 20,
                              width: 20,
                              color:
                                  _tabbed == '1' ? Colors.white : Colors.black),
                          SizedBox(
                            width: 7,
                          ),
                          Text(
                            'Attraction',
                            style: TextStyle(
                              fontSize: 18,
                              color:
                                  _tabbed == '1' ? Colors.white : Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      log('flight');
                      _tabbed = '2';
                      setState(() {});
                    },
                    child: Container(
                        width: 120,
                        decoration: new BoxDecoration(
                            color: _tabbed == '2'
                                ? Color(0xff1529e8)
                                // theme1.colorScheme.primary
                                : Colors.transparent,
                            border: Border.all(
                                color: _tabbed == '2'
                                    ? Colors.transparent
                                    : theme1.colorScheme.primaryContainer,
                                width: _tabbed == '2' ? 0.0 : 1.0),
                            borderRadius: BorderRadius.circular(20.0)
                            // borderRadius:
                            //     new BorderRadius.all(Radius.elliptical(90, 45)),
                            ),
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                                "assets/images/apps/shopping2/icons/flight.png",
                                height: 20,
                                width: 20,
                                color: _tabbed == '2'
                                    ? Colors.white
                                    : Colors.black),
                            SizedBox(
                              width: 7,
                            ),
                            Text(
                              'Flight',
                              style: TextStyle(
                                fontSize: 18,
                                color: _tabbed == '2'
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ],
                        )),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      log('Hotel');
                      _tabbed = '3';
                      setState(() {});
                    },
                    child: Container(
                      width: 120,
                      decoration: new BoxDecoration(
                          color: _tabbed == '3'
                              ? Color(0xff1529e8)
                              // theme1.colorScheme.primary
                              : Colors.transparent,
                          border: Border.all(
                              color: _tabbed == '3'
                                  ? Colors.transparent
                                  : theme1.colorScheme.primaryContainer,
                              width: _tabbed == '3' ? 0.0 : 1.0),
                          borderRadius: BorderRadius.circular(20.0)),
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                              "assets/images/apps/shopping2/icons/hotel.png",
                              height: 20,
                              width: 20,
                              color:
                                  _tabbed == '3' ? Colors.white : Colors.black),
                          SizedBox(
                            width: 7,
                          ),
                          Text(
                            'Hotel',
                            style: TextStyle(
                                fontSize: 18,
                                color: _tabbed == '3'
                                    ? Colors.white
                                    : Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      log('flight');
                      _tabbed = '4';
                      setState(() {});
                    },
                    child: Container(
                      width: 120,
                      decoration: new BoxDecoration(
                          color: _tabbed == '4'
                              ? Color(0xff1529e8)
                              // theme1.colorScheme.primary
                              : Colors.transparent,
                          border: Border.all(
                              color: _tabbed == '4'
                                  ? Colors.transparent
                                  : theme1.colorScheme.primaryContainer,
                              width: _tabbed == '4' ? 0.0 : 1.0),
                          borderRadius: BorderRadius.circular(20.0)),
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                              "assets/images/apps/shopping2/icons/visa.png",
                              height: 20,
                              width: 20,
                              color:
                                  _tabbed == '4' ? Colors.white : Colors.black),
                          SizedBox(
                            width: 7,
                          ),
                          Text(
                            'Visa',
                            style: TextStyle(
                                fontSize: 18,
                                color: _tabbed == '4'
                                    ? Colors.white
                                    : Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      log('Transfer');
                      _tabbed = '5';
                      setState(() {});
                    },
                    child: Container(
                      width: 120,
                      decoration: new BoxDecoration(
                          color: _tabbed == '5'
                              ? Color(0xff1529e8)
                              // theme1.colorScheme.primary
                              : Colors.transparent,
                          border: Border.all(
                              color: _tabbed == '5'
                                  ? Colors.transparent
                                  : theme1.colorScheme.primaryContainer,
                              width: _tabbed == '5' ? 0.0 : 1.0),
                          borderRadius: BorderRadius.circular(20.0)
                          // borderRadius:
                          //     new BorderRadius.all(Radius.elliptical(90, 45)),
                          ),
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                              "assets/images/apps/shopping2/icons/card.png",
                              height: 20,
                              width: 20,
                              color:
                                  _tabbed == '5' ? Colors.white : Colors.black),
                          SizedBox(
                            width: 7,
                          ),
                          Text(
                            'Transfer',
                            style: TextStyle(
                                fontSize: 18,
                                color: _tabbed == '5'
                                    ? Colors.white
                                    : Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            FxSpacing.height(20),
            TopAttraction(),
            FxSpacing.height(20),

            // FadeTransition(
            //   key: controller.intro.keys[1],
            //   opacity: controller.fadeAnimation,
            //   child: FxContainer(
            //     clipBehavior: Clip.antiAliasWithSaveLayer,
            //     borderRadiusAll: 4,
            //     onTap: () {
            //       controller.goToSubscription();
            //     },
            //     color: theme.colorScheme.primaryContainer,
            //     border: Border.all(color: theme.colorScheme.primaryContainer),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: [
            //         Column(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //             FxText.titleMedium(
            //               'Enjoy Upto \n50% Discount',
            //               letterSpacing: 0.3,
            //               fontWeight: 700,
            //               color: theme.colorScheme.primary,
            //             ),
            //             FxSpacing.height(4),
            //             FxButton.small(
            //               elevation: 0,
            //               padding: FxSpacing.xy(20, 2),
            //               borderRadiusAll: 4,
            //               backgroundColor: theme.colorScheme.primary,
            //               onPressed: () {
            //                 controller.goToSubscription();
            //               },
            //               child: FxText.labelLarge(
            //                 'Subscribe',
            //                 letterSpacing: 0.3,
            //                 color: theme.colorScheme.onPrimary,
            //               ),
            //             ),
            //           ],
            //         ),
            //         FxContainer(
            //           paddingAll: 0,
            //           borderRadiusAll: 4,
            //           height: 100,
            //           width: 150,
            //           clipBehavior: Clip.hardEdge,
            //           child: Image(
            //             fit: BoxFit.fill,
            //             image: AssetImage(Images.shoppingBannerPhoto),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            // FxSpacing.height(20),
            FadeTransition(
              opacity: controller.fadeAnimation,
              key: controller.intro.keys[1],
              child: Container(
                child: FxText.bodyLarge(
                  'Top Attractions',
                  letterSpacing: 0,
                  fontWeight: 600,
                ),
              ),
            ),
            // FxSpacing.height(20),
            // Container(
            //   key: controller.intro.keys[2],
            //   // height: 50,
            //   height: 70,
            //   // color: Colors.amber,
            //   child: AnimatedList(
            //       scrollDirection: Axis.horizontal,
            //       key: controller.listKey,
            //       initialItemCount: controller.newCategories.length,
            //       itemBuilder: (context, index, animation) {
            //         return SlideTransition(
            //             position: animation.drive(controller.offset),
            //             child: controller.newCategories[index]
            //             // child: Container(
            //             //   color: Colors.green,
            //             // ),
            //             );
            //       }),
            // ),

            // FxSpacing.height(20),
            // FadeTransition(
            //   opacity: controller.fadeAnimation,
            //   child: Container(
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: [
            //         FxText.bodyLarge(
            //           // 'Best Selling Attractions',
            //           'Best Attractions',
            //           letterSpacing: 0,
            //           fontWeight: 600,
            //         ),
            //         FxText.bodySmall(
            //           'VIEW MORE',
            //           fontWeight: 700,
            //           letterSpacing: 0.3,
            //           color: theme.colorScheme.primary,
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            FxSpacing.height(20),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: _buildProductList(),
            ),
            // FxSpacing.height(20),
            // FadeTransition(
            //   opacity: controller.fadeAnimation,
            //   child: Container(
            //     child: FxText.bodyLarge(
            //       // 'Best Selling Attractions',
            //       'Top Attractions',
            //       letterSpacing: 0,
            //       fontWeight: 600,
            //     ),
            //   ),
            // ),
            // FxSpacing.height(20),
            // // SizedBox(
            // //   height: 500,
            // //   width: MediaQuery.of(context).size.width,
            // //   child: GridView.custom(
            // //       gridDelegate:
            // //           SliverQuiltedGridDelegate(crossAxisCount: 4, pattern: [
            // //         QuiltedGridTile(
            // //           4,
            // //           2,
            // //         ),
            // //         QuiltedGridTile(2, 1),
            // //         QuiltedGridTile(2, 1),
            // //         QuiltedGridTile(2, 1),
            // //         QuiltedGridTile(2, 1)
            // //       ]),
            // //       childrenDelegate: SliverChildBuilderDelegate(
            // //           childCount: 5,
            // //           (context, index) => Container(
            // //                 color: Colors.red,
            // //               ))
            // //               ),
            // // )
            // PlacesStaggeredView(
            //     size: MediaQuery.of(context).size, places: places)
          ],
        ),
      ),
    );
    //}
  }
}
