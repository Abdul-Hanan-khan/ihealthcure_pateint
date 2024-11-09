import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tabib_al_bait/components/primary_button.dart';
import 'package:tabib_al_bait/helpers/color_manager.dart';
import 'package:tabib_al_bait/helpers/values_manager.dart';
import 'package:tabib_al_bait/screens/auth_screens/login.dart';
import '../../components/images.dart';

class RegistrationSuccessfulScreen extends StatelessWidget {
  const RegistrationSuccessfulScreen({super.key});

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
          const Center(child: BackgroundLogoimage()),
          Padding(
            padding: const EdgeInsets.all(AppPadding.p20),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'registered'.tr,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontSize: 24),
                  ),
                  Text(
                    'registrationCompleted'.tr,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontSize: 16, color: ColorManager.kblackColor),
                  ),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  PrimaryButton(
                      title: 'OK',
                      onPressed: () {},
                      color: ColorManager.kPrimaryColor,
                      textcolor: ColorManager.kWhiteColor)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
