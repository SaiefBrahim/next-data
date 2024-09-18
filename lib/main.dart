import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:next_data_saief_brahim/helpers/app_theme.dart';
import 'package:next_data_saief_brahim/views/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          pageTransitionsTheme: const PageTransitionsTheme(builders: {
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
            TargetPlatform.android: ZoomPageTransitionsBuilder(),
          }),
          primaryColor: AppTheme.primary),
      home: const SplashScreen(),
      //home: const TerritoryScreen(),
    );
  }
}
