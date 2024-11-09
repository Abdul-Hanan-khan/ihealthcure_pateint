import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tabib_al_bait/components/images.dart';
import 'package:tabib_al_bait/components/primary_button.dart';
import 'package:tabib_al_bait/data/controller/auth_controller.dart';
import 'package:tabib_al_bait/data/controller/forgotpasswordcontroller.dart';
import 'package:tabib_al_bait/data/repositories/passwordforgotrepo.dart';
import 'package:tabib_al_bait/helpers/color_manager.dart';
import 'package:tabib_al_bait/helpers/show_toast.dart';
import 'package:tabib_al_bait/helpers/values_manager.dart';
import 'package:tabib_al_bait/screens/family_screens/family_members.dart';
import 'package:tabib_al_bait/screens/forgot_password/verifypasswordscreen.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({
    super.key,
  });

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  void initState() {
    super.initState();
  }

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
                              'forgotpassword'.tr,
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
                                'ithappens'.tr,
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
                      AuthTextField(
                        function: (p0) {
                          if (p0.length > 15) {
                            return false;
                          }

                          return null;
                        },
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'Enter your Email';
                          }
                          // if (val.length > 15) {
                          //   return 'Email is invalid';
                          // }
                          // if (val.length < 10) {
                          //   return 'Email is invalid';
                          // }
                          return null;
                        },
                        // keyboardType: TextInputType.text,
                        // formatters: [Masks().maskFormatter],
                        controller: _controller,
                        hintText: 'email'.tr,
                      ),
                      SizedBox(
                        height: Get.height * 0.02,
                      ),
                      // AuthTextField(
                      //   validator: (val) {
                      //     if (val!.isEmpty) {
                      //       return 'Password field is empty';
                      //     }
                      //     return null;
                      //   },
                      //   controller: login.passwordController,
                      //   hintText: 'password'.tr,
                      // ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.end,
                      //   children: [
                      //     TextButton(
                      //         onPressed: () {
                      //           Get.to(() => const RegisterScreen());
                      //         },
                      //         child: const Text(
                      //           "Forgot Password ?",
                      //           style: TextStyle(
                      //               fontSize: 12,
                      //               color: ColorManager.kPrimaryColor),
                      //         ))
                      //   ],
                      // ),

                      PrimaryButton(
                          title: "verifyCode".tr,
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              await Forgotpasswordrepo().getpatienthistory(
                                  _controller.text.toString());
                              if (Forgotpasswordcontroller.i.data.status == 1) {
                                log(Forgotpasswordcontroller
                                    .i.data.verificationCode
                                    .toString());
                                Get.to(() => Verifycodescreen(
                                      data: Forgotpasswordcontroller.i.data,
                                    ));

                                ToastManager.showToast(Forgotpasswordcontroller
                                        .i.data.errorMessage ??
                                    "codesent".tr);
                              } else {
                                ToastManager.showToast(Forgotpasswordcontroller
                                        .i.data.errorMessage ??
                                    "somethingwentwrong".tr);
                              }
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
        opacity: 0.4,
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

class AuthTextField extends StatelessWidget {
  final Function(String)? function;
  final bool? obscureText;
  final List<TextInputFormatter>? formatters;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final String? hintText;
  final bool? readOnly;
  const AuthTextField({
    super.key,
    this.hintText,
    this.suffixIcon,
    this.controller,
    this.validator,
    this.readOnly,
    this.formatters,
    this.obscureText,
    this.keyboardType,
    this.function,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: function,
      keyboardType: keyboardType ?? TextInputType.text,
      obscureText: obscureText ?? false,
      inputFormatters: formatters,
      readOnly: readOnly ?? false,
      validator: validator,
      controller: controller,
      decoration: InputDecoration(
          errorStyle: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: ColorManager.kRedColor, fontSize: 12),
          suffixIcon: suffixIcon,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          hintText: hintText,
          hintStyle:
              const TextStyle(color: ColorManager.kGreyColor, fontSize: 12),
          disabledBorder: const OutlineInputBorder(),
          errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: ColorManager.kRedColor)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: ColorManager.kGreyColor)),
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: ColorManager.kGreyColor))),
    );
  }
}
