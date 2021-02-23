import 'package:flutter/material.dart';

/*This class is used to customization for app theme.
* */
final ThemeData customThemeData = new ThemeData(
  brightness: Brightness.light,
  primarySwatch:
      MaterialColor(CustomColors.white[900].value, CustomColors.white),
  primaryColor: CustomColors.white[900],
  //primaryColorBrightness: Platform.isAndroid ? Brightness.light : Brightness.dark,
  accentColor: Colors.red,
  //CustomColors.blue[900],
  // accentColorBrightness: Brightness.dark,
  primaryColorDark: Colors.purple,
  /* textTheme: GoogleFonts.aBeeZeeTextTheme(
    Theme.of(context).textTheme,
  ),*/
);

//Here We need to pass the colors as per app theme.
class CustomColors {
  CustomColors._(); // this basically makes it so you can instantiate this class
  static const Map<int, Color> white = const <int, Color>{
    50: const Color(0xFFFFFFFF),
    100: const Color(0xFFFFFFFF),
    200: const Color(0xFFFFFFFF),
    300: const Color(0xFFFFFFFF),
    400: const Color(0xFFFFFFFF),
    500: const Color(0xFFFFFFFF),
    600: const Color(0xFFFFFFFF),
    700: const Color(0xFFFFFFFF),
    800: const Color(0xFFFFFFFF),
    900: const Color(0xFFFFFFFF),
  };
}
