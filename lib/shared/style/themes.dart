import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop_app/shared/style/colors.dart';

ThemeData lightTheme=ThemeData(fontFamily: 'Jannah',
    textTheme: TextTheme(
        bodyText1: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 17,
            color: lightBlackLT),
        bodyText2: TextStyle(
            fontSize: 19,
            color: lightBlackLT),
        headline1: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: lightBlackLT)),
    primarySwatch: primaryColor,
    scaffoldBackgroundColor: darkWhiteLT,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: darkWhiteLT,
        selectedItemColor: primaryColor,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.grey,
        elevation: 20),
    appBarTheme: AppBarTheme(brightness:  Brightness.dark,iconTheme: IconThemeData(color: lightBlackLT),
        elevation: 5,
        actionsIconTheme: IconThemeData(color: lightBlackLT),
        titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: lightBlackLT),
        backgroundColor: darkWhiteLT,
        backwardsCompatibility: false,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark,
            statusBarColor: darkWhiteLT)));
ThemeData darkTheme=ThemeData(fontFamily: 'Jannah',
    primarySwatch: primaryColor,
    textTheme: TextTheme(
        bodyText1: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 17,
            color: darkWhiteDT),
        bodyText2: TextStyle(
            fontSize: 19,
            color: darkWhiteDT),
        headline1: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: darkWhiteDT)
    ),
    scaffoldBackgroundColor: lightBlackDT,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: lightBlackDT,
        selectedItemColor: primaryColor,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.grey,
        elevation: 20),
    appBarTheme: AppBarTheme(
        elevation: 5,
        iconTheme: IconThemeData(color: darkWhiteDT),
        // actionsIconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: darkWhiteDT),
        backgroundColor: lightBlackDT,
        backwardsCompatibility: false,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.light,
            statusBarColor: lightBlackDT)));