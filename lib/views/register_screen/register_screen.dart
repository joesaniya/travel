import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import '/theme/app_theme.dart';

import '../../controllers/register_controller.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with TickerProviderStateMixin {
  late ThemeData theme;

  late RegisterController controller;

  late OutlineInputBorder outlineInputBorder;
  // final TextEditingController controller = TextEditingController();
  String initialCountry = 'IN';
  PhoneNumber number = PhoneNumber(isoCode: 'IN');

  //manual
  final TextEditingController _phnocontroller = TextEditingController();
  final bool _isLoading = false;

  String? _selectedCountryCode;
  final List<String> _countryCodes = ['+91', '+23'];

  bool _obscureText = true;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void initState() {
    super.initState();
    theme = AppTheme.shoppingTheme;

    controller = FxControllerStore.put(RegisterController(this));

    outlineInputBorder = const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      borderSide: BorderSide(
        color: Colors.transparent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FxBuilder<RegisterController>(
        controller: controller,
        builder: (controller) {
          return _buildBody();
        });
  }

  Widget _buildBody() {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: FxSpacing.fromLTRB(20, 0, 20, 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          // padding: FxSpacing.fromLTRB(
          //     20, FxSpacing.safeAreaTop(context) + 48, 20, 20),

          children: [
            FxText.displaySmall(
              'Register',
              fontWeight: 700,
              textAlign: TextAlign.center,
            ),
            FxSpacing.height(20),
            FxText.bodyMedium(
              'Sign up to get started!',
              muted: true,
              textAlign: TextAlign.center,
            ),
            FxSpacing.height(32),
            Form(
              key: controller.formKey,
              child: Column(
                children: [
                  SlideTransition(
                    position: controller.nameAnimation,
                    child: TextFormField(
                      style: FxTextStyle.bodyMedium(),
                      decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          filled: true,
                          isDense: true,
                          fillColor: theme.cardTheme.color,
                          prefixIcon: Icon(
                            FeatherIcons.user,
                            color: theme.colorScheme.onBackground,
                          ),
                          hintText: "Name",
                          enabledBorder: outlineInputBorder,
                          focusedBorder: outlineInputBorder,
                          border: outlineInputBorder,
                          contentPadding: FxSpacing.all(16),
                          hintStyle: FxTextStyle.bodyMedium(),
                          isCollapsed: true),
                      maxLines: 1,
                      controller: controller.nameTE,
                      validator: controller.validateName,
                      cursorColor: theme.colorScheme.onBackground,
                    ),
                  ),
                  FxSpacing.height(20),
                  SlideTransition(
                    position: controller.emailAnimation,
                    child: TextFormField(
                      style: FxTextStyle.bodyMedium(),
                      decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          filled: true,
                          isDense: true,
                          fillColor: theme.cardTheme.color,
                          prefixIcon: Icon(
                            FeatherIcons.mail,
                            color: theme.colorScheme.onBackground,
                          ),
                          hintText: "Email Address",
                          enabledBorder: outlineInputBorder,
                          focusedBorder: outlineInputBorder,
                          border: outlineInputBorder,
                          contentPadding: FxSpacing.all(16),
                          hintStyle: FxTextStyle.bodyMedium(),
                          isCollapsed: true),
                      maxLines: 1,
                      controller: controller.emailTE,
                      validator: controller.validateEmail,
                      cursorColor: theme.colorScheme.onBackground,
                    ),
                  ),
                  FxSpacing.height(20),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: theme.cardTheme.color,
                            // color: const Color(0xff1529e8),
                            borderRadius: BorderRadius.circular(0)),
                        height: 45.0,
                        width: 68,
                        // margin: const EdgeInsets.all(3.0),
                        //width: 300.0,
                        child: DropdownButtonHideUnderline(
                          child: ButtonTheme(
                            alignedDropdown: true,
                            child: DropdownButton(
                              iconSize: 0.0,

                              dropdownColor: theme.cardTheme.color,
                              // dropdownColor: Colors.blueAccent,
                              // icon: Icon(icon),
                              value: controller.selectedCountryCode,
                              // value: _selectedCountryCode,
                              hint: Center(
                                child: FxText.labelLarge(
                                  "Code",
                                  fontWeight: 600,
                                  color: Colors.black,
                                  // color: theme.colorScheme.onPrimary,
                                  letterSpacing: 0.4,
                                ),
                                // child: Text(
                                //   'code',
                                //   style: TextStyle(
                                //       color: Colors.white,
                                //       fontSize: 20,
                                //       fontWeight: FontWeight.w500),
                                // ),
                              ),
                              items: controller.countryCodes.map
                                  // _countryCodes.map
                                  ((String value) {
                                return DropdownMenuItem<String>(
                                    value: value,
                                    child: Center(
                                      child: Text(
                                        value,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ));
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  controller.selectedCountryCode =
                                      value.toString();
                                  // _selectedCountryCode = value.toString();
                                });
                              },
                              style: FxTextStyle.bodyMedium(),
                              // style: const TextStyle(
                              //     color: Colors.black,
                              //     fontSize: 20,
                              //     fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: SlideTransition(
                          position: controller.phoneAnimation,
                          child: TextFormField(
                            style: FxTextStyle.bodyMedium(),
                            decoration: InputDecoration(
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                filled: true,
                                isDense: true,
                                fillColor: theme.cardTheme.color,
                                hintText: "Phone Number",
                                enabledBorder: outlineInputBorder,
                                focusedBorder: outlineInputBorder,
                                border: outlineInputBorder,
                                contentPadding: FxSpacing.all(16),
                                hintStyle: FxTextStyle.bodyMedium(),
                                isCollapsed: true),
                            maxLines: 1,
                            controller: controller.phoneTE,
                            validator: controller.validateMobile,
                            cursorColor: theme.colorScheme.onBackground,
                          ),
                        ),
                      ),
                    ],
                  ),
                  // SizedBox(
                  //   width: 4,
                  // ),

                  //phone

                  // SlideTransition(
                  //   position: controller.phoneAnimation,
                  //   child: Container(
                  //     // height: 20,
                  //     // width: 298,
                  //     // margin: const EdgeInsets.only(left: 48, right: 79),
                  //     color: theme.cardTheme.color,
                  //     padding: FxSpacing.only(left: 16),
                  //     child: InternationalPhoneNumberInput(
                  //       textStyle: FxTextStyle.bodyMedium(),
                  //       //                        autoValidate: false,
                  //       autoValidateMode: AutovalidateMode.disabled,
                  //       selectorTextStyle: FxTextStyle.bodyMedium(),
                  //       initialValue: number,

                  //       textFieldController: controller.phoneTE,

                  //       inputDecoration: InputDecoration(
                  //         focusedBorder:
                  //             UnderlineInputBorder(borderSide: BorderSide.none),
                  //         focusedErrorBorder:
                  //             UnderlineInputBorder(borderSide: BorderSide.none),
                  //         errorBorder:
                  //             UnderlineInputBorder(borderSide: BorderSide.none),
                  //         disabledBorder:
                  //             UnderlineInputBorder(borderSide: BorderSide.none),
                  //         border:
                  //             UnderlineInputBorder(borderSide: BorderSide.none),
                  //         // enabledBorder: UnderlineInputBorder(
                  //         //     borderSide:
                  //         //         BorderSide(color: Colors.pink)),
                  //         //                          contentPadding: EdgeInsets.only(left: 0.0),
                  //         hintText: 'Phone Number',
                  //         hintStyle: FxTextStyle.bodyMedium(),

                  //         isDense: true,
                  //       ),

                  //       selectorConfig: const SelectorConfig(
                  //           selectorType: PhoneInputSelectorType.DIALOG),
                  //       onInputChanged: (PhoneNumber number) {
                  //         print(number.phoneNumber);
                  //       },
                  //     ),
                  //   ),
                  // ),
                  FxSpacing.height(20),
                  SlideTransition(
                    position: controller.passwordAnimation,
                    child: TextFormField(
                      style: FxTextStyle.bodyMedium(),
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                          suffixIconColor: Colors.grey,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            color: Colors.grey,
                            onPressed: _toggle,
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          filled: true,
                          isDense: true,
                          fillColor: theme.cardTheme.color,
                          prefixIcon: Icon(
                            FeatherIcons.lock,
                            color: theme.colorScheme.onBackground,
                          ),
                          hintText: "Password",
                          enabledBorder: outlineInputBorder,
                          focusedBorder: outlineInputBorder,
                          border: outlineInputBorder,
                          contentPadding: FxSpacing.all(16),
                          hintStyle: FxTextStyle.bodyMedium(),
                          isCollapsed: true),
                      maxLines: 1,
                      controller: controller.passwordTE,
                      validator: controller.validatePassword,
                      cursorColor: theme.colorScheme.onBackground,
                    ),
                  ),
                ],
              ),
            ),
            FxSpacing.height(20),
            FxButton.block(
              elevation: 0,
              borderRadiusAll: 4,
              onPressed: () {
                controller.register();
              },
              splashColor: theme.colorScheme.onPrimary.withAlpha(30),
              backgroundColor: const Color(0xff1529e8),
              // backgroundColor: theme.colorScheme.primary,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FxText.labelLarge(
                    "Create Account",
                    fontWeight: 600,
                    color: theme.colorScheme.onPrimary,
                    letterSpacing: 0.4,
                  ),
                  FxSpacing.width(8),
                  SlideTransition(
                    position: controller.arrowAnimation,
                    child: Icon(
                      FeatherIcons.arrowRight,
                      color: theme.colorScheme.onPrimary,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
            // FxSpacing.height(20),
            // Row(
            //   children: [
            //     Expanded(child: Divider()),
            //     Padding(
            //       padding: FxSpacing.x(20),
            //       child: FxText.bodySmall(
            //         'Continue with',
            //         muted: true,
            //         fontWeight: 600,
            //         fontSize: 10,
            //       ),
            //     ),
            //     Expanded(child: Divider()),
            //   ],
            // ),
            // FxSpacing.height(24),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: [
            //     FxContainer.bordered(
            //       padding: FxSpacing.all(16),
            //       borderRadiusAll: 8,
            //       child: Image(
            //         height: 24,
            //         width: 24,
            //         image: AssetImage(Images.google),
            //       ),
            //     ),
            //     FxContainer.bordered(
            //       padding: FxSpacing.all(16),
            //       borderRadiusAll: 8,
            //       child: Image(
            //         height: 24,
            //         width: 24,
            //         image: AssetImage(Images.apple),
            //       ),
            //     ),
            //     FxContainer.bordered(
            //       padding: FxSpacing.all(16),
            //       borderRadiusAll: 8,
            //       child: Image(
            //         height: 24,
            //         width: 24,
            //         image: AssetImage(Images.facebook),
            //       ),
            //     ),
            //   ],
            // ),
            FxSpacing.height(20),
            Center(
              child: FxButton.text(
                onPressed: () {
                  controller.goToLogInScreen();
                },
                splashColor: theme.colorScheme.primary.withAlpha(40),
                child: FxText.labelLarge(
                  "I have an Account",
                  decoration: TextDecoration.underline,
                  // color: theme.colorScheme.primary
                  color: const Color(0xff1529e8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
