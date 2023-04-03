import 'package:farmlyfe/app/controllers/crop.dart';
import 'package:farmlyfe/app/widgets/bottombar.dart';
import 'package:farmlyfe/app/widgets/crop_favorite.dart';
import 'package:farmlyfe/app/widgets/crop_list.dart';
import 'package:farmlyfe/app/widgets/crop_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CropView extends StatelessWidget {
  CropView({Key? key}) : super(key: key);

  // Controllers
  final CropController cropController = Get.put(CropController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CropHeader(),
      body: SafeArea(
        child: Column(
          children: [
            // Crop Favorite
            CropFavorite(),

            // Crop List
            Expanded(
              child: CropList(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
