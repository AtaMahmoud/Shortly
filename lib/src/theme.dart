import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../src/util/hex_color.dart';

class AppTheme {
  static final Color cyan = HexColor("#2ACFCF");
  static final Color darkViolet = HexColor("#3B3054");
  static final Color red = HexColor("#F46262");
  static final Color lightGray = HexColor("#BFBFBF");
  static final Color gray = HexColor("#9E9AA7");
  static final Color grayishViolet = HexColor("#35323E");
  static final Color veryDarkViolet = HexColor("#232127");
  static final Color offWhite = HexColor("#F0F1F6");

  final _headLine1 = GoogleFonts.poppins(
    fontWeight: FontWeight.w700,
    fontSize: 20,
    color: grayishViolet,
  );

  final _headLine2 = GoogleFonts.poppins(
    fontWeight: FontWeight.w700,
    fontSize: 18,
    color: grayishViolet,
  );

  final _bodyText1 = GoogleFonts.poppins(
    fontWeight: FontWeight.w500,
    fontSize: 16,
    color: grayishViolet,
  );

  ThemeData get theme {
    return ThemeData.light().copyWith(
        primaryColor: cyan,
        accentColor: darkViolet,
        textTheme: TextTheme(
            headline1: _headLine1,
            headline2: _headLine2,
            bodyText1: _bodyText1));
  }
}
