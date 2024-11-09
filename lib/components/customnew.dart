// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tabib_al_bait/helpers/color_manager.dart';

class CustomText extends StatelessWidget {
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final Function()? onTap;
  final EdgeInsetsGeometry? padding;
  final int? maxlines;
  final Widget? prefixIcon;
  final TextStyle? suffixStyle;
  final String? suffixText;
  final bool? isSizedBoxAvailable;
  final bool readonly;
  final Color? fillColor;
  final Widget? suffixIcon;
  final String? hintText;
  final String? initialValue;

  final Function(String)? onchanged;
  const CustomText({
    super.key,
    this.hintText,
    this.suffixIcon,
    this.fillColor = ColorManager.kPrimaryLightColor,
    this.readonly = false,
    this.isSizedBoxAvailable = true,
    this.suffixText,
    this.suffixStyle,
    this.prefixIcon,
    this.maxlines,
    this.padding,
    this.onTap,
    this.validator,
    this.inputFormatters,
    this.onchanged,
    this.controller,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextFormField(
          controller: controller ?? TextEditingController(),
          onChanged: onchanged,
          validator: validator,
          onTap: () {},
          maxLines: maxlines ?? 1,
          readOnly: readonly,
          style: const TextStyle(
              color: ColorManager.kPrimaryColor, fontWeight: FontWeight.w900),
          decoration: InputDecoration(
            contentPadding: padding ?? EdgeInsets.symmetric(horizontal: 20),
            hintStyle: const TextStyle(
                fontWeight: FontWeight.w900, color: ColorManager.kPrimaryColor),
            hintText: hintText,
            filled: true,
            disabledBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: ColorManager.kDarkBlue),
                borderRadius: BorderRadius.circular(10)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
                  const BorderSide(color: ColorManager.kblackColor, width: 0.5),
            ),
            fillColor: fillColor,
            suffixIcon: suffixIcon,
            suffixText: suffixText,
            suffixStyle: suffixStyle,
            prefixIcon: prefixIcon,
            border: const OutlineInputBorder(
              borderSide: BorderSide(color: ColorManager.kPrimaryLightColor),
              borderRadius: BorderRadius.all(
                Radius.circular(0.0),
              ),
            ),
          ),
          inputFormatters: inputFormatters,
        ),
        isSizedBoxAvailable == true
            ? SizedBox(
                height: Get.height * 0.02,
              )
            : SizedBox.shrink()
      ],
    );
  }
}
