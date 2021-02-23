

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trade_inn/home/home_screen.dart';
import 'package:trade_inn/utility/constants.dart';
import 'package:trade_inn/utility/theme.dart';
import 'localization/locale_constant.dart';
import 'localization/localizations_delegate.dart';
import 'login/login_screen.dart';
import 'utility/shared_preference_utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.white, // navigation bar color
    statusBarColor: Colors.white,
    statusBarBrightness: Brightness.dark, // status bar color
  ));
  await PreferenceUtils.init();
  await Firebase.initializeApp();
  ///Check if user Logged In
  var isLoggedIn = PreferenceUtils.getBool(Constants.IS_LOGGED_IN);
  runApp(MyApp(
    isLoggedIn: isLoggedIn == null ? false : isLoggedIn,
  ));
  
}

class MyApp extends StatefulWidget {
  final bool isLoggedIn;

  const MyApp({Key key, @required this.isLoggedIn}) : super(key: key);

  static void setLocale(BuildContext context, Locale newLocale) {
    var state = context.findAncestorStateOfType<_MyAppState>();
    state.setLocale(newLocale);
  }

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  Locale _locale;

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() async {
    getLocale().then((locale) {
      setState(() {
        _locale = locale;
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TradeInn',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch:
            MaterialColor(CustomColors.white[900].value, CustomColors.white),
        primaryColor: CustomColors.white[900],
        textTheme: GoogleFonts.aBeeZeeTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      locale: _locale,
      home: widget.isLoggedIn
          ? HomeScreen(
              userName: 'User Name',
            )
          : LoginScreen(),
      supportedLocales: [
        Locale('en', ''),
        Locale('es', '')
      ],
      localizationsDelegates: [
        AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale?.languageCode == locale?.languageCode &&
              supportedLocale?.countryCode == locale?.countryCode) {
            return supportedLocale;
          }
        }
        return supportedLocales?.first;
      },
    );
  }
}
