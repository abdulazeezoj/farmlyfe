import 'package:get/get.dart';
import 'package:farmlyfe/app/controllers/auth.dart';

class AuthBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController());
  }
}
