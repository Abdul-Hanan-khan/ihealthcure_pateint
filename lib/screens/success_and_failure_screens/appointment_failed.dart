import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tabib_al_bait/components/images.dart';
import 'package:tabib_al_bait/components/success_or_failed.dart';
import 'package:tabib_al_bait/helpers/values_manager.dart';
// import 'package:tabib_al_bait/utils/constants.dart';

class AppointmentFailed extends StatelessWidget {
  final Function()? onfirstPressed;
  final Function()? onSecondPressed;
  const AppointmentFailed(
      {super.key, this.onfirstPressed, this.onSecondPressed});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Image.asset(
            Images.logo,
            height: Get.height * 0.08,
          ),
        ),
        body: Stack(
          children: [
            ListView(
              padding: const EdgeInsets.all(AppPadding.p20),
              children: [
                AppointSuccessfulOrFailedWidget(
                  image: Images.cross,
                  successOrFailedHeader: 'oopsFailed'.tr,
                  appoinmentFailedorSuccessSmalltext: 'failedAppointment'.tr,
                  firstButtonText: 'tryAgain'.tr,
                  secondButtonText: 'cancel'.tr,
                  onPressedFirst: onfirstPressed,
                  onPressedSecond: onSecondPressed,
                )
              ],
            )
          ],
        ));
  }
}
