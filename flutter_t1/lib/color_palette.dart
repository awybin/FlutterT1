import 'package:flutter/material.dart';

// Each color should have 4 bytes, and the first byte represents the opacity
// To make it opaque we should use 0xFF and then add the 3 bytes of the color hex
class ColorPalette extends MaterialColor {
  static const primaryBlue = Color(0xFF407BFF);
  static const secondaryBlue = Color(0xFF3267DC);
  static const primaryRed = Color(0xFFFB654E);
  static const secondaryRed = Color(0xFFD95643);
  static const backgroundRed = Color(0xFFFFAEAE);

  static const surveyYellow = Color(0xFFE5C859);
  static const surveyGreen = Color(0xFF54B270);
  static const surveyRed = Color(0xFFFF725E);
  static const surveyPurple = Color(0xFF9C67E7);

  ColorPalette(int primary, Map<int, Color> swatch) : super(primary, swatch);
}
