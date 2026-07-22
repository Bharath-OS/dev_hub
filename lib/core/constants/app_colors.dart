import 'package:flutter/material.dart';

class AppPalette{
  static const primary = Color(0xff2D1ACF);
  static const bgColor = Color(0xff2D1ACF);
  static const white = Color(0xffffffff);
  static const black = Color(0xff111111);

  static const secondary = Color(0xff6B7280);
  static const tertiary = Color(0xff8A2200);
  static const neutral = Color(0xff787681);

  //signin page gradient
  static const gradientColor = Color(0xffD2CBFD);
  static const gradient = LinearGradient(colors: [Colors.transparent, Color(0xaaD1CAFD)],begin: Alignment.topCenter,
    end: Alignment.bottomCenter,);

  //Font colors
  static const headingTextColor = Color(0xff111827);
  static const mutedTextColor = Color(0xff6B7280);
}