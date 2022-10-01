import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData theme() {
  return ThemeData(
      dividerColor: Colors.transparent,
      inputDecorationTheme: InputDecorationTheme(
        isDense: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      ),
      primarySwatch: Colors.green,
      primaryColor: Color.fromARGB(255, 38, 93, 48),
      primaryColorDark: Color.fromARGB(255, 16, 43, 21),
      // ignore: deprecated_member_use
      accentColor: Color.fromARGB(255, 38, 93, 48),
      primaryColorLight: Color(0xFFFE9AAA),
      scaffoldBackgroundColor: Color.fromARGB(255, 255, 255, 255),
      backgroundColor: Color(0xFFF5F5F5),
      fontFamily: 'Poppins',
      textTheme: TextTheme(
        headline1: TextStyle(
          color: Color(0xFF1B070B),
          fontWeight: FontWeight.bold,
          fontSize: 36,
        ),
        headline2: TextStyle(
          color: Color(0xFF1B070B),
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
        headline3: TextStyle(
          color: Color(0xFF1B070B),
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
        headline4: TextStyle(
          color: Color(0xFF1B070B),
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
        headline5: TextStyle(
          color: Color(0xFF1B070B),
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
        headline6: TextStyle(
          color: Color(0xFF1B070B),
          fontWeight: FontWeight.normal,
          fontSize: 14,
        ),
        bodyText1: TextStyle(
          color: Color(0xFF1B070B),
          fontWeight: FontWeight.normal,
          fontSize: 12,
        ),
        bodyText2: TextStyle(
          color: Color(0xFF1B070B),
          fontWeight: FontWeight.normal,
          fontSize: 10,
        ),
      ));
}
