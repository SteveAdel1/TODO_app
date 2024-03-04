import 'package:flutter/material.dart';

class ApplicationThemeManager {
  static const Color primaryColor = Color(0xFF5D9CEC);
  static ThemeData lighttheme = ThemeData(
    scaffoldBackgroundColor: Color(0xFFDFECDB),
    primaryColor: primaryColor,
    useMaterial3: true,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.transparent,
      elevation: 0,
      selectedItemColor: primaryColor,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedIconTheme: IconThemeData(color: primaryColor, size: 38),
      unselectedIconTheme: IconThemeData(color: Color(0xFFC8C9CB), size: 30),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
      //shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular())
    ),
    bottomAppBarTheme:
        const BottomAppBarTheme(padding: EdgeInsets.zero, color: Colors.white),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
          fontFamily: "Poppians",
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: Colors.white),
      bodyLarge: TextStyle(
          fontFamily: "Poppians",
          fontSize: 25,
          fontWeight: FontWeight.bold,
          color: Colors.black87),
      bodyMedium: TextStyle(
          fontFamily: "Poppians",
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black87),
      bodySmall: TextStyle(
          fontFamily: "Poppians",
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: Colors.black87),
      displayLarge: TextStyle(
          fontFamily: "Poppians",
          fontSize: 15,
          fontWeight: FontWeight.normal,
          color: Colors.black87),
    ),
    appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        toolbarHeight: 120,
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(color: Colors.white)),
  );

  static ThemeData darktheme = ThemeData(
    primaryColor: primaryColor,
    useMaterial3: true,
    scaffoldBackgroundColor: Color(0xFF060E1E),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.transparent,
        elevation: 0,
        selectedItemColor: primaryColor,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedIconTheme: IconThemeData(color: primaryColor, size: 38),
        unselectedIconTheme: IconThemeData(color: Color(0xFFC8C9CB), size: 30)),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
    ),
    bottomAppBarTheme: const BottomAppBarTheme(
      padding: EdgeInsets.zero,
      color: Color(0xFF141922),
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
          fontFamily: "Poppians",
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: Colors.white),
      bodyLarge: TextStyle(
          fontFamily: "Poppians",
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white),
      bodyMedium: TextStyle(
          fontFamily: "Poppians",
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: Colors.white),
      bodySmall: TextStyle(
          fontSize: 14,
          fontFamily: "Poppians",
          fontWeight: FontWeight.normal,
          color: Colors.white),
      displayLarge: TextStyle(
          fontFamily: "Poppians",
          fontSize: 15,
          fontWeight: FontWeight.normal,
          color: Colors.black87),
    ),
    appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        toolbarHeight: 120,
        iconTheme: IconThemeData(
          color: Color(0xFF141922),
        ),
        titleTextStyle: TextStyle(
          color: Color(0xFF141922),
        )),
  );
}
