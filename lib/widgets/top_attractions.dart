import 'package:flutter/material.dart';
import 'package:hotel_travel/card_widgets/attraction_tile.dart';
import 'package:hotel_travel/models/TopAttraction.dart';

import '../helperdata/helper.dart';

class TopAttractionCard extends StatefulWidget {
  const TopAttractionCard({Key? key}) : super(key: key);

  @override
  State<TopAttractionCard> createState() => _TopAttractionCardState();
}

class _TopAttractionCardState extends State<TopAttractionCard> {
  final List<TopAttraction> recentattraction =
      ActivityHelper.newlyTopAttraction;
  List<TopAttraction> searchResult = ActivityHelper.newlyTopAttraction;
  List<TopAttraction>? foundCompany;
  // late ThemeData theme;
  @override
  void initState() {
    foundCompany = searchResult;
    super.initState();
    // theme = AppTheme.shoppingTheme;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      height: 280,
      child: ListView.builder(
        itemExtent: 250,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          // return AttractionTile();
          return AttractionTile(data: recentattraction[index]);
        },
        // itemBuilder: (context, index) => Container(
        //       margin: EdgeInsets.all(5.0),
        //       // width: 800,
        //       height: 150,
        //       decoration: BoxDecoration(
        //         color: Color(0xffe6e1e5),
        //         // color: Color(0xffe5fdfd),
        //         borderRadius: BorderRadius.all(Radius.circular(10)),
        //         // color: theme!.colorScheme.onPrimaryContainer,
        //       ),
        //       child: Column(
        //         children: [
        //           Container(
        //             height: 200,

        //             decoration:BoxDecoration(image: DecorationImage(image: AssetImage(recentattraction[index].))) ,
        //           )
        //         ],
        //       ),
        //     ),
        itemCount: foundCompany!.length,
        // itemCount: recentattraction.length
      ),
    );
  }
}
