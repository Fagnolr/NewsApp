import 'package:flutter/material.dart';

class AppTheme {
  const AppTheme._();
  static final lightTheme = ThemeData(
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: const Color(0xffF5F5F5),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  static final darkTheme = ThemeData(
    primarySwatch: Colors.blue,
    primaryColor: AppColors.scaffoldColor,
    scaffoldBackgroundColor: AppColors.scaffoldColor,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    fontFamily: 'Metropolis',
    textTheme: const TextTheme(
      bodyText1: TextStyle(),
      bodyText2: TextStyle(),
    ).apply(
      bodyColor: Colors.white,
      displayColor: Colors.white,
    ),
  );
}

class AppColors {
  static const scaffoldColor = Color(0xff1A1E25);
}
