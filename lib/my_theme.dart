import 'package:flutter/material.dart';

class mytheme {
  static Color black = Color(0xff383838);
  static Color primarycolor = Color(0xff5D9CEC);
  static Color bglight = Color(0xffcde1c3);
  static Color bgdark = Color(0xff060e1e);
  static Color green = Color(0xff6be761);
  static Color white = Colors.white;
  static Color darkblack = Color(0xff141922);
  static Color grey = Color(0xffC8C9CB);

  static ThemeData lighttheme = ThemeData(
      scaffoldBackgroundColor: bglight,
      primaryColor: primarycolor,
      appBarTheme: AppBarTheme(
          backgroundColor: mytheme.primarycolor,
          elevation: 0,
          iconTheme: IconThemeData(color: black)),
      textTheme: TextTheme(
        titleLarge:
            TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: white),
        titleMedium:
            TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: black),
        titleSmall:
            TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: black),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(primarycolor))),
      floatingActionButtonTheme:
          FloatingActionButtonThemeData(backgroundColor: primarycolor),
      bottomSheetTheme: BottomSheetThemeData(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20)))),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: primarycolor,
          showUnselectedLabels: false,
          selectedIconTheme: IconThemeData(size: 30)));

  static ThemeData darkTheme = ThemeData(
    primaryColor: primarycolor,
    scaffoldBackgroundColor: bgdark,
    appBarTheme: AppBarTheme(
      backgroundColor: mytheme.primarycolor,
      elevation: 0,
      iconTheme: IconThemeData(
        color: white,
      ),
    ),
    textTheme: TextTheme(
      titleLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: white,
      ),
      titleMedium: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: white,
      ),
      titleSmall: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        color: grey,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(primarycolor))),
    floatingActionButtonTheme:
        FloatingActionButtonThemeData(backgroundColor: primarycolor),
    bottomSheetTheme: BottomSheetThemeData(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)))),
    bottomAppBarTheme: BottomAppBarTheme(color: darkblack),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.transparent,
        elevation: 0,
        selectedItemColor: primarycolor,
        unselectedItemColor: grey,
        showUnselectedLabels: false,
        selectedIconTheme: IconThemeData(size: 30)),
  );
}
