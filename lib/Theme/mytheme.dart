import 'dart:ui';

import 'package:flutter/material.dart';

class MyTheme {
  static const Color darkGrayColor = Color(0xff282A28);
  static const Color backgroundColor = Color(0xff121312);
  static const Color yellowColor = Color(0xffF7B539);
  static const Color mediumGrayColor = Color(0xff343534);
  static const Color offWhiteColor = Color(0xffC6C6C6);
  static const Color whiteColor = Color(0xffFFFFFF);
  static const Color lightYellowColor = Color(0xffFFBB3B);
  static const Color grayColor = Color(0xffB5B4B4);
  static const Color bottomColor = Color(0xff1A1A1A);
  static const Color searchColor = Color(0xff514F4F);

static ThemeData lightTheme = ThemeData(
    textTheme: const TextTheme(
        titleLarge: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: whiteColor,
        ),
        titleMedium: TextStyle(
          fontSize: 14,
          color: whiteColor,
        ),
        titleSmall: TextStyle(
            color: grayColor, fontSize: 10))

);
}