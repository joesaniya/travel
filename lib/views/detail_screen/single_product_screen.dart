import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';
import 'package:hotel_travel/extensions/extensions.dart';
import 'package:hotel_travel/views/detail_screen/review_Screen.dart';
import 'package:hotel_travel/widgets/facilty_widget.dart';
import 'package:iconsax/iconsax.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../controllers/single_product_controller.dart';
import '../../models/product.dart';
import '../../theme/app_theme.dart';

class SingleProductScreen extends StatefulWidget {
  final Product product;

  const SingleProductScreen(
    this.product, {
    Key? key,
  }) : super(key: key);

  @override
  _SingleProductScreenState createState() => _SingleProductScreenState();
}

class _SingleProductScreenState extends State<SingleProductScreen>
    with TickerProviderStateMixin {
  late ThemeData theme;

  late SingleProductController controller;

  @override
  void initState() {
    super.initState();
    theme = AppTheme.shoppingTheme;
    controller =
        FxControllerStore.put(SingleProductController(this, widget.product));
  }

  Widget _buildProductList() {
    List<Widget> list = [];

    list.add(FxSpacing.width(20));

    for (Product product in controller.products!) {
      if (controller.product == product) continue;
      list.add(FxContainer(
        onTap: () {
          controller.goToSingleProduct(product);
        },
        borderRadiusAll: 8,
        paddingAll: 8,
        width: 150,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FxContainer(
              paddingAll: 0,
              borderRadiusAll: 4,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Stack(
                children: [
                  Image(
                    image: AssetImage(product.image),
                    height: 140,
                    fit: BoxFit.cover,
                  ),
                  const Positioned(
                    right: 8,
                    top: 8,
                    child: Icon(
                      Icons.favorite_outline,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
            FxSpacing.height(8),
            FxText.labelLarge(
              product.name,
              fontWeight: 600,
            ),
            FxSpacing.height(4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FxText.labelLarge(
                  '\$${product.price}',
                  fontWeight: 700,
                ),
                const FxContainer.bordered(
                  paddingAll: 2,
                  borderRadiusAll: 4,
                  child: Icon(
                    FeatherIcons.plus,
                    size: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ));
      list.add(FxSpacing.width(20));
    }

    return Row(
      children: list,
    );
  }

  Widget _buildSizeWidget() {
    List<Widget> list = [];

    for (String size in controller.sizes) {
      bool selected = size == controller.selectedSize;
      list.add(
        FxContainer.roundBordered(
          paddingAll: 8,
          width: 36,
          height: 36,
          onTap: () {
            controller.selectSize(size);
          },
          border: Border.all(
              color: selected
                  ? theme.colorScheme.primary
                  : theme.colorScheme.onBackground),
          color: selected ? theme.colorScheme.primary : null,
          child: Center(
            child: FxText.bodySmall(
              size,
              fontWeight: 600,
              color: selected
                  ? theme.colorScheme.onSecondary
                  : theme.colorScheme.onBackground,
            ),
          ),
        ),
      );

      list.add(FxSpacing.width(8));
    }

    return Wrap(
      children: list,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FxBuilder<SingleProductController>(
        controller: controller,
        builder: (controller) {
          // return _buildBody();
          // return _buildbody2();
          return _buildDetail();
        });
  }

  Widget _buildDetail() {
    return Scaffold(
      backgroundColor: const Color(0xfff5f5f5),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15),
        child: FxButton.block(
          onPressed: () {},
          backgroundColor: Colors.indigo,
          // backgroundColor: customTheme.estatePrimary,
          borderRadiusAll: 12,

          elevation: 0,
          child: FxText.bodyMedium(
            'Book Now',
            color: Colors.white,
            // color: customTheme.estateOnPrimary,
            fontWeight: 700,
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          SizedBox(
            height: 400,
            // height: MediaQuery.of(context).size.height / 3,
            child: PageView(
              pageSnapping: true,
              physics: const ClampingScrollPhysics(),
              controller: controller.pageController,
              onPageChanged: (int page) {
                setState(() {
                  controller.currentPage = page;
                });
              },
              children: <Widget>[
                Container(
                  child: Image(
                    image: AssetImage(controller.product.image),
                    // height: MediaQuery.of(context).size.height / 3,
                    height: 400,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.fill,
                  ),
                ),
                Container(
                  child: Image(
                    image: const AssetImage(
                        './assets/images/apps/hotel/room-1.jpg'),
                    // height: MediaQuery.of(context).size.height / 3,
                    height: 400,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.fill,
                  ),
                ),
                Container(
                  child: Image(
                    image: const AssetImage(
                        './assets/images/apps/hotel/room-3.jpg'),
                    // height: MediaQuery.of(context).size.height / 3,
                    height: 400,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.fill,
                  ),
                ),
              ],
            ),
          ),
          // Container(
          //     foregroundDecoration: const BoxDecoration(color: Colors.black26),
          //     height: 400,
          //     child: Image.asset(controller.product.image, fit: BoxFit.cover)),
          SingleChildScrollView(
            padding: const EdgeInsets.only(top: 16.0, bottom: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 250),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
                //   child: Text(
                //     controller.product.name,
                //     style: const TextStyle(
                //         color: Colors.white,
                //         fontSize: 28.0,
                //         fontWeight: FontWeight.w900),
                //   ),
                // ),
                // Row(
                //   children: <Widget>[
                //     // const SizedBox(width: 16.0),
                //     Container(
                //       padding: const EdgeInsets.symmetric(
                //         vertical: 8.0,
                //         horizontal: 16.0,
                //       ),
                //       // decoration: BoxDecoration(
                //       //     color: Colors.grey,
                //       //     borderRadius: BorderRadius.circular(20.0)),
                //       child: Row(
                //         children: [
                //           FxText.bodyMedium(
                //             controller.product.rating.toString(),
                //             fontWeight: 900,
                //             color: Colors.white,
                //             // color: theme.colorScheme.onPrimary,
                //           ),
                //           const Icon(
                //             Icons.star,
                //             color: Colors.yellow,
                //           ),
                //         ],
                //       ),
                //     ),
                //     const Spacer(),
                //     // FxText.bodySmall(
                //     //   '23+',
                //     //   fontWeight: 900,
                //     //   color: Colors.white,
                //     //   // color: theme.colorScheme.onPrimary,
                //     // ),
                //     // IconButton(
                //     //   color: Colors.white,
                //     //   icon: const Icon(Icons.favorite_border),
                //     //   onPressed: () {},
                //     // )
                //   ],
                // ),
                Container(
                  padding: const EdgeInsets.all(32.0),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30)),
                      // color: Colors.blue
                      color: Color(0xfff5f5f5)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        // margin: const EdgeInsets.all(5.0),
                        // width: 800,
                        height: 100,
                        decoration: BoxDecoration(
                            // color: Color(0xffe6e1e5),
                            color: Colors.white,
                            // color: Color(0xffe5fdfd),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            border: Border.all(
                                color: Colors.grey.shade300, width: 1)
                            // color: theme!.colorScheme.onPrimaryContainer,
                            ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      FxContainer(
                                        borderRadiusAll: 10,
                                        // padding: FxSpacing.xy(8, 4),
                                        padding: FxSpacing.xy(6, 2),
                                        // color: Color(0xff1529e8),
                                        color: Colors.blueGrey,
                                        child: FxText.bodySmall(
                                          // 'Theme Park',
                                          controller.product.types.toString(),
                                          fontWeight: 300,
                                          color: Colors.white,
                                          // color: theme.colorScheme.onPrimary,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      FxContainer(
                                        borderRadiusAll: 10,
                                        // padding: FxSpacing.xy(8, 4),
                                        padding: FxSpacing.xy(6, 2),
                                        // color: Color(0xff1529e8),
                                        color: Colors.blueGrey,
                                        child: FxText.bodySmall(
                                          'Ticket',
                                          fontWeight: 300,
                                          color: Colors.white,
                                          // color: theme.colorScheme.onPrimary,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      FxContainer(
                                        borderRadiusAll: 10,
                                        // padding: FxSpacing.xy(8, 4),
                                        padding: FxSpacing.xy(6, 2),
                                        // color: Color(0xff1529e8),
                                        color: Colors.blueGrey,
                                        child: FxText.bodySmall(
                                          'Offer',
                                          fontWeight: 300,
                                          color: Colors.white,
                                          // color: theme.colorScheme.onPrimary,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(
                                            // FeatherIcons.star,
                                            Icons.star,
                                            color: Colors.yellow,
                                            size: 12,
                                          ),
                                          FxSpacing.width(4),
                                          FxText.bodySmall(
                                            // '4.5',
                                            controller.product.rating
                                                .toString(),
                                            fontWeight: 600,
                                            color: Colors.black,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            // FxSpacing.height(20),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: FxText.bodyLarge(
                                // 'Ferrari world',
                                controller.product.name.toString(),
                                fontWeight: 800,
                              ),
                            ),
                            // FxSpacing.height(10),
                            Padding(
                              // padding: EdgeInsets.symmetric(horizontal: 0),
                              padding: const EdgeInsets.only(right: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      FxContainer(
                                        borderRadiusAll: 8,
                                        padding: FxSpacing.xy(8, 4),
                                        // color: theme.colorScheme.primary,
                                        // color: Colors.yellow.shade400,
                                        color: Colors.white,
                                        child: Row(
                                          children: [
                                            const Icon(
                                              Iconsax.location,
                                              color: Colors.black,
                                              // color: theme.colorScheme.onPrimary,
                                              size: 12,
                                            ),
                                            FxSpacing.width(4),
                                            FxText.labelLarge(
                                              // '\$' + product.price.toString(),
                                              controller.product.location
                                                  .toString(),
                                              // product.price.toString() + " " + "USD",
                                              // "\$" + product.price.toString() + "/hour",
                                              // fontWeight: 700,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  FxText(
                                    controller.product.price.toString(),
                                    color: const Color(0xff1529e8),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      // FxContainer.bordered(
                      //   // margin: const EdgeInsets.only(left: 8, right: 8),
                      //   child: Column(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //       Text(
                      //         controller.product.name,
                      //         style: const TextStyle(
                      //             color: Colors.black,
                      //             fontSize: 28.0,
                      //             fontWeight: FontWeight.w900),
                      //       ),
                      //       Row(
                      //         children: <Widget>[
                      //           // const SizedBox(width: 16.0),
                      //           Container(
                      //             padding: const EdgeInsets.symmetric(
                      //               vertical: 8.0,
                      //               // horizontal: 16.0,
                      //             ),
                      //             // decoration: BoxDecoration(
                      //             //     color: Colors.grey,
                      //             //     borderRadius: BorderRadius.circular(20.0)),
                      //             child: Row(
                      //               children: [
                      //                 FxText.bodyMedium(
                      //                   controller.product.rating.toString(),
                      //                   fontWeight: 900,
                      //                   color: Colors.black,
                      //                   // color: theme.colorScheme.onPrimary,
                      //                 ),
                      //                 const Icon(
                      //                   Icons.star,
                      //                   color: Colors.yellow,
                      //                 ),
                      //               ],
                      //             ),
                      //           ),
                      //           const Spacer(),
                      //           // FxText.bodySmall(
                      //           //   '23+',
                      //           //   fontWeight: 900,
                      //           //   color: Colors.white,
                      //           //   // color: theme.colorScheme.onPrimary,
                      //           // ),
                      //           // IconButton(
                      //           //   color: Colors.white,
                      //           //   icon: const Icon(Icons.favorite_border),
                      //           //   onPressed: () {},
                      //           // )
                      //         ],
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      FxSpacing.height(15),
                      Container(
                        height: 80,
                        decoration: BoxDecoration(
                            // color: Color(0xffe6e1e5),
                            color: Colors.white,
                            // color: Color(0xffe5fdfd),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            border: Border.all(
                                color: Colors.grey.shade300, width: 1)
                            // color: theme!.colorScheme.onPrimaryContainer,
                            ),
                        padding: const EdgeInsets.only(left: 8.0, right: 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                FxText.labelLarge(
                                  // '\$' + product.price.toString(),
                                  'Per Person',
                                  // product.price.toString() + " " + "USD",
                                  // "\$" + product.price.toString() + "/hour",
                                  // fontWeight: 700,
                                ),
                                FxText.bodyLarge(
                                  '\$140 ',
                                  color: Colors.indigo,
                                  fontWeight: 900,
                                  // color: const Color(0xff1529e8),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FxText.bodyMedium(
                                  '4.5/5 - Good',
                                  fontWeight: 900,
                                  color: Colors.black,
                                  // color: theme.colorScheme.onPrimary,
                                ),
                                FxContainer(
                                  onTap: () {
                                    log('review Screen clicked');
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ReviewScreen()));
                                  },
                                  padding: FxSpacing.fromLTRB(8, 6, 8, 6),
                                  color: const Color(0xff1529e8).withAlpha(40),
                                  // color:Color(0xff6874E8),
                                  // customTheme.groceryPrimary.withAlpha(40),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      FxText.bodyMedium("(243 review)",
                                          color: const Color(0xff1529e8),
                                          // color: customTheme.groceryPrimary,
                                          fontWeight: 500,
                                          letterSpacing: -0.2),
                                      const Icon(
                                        MdiIcons.chevronRight,
                                        size: 14,
                                        color: Color(0xff1529e8),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      // FxContainer.bordered(
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //       FxText.bodyMedium(
                      //         'Per Person',
                      //         fontWeight: 900,
                      //         color: Colors.black,
                      //         // color: theme.colorScheme.onPrimary,
                      //       ),
                      //       RichText(
                      //         text: const TextSpan(
                      //           // style:
                      //           //     TextStyle(color: Colors.black, fontSize: 36),
                      //           children: <TextSpan>[
                      //             TextSpan(
                      //                 text: '\$140 ',
                      //                 style: TextStyle(color: Colors.black)),
                      //             TextSpan(
                      //                 text: '\$120',
                      //                 style: TextStyle(
                      //                     color: Colors.black,
                      //                     fontWeight: FontWeight.w900)),
                      //           ],
                      //         ),
                      //       )
                      //     ],
                      //   ),
                      // ),
                      // FxSpacing.height(15),
                      // // const Divider(
                      // //   color: Colors.black,
                      // // ),
                      // // FxSpacing.height(15),
                      // FxContainer.bordered(
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //       FxText.bodyMedium(
                      //         '4.5/5 - Good',
                      //         fontWeight: 900,
                      //         color: Colors.black,
                      //         // color: theme.colorScheme.onPrimary,
                      //       ),
                      //       Container(
                      //         child: Row(
                      //           children: const [
                      //             Text('1298 Reviews'),
                      //             Icon(
                      //               Icons.arrow_forward_ios,
                      //               size: 10,
                      //             )
                      //           ],
                      //         ),
                      //       )
                      //     ],
                      //   ),
                      // ),
                      FxSpacing.height(15),
                      // const Divider(
                      //   color: Colors.black,
                      // ),

                      // //fe
                      // FxSpacing.height(15),

                      Container(
                        // margin:
                        //     const EdgeInsets.only(top: 24, left: 8, right: 8),
                        color: Colors.transparent,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            FxText.bodyLarge(
                              'Features',
                              fontWeight: 800,
                            ),
                            FxSpacing.height(10),
                            Row(
                              children: const <Widget>[
                                Expanded(
                                    child: FacityWidget(
                                  iconData: MdiIcons.calendarAccount,
                                  text: "Availibility:Daily",
                                )),
                                Expanded(
                                    child: FacityWidget(
                                  iconData: MdiIcons.timerSand,
                                  // text: "Duration: 6 hours",
                                  text: "Duration: 6 hours (approx)",
                                )),
                                Expanded(
                                    child: FacityWidget(
                                  iconData: MdiIcons.timer,
                                  text: "Time slot: 8:00 - 11:30",
                                )),
                                Expanded(
                                    child: FacityWidget(
                                  iconData: Icons.bolt,
                                  text: "Instant Confirmation",
                                )),
                              ],
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 16),
                              child: Row(
                                children: const <Widget>[
                                  Expanded(
                                      child: FacityWidget(
                                    iconData: MdiIcons.accountCancelOutline,
                                    text: "Free cancellation upto 24 hours",
                                  )),
                                  Expanded(
                                      child: FacityWidget(
                                    iconData: MdiIcons.pool,
                                    text: "Pool",
                                  )),
                                  Expanded(
                                      child: FacityWidget(
                                    iconData: MdiIcons.spa,
                                    text: "Spa",
                                  )),
                                  Expanded(
                                      child: FacityWidget(
                                    iconData: MdiIcons.gamepad,
                                    text: "Games",
                                  )),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      //feaures
                      FxSpacing.height(15),
                      // Column(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     FxText.bodyLarge(
                      //       'Hotel Features',
                      //       fontWeight: 800,
                      //     ),
                      //     FxSpacing.height(10),
                      //     Container(
                      //       child: Row(
                      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //         crossAxisAlignment: CrossAxisAlignment.center,
                      //         children: [
                      //           Container(
                      //             child: Column(
                      //               mainAxisAlignment:
                      //                   MainAxisAlignment.spaceBetween,
                      //               crossAxisAlignment:
                      //                   CrossAxisAlignment.start,
                      //               children: [
                      //                 Row(
                      //                   children: [
                      //                     const Icon(
                      //                       Icons.breakfast_dining,
                      //                       size: 10,
                      //                     ),
                      //                     FxSpacing.width(8),
                      //                     FxText.bodySmall(
                      //                       'Breakfast',
                      //                       fontWeight: 800,
                      //                     ),
                      //                   ],
                      //                 ),
                      //                 FxSpacing.height(20),
                      //                 Row(
                      //                   children: [
                      //                     const Icon(
                      //                       FontAwesomeIcons.parking,
                      //                       size: 10,
                      //                     ),
                      //                     FxSpacing.width(8),
                      //                     FxText.bodySmall(
                      //                       'Parking',
                      //                       fontWeight: 800,
                      //                     ),
                      //                   ],
                      //                 ),
                      //               ],
                      //             ),
                      //           ),
                      //           FxSpacing.height(30),
                      //           Container(
                      //             child: Column(
                      //               mainAxisAlignment:
                      //                   MainAxisAlignment.spaceBetween,
                      //               crossAxisAlignment:
                      //                   CrossAxisAlignment.start,
                      //               children: [
                      //                 Row(
                      //                   children: [
                      //                     const Icon(
                      //                       Icons.dining,
                      //                       size: 10,
                      //                     ),
                      //                     FxSpacing.width(8),
                      //                     FxText.bodySmall(
                      //                       'Dinning',
                      //                       fontWeight: 800,
                      //                     ),
                      //                   ],
                      //                 ),
                      //                 FxSpacing.height(20),
                      //                 Row(
                      //                   children: [
                      //                     const Icon(
                      //                       Icons.wifi,
                      //                       size: 10,
                      //                     ),
                      //                     FxSpacing.width(8),
                      //                     FxText.bodySmall(
                      //                       'Free wifi',
                      //                       fontWeight: 800,
                      //                     ),
                      //                   ],
                      //                 ),
                      //               ],
                      //             ),
                      //           ),
                      //           FxSpacing.height(30),
                      //           Container(
                      //             child: Column(
                      //               mainAxisAlignment:
                      //                   MainAxisAlignment.spaceBetween,
                      //               crossAxisAlignment:
                      //                   CrossAxisAlignment.start,
                      //               children: [
                      //                 Row(
                      //                   children: [
                      //                     const Icon(
                      //                       Icons.dining,
                      //                       size: 10,
                      //                     ),
                      //                     FxSpacing.width(8),
                      //                     FxText.bodySmall(
                      //                       'Dinning',
                      //                       fontWeight: 800,
                      //                     ),
                      //                   ],
                      //                 ),
                      //                 FxSpacing.height(20),
                      //                 Row(
                      //                   children: [
                      //                     const Icon(
                      //                       Icons.wifi,
                      //                       size: 10,
                      //                     ),
                      //                     FxSpacing.width(8),
                      //                     FxText.bodySmall(
                      //                       'Wifi',
                      //                       fontWeight: 800,
                      //                     ),
                      //                   ],
                      //                 ),
                      //               ],
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //     )
                      //   ],
                      // ),
                      FxSpacing.height(15),
                      const Divider(
                        color: Colors.black,
                      ),
                      FxSpacing.height(15),
                      Text(
                        "HighLights".toUpperCase(),
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 14.0),
                      ),

                      //highlights
                      FxSpacing.height(15),

                      Container(
                        // height: 300,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.transparent,
                        // child: AnimatedList(
                        //     scrollDirection: Axis.horizontal,
                        //     // key: controller.listKey,
                        //     initialItemCount: controller.product.interests.length,
                        //     itemBuilder: (context, index, animation) {
                        //       return SlideTransition(
                        //           position: animation.drive(controller.offset),
                        //           child: controller.newCategories[index]
                        //           // child: Container(
                        //           //   color: Colors.green,
                        //           // ),
                        //           );
                        //     }),
                        child: ListView.separated(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          itemCount: controller.product.interests.length,
                          physics: const NeverScrollableScrollPhysics(),
                          separatorBuilder: (context, index) {
                            return FxSpacing.height(2);
                          },
                          itemBuilder: (context, index) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(
                                  Icons.star_border_outlined,
                                  color: Colors.black,
                                ),
                                FxSpacing.width(5),
                                Expanded(
                                  child: FxText.bodyLarge(
                                      controller.product.interests[index]),
                                ),
                              ],
                            );
                            // return StepTile(
                            //   data: controller.product,
                            // );
                          },
                        ),
                      ),
                      // const SizedBox(height: 30.0),
                      // SizedBox(
                      //   width: double.infinity,
                      //   child: ElevatedButton(
                      //     style: ElevatedButton.styleFrom(
                      //       shape: RoundedRectangleBorder(
                      //           borderRadius: BorderRadius.circular(30.0)),
                      //       // backgroundColor: Colors.purple,
                      //       // foregroundColor: Colors.white,
                      //       padding: const EdgeInsets.symmetric(
                      //         vertical: 16.0,
                      //         horizontal: 32.0,
                      //       ),
                      //     ),
                      //     child: const Text(
                      //       "Book Now",
                      //       style: TextStyle(fontWeight: FontWeight.normal),
                      //     ),
                      //     onPressed: () {},
                      //   ),
                      // ),
                      // const SizedBox(height: 30.0),
                      const Divider(
                        color: Colors.black,
                      ),
                      FxSpacing.height(15),
                      Text(
                        "Description".toUpperCase(),
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 14.0),
                      ),
                      const SizedBox(height: 10.0),
                      FxText.bodyLarge(
                        "Lorem ipsum dolor sit, amet consectetur adipisicing elit. Ratione architecto autem quasi nisi iusto eius ex dolorum velit! Atque, veniam! Atque incidunt laudantium eveniet sint quod harum facere numquam molestias?",
                        textAlign: TextAlign.justify,
                        // style: TextStyle(
                        //     fontWeight: FontWeight.w300, fontSize: 14.0),
                      ),
                      const SizedBox(height: 10.0),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 40,
            left: 10,
            right: 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: FxContainer.bordered(
                    paddingAll: 4,
                    child: Icon(
                      Icons.chevron_left_outlined,
                      color: theme.colorScheme.onBackground.withAlpha(200),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    controller.isFav
                        ? controller.animationController.reverse()
                        : controller.animationController.forward();
                  },
                  child: FxContainer.bordered(
                    paddingAll: 4,
                    child: Icon(
                      // FontAwesomeIcons.heart,
                      // color: theme.colorScheme.onBackground.withAlpha(200),
                      Icons.favorite,
                      color: controller.colorAnimation.value,
                      size: controller.sizeAnimation.value,
                    ),
                  ),
                ),
              ],
            ),
            // child: AppBar(
            //   backgroundColor: Colors.transparent,
            //   elevation: 0,

            //   centerTitle: true,
            //   title: const Text(
            //     "DETAIL",
            //     style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal),
            //   ),
            // ),
          ),
        ],
      ),
    );
  }

  Widget _buildbody2() {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var statusBarHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: statusBarHeight * 0.8),
            height: height * 0.4,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(controller.product.image),
                fit: BoxFit.cover,
              ),
            ),
            child: const Center(
              child: Text(
                'data',
                style: TextStyle(color: Colors.pink),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: height * 0.3),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(30), topLeft: Radius.circular(30)),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(
                      height: height * 0.05,
                    ),
                    Container(
                      width: width,
                      margin: EdgeInsets.only(left: width * 0.03),
                      child: const Text(
                        'NYC Food Festival',
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: width * 0.03),
                      child: Row(
                        children: <Widget>[
                          const Icon(
                            Icons.calendar_today,
                            size: 20,
                            color: Color(0xff808080),
                          ),
                          SizedBox(width: width * 0.02), // give it width
                          Column(
                            children: const <Widget>[
                              Text(
                                'Sat, May 25, 2020',
                                style: TextStyle(
                                    color: Color(0xff000000),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: width * 0.03),
                      child: Row(
                        children: <Widget>[
                          const Icon(
                            Icons.attach_money,
                            size: 20,
                            color: Color(0xff808080),
                          ),
                          SizedBox(width: width * 0.02), // give it width
                          Column(
                            children: const <Widget>[
                              Text(
                                '25,000 PKR',
                                style: TextStyle(
                                    color: Color(0xff000000),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Container(
                      width: width,
                      margin: EdgeInsets.only(left: width * 0.03),
                      child: const Text(
                        'Snaps',
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildbody1() {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              height: MediaQuery.of(context).size.height * .8,
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.red,
                image: DecorationImage(
                  image: AssetImage(
                    controller.product.image,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Stack(
            alignment: Alignment.bottomRight,
            children: <Widget>[
              // Max Size
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  color: Colors.red.shade50,
                ),
                alignment: const Alignment(1, 1),
                height: 400,
                width: 350,
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(10, 40, 100, 40),
                      child: Text(
                        "Summer  Collections",
                        style: TextStyle(
                            fontSize: 24,
                            color: Color(0xff262626),
                            fontWeight: FontWeight.w700),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 270, 100),
                      child: Text(
                        "Sizes",
                        style: TextStyle(
                            fontSize: 12,
                            color: Color(0xff262626),
                            fontWeight: FontWeight.w700),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                          style: TextButton.styleFrom(
                            side: const BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          onPressed: () {
                            print('XS');
                          },
                          child: const Text('XS'),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            side: const BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          onPressed: () {
                            print('X');
                          },
                          child: const Text('S'),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            side: const BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          onPressed: () {
                            print('M');
                          },
                          child: const Text('M'),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            side: const BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          onPressed: () {
                            print('L');
                          },
                          child: const Text('L'),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            side: const BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          onPressed: () {
                            print('XL');
                          },
                          child: const Text('XL'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(230, 110, 0, 40),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    padding: const EdgeInsets.all(15),
                  ),
                  child: const Text(
                    "Add to Cart ",
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    /*if (controller.uiLoading) {
      return Scaffold(
          body: Padding(
        padding: FxSpacing.top(FxSpacing.safeAreaTop(context)),
        child:
            LoadingEffect.getProductLoadingScreen(context, theme, theme.colorScheme),
      ));
    } else {*/
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            controller.goBack();
          },
          child: Icon(
            FeatherIcons.chevronLeft,
            size: 20,
            color: theme.colorScheme.onBackground,
          ).autoDirection(),
        ),
        actions: [
          AnimatedBuilder(
            animation: controller.animationController,
            builder: (BuildContext context, _) {
              return InkWell(
                onTap: () {
                  controller.isFav
                      ? controller.animationController.reverse()
                      : controller.animationController.forward();
                },
                child: Icon(
                  Icons.favorite,
                  color: controller.colorAnimation.value,
                  size: controller.sizeAnimation.value,
                ),
              );
            },
          ),
          AnimatedBuilder(
            animation: controller.animationController,
            builder: (BuildContext context, _) {
              return FxSpacing.width(
                  20 - (controller.sizeAnimation.value! - 24) / 2);
            },
          )
        ],
        title: FxText.titleMedium(
          controller.product.name,
          fontWeight: 600,
        ),
      ),
      body: ListView(
        padding: FxSpacing.fromLTRB(0, 4, 0, 20),
        children: [
          Hero(
            tag: "product_image_${controller.product.name}",
            child: FxContainer(
              margin: FxSpacing.x(20),
              paddingAll: 0,
              borderRadiusAll: 4,
              height: 250,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Image(
                fit: BoxFit.cover,
                image: AssetImage(controller.product.image),
              ),
            ),
          ),
          FxSpacing.height(20),
          FxContainer(
            margin: FxSpacing.x(20),
            paddingAll: 0,
            borderRadiusAll: 0,
            color: theme.scaffoldBackgroundColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 4,
                      child: Hero(
                        tag: "product_${controller.product.name}",
                        child: FxText.titleMedium(
                          controller.product.name,
                          fontWeight: 700,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Hero(
                        tag:
                            "${controller.product.name}_${controller.product.rating}",
                        child: FxContainer(
                          borderRadiusAll: 4,
                          padding: FxSpacing.xy(10, 6),
                          color: theme.colorScheme.primary,
                          child: Center(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  FeatherIcons.star,
                                  color: theme.colorScheme.onPrimary,
                                  size: 14,
                                ),
                                FxSpacing.width(6),
                                FxText.labelLarge(
                                  controller.product.rating.toString(),
                                  fontWeight: 600,
                                  color: theme.colorScheme.onSecondary,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Hero(
                  tag: "${controller.product.name}_${controller.product.price}",
                  child: FxText.titleMedium(
                    '\$${controller.product.price}',
                    fontWeight: 600,
                  ),
                ),
                FxSpacing.height(20),
                FxText.bodySmall(
                  controller.product.description.toParagraph(true),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                // FxSpacing.height(20),
                // FxText.bodyMedium(
                //   'Size',
                //   fontWeight: 600,
                // ),
                // FxSpacing.height(8),
                // _buildSizeWidget(),
              ],
            ),
          ),
          FxSpacing.height(20),
          Container(
            margin: FxSpacing.x(20),
            child: FxButton.block(
              splashColor: theme.colorScheme.onPrimary.withAlpha(40),
              backgroundColor: theme.colorScheme.primary,
              elevation: 0,
              borderRadiusAll: 4,
              onPressed: () {
                controller.addCart
                    ? controller.cartController.reverse()
                    : controller.cartController.forward();
                // controller.goToCheckout();
              },
              child: FxText.bodyLarge(
                'Book Now',
                fontWeight: 600,
                color: Colors.white,
                // color: theme.colorScheme.onPrimary,
              ),
            ),
          ),
          FxSpacing.height(20),
          Container(
            padding: FxSpacing.x(20),
            child: Row(
              children: [
                FxText.bodyLarge(
                  'Related',
                  letterSpacing: 0,
                  fontWeight: 600,
                ),
              ],
            ),
          ),
          FxSpacing.height(20),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: _buildProductList(),
          ),
        ],
      ),
    );
    //  }
  }
}
