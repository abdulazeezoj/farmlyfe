// ignore_for_file: constant_identifier_names

import 'package:farmlyfe/app/bindings/auth.dart';
import 'package:farmlyfe/app/bindings/crop.dart';
import 'package:farmlyfe/app/bindings/weather.dart';
import 'package:farmlyfe/app/middlewares/auth.dart';
import 'package:farmlyfe/app/views/auth.dart';
import 'package:farmlyfe/app/views/crop.dart';
import 'package:farmlyfe/app/views/weather.dart';
import 'package:get/get.dart';

class FarmLyfeRoutes {
  static const auth = '/auth';
  static const weather = '/weather';
  static const crop = '/crop';
  static const initial = auth;

  static const int initialPage = 1;
  static const Map<int, String> pagesMap = {
    0: weather,
    1: crop,
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
      middlewares: [
        AuthMiddleware(),
      ],
    ),
    GetPage(
      name: FarmLyfeRoutes.crop,
      page: () => CropView(),
      binding: CropBindings(),
      middlewares: [
        AuthMiddleware(),
      ],
    ),
  ];
}
