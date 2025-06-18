import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'color.dart';

class AppTheme {
  static TextTheme appTextLightTheme = TextTheme(
    displayLarge: GoogleFonts.inter(fontSize: 32, fontWeight: FontWeight.bold, color: primaryLight),
    displayMedium: GoogleFonts.inter(fontSize: 28, fontWeight: FontWeight.bold, color: primaryLight),
    displaySmall: GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.w600, color: primaryLight),
    headlineMedium: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w600, color: primaryLight),
    headlineSmall: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600, color: primaryLight),
    headlineLarge: GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.bold, color: primaryLight),
    titleLarge: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.bold, color: primaryLight),
    titleMedium: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.bold, color: primaryLight),
    bodyLarge: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.normal, color: primaryLight),
    bodyMedium: GoogleFonts.inter(fontSize: 14, color: primaryLight),
    bodySmall: GoogleFonts.inter(fontSize: 12, color: primaryLight),
    labelLarge: GoogleFonts.inter(fontSize: 12, color: labelColor),
  );

  static TextTheme appTextDarkTheme = TextTheme(
    displayLarge: GoogleFonts.inter(fontSize: 32, fontWeight: FontWeight.bold, color: primaryDark),
    displayMedium: GoogleFonts.inter(fontSize: 28, fontWeight: FontWeight.bold, color: primaryDark),
    displaySmall: GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.w600, color: primaryDark),
    headlineMedium: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w600, color: primaryDark),
    headlineSmall: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600, color: primaryDark),
    headlineLarge: GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.w600, color: primaryDark),
    titleLarge: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.bold, color: primaryDark),
    titleMedium: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.bold, color: primaryDark),
    bodyLarge: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.normal, color: primaryDark),
    bodyMedium: GoogleFonts.inter(fontSize: 14, color: primaryDark),
    bodySmall: GoogleFonts.inter(fontSize: 12, color: primaryDark),
    labelLarge: GoogleFonts.inter(fontSize: 12, color: labelColor),
  );


  final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: primaryLight,
    cardColor: cardLightColor,
    shadowColor: Colors.black,
    scaffoldBackgroundColor: appLightBgColor,
    fontFamily: GoogleFonts.inter().fontFamily,
    drawerTheme: DrawerThemeData(
      backgroundColor: drawerLightBgColor,
    ),
    appBarTheme: AppBarTheme(
      surfaceTintColor: cardLightColor,
      backgroundColor: cardLightColor,
      elevation: 6,
      shadowColor: Colors.black.withOpacity(0.1),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
      ),
      iconTheme: IconThemeData(color: mainColor),
      titleTextStyle: TextStyle(color: mainColor, fontSize: 20, fontWeight: FontWeight.w600),
    ),

    textTheme: appTextLightTheme,
    iconTheme: IconThemeData(color: mainColor),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: bottomBarColor,
      selectedItemColor: primaryLight,
      unselectedItemColor: inActiveColor,
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: textBoxColor,
      filled: true,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
      hintStyle: TextStyle(color: labelColor),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: secondary,
      foregroundColor: Colors.white,
    ),
  );

  final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: primaryDark,
    scaffoldBackgroundColor: appDarkBgColor,
    drawerTheme: DrawerThemeData(
      backgroundColor: drawerDarkBgColor,
    ),
    fontFamily: GoogleFonts.inter().fontFamily,
    appBarTheme: AppBarTheme(
      surfaceTintColor: cardDarkColor,
      backgroundColor: cardDarkColor,
      elevation: 6,
      shadowColor: Colors.black.withOpacity(0.1),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
      ),
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
    ),
    cardColor: cardDarkColor,
    shadowColor: shadowColor,
    textTheme: appTextDarkTheme,
    iconTheme: IconThemeData(color: Colors.white),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: bottomBarColor,
      selectedItemColor: secondary,
      unselectedItemColor: inActiveColor,
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: mainColor,
      filled: true,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
      hintStyle: TextStyle(color: labelColor),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: secondary,
      foregroundColor: Colors.black,
    ),
  );
}