import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:hotel_travel/controllers/Detail_controller.dart';
import 'package:hotel_travel/views/detail_screen/review_Screen.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../controllers/attraction_Controller.dart';
import '../../loading_effect.dart';
import '../../theme/app_theme.dart';

class DetailScreen extends StatefulWidget {
  final String productid;

  const DetailScreen(
    this.productid, {
    Key? key,
  }) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen>
    with TickerProviderStateMixin {
  late ThemeData theme;
  late OutlineInputBorder outlineInputBorder;
  late DetailController controller;
  bool isLoading = true;

  // List<DetailattractionModal> detailattraction = <DetailattractionModal>[];

  getDetailAttraction() {
    log('getDetail Attraction function called');
    Future.delayed(Duration.zero, () async {
      await AttractionController()
          .getDetailattractionList(productid: widget.productid)
          .then((value) {
        log('Details => $value');
        if (value != null) {
          isLoading = false;
          setState(() {
            controller.detailattraction = value;
          });
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    controller = FxControllerStore.put(DetailController(
      this,
      //  widget.productid
    ));
    getDetailAttraction();
    theme = AppTheme.shoppingTheme;

    outlineInputBorder = const OutlineInputBorder(
        borderSide: BorderSide(
            color: Color(0xff1529e8),
            // color: Colors.lightBlueAccent,
            width: 0));
  }

  @override
  Widget build(BuildContext context) {
    return FxBuilder<DetailController>(
        controller: controller,
        builder: (controller) {
          return _buildnew();
        });
  }

  Widget _buildnew() {
    log('buildnew');
    log(controller.detailattraction.toString());
    if (controller.detailattraction.isEmpty)
    // if (controller.uiLoading)
    {
      log('detail');
      log(controller.detailattraction.length.toString());
      log('name${controller.detailattraction}');
      return Scaffold(
          body: Padding(
        padding: FxSpacing.top(FxSpacing.safeAreaTop(context) + 20),
        child: LoadingEffect.getHomeLoadingScreen
            // getProductLoadingScreen->profile
            //getDatingHomeScreen->detail

            (
          context,
          // theme, theme.colorScheme
        ),
      ));
    } else {
      return Scaffold(
          backgroundColor: const Color(0xfff5f5f5),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15),
            child: FxButton.block(
              onPressed: () {
                controller.bookNow();
                // cartController.carts.add(Cart());
              },
              backgroundColor: const Color(0xff1529e8),
              // backgroundColor: customTheme.estatePrimary,
              borderRadiusAll: 12,

              elevation: 0,
              child: FxText.bodyMedium(
                'Add to Cart',
                color: Colors.white,
                // color: customTheme.estateOnPrimary,
                fontWeight: 700,
              ),
            ),
          ),
          body: ListView(
            padding: EdgeInsets.zero,
            physics: const ClampingScrollPhysics(),
            children: <Widget>[
              Stack(
                children: <Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 3,
                    child: PageView.builder(
                        pageSnapping: true,
                        physics: const ClampingScrollPhysics(),
                        controller: controller.pageController,
                        onPageChanged: (int page) {
                          setState(() {
                            controller.currentPage = page;
                          });
                        },
                        itemCount:
                            controller.detailattraction.first.images.length,
                        itemBuilder: (context, index) {
                          return Container(
                            child: Image(
                              image: NetworkImage(
                                  'https://a.walletbot.online/${controller.detailattraction.first.images[index]}'),
                              height: MediaQuery.of(context).size.height / 3,
                              width: MediaQuery.of(context).size.width,
                              fit: BoxFit.fill,
                            ),
                          );
                        }),
                  ),
                  Positioned(
                    top: 24,
                    child: IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(
                        MdiIcons.chevronLeft,
                        color: Colors.black,
                      ),
                    ),
                  )
                ],
              ),
              Container(
                padding: const EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
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
                                  controller.detailattraction.first.category
                                      .categoryName,
                                  // controller.product.bookingType.toString(),
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
                          FxSpacing.height(10),
                          FxText.titleMedium(
                              // controller.product.title,
                              controller.detailattraction.first.title,
                              fontWeight: 600,
                              letterSpacing: 0),
                          Container(
                            margin: const EdgeInsets.only(top: 4),
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  MdiIcons.mapMarker,
                                  color: theme.colorScheme.onBackground,
                                  size: 16,
                                ),
                                Container(
                                    margin: const EdgeInsets.only(left: 2),
                                    child: FxText.bodySmall(
                                        controller.detailattraction.first.title,
                                        fontWeight: 500)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        ClipOval(
                          child: Material(
                            color: const Color(0xff1529e8).withAlpha(24),
                            child: InkWell(
                              splashColor:
                                  const Color(0xff1529e8).withAlpha(100),
                              highlightColor:
                                  const Color(0xff1529e8).withAlpha(20),
                              child: SizedBox(
                                  width: 44,
                                  height: 44,
                                  child: Icon(
                                    MdiIcons.shareOutline,
                                    size: 22,
                                    color:
                                        const Color(0xff1529e8).withAlpha(240),
                                  )),
                              onTap: () {},
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 8),
                          child: ClipOval(
                            child: Material(
                              color: const Color(0xff1529e8).withAlpha(24),
                              child: InkWell(
                                highlightColor:
                                    const Color(0xff1529e8).withAlpha(20),
                                splashColor:
                                    const Color(0xff1529e8).withAlpha(100),
                                child: const SizedBox(
                                    width: 44,
                                    height: 44,
                                    child: Icon(
                                      MdiIcons.heartOutline,
                                      size: 20,
                                      color: Color(0xff1529e8),
                                    )),
                                onTap: () {},
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(bottom: 8, left: 16, right: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        FxText.bodyMedium("Price", fontWeight: 500),
                        FxText.bodyMedium(
                            // "350 \$",
                            '${controller.detailattraction.first.activities.first.adultPrice} AED',
                            // controller.product.price.toString(),
                            fontWeight: 700)
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 32),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          FxText.bodyMedium("Rating", fontWeight: 500),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              FxText.bodyMedium(
                                  controller
                                      .detailattraction.first.averageRating
                                      .toString(),
                                  fontWeight: 700),
                              Container(
                                  margin: const EdgeInsets.only(left: 4),
                                  child: FxStarRating(rating: 4.1))
                            ],
                          )
                        ],
                      ),
                    ),
                    Expanded(child: Container()),
                    FxContainer(
                      onTap: () {
                        log('review Screen clicked');
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ReviewScreen()));
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
              ),
              Container(
                // padding: const EdgeInsets.all(32.0),
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30)),
                    color: Color(0xfff5f5f5)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    // Container(
                    //   // margin: const EdgeInsets.all(5.0),
                    //   // width: 800,
                    //   height: 100,
                    //   decoration: BoxDecoration(
                    //       // color: Color(0xffe6e1e5),
                    //       color: Colors.white,
                    //       // color: Color(0xffe5fdfd),
                    //       borderRadius:
                    //           const BorderRadius.all(Radius.circular(10)),
                    //       border:
                    //           Border.all(color: Colors.grey.shade300, width: 1)
                    //       // color: theme!.colorScheme.onPrimaryContainer,
                    //       ),
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //     children: [
                    //       Padding(
                    //         padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    //         child: Row(
                    //           crossAxisAlignment: CrossAxisAlignment.center,
                    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //           children: [
                    //             Row(
                    //               children: [
                    //                 FxContainer(
                    //                   borderRadiusAll: 10,
                    //                   // padding: FxSpacing.xy(8, 4),
                    //                   padding: FxSpacing.xy(6, 2),
                    //                   // color: Color(0xff1529e8),
                    //                   color: Colors.blueGrey,
                    //                   child: FxText.bodySmall(
                    //                     // 'Theme Park',
                    //                     controller.product.types.toString(),
                    //                     fontWeight: 300,
                    //                     color: Colors.white,
                    //                     // color: theme.colorScheme.onPrimary,
                    //                   ),
                    //                 ),
                    //                 const SizedBox(
                    //                   width: 5,
                    //                 ),
                    //                 FxContainer(
                    //                   borderRadiusAll: 10,
                    //                   // padding: FxSpacing.xy(8, 4),
                    //                   padding: FxSpacing.xy(6, 2),
                    //                   // color: Color(0xff1529e8),
                    //                   color: Colors.blueGrey,
                    //                   child: FxText.bodySmall(
                    //                     'Ticket',
                    //                     fontWeight: 300,
                    //                     color: Colors.white,
                    //                     // color: theme.colorScheme.onPrimary,
                    //                   ),
                    //                 ),
                    //                 const SizedBox(
                    //                   width: 5,
                    //                 ),
                    //                 FxContainer(
                    //                   borderRadiusAll: 10,
                    //                   // padding: FxSpacing.xy(8, 4),
                    //                   padding: FxSpacing.xy(6, 2),
                    //                   // color: Color(0xff1529e8),
                    //                   color: Colors.blueGrey,
                    //                   child: FxText.bodySmall(
                    //                     'Offer',
                    //                     fontWeight: 300,
                    //                     color: Colors.white,
                    //                     // color: theme.colorScheme.onPrimary,
                    //                   ),
                    //                 ),
                    //               ],
                    //             ),
                    //             Row(
                    //               mainAxisAlignment:
                    //                   MainAxisAlignment.spaceBetween,
                    //               children: [
                    //                 Row(
                    //                   children: [
                    //                     const Icon(
                    //                       // FeatherIcons.star,
                    //                       Icons.star,
                    //                       color: Colors.yellow,
                    //                       size: 12,
                    //                     ),
                    //                     FxSpacing.width(4),
                    //                     FxText.bodySmall(
                    //                       // '4.5',
                    //                       controller.product.rating.toString(),
                    //                       fontWeight: 600,
                    //                       color: Colors.black,
                    //                     ),
                    //                   ],
                    //                 ),
                    //               ],
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //       // FxSpacing.height(20),
                    //       Padding(
                    //         padding: const EdgeInsets.symmetric(horizontal: 8),
                    //         child: FxText.bodyLarge(
                    //           // 'Ferrari world',
                    //           controller.product.name.toString(),
                    //           fontWeight: 800,
                    //         ),
                    //       ),
                    //       // FxSpacing.height(10),
                    //       Padding(
                    //         // padding: EdgeInsets.symmetric(horizontal: 0),
                    //         padding: const EdgeInsets.only(right: 8),
                    //         child: Row(
                    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //           children: [
                    //             Row(
                    //               mainAxisAlignment:
                    //                   MainAxisAlignment.spaceBetween,
                    //               children: [
                    //                 FxContainer(
                    //                   borderRadiusAll: 8,
                    //                   padding: FxSpacing.xy(8, 4),
                    //                   // color: theme.colorScheme.primary,
                    //                   // color: Colors.yellow.shade400,
                    //                   color: Colors.white,
                    //                   child: Row(
                    //                     children: [
                    //                       const Icon(
                    //                         Iconsax.location,
                    //                         color: Colors.black,
                    //                         // color: theme.colorScheme.onPrimary,
                    //                         size: 12,
                    //                       ),
                    //                       FxSpacing.width(4),
                    //                       FxText.labelLarge(
                    //                         // '\$' + product.price.toString(),
                    //                         controller.product.location
                    //                             .toString(),
                    //                         // product.price.toString() + " " + "AED",
                    //                         // "\$" + product.price.toString() + "/hour",
                    //                         // fontWeight: 700,
                    //                       ),
                    //                     ],
                    //                   ),
                    //                 ),
                    //               ],
                    //             ),
                    //             FxText(
                    //               controller.product.price.toString(),
                    //               color: const Color(0xff1529e8),
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),

                    // FxSpacing.height(15),
                    // Container(
                    //   height: 80,
                    //   decoration: BoxDecoration(
                    //       // color: Color(0xffe6e1e5),
                    //       color: Colors.white,
                    //       // color: Color(0xffe5fdfd),
                    //       borderRadius:
                    //           const BorderRadius.all(Radius.circular(10)),
                    //       border:
                    //           Border.all(color: Colors.grey.shade300, width: 1)
                    //       // color: theme!.colorScheme.onPrimaryContainer,
                    //       ),
                    //   padding: const EdgeInsets.only(left: 8.0, right: 8),
                    //   child: Column(
                    //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       Row(
                    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //         children: [
                    //           FxText.labelLarge(
                    //             // '\$' + product.price.toString(),
                    //             'Per Person',
                    //             // product.price.toString() + " " + "AED",
                    //             // "\$" + product.price.toString() + "/hour",
                    //             // fontWeight: 700,
                    //           ),
                    //           FxText.bodyLarge(
                    //             // '\$140 ',
                    //             '140 AED ',
                    //             color: Colors.indigo,
                    //             fontWeight: 900,
                    //             // color: const Color(0xff1529e8),
                    //           ),
                    //         ],
                    //       ),
                    //       Row(
                    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           FxText.bodyMedium(
                    //             '4.5/5 - Good',
                    //             fontWeight: 900,
                    //             color: Colors.black,
                    //             // color: theme.colorScheme.onPrimary,
                    //           ),
                    //           FxContainer(
                    //             onTap: () {
                    //               log('review Screen clicked');
                    //               Navigator.push(
                    //                   context,
                    //                   MaterialPageRoute(
                    //                       builder: (context) => ReviewScreen()));
                    //             },
                    //             padding: FxSpacing.fromLTRB(8, 6, 8, 6),
                    //             color: const Color(0xff1529e8).withAlpha(40),
                    //             // color:Color(0xff6874E8),
                    //             // customTheme.groceryPrimary.withAlpha(40),
                    //             child: Row(
                    //               mainAxisSize: MainAxisSize.min,
                    //               children: [
                    //                 FxText.bodyMedium("(243 review)",
                    //                     color: const Color(0xff1529e8),
                    //                     // color: customTheme.groceryPrimary,
                    //                     fontWeight: 500,
                    //                     letterSpacing: -0.2),
                    //                 const Icon(
                    //                   MdiIcons.chevronRight,
                    //                   size: 14,
                    //                   color: Color(0xff1529e8),
                    //                 )
                    //               ],
                    //             ),
                    //           )
                    //         ],
                    //       ),
                    //     ],
                    //   ),
                    // ),

                    //tabbar
                    Container(
                      height: 60,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.transparent,
                      child: TabBar(
                        controller: controller.tabController,
                        onTap: (index) {
                          setState(() {
                            controller.tabController.index = index;
                          });
                        },
                        labelColor: Colors.black,
                        unselectedLabelColor: Colors.black.withOpacity(0.6),
                        labelStyle: const TextStyle(
                            fontFamily: 'inter', fontWeight: FontWeight.w500),
                        indicatorColor: Colors.black,
                        isScrollable: true,
                        tabs: const [
                          Tab(
                            text: 'Description',
                          ),
                          Tab(
                            text: 'Overview',
                          ),
                          Tab(
                            text: 'Highlights',
                          ),
                        ],
                      ),
                    ),

                    //indexedStack
                    IndexedStack(
                      index: controller.tabController.index,
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          itemCount: 1,
                          // itemCount: controller.product.description.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return const Text('Description');
                            // return StepTile(
                            //   // data: widget.data.tutorial[index],
                            //   data: widget.product,
                            // );
                          },
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          itemCount: controller.detailattraction.first.sections
                              .first.body.length,
                          // itemCount: controller.product.description.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Text(controller
                                .detailattraction.first.sections.first.body);
                            // return StepTile(
                            //   // data: widget.data.tutorial[index],
                            //   data: widget.product,
                            // );
                          },
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          itemCount: controller
                              .detailattraction.first.highlights.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Text(controller
                                .detailattraction.first.highlights
                                .toString());
                            // return StepTile(
                            //   // data: widget.data.tutorial[index],
                            //   data: widget.product,
                            // );
                          },
                        ),
                      ],
                    ),

                    //touroption
                    FxSpacing.height(15),
                    // _billingWidget(),
                    // _buildoption(),

                    FxSpacing.height(15),
                    Container(
                        decoration: BoxDecoration(
                            // color: Color(0xffe6e1e5),
                            color: Colors.white,
                            // color: Color(0xffe5fdfd),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            border: Border.all(
                                color: Colors.grey.shade300, width: 1)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Contact Details".toUpperCase(),
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 14.0),
                            ),
                            const SizedBox(height: 10.0),
                            FxText.bodyLarge(
                              'Sheikh Zayed Rd - Dubai - United Arab Emirates\n www.dubaiparksandresorts.com \n ph.No:+9718002629464',
                              textAlign: TextAlign.justify,
                              // style: TextStyle(
                              //     fontWeight: FontWeight.w300, fontSize: 14.0),
                            ),
                          ],
                        )),

                    const SizedBox(height: 10.0),
                  ],
                ),
              ),
            ],
          ));
    }
  }
}
