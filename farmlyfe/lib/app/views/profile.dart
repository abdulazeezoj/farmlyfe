import 'package:farmlyfe/app/controllers/auth.dart';
import 'package:farmlyfe/app/controllers/profile.dart';
import 'package:farmlyfe/app/widgets/bottombar.dart';
import 'package:farmlyfe/app/widgets/crop_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileView extends StatelessWidget {
  ProfileView({Key? key}) : super(key: key);

  // Controllers
  final AuthController authController = Get.put(AuthController());
  final ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CropHeader(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              authController.getUser?.displayName ?? 'No user',
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
