import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tabib_al_bait/components/images.dart';
import 'package:tabib_al_bait/data/controller/bottom_nav_bar_controller.dart';
import 'package:tabib_al_bait/helpers/color_manager.dart';
import 'package:tabib_al_bait/helpers/values_manager.dart';
import 'package:tabib_al_bait/screens/dashboard/menu_drawer.dart';
import 'primary_button.dart';

class AppointSuccessfulOrFailedWidget extends StatelessWidget {
  final String? imagePath;
  final bool? isLabInvestigationBooking;
  final Function()? onPressedFirst;
  final Function()? onPressedSecond;

  final bool? titleImage;
  final String? image;
  final String? successOrFailedHeader;
  final String? appoinmentFailedorSuccessSmalltext;
  final String? firstButtonText;
  final String? secondButtonText;

  const AppointSuccessfulOrFailedWidget({
    super.key,
    this.image,
    this.successOrFailedHeader,
    this.appoinmentFailedorSuccessSmalltext,
    this.firstButtonText,
    this.secondButtonText,
    this.titleImage = true,
    this.onPressedFirst,
    this.onPressedSecond,
    this.isLabInvestigationBooking = false,
    this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppPadding.p10)
          .copyWith(left: 20, right: 20, bottom: 20),
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              spreadRadius: 4,
              blurStyle: BlurStyle.inner,
              color: Colors.grey[300]!,
              blurRadius: 10,
              offset: const Offset(-2, 2), // Shadow position
            ),
          ],
          borderRadius: BorderRadius.circular(20),
          color: ColorManager.kWhiteColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // SizedBox(
          //   height: Get.height * 0.03,
          // ),
          isLabInvestigationBooking == true
              ? Image.asset(
                  imagePath ?? Images.bike,
                  height: Get.height * 0.2,
                )
              : imagePath != null
                  ? Image.asset(
                      imagePath!,
                      height: Get.height * 0.2,
                    )
                  : const SizedBox.shrink(),
          SizedBox(
            height: Get.height * 0.01,
          ),
          Image.asset(
            image!,
            height: Get.height * 0.15,
          ),
          SizedBox(
            height: Get.height * 0.01,
          ),
          Text(
            '$successOrFailedHeader',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 22,
                color: ColorManager.kblackColor,
                fontWeight: FontWeight.w900),
          ),
          SizedBox(
            height: Get.height * 0.01,
          ),
          Text(
            '$appoinmentFailedorSuccessSmalltext',
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(fontSize: 13, color: ColorManager.kblackColor),
          ),
          SizedBox(
            height: Get.height * 0.01,
          ),
          PrimaryButton(
              fontSize: 12,
              title: '$firstButtonText',
              onPressed: onPressedFirst ??
                  () {
                    Get.offAll(() => const DrawerScreen());
                    BottomBarController.i.navigateToPage(1);
                  },
              color: ColorManager.kPrimaryColor,
              textcolor: ColorManager.kWhiteColor),
          SizedBox(
            height: Get.height * 0.01,
          ),
          PrimaryButton(
              fontSize: 12,
              title: '$secondButtonText',
              onPressed: onPressedSecond ??
                  () {
                    Get.offAll(() => const DrawerScreen());
                  },
              color: ColorManager.kPrimaryLightColor,
              textcolor: ColorManager.kPrimaryColor),
        ],
      ),
    );
  }
}
