import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';

import '../theme/app_theme.dart';

class AttractionTile extends StatefulWidget {
  @override
  State<AttractionTile> createState() => _AttractionTileState();
}

class _AttractionTileState extends State<AttractionTile> {
  late ThemeData theme, theme1;

  @override
  void initState() {
    super.initState();
    theme = AppTheme.shoppingTheme;
    theme1 = AppTheme.learningTheme;
  }

  // final TopAttraction data;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5.0),
      // width: 800,
      height: 150,
      decoration: BoxDecoration(
          // color: Color(0xffe6e1e5),
          color: Colors.white,
          // color: Color(0xffe5fdfd),
          borderRadius: BorderRadius.all(Radius.circular(10)),
          border: Border.all(color: Colors.grey.shade300, width: 1)
          // color: theme!.colorScheme.onPrimaryContainer,
          ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.all(8),
            height: 150,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image: AssetImage(
                      'assets/images/apps/shopping2/images/Ferraiworld.jpg',
                    ),
                    fit: BoxFit.fill)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Expanded(
                //   child: Container(
                //     // width: 200,
                //     color: Color(0xff1529e8),
                //     height: 20,
                //     child: Text('Theme Park',sty),
                //   ),
                // ),
                FxContainer(
                  borderRadiusAll: 10,
                  padding: FxSpacing.xy(8, 4),
                  color: Color(0xff1529e8),
                  child: FxText.bodySmall(
                    'Theme Park',
                    fontWeight: 600,
                    color: Colors.white,
                    // color: theme.colorScheme.onPrimary,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FxContainer(
                      borderRadiusAll: 2,
                      padding: FxSpacing.xy(8, 4),
                      // color: Color(0xff5563e8),
                      color: Color.fromARGB(255, 248, 223, 2),
                      // color: theme.colorScheme.primary,
                      child: Row(
                        children: [
                          Icon(
                            FeatherIcons.star,
                            color: theme1.colorScheme.onPrimary,
                            size: 12,
                          ),
                          FxSpacing.width(4),
                          FxText.bodySmall(
                            '4.5',
                            fontWeight: 600,
                            color: theme.colorScheme.onPrimary,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          FxSpacing.height(20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: FxText.bodyMedium(
              'Ferrari world',
            ),
          ),
          FxSpacing.height(10),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
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
                          Icon(
                            Icons.location_city,
                            color: Colors.black,
                            // color: theme.colorScheme.onPrimary,
                            size: 12,
                          ),
                          FxSpacing.width(4),
                          FxText.labelLarge(
                            // '\$' + product.price.toString(),
                            'Abu Dhabi',
                            // product.price.toString() + " " + "USD",
                            // "\$" + product.price.toString() + "/hour",
                            fontWeight: 700,
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
                  '35 AED',
                  color: Color(0xff1529e8),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
