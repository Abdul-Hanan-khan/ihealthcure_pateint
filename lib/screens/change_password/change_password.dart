// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tabib_al_bait/components/images.dart';
import 'package:tabib_al_bait/components/primary_button.dart';
import 'package:tabib_al_bait/data/controller/auth_controller.dart';
import 'package:tabib_al_bait/data/repositories/pass_repository/pass_repository.dart';
import 'package:tabib_al_bait/helpers/color_manager.dart';
import 'package:tabib_al_bait/helpers/values_manager.dart';
import 'package:tabib_al_bait/screens/auth_screens/login.dart';
import 'package:tabib_al_bait/screens/family_screens/family_members.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({
    super.key,
  });

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController oldpassword = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();
  bool isObscure = true;
  bool _isObsecure = true;
  bool is_Obsecure = true;
  @override
  void initState() {
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    AuthController.i.emailController.clear();
    AuthController.i.passwordController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // var login = Get.put<AuthController>(AuthController());
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
                        child: Text(
                          'createpassword'.tr,
                          textAlign: TextAlign.start,
                          style: GoogleFonts.poppins(
                              textStyle: const TextStyle(fontSize: 24)),
                        ),
                      ),
                      SizedBox(
                        height: Get.height * 0.02,
                      ),
                      Center(
                        child: Text(
                          'kindlyenter'.tr,
                          textAlign: TextAlign.start,
                          style: GoogleFonts.poppins(
                              textStyle: const TextStyle(fontSize: 16)),
                        ),
                      ),
                      SizedBox(
                        height: Get.height * 0.02,
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
                      //       return 'Enter your National ID';
                      //     }
                      //     if (val.length > 15) {
                      //       return 'National ID is invalid';
                      //     }
                      //     if (val.length < 10) {
                      //       return 'National ID is invalid';
                      //     }
                      //     return null;
                      //   },
                      //   keyboardType: TextInputType.number,
                      //   formatters: [Masks().maskFormatter],
                      //   controller: login.emailController,
                      //   hintText: 'identityNumber'.tr,
                      // ),
                      SizedBox(
                        height: Get.height * 0.02,
                      ),
                      AuthTextField(
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'Old Password field is empty';
                          }
                          return null;
                        },
                        controller: oldpassword,
                        hintText: 'oldpaasword'.tr,
                        obscureText: isObscure,
                        suffixIcon: IconButton(
                          icon: Icon(
                            isObscure ? Icons.visibility_off : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              isObscure = !isObscure;
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        height: Get.height * 0.02,
                      ),
                      AuthTextField(
                        validator: (val) {
                          if (val!.isEmpty) {
                            return ' Password field is empty';
                          }
                          return null;
                        },
                        controller: password,
                        hintText: 'password'.tr,
                        obscureText: _isObsecure,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isObsecure
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _isObsecure = !_isObsecure;
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        height: Get.height * 0.02,
                      ),
                      AuthTextField(
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'Confirm Password field is empty';
                          }
                          return null;
                        },
                        controller: confirmpassword,
                        hintText: 'confirmpassword'.tr,
                        obscureText: is_Obsecure,
                        suffixIcon: IconButton(
                          icon: Icon(
                            is_Obsecure
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              is_Obsecure = !is_Obsecure;
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        height: Get.height * 0.04,
                      ),

                      Center(
                        child: PrimaryButton(
                            width: Get.width * 0.7,
                            title: 'changepassword'.tr,
                            fontSize: 20,
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                if (password.text == confirmpassword.text) {
                                  int val =
                                      await PasswordRepository.changepassword(
                                          oldpassword.text.toString(),
                                          password.text.toString());
                                  if (val == 1) {
                                    Get.to(() => const LoginScreen());
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text("passwordnotchanged".tr),
                                      ),
                                    );
                                  }
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("passandconfirmpass".tr),
                                    ),
                                  );
                                }
                              }
                            },
                            color: ColorManager.kPrimaryColor,
                            textcolor: ColorManager.kWhiteColor),
                      ),
                      const Spacer(
                        flex: 2,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
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
      keyboardType: keyboardType,
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
