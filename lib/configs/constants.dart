import 'package:flutter/material.dart';
import 'package:greenmind/Utils.dart';
import 'package:greenmind/feature/analyse/field/field_component.dart';
import 'package:greenmind/feature/create_ground/create_ground_page.dart';
import 'package:greenmind/feature/delimitation/delimit_map.dart';
import 'package:greenmind/feature/fields_page.dart/fields_page.dart';

import '../feature/vegetation_analyse/vegetation_analyse_page.dart';

const kPrimaryColor = Color(0xfff1bb274);
const kPrimaryLightColor = Color(0xfffeeeee4);

class ConstantsApp {
  static ThemeData lightTheme({required BuildContext context}) => ThemeData(
        appBarTheme: const AppBarTheme(
            centerTitle: false,
            backgroundColor: Colors.white,
            titleTextStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17,
              color: Colors.black,
            ),
            elevation: 0,
            iconTheme: IconThemeData(
              color: Colors.black,
            )),
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
              primary: HexColor.fromHex('#00a878'),
              //onPrimary: HexColor.fromHex('#00BFA6'),
              //: Colors.blue,
            ),
      );

  static Map<PageIndex, Widget> listPages = {
    PageIndex.HOME: DelimiteMap(),
    PageIndex.ANALYSE: VegetationAnalysePage(),
    PageIndex.FIELDS: FieldPage(),
  };
}

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}
