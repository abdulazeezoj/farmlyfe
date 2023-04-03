import 'dart:convert';

import 'package:farmlyfe/app/configs/firebase.dart';
import 'package:farmlyfe/app/configs/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:json_theme/json_theme.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize Json Theme
  final themeString = await rootBundle.loadString('assets/theme/light_theme.json');
  final themeJson = jsonDecode(themeString);
  final themedata = ThemeDecoder.decodeThemeData(themeJson);

  runApp(FarmLyfeApp(theme: themedata));
}

class FarmLyfeApp extends StatelessWidget {
  final ThemeData? theme;

  const FarmLyfeApp({super.key, required this.theme});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FarmLyfe',
      theme: theme,
      initialRoute: FarmLyfeRoutes.crop,
      getPages: FarmLyfePages.pages,
    );
  }
}
