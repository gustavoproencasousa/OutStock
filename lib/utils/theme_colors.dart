import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum ThemeStatus { Dark, Light, System }

class MainTheme {
  static Color teal = const Color.fromRGBO(93, 166, 158, 1);
  static Color orange = const Color.fromRGBO(242, 171, 49, 1);
  static Color darkBlue = const Color.fromRGBO(40, 102, 117, 1);
  
  static Color lightGrey = const Color.fromRGBO(217, 217, 217, 1);
  static Color grey = const Color.fromRGBO(150, 150, 150, 1.0);
  static Color black = const Color.fromRGBO(38, 38, 38, 1);
  static Color white = const Color.fromRGBO(242, 242, 242, 1);
  static Color red = const Color.fromRGBO(217, 4, 4, 1);
  static Color darkRed = const Color.fromRGBO(151, 37, 26, 1.0);

  static ThemeData lightTheme = ThemeData(
    fontFamily: 'ResolveLight',
    useMaterial3: false,
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: darkBlue,
      onPrimary:  white,
      secondary: darkBlue,
      onSecondary: white,
      error: red,
      onError: Color.fromRGBO(242, 242, 242, 1),
      background: teal,
      onBackground: Color.fromRGBO(38, 38, 38, 1),
      surface: Color.fromRGBO(242, 242, 242, 1),
      onSurface: Color.fromRGBO(38, 38, 38, 1),
      tertiary: Color.fromRGBO(217, 217, 217, 1),
    ),
    canvasColor: teal,
    primaryColor: const Color.fromRGBO(242, 242, 242, 1),
  );
}
