import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

class ThemeConfig {
  static ThemeData lightTheme({required BuildContext context}) => ThemeData(
        useMaterial3: true,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(
            color: CupertinoColors.black,
          ),
        ).apply(
          decorationColor: Colors.red,
          bodyColor: CupertinoColors.black,
          displayColor: Colors.blue,
        ),
        primaryColor: CupertinoColors.white,
        scaffoldBackgroundColor: CupertinoColors.white,
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: CupertinoColors.secondarySystemFill,
          labelStyle: TextStyle(color: CupertinoColors.black),

          prefixStyle: TextStyle(color: CupertinoColors.systemGrey),
          hintStyle: TextStyle(color: Colors.white70),
          // enabledBorder: OutlineInputBorder(
          //   borderSide: BorderSide(color: Colors.white),
          // ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          // focusedBorder: OutlineInputBorder(
          //   borderSide: BorderSide(color: Colors.blue),
          // ),
        ),
        appBarTheme: const AppBarTheme(
            centerTitle: false,
            backgroundColor: CupertinoColors.white,
            titleTextStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17,
              color: CupertinoColors.black,
            ),
            elevation: 0,
            iconTheme: IconThemeData(
              color: Colors.black,
            )),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: HexColor.fromHex('#00BFA6'),
          ),
        ),
        checkboxTheme: CheckboxThemeData(
          fillColor: MaterialStateProperty.all(HexColor.fromHex('#00BFA6')),
        ),
        colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: HexColor.fromHex('#00BFA6'),
              background: CupertinoColors.activeGreen,
            ),
      );
//DARK THEME
  static ThemeData darkTheme({required BuildContext context}) =>
      ThemeData.dark().copyWith(
        useMaterial3: true,
        primaryColor: CupertinoColors.systemFill,
        textTheme: TextTheme(
          bodyLarge: TextStyle(
            color: CupertinoColors.white,
          ),
        ).apply(
          decorationColor: Colors.red,
          bodyColor: CupertinoColors.white,
          displayColor: Colors.blue,
        ),
        scaffoldBackgroundColor: CupertinoColors.black,
        appBarTheme: const AppBarTheme(
            centerTitle: false,
            backgroundColor: CupertinoColors.black,
            titleTextStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17,
                color: CupertinoColors.white),
            elevation: 0,
            iconTheme: IconThemeData(
              color: CupertinoColors.white,
            )),
        //scaffoldBackgroundColor: CupertinoColors.black,
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: CupertinoColors.systemFill.darkColor,
          labelStyle: TextStyle(color: CupertinoColors.white),

          prefixStyle: TextStyle(color: CupertinoColors.systemGrey3),
          hintStyle: TextStyle(color: Colors.white70),
          // enabledBorder: OutlineInputBorder(
          //   borderSide: BorderSide(color: Colors.white),
          // ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          // focusedBorder: OutlineInputBorder(
          //   borderSide: BorderSide(color: Colors.blue),
          // ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: HexColor.fromHex('#00BFA6'),
            //textStyle: Tex
          ),
        ),
        checkboxTheme: CheckboxThemeData(
          fillColor: MaterialStateProperty.all(HexColor.fromHex('#00BFA6')),
        ),
        //primarySwatch: Colors.green,
        colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: HexColor.fromHex('#00BFA6'),
              background: CupertinoColors.activeGreen,
              //onPrimary: HexColor.fromHex('#00BFA6')FEA853,
              //: Colors.blue,
            ),
      );
}
