import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NoDataFound extends StatelessWidget {
  final bool? dashbaord;
  const NoDataFound({super.key, this.dashbaord});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: Center(
        child: dashbaord != null && dashbaord == true
            ? Text('comingsoon'.tr)
            : Text('norecordfound'.tr),
      ),
    );
  }
}
