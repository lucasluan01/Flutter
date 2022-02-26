import 'package:flutter/material.dart';

ThemeData themeData(BuildContext context) {
  return ThemeData(
    primarySwatch: Colors.blue,
  );
}

ThemeData darkThemeData(BuildContext context) {
  return ThemeData(
    primarySwatch: Colors.red,
    switchTheme: SwitchThemeData(
      trackColor: MaterialStateProperty.all<Color>(Colors.red.shade900),
      thumbColor: MaterialStateProperty.all<Color>(Colors.white),
    ),
    textTheme: const TextTheme(
        headline4: TextStyle(fontSize: 40, color: Colors.white)),
  );
}
