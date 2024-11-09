import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tabib_al_bait/components/images.dart';
import 'package:tabib_al_bait/components/primary_button.dart';
import 'package:tabib_al_bait/data/localDB/local_db.dart';
import 'package:tabib_al_bait/helpers/color_manager.dart';
import 'package:tabib_al_bait/screens/dashboard/menu_drawer.dart';

class Introduction extends StatelessWidget {
  const Introduction({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: Get.height * 0.1,
            ),
            Text(
              'takecareof'.tr,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600, fontSize: Get.height * 0.05),
            ),
            Text(
              'yourhealth'.tr,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600, fontSize: Get.height * 0.05),
            ),
            // SizedBox(
            //   height: Get.height * 0.02,
            // ),
            Row(
              children: [
                Text('with'.tr),
                const SizedBox(
                  width: 5,
                ),
                Text("SIDRA HEALTHCARE",
                    style: GoogleFonts.raleway(
                        fontSize: 16,
                        color: ColorManager.kPrimaryColor,
                        fontWeight: FontWeight.w500)),
              ],
            ),
            Container(
              height: Get.height * 0.45,
              width: Get.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                      image: AssetImage(
                        Images.docImagesmaleFemale,
                      ),
                      fit: BoxFit.contain)),
            ),
            SizedBox(
              height: Get.height * 0.008,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                'caretocure'.tr,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: ColorManager.kPrimaryDark),
              ),
            ),
            // SizedBox(
            //   height: Get.height*0.08,
            // ),
            // const Spacer(),
            SizedBox(
              height: Get.height * 0.06,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: PrimaryButton(
                  radius: 15,
                  isGradient: true,
                  gradientColor: const Color(0xFF1272D3),
                  height: 45,
                  title: 'go'.tr,
                  onPressed: () async {
                    await LocalDb().setisOnboarding();
                    var k = await LocalDb().getIsOnboarding();
                    Get.offAll(() => const DrawerScreen());
                  },
                  color: ColorManager.kPrimaryDark,
                  textcolor: ColorManager.kWhiteColor),
            ),
          ],
        ),
      ),
    );
  }
}
