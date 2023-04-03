import 'package:farmlyfe/app/configs/routes.dart';
import 'package:get/get.dart';

class GlobalController extends GetxController {
  // Variables
  final _pagesMap = FarmLyfeRoutes.pagesMap;

  // Observables
  final RxInt _pageIndex = FarmLyfeRoutes.initialPage.obs;

  // Getters
  int get getPageIndex => _pageIndex.value;

  // Setters
  void setPageIndex(int index) {
    // Check if the index is valid
    if (index >= 0 && index < _pagesMap.length) {
      _pageIndex.value = index;

      // Navigate to the page
      Get.toNamed(_pagesMap[index]!);
    }
  }
}
