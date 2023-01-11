import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:iconsax/iconsax.dart';

import '../models/TopAttraction.dart';

class AttractionTile extends StatelessWidget {
  const AttractionTile({required this.data});
  final TopAttraction data;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5.0),
      // width: 800,
      height: 155,
      decoration: BoxDecoration(
          // color: Color(0xffe6e1e5),
          color: Colors.white,
          // color: Color(0xffe5fdfd),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(color: Colors.grey.shade300, width: 1)
          // color: theme!.colorScheme.onPrimaryContainer,
          ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.all(8),
            height: 150,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image: AssetImage(data.image.toString()
                        // 'assets/images/apps/shopping2/images/Ferraiworld.jpg',
                        ),
                    fit: BoxFit.fill)),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          data.types.toString(),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            data.rating.toString(),
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
          ),
          FxSpacing.height(20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: FxText.bodyLarge(
              // 'Ferrari world',
              data.titlename.toString(),
              fontWeight: 800,
            ),
          ),
          FxSpacing.height(10),
          Padding(
            // padding: EdgeInsets.symmetric(horizontal: 0),
            padding: const EdgeInsets.only(right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            data.location.toString(),
                            // product.price.toString() + " " + "USD",
                            // "\$" + product.price.toString() + "/hour",
                            // fontWeight: 700,
                          ),
                        ],
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
                FxText(
                  data.price.toString(),
                  color: const Color(0xff1529e8),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
