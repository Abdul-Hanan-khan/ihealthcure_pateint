// ignore_for_file: use_build_context_synchronously
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tabib_al_bait/components/primary_button.dart';
import 'package:tabib_al_bait/data/controller/health_summary_controller.dart';
import 'package:tabib_al_bait/data/sqflite_db/sqflite_db.dart';
import 'package:tabib_al_bait/helpers/color_manager.dart';
import 'package:tabib_al_bait/helpers/values_manager.dart';
import 'package:tabib_al_bait/models/health_summary_model/health_summary_model.dart';
import 'package:tabib_al_bait/screens/family_screens/family_members.dart';
import 'package:tabib_al_bait/screens/no_data_found/no_data_found.dart';
import 'package:tabib_al_bait/screens/pdf_viewer/pdf_viewer.dart';
import 'package:tabib_al_bait/utils/dialogue_boxes/dialogue.dart';

double screenWidth = MediaQuery.of(Get.context!).size.width;
TextEditingController controller = TextEditingController();

class HealthSummary extends StatefulWidget {
  final bool? isHereFromLogin;
  const HealthSummary({super.key, this.isHereFromLogin = false});

  @override
  State<HealthSummary> createState() => _HealthSummaryState();
}

class _HealthSummaryState extends State<HealthSummary> {
  @override
  void initState() {
    HealthSummaryController.i.getHealthSummaryData();
    HealthSummaryController.i.getLastDataBasedOnTitle();
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var health = Get.put<HealthSummaryController>(HealthSummaryController());
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: CustomAppBar(
          isScheduleScreen: widget.isHereFromLogin,
          title: 'healthSummary'.tr,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppPadding.p20),
        child: SingleChildScrollView(
          child: GetBuilder<HealthSummaryController>(builder: (cont) {
            return cont.isLoading == false
                ? Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                              child: dataWidget(context,
                                  formkey: _formKey,
                                  unit: 'mg/dl',
                                  title: 'glucose'.tr,
                                  date: cont.normalglucose?.dateTime != null
                                      ? '${cont.normalglucose?.dateTime?.split(' - ').first}'
                                      : '',
                                  whiteContainerContent: SizedBox(
                                    height: Get.height * 0.06,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              'normal'.tr,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium
                                                  ?.copyWith(fontSize: 10),
                                            ),
                                            Text(
                                              cont.normalglucose?.value != null
                                                  ? '${cont.normalglucose?.value}'
                                                  : '--',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium
                                                  ?.copyWith(
                                                      fontSize: 11,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: normalValues(
                                                          HealthSummaryController
                                                              .i
                                                              .normalglucose)),
                                            )
                                          ],
                                        ),
                                        Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              'fasting'.tr,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium
                                                  ?.copyWith(fontSize: 11),
                                            ),
                                            Text(
                                              cont.fastingGlucose?.value != null
                                                  ? '${cont.fastingGlucose?.value}'
                                                  : '--',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium
                                                  ?.copyWith(
                                                      fontSize: 11,
                                                      color: normalValues(
                                                          HealthSummaryController
                                                              .i
                                                              .fastingGlucose),
                                                      fontWeight:
                                                          FontWeight.bold),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ))),
                          SizedBox(
                            width: Get.width * 0.02,
                          ),
                          Expanded(
                              child: dataWidget(context,
                                  unit: 'mm Hg',
                                  formkey: _formKey,
                                  title: bloodPressureTitle('bloodPressure'.tr),
                                  date: cont.bloodPressure?.dateTime != null
                                      ? '${cont.bloodPressure?.dateTime?.split('-').first}'
                                      : '',
                                  hintText1: 'systolicupper'.tr,
                                  hintText2: 'diastolic'.tr,
                                  whiteContainerContent: SizedBox(
                                    height: Get.height * 0.04,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          cont.bloodPressure?.value != null
                                              ? '${cont.bloodPressure?.value}'
                                              : '--',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                                  fontSize: 12,
                                                  color: normalValues(
                                                      HealthSummaryController
                                                          .i.bloodPressure),
                                                  fontWeight: FontWeight.w900),
                                        ),
                                        const Text('/'),
                                        Text(
                                          cont.bloodPressure?.value1 != null
                                              ? '${cont.bloodPressure?.value1}'
                                              : '--',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                                  fontSize: 12,
                                                  color: normalValues(
                                                      HealthSummaryController
                                                          .i.bloodPressure),
                                                  fontWeight: FontWeight.w900),
                                        ),
                                      ],
                                    ),
                                  ))),
                        ],
                      ),
                      SizedBox(
                        height: Get.height * 0.02,
                      ),
                      Row(
                        children: [
                          Flexible(
                              child: dataWidget(context,
                                  unit: 'cm/kg',
                                  formkey: _formKey,
                                  title: 'measurements'.tr,
                                  date: cont.measurements?.dateTime != null
                                      ? '${cont.measurements?.dateTime?.split(' - ').first}'
                                      : '',
                                  hintText1: 'height'.tr,
                                  hintText2: 'weight'.tr,
                                  whiteContainerContent: SizedBox(
                                    height: Get.height * 0.05,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              'height'.tr,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium
                                                  ?.copyWith(
                                                      fontSize: 11,
                                                      color: ColorManager
                                                          .kblackColor,
                                                      fontWeight:
                                                          FontWeight.w500),
                                            ),
                                            Text(
                                              cont.measurements?.value != null
                                                  ? '${cont.measurements?.value}'
                                                  : '--',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium
                                                  ?.copyWith(
                                                      fontSize: 11,
                                                      color: ColorManager
                                                          .kblackColor,
                                                      fontWeight:
                                                          FontWeight.w900),
                                            )
                                          ],
                                        ),
                                        Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              'weight'.tr,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium
                                                  ?.copyWith(
                                                      fontSize: 11,
                                                      color: ColorManager
                                                          .kblackColor,
                                                      fontWeight:
                                                          FontWeight.w500),
                                            ),
                                            Text(
                                              cont.measurements?.value1 != null
                                                  ? '${cont.measurements?.value1}'
                                                  : '--',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium
                                                  ?.copyWith(
                                                      fontSize: 11,
                                                      color: ColorManager
                                                          .kblackColor,
                                                      fontWeight:
                                                          FontWeight.w900),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ))),
                          SizedBox(
                            width: Get.width * 0.02,
                          ),
                          Flexible(
                              child: dataWidget(context,
                                  formkey: _formKey,
                                  title: 'Sp02%',
                                  unit: '',
                                  date: cont.sp02?.dateTime != null
                                      ? '${cont.sp02?.dateTime?.split(' - ').first}'
                                      : '',
                                  whiteContainerContent: SizedBox(
                                    height: Get.height * 0.05,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          cont.sp02?.value != null
                                              ? '${cont.sp02?.value}'
                                              : '--',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                                  color: normalValues(
                                                      HealthSummaryController
                                                          .i.sp02),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w900),
                                        )
                                      ],
                                    ),
                                  ))),
                        ],
                      ),
                      SizedBox(
                        height: Get.height * 0.02,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: dataWidget(context,
                                  formkey: _formKey,
                                  title: 'pulse'.tr,
                                  unit: 'BPM',
                                  date: cont.pulse?.dateTime != null
                                      ? '${cont.pulse?.dateTime?.split(' - ').first}'
                                      : '',
                                  whiteContainerContent: SizedBox(
                                    height: Get.height * 0.05,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          cont.pulse?.value != null
                                              ? '${cont.pulse?.value}'
                                              : '--',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                                  color: normalValues(
                                                      HealthSummaryController
                                                          .i.pulse),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w900),
                                        )
                                      ],
                                    ),
                                  ))),
                          SizedBox(
                            width: Get.width * 0.02,
                          ),
                          Expanded(
                              child: dataWidget(context,
                                  formkey: _formKey,
                                  title: 'temperature'.tr,
                                  unit: '\u00B0 F',
                                  date: cont.temperature?.dateTime != null
                                      ? '${cont.temperature?.dateTime?.split(' - ').first}'
                                      : '',
                                  whiteContainerContent: SizedBox(
                                    height: Get.height * 0.05,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          cont.temperature?.value != null
                                              ? '${cont.temperature?.value}'
                                              : '--',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                                  color: normalValues(
                                                      HealthSummaryController
                                                          .i.temperature),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w900),
                                        )
                                      ],
                                    ),
                                  ))),
                        ],
                      ),
                      SizedBox(
                        height: Get.height * 0.03,
                      ),
                      // Text(
                      //   'ecg'.tr,
                      //   style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      //       color: ColorManager.kPrimaryColor,
                      //       fontWeight: FontWeight.w600),
                      // ),
                      // SizedBox(
                      //   height: Get.height * 0.02,
                      // ),
                      // SfCartesianChart(
                      //   primaryXAxis: CategoryAxis(),
                      //   series: <ChartSeries>[
                      //     LineSeries<StepsDataModel, String>(
                      //         color: ColorManager.kRedColor,
                      //         xAxisName: 'Time',
                      //         yAxisName: 'Steps',
                      //         dataSource: steps,
                      //         xValueMapper: ((StepsDataModel steps, _) =>
                      //             steps.time.toString()),
                      //         yValueMapper: ((StepsDataModel time, _) =>
                      //             time.stepsCount))
                      //   ],
                      // ),
                      Container(
                        padding: const EdgeInsets.all(AppPadding.p16),
                        decoration: const BoxDecoration(
                            color: ColorManager.kPrimaryLightColor),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'test'.tr,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                          color: ColorManager.kPrimaryColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w900),
                                ),
                                Text(
                                  'status'.tr,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                          color: ColorManager.kPrimaryColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w900),
                                )
                              ],
                            ),
                            SizedBox(
                              height: Get.height * 0.01,
                            ),
                            Text(
                              'labTestResult'.tr,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                      color: ColorManager.kPrimaryColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w900),
                            ),
                            SizedBox(
                              height: Get.height * 0.01,
                            ),
                            ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: cont.investigationSummary?.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  var inv = cont.investigationSummary?[index];
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: Get.width * 0.6,
                                        child: Text(
                                          '${inv?.testName}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                                  color: ColorManager
                                                      .kPrimaryColor,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w900),
                                        ),
                                      ),
                                      inv?.uRL != null && inv?.uRL != ''
                                          ? IconButton(
                                              icon: const Icon(
                                                  Icons.picture_as_pdf),
                                              onPressed: () {
                                                log('${inv!.uRL.toString()} url');
                                                if (inv.uRL!.isNotEmpty) {
                                                  Get.to(() => PdfViewerPage(
                                                        testName: inv.testName,
                                                        url: inv.uRL,
                                                      ));
                                                }
                                              },
                                            )
                                          : Text('pending'.tr)
                                    ],
                                  );
                                }),
                            SizedBox(
                              height: Get.height * 0.01,
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: Get.height * 0.02,
                      ),
                      // PrimaryButton(
                      //     title: 'Connect',
                      //     onPressed: () {},
                      //     color: ColorManager.kPrimaryColor,
                      //     textcolor: ColorManager.kWhiteColor),
                      SizedBox(
                        height: Get.height * 0.02,
                      ),
                      // Container(
                      //   width: Get.width,
                      //   padding: const EdgeInsets.all(AppPadding.p10),
                      //   decoration: BoxDecoration(
                      //       color: ColorManager.kPrimaryLightColor,
                      //       borderRadius: BorderRadius.circular(20)),
                      //   child: Column(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //       Text(
                      //         'Health Summary',
                      //         style: Theme.of(context)
                      //             .textTheme
                      //             .bodyMedium
                      //             ?.copyWith(
                      //                 color: ColorManager.kPrimaryColor,
                      //                 fontSize: 14,
                      //                 fontWeight: FontWeight.w900),
                      //       ),
                      //       SizedBox(
                      //         height: Get.height * 0.02,
                      //       ),
                      //       SizedBox(
                      //         height: Get.height * 0.08,
                      //         child: ListView.builder(
                      //             scrollDirection: Axis.horizontal,
                      //             itemCount: 2,
                      //             shrinkWrap: true,
                      //             itemBuilder: (context, index) {
                      //               return Padding(
                      //                 padding: const EdgeInsets.all(5),
                      //                 child: Container(
                      //                   padding: const EdgeInsets.all(5),
                      //                   decoration: BoxDecoration(
                      //                       borderRadius:
                      //                           BorderRadius.circular(10),
                      //                       color: ColorManager.kPrimaryColor),
                      //                   child: Row(
                      //                     mainAxisSize: MainAxisSize.min,
                      //                     children: [
                      //                       Text(
                      //                         'Health Summary',
                      //                         style: Theme.of(context)
                      //                             .textTheme
                      //                             .bodyMedium
                      //                             ?.copyWith(
                      //                                 color: ColorManager
                      //                                     .kWhiteColor,
                      //                                 fontSize: 14,
                      //                                 fontWeight:
                      //                                     FontWeight.w900),
                      //                       ),
                      //                       const Icon(
                      //                         Icons.close,
                      //                         color: ColorManager.kWhiteColor,
                      //                       )
                      //                     ],
                      //                   ),
                      //                 ),
                      //               );
                      //             }),
                      //       )
                      //     ],
                      //   ),
                      // )
                    ],
                  )
                : Center(
                    child: Column(
                      children: [
                        SizedBox(
                          height: Get.height * 0.3,
                        ),
                        const CircularProgressIndicator(),
                      ],
                    ),
                  );
          }),
        ),
      ),
    );
  }

  Widget dataWidget(BuildContext context,
      {String? title,
      String? unit,
      GlobalKey<FormState>? formkey,
      String? date,
      Widget? whiteContainerContent,
      String? hintText1,
      String? hintText2}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '$title',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: ColorManager.kPrimaryColor, fontWeight: FontWeight.w900),
        ),
        InkWell(
          onTap: () async {
            var list = await SqfliteDB().queryAllRowsBasedOnTitle(title);
            HealthSummaryController.i.updateHistoryList(list);
            AlertDialgue().dialogueBox(context,
                formKey: formkey,
                list: list,
                controller1: HealthSummaryController.i.controller1,
                controller2: HealthSummaryController.i.controller2,
                title: title == 'Blood Pressure' ? '$title values' : title,
                hintText1: hintText1,
                hintText2: hintText2);
          },
          child: Container(
            width: Get.width * 0.5,
            padding: const EdgeInsets.all(AppPadding.p10)
                .copyWith(top: 30, bottom: 30),
            decoration: BoxDecoration(
                color: ColorManager.kPrimaryLightColor,
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '$date',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: ColorManager.kPrimaryColor,
                      fontWeight: FontWeight.w900,
                      fontSize: 12),
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                Container(
                    padding: const EdgeInsets.all(AppPadding.p4)
                        .copyWith(left: 15, right: 15),
                    decoration: BoxDecoration(
                        color: ColorManager.kWhiteColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: SizedBox(
                        height: Get.height * 0.05,
                        child: whiteContainerContent)),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                Text(
                  '$unit',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: ColorManager.kPrimaryColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w600),
                )
              ],
            ),
          ),
        ),
        SizedBox(
          height: Get.height * 0.02,
        ),
        PrimaryButton(
          title: 'connect'.tr,
          onPressed: () async {
            Get.to(() => const NoDataFound());
          },
          color: ColorManager.kPrimaryColor,
          textcolor: ColorManager.kWhiteColor,
          fontSize: 12,
        )
      ],
    );
  }
}

Color normalValues(HealthModel? title) {
  if (title == null) {
    return Colors.red;
  }

  switch (title.title) {
    case 'Sp02%':
      return evaluateSpO2(title.value);
    case 'Blood Pressure values':
      return evaluateBloodPressure(title.value);
    case 'Pulse':
      return evaluatePulse(title.value);
    case 'Temperature':
      return evalTemperature(title.value);
    case 'Glucose':
      return evalFastingGlucose(title.value);
    default:
      return Colors.red;
  }
}

Color evaluateSpO2(String? value) {
  if (value == null) {
    return Colors.red;
  }

  int parsedValue = int.tryParse(value) ?? 0;

  if (parsedValue >= 80 && parsedValue < 95) {
    return Colors.yellow;
  } else if (parsedValue >= 95 && parsedValue <= 100) {
    return Colors.green;
  } else {
    return Colors.red;
  }
}

Color evaluateBloodPressure(String? value) {
  if (value == null) {
    return Colors.red;
  }

  int parsedValue = int.tryParse(value) ?? 0;

  if (parsedValue >= 80 && parsedValue <= 120) {
    return Colors.green;
  } else {
    return Colors.yellow;
  }
}

Color evalTemperature(String? value) {
  if (value == null) {
    return Colors.red;
  }

  int parsedValue = int.tryParse(value) ?? 0;

  if (parsedValue >= 93 && parsedValue <= 100) {
    return Colors.green;
  } else if (parsedValue <= 92 && parsedValue >= 90) {
    return Colors.yellow;
  } else {
    return Colors.red;
  }
}

Color evalFastingGlucose(String? value) {
  if (value == null) {
    return Colors.black;
  }

  int parsedValue = int.tryParse(value) ?? 0;

  if (parsedValue >= 70 && parsedValue <= 100) {
    return Colors.green;
  } else if ((parsedValue > 110 && parsedValue < 120) ||
      parsedValue < 70 && parsedValue >= 60) {
    return Colors.yellow;
  } else {
    return Colors.red;
  }
}

Color evaluatePulse(String? value) {
  if (value == null) {
    return Colors.black;
  }

  int parsedValue = int.tryParse(value) ?? 0;

  if (parsedValue > 50 && parsedValue <= 110) {
    return Colors.green;
  } else if (parsedValue > 110 && parsedValue < 120) {
    return Colors.yellow;
  } else {
    return Colors.red;
  }
}

String bloodPressureTitle(String? title) {
  if (title == 'bloodPressure'.tr) {
    title = 'Blood Pressure';
    return title;
  } else {
    return '';
  }
}
