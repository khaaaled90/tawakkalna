import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'dart:async';
import 'tawakkalna_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // الانتقال تلقائيًا بعد 3 ثواني (أو حسب طول اللوتي)
    Timer(const Duration(seconds: 8), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (_) => const TawakkalnaScreen()), // استبدل بـ شاشة البداية
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // خلفية بيضاء أو أي لون
      body: Center(
        child: Lottie.asset(
          'assets/lottie/splash_screen_loading_lottie_first.json',
          width: 500, // حجم اللوتي
          height: 500,
          fit: BoxFit.contain,
          repeat: false, // تشغيل مرة واحدة فقط
        ),
      ),
    );
  }
}
