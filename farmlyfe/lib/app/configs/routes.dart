// ignore_for_file: constant_identifier_names

import 'package:farmlyfe/app/bindings/auth.dart';
import 'package:farmlyfe/app/bindings/crop.dart';
import 'package:farmlyfe/app/bindings/profile.dart';
import 'package:farmlyfe/app/bindings/weather.dart';
import 'package:farmlyfe/app/middlewares/auth.dart';
import 'package:farmlyfe/app/views/auth.dart';
import 'package:farmlyfe/app/views/crop.dart';
import 'package:farmlyfe/app/views/profile.dart';
import 'package:farmlyfe/app/views/weather.dart';
import 'package:get/get.dart';

class FarmLyfeRoutes {
  static const auth = '/auth';
  static const weather = '/weather';
  static const crop = '/crop';
  static const profile = '/profile';
  static const initial = auth;

  static const int initialPage = 2;
  static const Map<int, String> pagesMap = {
    0: weather,
    1: crop,
    2: profile,
  };
}

class FarmLyfePages {
  static final List<GetPage> pages = [
    GetPage(
      name: FarmLyfeRoutes.auth,
      page: () => AuthView(),
      binding: AuthBindings(),
    ),
    GetPage(
      name: FarmLyfeRoutes.weather,
      page: () => WeatherView(),
      binding: WeatherBindings(),
      // middlewares: [
      //   AuthMiddleware(),
      // ],
    ),
    GetPage(
      name: FarmLyfeRoutes.crop,
      page: () => CropView(),
      binding: CropBindings(),
      // middlewares: [
      //   AuthMiddleware(),
      // ],
    ),
    GetPage(
      name: FarmLyfeRoutes.profile,
      page: () => ProfileView(),
      binding: ProfileBindings(),
      middlewares: [
        AuthMiddleware(),
      ],
    ),
  ];
}
