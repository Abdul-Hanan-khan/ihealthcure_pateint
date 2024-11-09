// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tabib_al_bait/data/controller/lab_investigations_controller.dart';
import 'package:tabib_al_bait/helpers/color_manager.dart';

int? selectedValue;

class RadioButtonStatus extends StatefulWidget {
  const RadioButtonStatus({super.key});

  @override
  _RadioButtonStatusState createState() => _RadioButtonStatusState();
}

class _RadioButtonStatusState extends State<RadioButtonStatus> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      LabInvestigationController.i.updateSelectedstatus(0);
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LabInvestigationController>(builder: (cont) {
      return SizedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Radio<int>(
              fillColor: MaterialStateProperty.all(ColorManager.kPrimaryColor),
              value: 0,
              groupValue: cont.selectedalue2,
              onChanged: (value) {
                cont.updateSelectedstatus(0);
                cont.getstatus();
                cont.online();
              },
            ),
            Text(
              'homeVisit'.tr,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  color: ColorManager.kPrimaryColor,
                  fontSize: 12),
            ),
            Radio<int>(
              fillColor: MaterialStateProperty.all(ColorManager.kPrimaryColor),
              value: 1,
              groupValue: cont.selectedalue2,
              onChanged: (value) {
                cont.updateSelectedstatus(1);
                cont.getstatus();
                cont.online();
              },
            ),
            Text(
              'online'.tr,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  color: ColorManager.kPrimaryColor,
                  fontSize: 12),
            ),
          ],
        ),
      );
    });
  }
}
