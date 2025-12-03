import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
//import 'NationalIDScreen.dart';
//import 'PassportIDScreen.dart';
//import 'NationalIDScreen1.dart';
//import 'tawakkalna_screen.dart';
import 'SplashScreen.dart';

void main() => runApp(const MyApp());

//const Color _accentColor = Color(0xFF7B8BFF);
//const Color _indicatorColor = Color(0xFF6B7CFF);
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: const Locale('ar'),
      supportedLocales: const [
        Locale('ar'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      // أهم جزء ↓↓↓↓↓↓↓↓↓
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: child!,
        );
      },

      theme: ThemeData(
        fontFamily: 'NotoSansArabic',
        scaffoldBackgroundColor: Colors.white,
      ),

      home: const SplashScreen(),
      /*theme: ThemeData(
        fontFamily: 'Tajawal', // الخط الافتراضي
      ),*/
      /*locale: const Locale('ar', 'SA'), // اللغة العربية
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,*/
      //],
    );
  }
}
