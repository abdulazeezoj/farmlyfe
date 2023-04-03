import 'package:farmlyfe/app/controllers/weather.dart';
import 'package:get/get.dart';

class WeatherBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WeatherController());
  }
}
