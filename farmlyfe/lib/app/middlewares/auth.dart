import 'package:farmlyfe/app/configs/routes.dart';
import 'package:farmlyfe/app/controllers/auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthMiddleware extends GetMiddleware {
  // Controllers
  final AuthController _authController = Get.put(AuthController());

  @override
  RouteSettings? redirect(String? route) {
    return _authController.getUser != null
        ? null
        : const RouteSettings(name: FarmLyfeRoutes.auth);
  }
}
