import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Loading Dialog Widget with open and close methods using GetX dialog
class LoadingDialogWidget {
  static void open() {
    Get.dialog(
      WillPopScope(
        child: const Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
        onWillPop: () => Future.value(false),
      ),
      barrierDismissible: false,
      barrierColor: const Color.fromRGBO(0, 0, 0, 0.75),
      useSafeArea: true,
    );
  }

  static void close() {
    Get.back();
  }
}
