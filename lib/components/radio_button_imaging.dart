// ignore_for_file: library_private_types_in_public_api

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tabib_al_bait/data/controller/google_maps_controller.dart';
import 'package:tabib_al_bait/data/controller/lab_investigations_controller.dart';
import 'package:tabib_al_bait/helpers/color_manager.dart';

int? selectedValue;

class ImagingRadioButton extends StatefulWidget {
  const ImagingRadioButton({super.key});

  @override
  _ImagingRadioButtonState createState() => _ImagingRadioButtonState();
}

class _ImagingRadioButtonState extends State<ImagingRadioButton> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      LabInvestigationController.i.updateSelectedValue(1);
      LabInvestigationController.i.prescription();
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LabInvestigationController>(builder: (cont) {
      return SizedBox(
        height: Get.height*0.03,
        width: Get.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Radio<int>(
              fillColor: MaterialStateProperty.all(ColorManager.kPrimaryColor),
              value: 1,
              groupValue: cont.selectedalue,
              onChanged: (value) {
                cont.doctorname.clear();
                cont.updateSelectedValue(value!);
                cont.prescription();
              },
            ),
            Text(
              'doctor'.tr,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  color: ColorManager.kPrimaryColor,
                  fontSize: 12),
            ),
            Radio<int>(
              fillColor: MaterialStateProperty.all(ColorManager.kPrimaryColor),
              value: 2,
              groupValue: cont.selectedalue,
              onChanged: (value) {
                cont.selectedDoctor = null;
                cont.updateSelectedValue(value!);
                cont.prescription();
              },
            ),
            FittedBox(
              child: Text(
                'outdoorDoctor'.tr,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontFamily: GoogleFonts.poppins().fontFamily,
                    color: ColorManager.kPrimaryColor,
                    fontSize: 12),
              ),
            ),
          ],
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
          width: Get.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Radio<int>(
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
                    color: ColorManager.kPrimaryColor,
                    fontSize: 12),
              ),
              Radio<int>(
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
                    fontSize: 12),
              ),
            ],
          ),
        );
      });
    });
  }
}
