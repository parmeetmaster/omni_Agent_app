import 'package:flutter/material.dart';
import 'package:six_cash/util/color_resources.dart';

ThemeData light = ThemeData(
  brightness: Brightness.light,
  fontFamily: 'Rubik',
  primaryColor: Color(0xFF003E47),
  secondaryHeaderColor: Color(0xFFE0EC53),
  highlightColor: Color(0xFF003E47),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(backgroundColor: ColorResources.whiteColor,selectedItemColor: ColorResources.themeLightBackgroundColor),

);