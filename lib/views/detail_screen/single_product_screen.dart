import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';
import 'package:hotel_travel/extensions/extensions.dart';

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
          return _buildBody();
          // return _buildbody2();
        });
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
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(controller.product.image),
                fit: BoxFit.fill,
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
                color: theme.colorScheme.onPrimary,
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
