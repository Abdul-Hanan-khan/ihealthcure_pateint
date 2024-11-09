// ignore_for_file: avoid_unnecessary_containers, must_be_immutable, unused_field

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tabib_al_bait/components/images.dart';
import 'package:tabib_al_bait/components/primary_button.dart';
import 'package:tabib_al_bait/data/controller/auth_controller.dart';
import 'package:tabib_al_bait/helpers/color_manager.dart';
import 'package:tabib_al_bait/helpers/show_toast.dart';
import 'package:tabib_al_bait/helpers/values_manager.dart';
import 'package:tabib_al_bait/models/forgetpassword/verifycodereturn.dart';
import 'package:tabib_al_bait/screens/family_screens/family_members.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:tabib_al_bait/screens/forgot_password/resetpassword.dart';

class Verifycodescreen extends StatefulWidget {
  Verifycoderesponse data;
  Verifycodescreen({
    required this.data,
    super.key,
  });

  @override
  State<Verifycodescreen> createState() => _VerifycodescreenState();
}

class _VerifycodescreenState extends State<Verifycodescreen> {
  @override
  void initState() {
    super.initState();
  }

  String verificationCode = "";
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();
  @override
  void dispose() {
    AuthController.i.emailController.clear();
    AuthController.i.passwordController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var login = Get.put<AuthController>(AuthController());
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: CustomAppBar(
            title: '',
            isLogoPresent: true,
            widget: Image.asset(
              Images.logo,
              height: Get.height * 0.08,
            ),
          ),
        ),
        body: SafeArea(
          child: Stack(
            children: [
              const BackgroundLogoimage(),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.all(AppPadding.p20),
                height: Get.height,
                width: Get.width,
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Spacer(
                        flex: 1,
                      ),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'entercode'.tr,
                              textAlign: TextAlign.start,
                              style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(fontSize: 25)),
                            ),
                          ],
                        ),
                      ),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Flexible(
                              child: Text(
                                'kindlyenterthecode'.tr,
                                textAlign: TextAlign.start,
                                style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(fontSize: 16)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: Get.height * 0.02,
                      ),
                      OtpTextField(
                        fieldWidth: Get.width * 0.12,
                        borderRadius: BorderRadius.circular(10),
                        enabledBorderColor: const Color(0xff1272D3),
                        numberOfFields: 6,
                        borderColor: const Color(0xFF512DA8),
                        //set to true to show as box or false to show as dash
                        showFieldAsBox: true,
                        //runs when a code is typed in
                        onCodeChanged: (String code) {
                          //handle validation or checks here
                        },
                        //runs when every textfield is filled
                        onSubmit: (String code) {
                          verificationCode = code;
                        },
                      ),
                      // AuthTextField(
                      //   function: (p0) {
                      //     if (p0.length > 15) {
                      //       return false;
                      //     }

                      //     return null;
                      //   },
                      //   validator: (val) {
                      //     if (val!.isEmpty) {
                      //       return 'Enter your Email';
                      //     }
                      //     // if (val.length > 15) {
                      //     //   return 'Email is invalid';
                      //     // }
                      //     // if (val.length < 10) {
                      //     //   return 'Email is invalid';
                      //     // }
                      //     return null;
                      //   },
                      //   // keyboardType: TextInputType.text,
                      //   // formatters: [Masks().maskFormatter],
                      //   controller: _controller,
                      //   hintText: 'email'.tr,
                      // ),
                      SizedBox(
                        height: Get.height * 0.02,
                      ),

                      PrimaryButton(
                          title: "verifyCode".tr,
                          onPressed: () async {
                            if (verificationCode ==
                                widget.data.verificationCode) {
                              Get.to(() => Verifyscreen(
                                    data: widget.data,
                                  ));
                            } else {
                              ToastManager.showToast("coderror".tr);
                            }
                          },
                          color: ColorManager.kPrimaryColor,
                          textcolor: ColorManager.kWhiteColor),
                      const Spacer(
                        flex: 2,
                      ),
                      // SignupOrLoginText(
                      //   pre: '${'donthaveanAccount'.tr}? ',
                      //   suffix: 'register'.tr,
                      //   onTap: () {
                      //     Get.to(() => const RegisterScreen());
                      //   },
                      // )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

class BackgroundLogoimage extends StatelessWidget {
  const BackgroundLogoimage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 100,
      right: 0,
      child: Opacity(
        opacity: 0.8,
        child: Container(
          height: Get.height * 0.8,
          width: Get.width,
          alignment: Alignment.centerLeft,
          child: Image.asset(
            Images.logoBackground,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class SignupOrLoginText extends StatelessWidget {
  final Function()? onTap;
  final String? pre;
  final String? suffix;
  const SignupOrLoginText({
    super.key,
    this.pre,
    this.suffix,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '$pre',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        SizedBox(
          width: Get.width * 0.02,
        ),
        InkWell(
          onTap: onTap,
          child: Text(
            '$suffix',
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: ColorManager.kPrimaryColor, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
