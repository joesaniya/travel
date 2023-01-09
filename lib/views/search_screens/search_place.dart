import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';

import '../../controllers/search_controller.dart';
import '../../theme/app_theme.dart';

class SearchPlace extends StatefulWidget {
  const SearchPlace({Key? key}) : super(key: key);

  @override
  State<SearchPlace> createState() => _SearchPlaceState();
}

class _SearchPlaceState extends State<SearchPlace>
    with TickerProviderStateMixin {
  late CustomTheme customTheme;
  late ThemeData theme;
  late SearchController controller;
  // late LogInController controller;
  // late OutlineInputBorder outlineInputBorder;
  TextEditingController dateinput = TextEditingController();

  @override
  void initState() {
    super.initState();
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;
    controller = FxControllerStore.put(SearchController(this));
  }

  @override
  Widget build(BuildContext context) {
    return FxBuilder<SearchController>(
        controller: controller,
        builder: (controller) {
          return Container(
            // padding: FxSpacing.top(FxSpacing.safeAreaTop(context) + 48),
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 24, right: 24, top: 36),
                  child: FxContainer.none(
                    borderRadiusAll: 4,
                    child: Column(
                      children: <Widget>[
                        SlideTransition(
                          position: controller.locationAnimation,
                          child: TextFormField(
                            style: FxTextStyle.bodyMedium(),
                            // style: FxTextStyle.bodyLarge(
                            //     fontWeight: 600, letterSpacing: 0.2),
                            // decoration: InputDecoration(
                            //   suffixIcon: Icon(Icons.location_city),
                            //   hintStyle: FxTextStyle.bodyLarge(
                            //       fontWeight: 600,
                            //       letterSpacing: 0,
                            //       color: theme.colorScheme.onBackground
                            //           .withAlpha(180)),
                            //   hintText: "Where do you Want to see?",
                            //   border: InputBorder.none,
                            //   enabledBorder: InputBorder.none,
                            //   focusedBorder: InputBorder.none,
                            //   isDense: true,
                            //   contentPadding: EdgeInsets.all(16),
                            // ),
                            decoration: InputDecoration(
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                filled: true,
                                isDense: true,
                                fillColor: theme.cardTheme.color,
                                suffixIcon: Icon(
                                  FeatherIcons.map,
                                  color: theme.colorScheme.onBackground,
                                ),
                                hintText: "Where do you want to see?",
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                contentPadding: FxSpacing.all(16),
                                hintStyle: FxTextStyle.bodyMedium(),
                                isCollapsed: true),
                            maxLines: 1,
                            controller: controller.locationTE,
                            // validator: controller.validatePassword,
                            cursorColor: theme.colorScheme.onBackground,
                          ),
                        ),
                        Divider(
                          // color: theme.dividerColor,
                          color: theme.colorScheme.secondary,
                          height: 0.5,
                        ),
                        SlideTransition(
                          position: controller.dateAnimation,
                          child: TextFormField(
                            style: FxTextStyle.bodyMedium(),
                            controller: controller.dateTE,
                            readOnly:
                                true, //set it true, so that user will not able to edit text
                            // onTap: () async {
                            //   DateTime? pickedDate = await showDatePicker(
                            //       context: context,
                            //       initialDate: DateTime.now(),
                            //       firstDate: DateTime(
                            //           1900), //DateTime.now() - not to allow to choose before today.
                            //       lastDate: DateTime(2101));

                            //   if (pickedDate != null) {
                            //     print(
                            //         pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                            //     String formattedDate =
                            //         DateFormat('yyyy-MM-dd').format(pickedDate);
                            //     print(
                            //         formattedDate); //formatted date output using intl package =>  2021-03-16
                            //     //you can implement different kind of Date Format here according to your requirement

                            //     setState(() {
                            //       dateinput.text =
                            //           formattedDate; //set output date to TextField value.
                            //     });
                            //   } else {
                            //     print("Date is not selected");
                            //   }
                            // },
                            onTap: controller.dateselect,
                            decoration: InputDecoration(
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                filled: true,
                                isDense: true,
                                fillColor: theme.cardTheme.color,
                                suffixIcon: Icon(
                                  FeatherIcons.calendar,
                                  color: theme.colorScheme.onBackground,
                                ),
                                hintText: "yyyy-mm-dd",
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                contentPadding: FxSpacing.all(16),
                                hintStyle: FxTextStyle.bodyMedium(),
                                isCollapsed: true),
                            autofocus: false,
                            keyboardType: TextInputType.emailAddress,
                          ),
                        ),
                        // Divider(
                        //   // color: theme.dividerColor,
                        //   color: theme.colorScheme.secondary,
                        //   height: 0.5,
                        // ),
                        // SlideTransition(
                        //   position: controller.locationAnimation,
                        //   child: TextFormField(
                        //     style: FxTextStyle.bodyMedium(),
                        //     decoration: InputDecoration(
                        //         floatingLabelBehavior:
                        //             FloatingLabelBehavior.never,
                        //         filled: true,
                        //         isDense: true,
                        //         fillColor: theme.cardTheme.color,
                        //         prefixIcon: Icon(
                        //           FeatherIcons.lock,
                        //           color: theme.colorScheme.onBackground,
                        //         ),
                        //         hintText: "Password",
                        //         // enabledBorder: outlineInputBorder,
                        //         // focusedBorder: outlineInputBorder,
                        //         // border: outlineInputBorder,
                        //         contentPadding: FxSpacing.all(16),
                        //         hintStyle: FxTextStyle.bodyMedium(),
                        //         isCollapsed: true),
                        //     maxLines: 1,
                        //     controller: controller.locationTE,
                        //     // validator: controller.validatePassword,
                        //     cursorColor: theme.colorScheme.onBackground,
                        //   ),
                        // ),

//demo
                        // TextFormField(
                        //   style: FxTextStyle.bodyLarge(
                        //       fontWeight: 600, letterSpacing: 0.2),
                        //   decoration: InputDecoration(
                        //     hintStyle: FxTextStyle.bodyLarge(
                        //         fontWeight: 600,
                        //         letterSpacing: 0,
                        //         color: theme.colorScheme.onBackground.withAlpha(180)),
                        //     hintText: "Your Password",
                        //     border: InputBorder.none,
                        //     enabledBorder: InputBorder.none,
                        //     focusedBorder: InputBorder.none,
                        //     isDense: true,
                        //     contentPadding: EdgeInsets.all(16),
                        //   ),
                        //   autofocus: false,
                        //   textCapitalization: TextCapitalization.sentences,
                        //   obscureText: true,
                        // )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
