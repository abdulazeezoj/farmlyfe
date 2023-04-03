import 'package:farmlyfe/app/controllers/crop.dart';
import 'package:get/get.dart';

class CropBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CropController());
  }
}
