/**
 * Creating custom color palettes is part of creating a custom app. The idea is to create
 * your class of custom colors, in this case `CompanyColors` and then create a `ThemeData`
 * object with those colors you just defined.
 *
 * Resource:
 * A good resource would be this website: http://mcg.mbitson.com/
 * You simply need to put in the colour you wish to use, and it will generate all shades
 * for you. Your primary colour will be the `500` value.
 *
 * Colour Creation:
 * In order to create the custom colours you need to create a `Map<int, Color>` object
 * which will have all the shade values. `const Color(0xFF...)` will be how you create
 * the colours. The six character hex code is what follows. If you wanted the colour
 * #114488 or #D39090 as primary colours in your theme, then you would have
 * `const Color(0x114488)` and `const Color(0xD39090)`, respectively.
 *
 * Usage:
 * In order to use this newly created theme or even the colours in it, you would just
 * `import` this file in your project, anywhere you needed it.
 * `import 'path/to/theme.dart';`
 */

import 'package:flutter/material.dart';

final ThemeData themeData = new ThemeData(
    scaffoldBackgroundColor: Colors.white,
    fontFamily: 'Roboto',
    cursorColor: Color(0xfff7d955),
    canvasColor: Colors.white,
    brightness: Brightness.light,
    primarySwatch: MaterialColor(AppColors.blue[400].value, AppColors.blue),
    primaryColor: AppColors.blue[400],
    primaryColorBrightness: Brightness.light,
    accentColor: Color(0xfff7d955),
    bottomSheetTheme: BottomSheetThemeData(backgroundColor: Colors.transparent),
    accentColorBrightness: Brightness.light);

class AppColors {
  AppColors._(); // this basically makes it so you can instantiate this class

//ref : https://materialpalettes.com/    && Primary color:#5574F7
  static const Map<int, Color> blue = const <int, Color>{
    50: const Color(0xffe9ecfe),
    100: const Color(0xffc8cefc),
    200: const Color(0xffa2aefa),
    300: const Color(0xff788ef9),
    400: const Color(0xff5573f7),
    500: const Color(0xff2b58f3),
    600: const Color(0xff244fe7),
    700: const Color(0xff1443da),
    800: const Color(0xff0038cf),
    900: const Color(0xff0022b7)
  };
}
