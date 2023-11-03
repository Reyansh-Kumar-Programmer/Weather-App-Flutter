import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    background: Color(0xffFFFFFF),
    primary: Colors.grey.shade700,
    secondary: Colors.grey.shade800,
  )
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    background: Color(0xff141414),
    primary: Colors.grey.shade700,
    secondary: Colors.white70,
  )
);