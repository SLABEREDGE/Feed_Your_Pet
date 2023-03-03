import 'package:flutter/material.dart';

class Styles {
  static Color scaffoldBackgroundColor = const Color(0xFFe0efff);
  static Color defaultRedColor = const Color(0xffff698a);
  static Color defaultYellowColor = const Color(0xFFfedd69);
  static Color defaultBlueColor = const Color(0xff52beff);
  static Color defaultGreyColor = const Color(0xff77839a);
  static Color defaultLightGreyColor = const Color(0xffc4c4c4);
  static Color defaultLightWhiteColor = const Color(0xFFf2f6fe);
  static Color defaultWhiteColor = const Color(0xFFffffff);
  static Color defaultBlackColor = const Color(0xFF000000);
  static Color defaultOliveGreenColor = const Color(0xFF3D550C);
  static Color defaultLimeGreenColor = const Color(0xFF81B622);
  static Color defaultYellowGreenColor = const Color(0xFFECF87F);
  static Color defaultGreenColor = const Color(0xFF59981A);

  static double defaultPadding = 18.0;

  static BorderRadius defaultBorderRadius = BorderRadius.circular(20);

  static ScrollbarThemeData scrollbarTheme =
  const ScrollbarThemeData().copyWith(
    thumbColor: MaterialStateProperty.all(defaultYellowColor),
    isAlwaysShown: false,
    interactive: true,
  );
}