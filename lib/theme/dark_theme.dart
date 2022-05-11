import 'package:flutter/material.dart';
import 'package:six_cash/util/color_resources.dart';

ThemeData dark = ThemeData(
  fontFamily: 'Roboto',
  primaryColor: Color(0xFF689da7),
  brightness: Brightness.dark,
  secondaryHeaderColor: Color(0xFFe6f174),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(backgroundColor: ColorResources.blackColor,selectedItemColor: ColorResources.themeDarkBackgroundColor),
);
