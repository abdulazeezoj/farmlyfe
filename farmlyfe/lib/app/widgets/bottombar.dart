import 'package:farmlyfe/app/controllers/auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:farmlyfe/app/controllers/global.dart';

class BottomBar extends StatelessWidget {
  // Controllers
  final _globalController = Get.put(GlobalController());
  final _authController = Get.put(AuthController());

  BottomBar({super.key, context});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => BottomNavigationBar(
        currentIndex: _globalController.getPageIndex,
        onTap: (index) => {
          if (index == 2)
            {
              _authController.logout(),
            }
          else
            {
              _globalController.setPageIndex(index),
            }
        },
        // type: BottomNavigationBarType.fixed,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.cloudy_snowing),
            label: 'Weather',
            tooltip: 'Weather',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grass_sharp),
            label: 'Crops',
            tooltip: 'Crops',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout),
            label: 'Logout',
            tooltip: 'Logout',
          ),
        ],
      ),
    );
  }
}
