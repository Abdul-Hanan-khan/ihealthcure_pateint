import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tabib_al_bait/components/custom_textfields.dart';
import 'package:tabib_al_bait/components/primary_button.dart';
import 'package:tabib_al_bait/data/controller/health_controller.dart';
import 'package:tabib_al_bait/data/controller/health_summary_controller.dart';
import 'package:tabib_al_bait/data/localDB/local_db.dart';
import 'package:tabib_al_bait/data/sqflite_db/sqflite_db.dart';
import 'package:tabib_al_bait/helpers/color_manager.dart';
import 'package:tabib_al_bait/main.dart';
import 'package:tabib_al_bait/models/health_summary_model/health_summary_model.dart';

class AlertDialgue {
  Future<dynamic> dialogueBox(BuildContext context,
      {TextEditingController? controller1,
      TextEditingController? controller2,
      GlobalKey<FormState>? formKey,
      List<HealthModel>? list,
      String? title,
      String? hintText1,
      String? hintText2}) {
    return showDialog(
        context: context,
        builder: ((context) {
          
          return FractionallySizedBox(
            child: Material(
              color: Colors.transparent,
              child: Center(
                  child: Container(
                // height: Get.height * 0.8,
                width: Get.width * 0.8,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Spacer(
                            flex: 2,
                          ),
                          Center(
                            child: Text(
                              '${title == 'Measurements' ? '' : 'add'.tr} $title',
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                      color: ColorManager.kPrimaryColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w900),
                            ),
                          ),
                          const Spacer(),
                          Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                                padding: EdgeInsets.zero,
                                onPressed: (() {
                                  Get.back();
                                  HealthSummaryController.i.controller1.clear();
                                  HealthSummaryController.i.controller2.clear();
                                }),
                                icon: Icon(
                                  Icons.close_rounded,
                                  size: 20,
                                  color: Theme.of(context).hintColor,
                                )),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0).copyWith(top: 5),
                        child: Column(
                          children: [
                            title == "Glucose" ||
                                    title == 'گلوکوز' ||
                                    title == 'الجلوكوز' ||
                                    title == "Temperature" ||
                                    title == 'درجہ حرارت' ||
                                    title == 'درجة حرارة' ||
                                    title == "Pulse" ||
                                    title == "نبض" ||
                                    title == 'نبض' ||
                                    title == "Sp02%"
                                ? Row(
                                    children: [
                                      Expanded(
                                        child: CustomTextField(
                                          errorFontSize: 10,
                                          hintFontSize: 10,
                                          controller: controller1,
                                          hintText: '$title ${'values'.tr}',
                                          validator: (p0) {
                                            if (p0!.isEmpty) {
                                              return 'This field required';
                                            } else if (title == "Sp02%" &&
                                                (int.parse(controller1!.text) >
                                                        100 ||
                                                    int.parse(
                                                            controller1.text) <
                                                        0)) {
                                              return 'The value is in between 0 and 100';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                    ],
                                  )
                                : const SizedBox.shrink(),
                            title == "Blood Pressure values" ||
                                    title == "بلڈ پریشر کی اقدار" ||
                                    title == "Measurements" ||
                                    title == "پیمائش" ||
                                    title == 'ضغط الدم' ||
                                    title == 'قياسات'
                                ? Row(
                                    children: [
                                      Expanded(
                                        child: CustomTextField(
                                          errorFontSize: 10,
                                          hintFontSize: 10,
                                          controller: controller1,
                                          hintText: '$hintText1 ${'values'.tr}',
                                          validator: (p0) {
                                            if (p0!.isEmpty) {
                                              return 'This field required';
                                            }
                                            // else if(p0.isNotEmpty){
                                            //   return '';
                                            // }
                                            else if ((title ==
                                                        'Blood Pressure values' ||
                                                    title == 'ضغط الدم' ||
                                                    title ==
                                                        "بلڈ پریشر کی اقدار") &&
                                                (int.parse(controller1!.text) <
                                                    int.parse(
                                                        controller2!.text))) {
                                              return 'Systolic be greater than distolic';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        width: Get.width * 0.02,
                                      ),
                                      Expanded(
                                        child: CustomTextField(
                                          errorFontSize: 10,
                                          hintFontSize: 10,
                                          controller: controller2,
                                          hintText: '$hintText2 ${'values'.tr}',
                                          validator: (p0) {
                                            if (p0!.isEmpty) {
                                              return 'This field required';
                                            }
                                            //  else if(p0.isNotEmpty){
                                            //   return '';
                                            // }
                                            else if ((title ==
                                                        'Blood Pressure values' ||
                                                    title == 'ضغط الدم' ||
                                                    title ==
                                                        "بلڈ پریشر کی اقدار") &&
                                                (int.parse(controller2!.text) >
                                                    int.parse(
                                                        controller1!.text))) {
                                              return 'Diastolic should be less than Systolic';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                    ],
                                  )
                                : const SizedBox.shrink(),
                            title == "Glucose" || title == 'الجلوكوز'
                                ? RadioButtonRow()
                                : const SizedBox.shrink(),
                            Container(
                              width: Get.width,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: ColorManager.kPrimaryLightColor),
                              child: Text(
                                'history'.tr,
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        color: ColorManager.kPrimaryColor,
                                        fontWeight: FontWeight.w600),
                              ),
                            ),
                            SizedBox(
                              height: Get.height * 0.02,
                            ),
                            Container(
                              width: Get.width,
                              padding: const EdgeInsets.all(10),
                              decoration: const BoxDecoration(
                                  color: ColorManager.kPrimaryLightColor),
                              child: Column(
                                children: [
                                  CustomRow(
                                    title: 'glucose'.tr,
                                    value: 'values'.tr,
                                    condition: title == 'Glucose' ||
                                            title == 'الجلوكوز'
                                        ? 'condition'.tr
                                        : '',
                                    dateTime: '${'date'.tr}/${'time'.tr}',
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.02,
                                  ),
                                  GetBuilder<HealthSummaryController>(
                                      builder: (cont) {
                                    return SizedBox(
                                      height: Get.height * 0.2,
                                      child: ListView.builder(
                                          itemCount: cont.history.length,
                                          shrinkWrap: true,
                                          keyboardDismissBehavior:
                                              ScrollViewKeyboardDismissBehavior
                                                  .onDrag,
                                          itemBuilder: ((context, index) {
                                            var item = cont.history[index];
                                            return CustomRow(
                                              title: item.title,
                                              value: title == 'Glucose' ||
                                                      title == 'الجلوكوز' ||
                                                      title == 'Sp02%' ||
                                                      title == 'Pulse' ||
                                                      title == 'Temperature' ||
                                                      title == 'نبض' ||
                                                      title == 'درجة حرارة'
                                                  ? '${item.value}'
                                                  : '${item.value}${item.value1 != null ? '/' : ''}${item.value1}',
                                              value1: '${item.value}',
                                              value2: '${item.value1}',
                                              condition: '${item.condition}',
                                              dateTime: '${item.dateTime}',
                                            );
                                          })),
                                    );
                                  })
                                ],
                              ),
                            ),
                            SizedBox(
                              height: Get.height * 0.02,
                            ),
                            PrimaryButton(
                                height: Get.height * 0.06,
                                fontSize: 12,
                                title: 'saveRecord'.tr,
                                onPressed: () async {
                                  if (formKey!.currentState!.validate()) {
                                    var id = uuid.v4();
                                    String? patientId =
                                        await LocalDb().getPatientId();
                                    int result = await SqfliteDB().insert(
                                        HealthModel(
                                            value1: controller2?.text ?? '',
                                            id: id,
                                            patientId: patientId,
                                            value: controller1?.text ?? '',
                                            condition: title == 'Glucose' ||
                                                    title == 'الجلوكوز'
                                                ? selectedValue()
                                                : null,
                                            title: title == 'Glucose' ||
                                                    title == 'الجلوكوز'
                                                ? "Glucose"
                                                : '$title',
                                            dateTime: HealthSummaryController
                                                .i.formattedDatetime));
                                    log(result.toString());
                                    var list = await SqfliteDB()
                                        .queryAllRowsBasedOnTitle(title);
                                    HealthSummaryController.i
                                        .updateHistoryList(list);
                                    HealthSummaryController.i.controller1
                                        .clear();
                                    HealthSummaryController.i.controller2
                                        .clear();
                                    await SqfliteDB()
                                        .getLastHealthModelWithTitle(title!);
                                    await HealthSummaryController.i
                                        .getLastDataBasedOnTitle();
                                  } else {}
                                },
                                color: ColorManager.kPrimaryColor,
                                textcolor: ColorManager.kWhiteColor)
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )),
            ),
          );
        }));
  }
}

class CustomRow extends StatelessWidget {
  final String? value1;
  final String? value2;
  final String? title;
  final String? value;
  final String? condition;
  final String? dateTime;
  const CustomRow({
    super.key,
    this.value,
    this.condition,
    this.dateTime,
    this.title,
    this.value1,
    this.value2,
  });

  @override
  Widget build(BuildContext context) {
    return Table(
      columnWidths: const {
        1: FixedColumnWidth(90),
        2: FixedColumnWidth(100),
        3: FixedColumnWidth(30),
      },
      children: [
        TableRow(children: [
          Text(
            '$value ',
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: ColorManager.kPrimaryColor, fontSize: 10),
          ),
          title == 'Glucose' || title == 'الجلوكوز'
              ? Text(
                  '$condition',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: ColorManager.kPrimaryColor, fontSize: 10),
                )
              : const SizedBox.shrink(),
          Text(
            '$dateTime',
            textAlign: TextAlign.end,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: ColorManager.kPrimaryColor, fontSize: 10),
          ),
        ]),
      ],
    );
    // return Row(
    //   mainAxisAlignment: MainAxisAlignment.spaceAround,
    //   children: [
    //     Column(
    //       children: [

    //   ],
    // ),
    //     Column(
    //       children: [
    // title == 'Glucose' || title == 'الجلوكوز'
    //     ? Column(
    //         crossAxisAlignment: CrossAxisAlignment.center,
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: [
    //           Text(
    //             '$condition',
    //             textAlign: TextAlign.center,
    //             style: Theme.of(context).textTheme.bodyMedium!.copyWith(
    //                 color: ColorManager.kPrimaryColor,
    //                 fontWeight: FontWeight.w600,
    //                 fontSize: 12),
    //           ),
    //         ],
    //       )
    //     : const SizedBox.shrink(),
    //       ],
    //     ),
    //     Column(
    //       children: [
    // Text(
    //   '$dateTime',
    //   textAlign: TextAlign.center,
    //   style: Theme.of(context).textTheme.bodyMedium!.copyWith(
    //       color: ColorManager.kPrimaryColor,
    //       fontWeight: FontWeight.w600,
    //       fontSize: 12),
    // ),
    //       ],
    //     ),
    //   ],
    // );
  }
}

class RadioButtonRow extends StatelessWidget {
  final HealthController _controller = Get.put(HealthController());

  RadioButtonRow({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HealthController>(builder: (contr) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Radio<int>(
            fillColor: MaterialStateProperty.all(ColorManager.kPrimaryColor),
            value: 0,
            groupValue: _controller.selectedOption,
            onChanged: (value) {
              _controller.setSelectedOption(value!);
            },
          ),
          Text(
            'normal'.tr,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontFamily: GoogleFonts.urbanist().fontFamily,
                color: Colors.black),
          ),
          const SizedBox(
            width: 30,
          ),
          Radio<int>(
            fillColor: MaterialStateProperty.all(ColorManager.kPrimaryColor),
            value: 1,
            groupValue: _controller.selectedOption,
            onChanged: (value) {
              _controller.setSelectedOption(value!);
              log(contr.selectedOption.toString());
            },
          ),
          Text('fasting'.tr),
        ],
      );
    });
  }
}

String? selectedValue() {
  if (HealthController.i.selectedOption == 0) {
    return 'normal'.tr;
  } else {
    return 'fasting'.tr;
  }
}
