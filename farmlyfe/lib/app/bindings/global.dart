import 'package:get/get.dart';
import 'package:farmlyfe/app/controllers/global.dart';

class GlobalBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GlobalController());
  }
}
