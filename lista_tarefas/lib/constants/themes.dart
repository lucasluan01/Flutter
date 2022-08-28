import 'package:flutter/material.dart';

ThemeData darkThemeData(BuildContext context) {
  return ThemeData(
    scaffoldBackgroundColor: const Color(0xff121212),
    appBarTheme: AppBarTheme(
      backgroundColor: const Color(0xff262626),
      titleTextStyle: TextStyle(
        color: Colors.white.withOpacity(0.87),
        fontSize: 20,
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.teal.shade500,
    ),
    switchTheme: SwitchThemeData(
      trackColor: MaterialStateProperty.all<Color>(Colors.grey.shade600),
      thumbColor: MaterialStateProperty.all<Color>(Colors.white),
    ),
    textTheme: TextTheme(
      bodyText2: TextStyle(
        color: Colors.white.withOpacity(0.6),
      ),
    ),
  );
}
