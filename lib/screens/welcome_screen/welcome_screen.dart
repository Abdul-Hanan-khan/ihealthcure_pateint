import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tabib_al_bait/components/images.dart';
import 'package:tabib_al_bait/helpers/color_manager.dart';
import 'package:tabib_al_bait/helpers/values_manager.dart';
import 'package:tabib_al_bait/screens/introduction/introduction.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.only(bottom: AppPadding.p20, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: Get.height * 0.05,
            ),
            Image.asset(
              Images.welcome,
              height: Get.height * 0.5,
              width: Get.width,
              fit: BoxFit.cover,
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            Text(
              'welcomeTo'.tr,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: ColorManager.kblackColor,
                  wordSpacing: 1,
                  fontWeight: FontWeight.w300,
                  fontSize: 35),
            ),
            Text(
              "SIDRA HEALTHCARE",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: ColorManager.kPrimaryColor,
                  fontWeight: FontWeight.w900,
                  fontSize: 30),
            ),
            const Spacer(),
            const GetStartedButton(),
            SizedBox(
              height: Get.height * 0.04,
            )
          ],
        ),
      ),
    );
  }
}

class GetStartedButton extends StatelessWidget {
  const GetStartedButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(40),
      onTap: () async {
        Get.to(() => const Introduction());
      },
      child: const CircleAvatar(
        radius: 35,
        backgroundColor: ColorManager.kPrimaryColor,
        child: CircleAvatar(
          radius: 32,
          backgroundColor: ColorManager.kWhiteColor,
          child: CircleAvatar(
            radius: 27,
            child: Icon(Icons.arrow_forward),
          ),
        ),
      ),
    );
  }
}

class ElevatedText extends StatelessWidget {
  final String? text;
  final Color? textColor;
  const ElevatedText({
    super.key,
    this.text,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      '$text'.tr,
      style: const TextStyle(
        fontSize: 20,
        shadows: <Shadow>[
          Shadow(
            offset: Offset(3.0, 3.0),
            blurRadius: 1.0,
            color: Color(0xFFE8E8E8),
          ),
        ],
      ),
    );
  }
}
