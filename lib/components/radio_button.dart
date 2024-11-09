// ignore_for_file: library_private_types_in_public_api

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tabib_al_bait/data/controller/google_maps_controller.dart';
import 'package:tabib_al_bait/data/controller/lab_investigations_controller.dart';
import 'package:tabib_al_bait/helpers/color_manager.dart';

int? selectedValue;

class RadioButtonRow extends StatefulWidget {
  const RadioButtonRow({super.key});

  @override
  _RadioButtonRowState createState() => _RadioButtonRowState();
}

class _RadioButtonRowState extends State<RadioButtonRow> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      LabInvestigationController.i.updateSelectedValue(0);
      LabInvestigationController.i.prescription();
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LabInvestigationController>(builder: (cont) {
      return Align(
        alignment: Alignment.centerLeft,
        child: SizedBox(
          height: Get.height * 0.06,
          width: Get.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Radio<int>(
                visualDensity: const VisualDensity(horizontal: -4),
                fillColor:
                    MaterialStateProperty.all(ColorManager.kPrimaryColor),
                value: 0,
                groupValue: cont.selectedalue,
                onChanged: (value) {
                  cont.updateSelectedValue(value!);
                  cont.prescription();
                },
              ),
              Text(
                'self'.tr,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontFamily: GoogleFonts.poppins().fontFamily,
                    fontWeight: FontWeight.w900,
                    color: ColorManager.kPrimaryColor,
                    fontSize: 12),
              ),
              Radio<int>(
                visualDensity: const VisualDensity(horizontal: -4),
                fillColor:
                    MaterialStateProperty.all(ColorManager.kPrimaryColor),
                value: 1,
                groupValue: cont.selectedalue,
                onChanged: (value) {
                  cont.updateSelectedValue(value!);
                  cont.prescription();
                },
              ),
              Text(
                'doctor'.tr,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontFamily: GoogleFonts.poppins().fontFamily,
                    color: ColorManager.kPrimaryColor,
                    fontWeight: FontWeight.w900,
                    fontSize: 12),
              ),
              Radio<int>(
                visualDensity: const VisualDensity(horizontal: -4),
                fillColor:
                    MaterialStateProperty.all(ColorManager.kPrimaryColor),
                value: 2,
                groupValue: cont.selectedalue,
                onChanged: (value) {
                  cont.updateSelectedValue(value!);
                  cont.prescription();
                },
              ),
              FittedBox(
                child: Text(
                  'outdoorDoctor'.tr,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w900,
                      fontFamily: GoogleFonts.poppins().fontFamily,
                      color: ColorManager.kPrimaryColor,
                      fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

int? sampleValue = 0;

class SamplesRadioButton extends StatefulWidget {
  const SamplesRadioButton({super.key});

  @override
  _SamplesRadioButtonState createState() => _SamplesRadioButtonState();
}

class _SamplesRadioButtonState extends State<SamplesRadioButton> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LabInvestigationController>(builder: (cont) {
      return GetBuilder<AddressController>(builder: (address) {
        return SizedBox(
          height: Get.height * 0.05,
          width: Get.width * 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Radio<int>(
                visualDensity: const VisualDensity(horizontal: -4),
                fillColor:
                    MaterialStateProperty.all(ColorManager.kPrimaryColor),
                value: 0,
                groupValue: cont.selectedLabValue,
                onChanged: (value) {
                  cont.updateSelectedLab(value!);
                  log('${address.latitude.toString()} --- ${address.longitude.toString()}');
                },
              ),
              Text(
                'samplesfromhome'.tr,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontFamily: GoogleFonts.poppins().fontFamily,
                    fontWeight: FontWeight.w900,
                    color: ColorManager.kPrimaryColor,
                    fontSize: 12),
              ),
              Radio<int>(
                visualDensity: const VisualDensity(horizontal: -4),
                fillColor:
                    MaterialStateProperty.all(ColorManager.kPrimaryColor),
                value: 1,
                groupValue: cont.selectedLabValue,
                onChanged: (value) {
                  cont.updateSelectedLab(value!);

                  address.updateAddress('');
                  log('${address.latitude.toString()} --- ${address.longitude.toString()}');
                },
              ),
              Text(
                'samplesinlab'.tr,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontFamily: GoogleFonts.poppins().fontFamily,
                    color: ColorManager.kPrimaryColor,
                    fontWeight: FontWeight.w900,
                    fontSize: 12),
              ),
            ],
          ),
        );
      });
    });
  }
}
