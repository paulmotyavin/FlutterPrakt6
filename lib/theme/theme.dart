import 'package:flutter/material.dart';

ThemeData firstMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    background: Colors.blueGrey.shade100,
    primary: Colors.blue.shade600,
    secondary: Colors.yellow.shade600,
  ),
  appBarTheme: AppBarTheme(
    color: Colors.blue.shade800,
  ),
);

ThemeData secondMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    background: Colors.black,
    primary: Colors.red.shade900,
    secondary: Colors.grey.shade800,
  ),
  appBarTheme: AppBarTheme(
    color: Colors.red.shade700,
  ),
);
