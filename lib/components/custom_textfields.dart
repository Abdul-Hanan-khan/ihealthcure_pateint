// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tabib_al_bait/helpers/color_manager.dart';

class CustomTextField extends StatelessWidget {
  final TextInputType? inputType;
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
  final double? hintFontSize;
  final double? errorFontSize;
  final Function()? onPressed;

  final Function(String)? onchanged;
  const CustomTextField({
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
    this.hintFontSize,
    this.errorFontSize = 12,
    this.onPressed,
    this.inputType,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextFormField(
              keyboardType: inputType,
              textAlign: TextAlign.start,
              controller: controller ?? TextEditingController(),
              onChanged: onchanged,
              validator: validator,
              onTap: () {},
              maxLines: maxlines ?? 1,
              readOnly: readonly,
              style: const TextStyle(
                  color: ColorManager.kPrimaryColor,
                  fontWeight: FontWeight.w600),
              decoration: InputDecoration(
                errorStyle: TextStyle(fontSize: errorFontSize),
                contentPadding: padding ?? EdgeInsets.symmetric(horizontal: 20),
                hintStyle: TextStyle(
                  color: const Color.fromARGB(255, 92, 156, 220),
                  fontSize: hintFontSize ?? 12,
                ),
                hintText: hintText,
                filled: true,
                disabledBorder:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: ColorManager.kDarkBlue),
                    borderRadius: BorderRadius.circular(10)),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                      color: ColorManager.kPrimaryLightColor, width: 0.5),
                ),
                fillColor: fillColor,
                suffixIcon: suffixIcon,
                suffixText: suffixText,
                suffixStyle: suffixStyle,
                prefixIcon: prefixIcon,
                border: const OutlineInputBorder(
                  borderSide:
                      BorderSide(color: ColorManager.kPrimaryLightColor),
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
        ),
      ),
    );
  }
}
