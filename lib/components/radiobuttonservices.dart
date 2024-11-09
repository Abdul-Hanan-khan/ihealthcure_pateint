// ignore_for_file: library_private_types_in_public_api

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tabib_al_bait/data/controller/lab_investigations_controller.dart';
import 'package:tabib_al_bait/helpers/color_manager.dart';
import 'package:tabib_al_bait/models/lab_tests_model.dart';

int? selectedValue;

class RadioButtonService extends StatefulWidget {
  const RadioButtonService({super.key});

  @override
  _RadioButtonServiceState createState() => _RadioButtonServiceState();
}

class _RadioButtonServiceState extends State<RadioButtonService> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      LabInvestigationController.i.updateSelectedValue(1);
      setState(() {});
    });

    super.initState();
  }

  int? selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LabInvestigationController>(builder: (cont) {
      return SizedBox(
        height: Get.height * 0.07,
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: cont.radioOptions.length,
          itemBuilder: (BuildContext context, int index) {
            final radioValue = cont.radioOptions[index]['value'] as int;
            final labelText = cont.radioOptions[index]['labelText'] as String;

            return Container(
              margin: const EdgeInsets.only(right: 5),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  boxShadow: const [],
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      color: selectedIndex == index
                          ? ColorManager.kPrimaryColor
                          : const Color.fromARGB(255, 241, 237, 237))),
              child: Row(
                children: [
                  Radio<int>(
                    visualDensity: const VisualDensity(horizontal: -4),
                    fillColor:
                        MaterialStateProperty.all(ColorManager.kPrimaryColor),
                    value: radioValue,
                    groupValue: cont.selectedalue1,
                    onChanged: (value) {
                      cont.updateservice(LabTests(name: "Services"));
                      cont.updateSelectedservices(value!);
                      cont.getserviceslist();
                      cont.Serivcesprecription();
                      selectedIndex = cont.radioOptions.indexWhere(
                        (option) => option['value'] == value,
                      );

                      // If the selected item is found, remove it from its current position
                      if (selectedIndex != -1) {
                        final selectedOption =
                            cont.radioOptions.removeAt(selectedIndex!);
                        cont.radioOptions.insert(0, selectedOption);
                      }
                      cont.swapList(cont.radioOptions);

                      log(cont.radioOptions.toString());
                    },
                  ),
                  Text(
                    labelText,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontFamily: GoogleFonts.poppins().fontFamily,
                          color: ColorManager.kblackColor,
                          fontSize: 12,
                        ),
                  ),
                ],
              ),
            );
          },
        ),
      );
    });
  }
}
