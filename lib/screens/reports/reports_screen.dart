import 'dart:async';
import 'dart:developer';
import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:tabib_al_bait/components/custom_textfields.dart';
import 'package:tabib_al_bait/components/images.dart';
import 'package:tabib_al_bait/data/controller/reportcontroller.dart';
import 'package:tabib_al_bait/data/controller/schedule_controller.dart';
import 'package:tabib_al_bait/helpers/color_manager.dart';
import 'package:tabib_al_bait/helpers/font_manager.dart';
import 'package:tabib_al_bait/helpers/show_toast.dart';
import 'package:tabib_al_bait/helpers/values_manager.dart';
import 'package:tabib_al_bait/models/digital_prescriptions_response/digital_prescriptions_response.dart';
import 'package:tabib_al_bait/models/labTestResultResponse/LabTestResultResponse.dart';
import 'package:tabib_al_bait/models/services_model.dart';
import 'package:tabib_al_bait/screens/dashboard/schedule.dart';
import 'package:tabib_al_bait/screens/family_screens/family_members.dart';
import 'package:tabib_al_bait/screens/imaging_screen/imaging_booking.dart';
import 'package:tabib_al_bait/screens/lab_screens/lab_investigations.dart';
import 'package:tabib_al_bait/screens/pdf_viewer/pdf_viewer.dart';
import 'package:tabib_al_bait/screens/specialists_screen/doctor_schedule.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  TextEditingController controller = TextEditingController();
  ScrollController _scrollController = ScrollController();

  scrollController() async {
    _scrollController.addListener(() async {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        bool? isCallToFetchData = await Reportcontroller.j
            .setStartToFetchNextDataForUpcomingLabReports();
        if (isCallToFetchData!) {
          Reportcontroller.j.getLabTestReportsFromAPI('');
        }
      }
    });
  }

  @override
  void initState() {
    scrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Reportcontroller.j.updateSelectedTab(0);
      ScheduleController.i.updateSelectedService(0);
    });
    Reportcontroller.j.getLabTestReportsFromAPI('');
    super.initState();
  }

  @override
  void dispose() {
    Reportcontroller.j.updateSelectedTab(0);
    ScheduleController.i.updateSelectedService(-1);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var cont = Get.put<Reportcontroller>(Reportcontroller());
    List<Services> reportsType = [
      Services(
          onPressed: () {
            Reportcontroller.j.updateSelectedTab(0);
            Reportcontroller.j.getLabTestReportsFromAPI('');
            ScheduleController.i.updateSelectedService(0);
          },
          title: 'digitalPrescriptions'.tr,
          imagePath: Images.rxDoc,
          color: ColorManager.kPrimaryColor,
          gradientColor: ColorManager.kWhiteColor),
      Services(
          onPressed: () {
            Reportcontroller.j.updateSelectedTab(1);
            Reportcontroller.j.getLabTestReportsFromAPI('');
            ScheduleController.i.updateSelectedService(1);
            // setState(() {

            // });
          },
          title: 'labInvestions'.tr,
          imagePath: Images.microscope,
          color: ColorManager.kyellowContainer,
          gradientColor: ColorManager.kWhiteColor),
      Services(
          onPressed: () {
            Reportcontroller.j.updateSelectedTab(2);
            Reportcontroller.j.getLabTestReportsFromAPI('');
            ScheduleController.i.updateSelectedService(2);
          },
          title: 'imagingbooking'.tr,
          imagePath: Images.imaging,
          color: ColorManager.kCyanBlue,
          gradientColor: ColorManager.kWhiteColor),
    ];
    String? search;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: CustomAppBar(
            title: 'reports'.tr,
          ),
        ),
        body: GetBuilder<Reportcontroller>(builder: (cont) {
          return BlurryModalProgressHUD(
            inAsyncCall: cont.isLoading,
            blurEffectIntensity: 4,
            progressIndicator: const SpinKitSpinningLines(
              color: Color(0xff1272d3),
              size: 60,
            ),
            dismissible: false,
            opacity: 0.4,
            color: Theme.of(context).scaffoldBackgroundColor,
            child: SafeArea(
                minimum: const EdgeInsets.all(AppPadding.p18),
                child: GetBuilder<Reportcontroller>(builder: (cont) {
                  return Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ServiceWidget(
                            service: reportsType[0],
                            height: Get.height * 0.12,
                            width: Get.width * 0.25,
                            index: 0,
                          ),
                          ServiceWidget(
                            service: reportsType[1],
                            height: Get.height * 0.12,
                            width: Get.width * 0.25,
                            index: 1,
                          ),
                          ServiceWidget(
                            service: reportsType[2],
                            height: Get.height * 0.12,
                            width: Get.width * 0.25,
                            index: 2,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: Get.height * 0.02,
                      ),
                      CustomTextField(
                        controller: controller,
                        onchanged: (p0) {
                          Timer(const Duration(milliseconds: 300), () {
                            if (cont.selectedTab == 1) {
                              log(search.toString());
                              Reportcontroller.j.getLabTestReportsFromAPI(
                                  controller.text.trim());
                            } else if (cont.selectedTab == 2) {
                              Reportcontroller.j.getLabTestReportsFromAPI(
                                  controller.text.trim());
                            } else {
                              Reportcontroller.j.getLabTestReportsFromAPI(
                                  controller.text.trim());
                            }
                          });
                        },
                        fillColor: ColorManager.kPrimaryLightColor,
                        hintText: 'search'.tr,
                        prefixIcon: const Icon(
                          Icons.search,
                          color: ColorManager.kPrimaryColor,
                        ),
                      ),
                      cont.isLoading == false
                          ? GetBuilder<Reportcontroller>(builder: (cont) {
                              return cont.selectedTab == 0
                                  ? Flexible(
                                      child: ListView.builder(
                                          controller: _scrollController,
                                          shrinkWrap: true,
                                          physics:
                                              const AlwaysScrollableScrollPhysics(),
                                          itemCount: Reportcontroller.j
                                              .digitalPrescriptionsList.length,
                                          itemBuilder: (context, index) {
                                            var result = Reportcontroller
                                                    .j.digitalPrescriptionsList[
                                                index];
                                            return DigitalPrescriptionsWidget(
                                              index: index,
                                              dp: result,
                                            );
                                          }),
                                    )
                                  : cont.selectedTab == 1
                                      ? Flexible(
                                          child: ListView.builder(
                                              controller: _scrollController,
                                              shrinkWrap: true,
                                              physics:
                                                  const AlwaysScrollableScrollPhysics(),
                                              itemCount:
                                                  cont.labTestReports.length,
                                              itemBuilder: (context, index) {
                                                var dp =
                                                    cont.labTestReports[index];
                                                return LabTestResultWidget(
                                                  labResult: dp,
                                                );
                                              }),
                                        )
                                      : Reportcontroller
                                              .j.diagnosticReports.isNotEmpty
                                          ? Flexible(
                                              child: ListView.builder(
                                                controller: _scrollController,
                                                  physics:
                                                      const AlwaysScrollableScrollPhysics(),
                                                  itemCount: Reportcontroller.j
                                                      .diagnosticReports.length,
                                                  shrinkWrap: true,
                                                  itemBuilder:
                                                      ((context, index) {
                                                    var report = Reportcontroller
                                                            .j
                                                            .diagnosticReports[
                                                        index];
                                                    return Column(
                                                      children: [
                                                        index == 0
                                                            ? const SizedBox
                                                                .shrink()
                                                            : SizedBox(
                                                                height:
                                                                    Get.height *
                                                                        0.02,
                                                              ),
                                                        Container(
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                              color: ColorManager
                                                                  .kPrimaryLightColor),
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(
                                                                  AppPadding
                                                                      .p20),
                                                          child: Column(
                                                              children: [
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Text(
                                                                      'prescribedBy'
                                                                          .tr,
                                                                      style: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .bodySmall
                                                                          ?.copyWith(
                                                                              color: ColorManager.kPrimaryColor,
                                                                              fontSize: 12),
                                                                    ),
                                                                    Text(
                                                                      '${report.visitNo}'
                                                                          .tr,
                                                                      style: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .bodySmall
                                                                          ?.copyWith(
                                                                              color: ColorManager.kblackColor,
                                                                              fontSize: 12),
                                                                    )
                                                                  ],
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    SizedBox(
                                                                        width: Get.width *
                                                                            0.25,
                                                                        child:
                                                                            Text(
                                                                          '${report.prescribedBy}',
                                                                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                                              fontWeight: FontWeight.w900,
                                                                              color: ColorManager.kPrimaryColor,
                                                                              fontSize: 12),
                                                                        )),
                                                                    Text(
                                                                      '${'visitTime'.tr} ${report.visitTime}',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .start,
                                                                      style: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .bodySmall
                                                                          ?.copyWith(
                                                                              color: ColorManager.kblackColor,
                                                                              fontSize: 12),
                                                                    )
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                  height:
                                                                      Get.height *
                                                                          0.02,
                                                                ),
                                                                const MySeparator(),
                                                                SizedBox(
                                                                  height:
                                                                      Get.height *
                                                                          0.02,
                                                                ),
                                                                SizedBox(
                                                                  height:
                                                                      Get.height *
                                                                          0.01,
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    SizedBox(
                                                                      width: Get
                                                                              .width *
                                                                          0.6,
                                                                      child:
                                                                          Text(
                                                                        '${report.testName}',
                                                                        style: Theme.of(context)
                                                                            .textTheme
                                                                            .bodySmall
                                                                            ?.copyWith(
                                                                                color: ColorManager.kPrimaryColor,
                                                                                fontWeight: FontWeight.w900),
                                                                      ),
                                                                    ),
                                                                    InkWell(
                                                                        onTap:
                                                                            (() {
                                                                          if (report.uRL == null ||
                                                                              report.uRL! == '') {
                                                                            ToastManager.showToast('notfound'.tr);
                                                                          } else {
                                                                            Get.to(() =>
                                                                                PdfViewerPage(
                                                                                  url: report.uRL,
                                                                                  testName: report.visitNo,
                                                                                ));
                                                                          }
                                                                        }),
                                                                        child: Image
                                                                            .asset(
                                                                          Images
                                                                              .imagingIcon,
                                                                          height:
                                                                              Get.height * 0.03,
                                                                        ))
                                                                  ],
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    const Icon(
                                                                      Icons
                                                                          .pin_drop_outlined,
                                                                      color: ColorManager
                                                                          .kPrimaryColor,
                                                                    ),
                                                                    Text(
                                                                      '${report.cityName}',
                                                                      style: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .bodySmall
                                                                          ?.copyWith(
                                                                              color: ColorManager.kblackColor,
                                                                              fontWeight: FontWeight.w500),
                                                                    ),
                                                                    const Spacer(),
                                                                    Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .min,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .end,
                                                                      children: [
                                                                        Text(
                                                                          'status'
                                                                              .tr,
                                                                          textAlign:
                                                                              TextAlign.end,
                                                                          style: Theme.of(context)
                                                                              .textTheme
                                                                              .bodySmall
                                                                              ?.copyWith(color: ColorManager.kPrimaryColor, fontWeight: FontWeight.w500),
                                                                        ),
                                                                        Text(
                                                                          '${report.patientLabStatus}'
                                                                              .tr,
                                                                          textAlign:
                                                                              TextAlign.end,
                                                                          style: Theme.of(context)
                                                                              .textTheme
                                                                              .bodySmall
                                                                              ?.copyWith(color: ColorManager.kblackColor, fontWeight: FontWeight.w500),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                )
                                                              ]),
                                                        ),
                                                      ],
                                                    );
                                                  })),
                                            )
                                          : Center(
                                              child: Text('noDataFound'.tr),
                                            );
                            })
                          : Center(
                              child: Text('noDataFound'.tr),
                            )
                    ],
                  );
                })),
          );
        }),
      ),
    );
  }
}

class DigitalPrescriptionsWidget extends StatefulWidget {
  final int? index;
  final DigitalPrescriptions? dp;
  const DigitalPrescriptionsWidget({
    super.key,
    this.dp,
    this.index,
  });

  @override
  State<DigitalPrescriptionsWidget> createState() =>
      _DigitalPrescriptionsWidgetState();
}

class _DigitalPrescriptionsWidgetState
    extends State<DigitalPrescriptionsWidget> {
  List<bool> fixedLengthList = [];
  List<bool> diagnostics = [];
  @override
  void initState() {
    fixedLengthList = List<bool>.generate(
        widget.dp!.labInvestigation!.length, (int index) => false,
        growable: true);
    diagnostics = List<bool>.generate(
        widget.dp!.diagnostics!.length, ((index) => false),
        growable: true);
    log(fixedLengthList.toString());
    super.initState();
  }

  var isShowAllItems = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isShowAllItems = !isShowAllItems;
          Reportcontroller.j.updateSelectedDigitalPrescription(widget.index!);
          fixedLengthList = List<bool>.generate(
              widget.dp!.labInvestigation!.length, (int index) => false,
              growable: true);
          diagnostics = List<bool>.generate(
              widget.dp!.diagnostics!.length, ((index) => false),
              growable: true);
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 15),
        padding: const EdgeInsets.all(AppPadding.p10),
        decoration: BoxDecoration(
            color: ColorManager.kPrimaryLightColor,
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  child: Text(
                    '${'visitNo'.tr} : \n${widget.dp?.visitNo ?? ''}',
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: ColorManager.kPrimaryColor,
                        fontWeight: FontWeightManager.medium,
                        fontSize: 12),
                  ),
                ),
                Text(
                  '${'checkInTime'.tr} | \n${widget.dp?.consultedTime ?? ''}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeightManager.medium, fontSize: 12),
                )
              ],
            ),
            SizedBox(
              height: Get.height * 0.01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.dp?.doctorName?.trim() ?? '',
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: ColorManager.kPrimaryColor,
                      fontWeight: FontWeightManager.bold,
                      fontSize: 12),
                ),
                Text(
                  '${'visitTime'.tr} | \n${widget.dp?.admissionTime ?? ''}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeightManager.medium, fontSize: 12),
                )
              ],
            ),
            const Divider(
              color: ColorManager.kblackColor,
            ),
            Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () {
                    if (widget.dp?.uRL == null || widget.dp!.uRL! == '') {
                      ToastManager.showToast('notfound'.tr);
                    } else {
                      Get.to(() => PdfViewerPage(
                            url: widget.dp?.uRL,
                            testName: widget.dp?.visitNo,
                          ));
                    }
                  },
                  child: Image.asset(
                    Images.rxButton,
                    height: 20,
                    fit: BoxFit.cover,
                    color: ColorManager.kPrimaryColor,
                  ),
                )),
            SizedBox(
              height: Get.height * 0.01,
            ),
            isShowAllItems == true &&
                    Reportcontroller.j.selectedDigitalPrescription ==
                        widget.index
                ? Column(
                    children: [
                      Table(
                        // border: const TableBorder(
                        //   top: BorderSide(color: Colors.black),
                        //   right: BorderSide(color: Colors.black),
                        //   left: BorderSide(color: Colors.black),
                        //   verticalInside:
                        //       BorderSide(color: Colors.black),
                        // ),
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,

                        columnWidths: const {
                          1: FixedColumnWidth(30),
                          2: FixedColumnWidth(50),
                          3: FixedColumnWidth(50),
                          4: FixedColumnWidth(50),
                        },
                        children: [
                          TableRow(children: [
                            Text(
                              'medicine'.tr,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                      color: ColorManager.kPrimaryColor,
                                      fontSize: 11),
                            ),
                            Text(
                              'freq'.tr,
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                      color: ColorManager.kPrimaryColor,
                                      fontSize: 11),
                            ),
                            Text(
                              'dos'.tr,
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                      color: ColorManager.kPrimaryColor,
                                      fontSize: 11),
                            ),
                            Text(
                              'duration'.tr,
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                      color: ColorManager.kPrimaryColor,
                                      fontSize: 11),
                            ),
                          ]),
                        ],
                      ),
                      SizedBox(
                        height: Get.height * 0.01,
                      ),
                      const MySeparator(),
                      SizedBox(
                        height: Get.height * 0.01,
                      ),
                      widget.dp!.medicines!.isNotEmpty
                          ? ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: widget.dp?.medicines?.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                var medicine = widget.dp?.medicines?[index];
                                return Table(
                                  // border: const TableBorder(
                                  //   top: BorderSide(color: Colors.black),
                                  //   right: BorderSide(color: Colors.black),
                                  //   left: BorderSide(color: Colors.black),
                                  //   verticalInside:
                                  //       BorderSide(color: Colors.black),
                                  // ),
                                  defaultVerticalAlignment:
                                      TableCellVerticalAlignment.middle,

                                  columnWidths: const {
                                    1: FixedColumnWidth(29),
                                    2: FixedColumnWidth(50),
                                    3: FixedColumnWidth(50),
                                    4: FixedColumnWidth(50),
                                  },
                                  children: [
                                    TableRow(children: [
                                      Text(
                                        medicine?.name ?? '',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(
                                                color:
                                                    ColorManager.kPrimaryColor,
                                                fontSize: 11),
                                      ),
                                      Text(
                                        '${medicine?.frequencyNumeric ?? 0.0}',
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(
                                                color:
                                                    ColorManager.kPrimaryColor,
                                                fontSize: 11),
                                      ),
                                      Text(
                                        medicine?.dOS ?? '',
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(
                                                color:
                                                    ColorManager.kPrimaryColor,
                                                fontSize: 11),
                                      ),
                                      Text(
                                        '${medicine?.dayDate}',
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(
                                                color:
                                                    ColorManager.kPrimaryColor,
                                                fontSize: 11),
                                      ),
                                    ]),
                                  ],
                                );
                              })
                          : Center(
                              child: Text(
                                'doctorDidNotPrescribe'.tr,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(fontSize: 11),
                              ),
                            ),
                      SizedBox(
                        height: Get.height * 0.01,
                      ),
                      const Divider(
                        color: ColorManager.kblackColor,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'labInvestions'.tr,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(color: ColorManager.kPrimaryColor),
                          ),
                          InkWell(
                            onTap: () {
                              if (Reportcontroller.j.labTests.isNotEmpty) {
                                Get.to(() => LabInvestigations(
                                      title: 'labInvestigationBooking'.tr,
                                      imagePath: Images.microscope,
                                      isHereFromReports: true,
                                    ));
                              } else {
                                ToastManager.showToast('notestsselected'.tr);
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.all(15)
                                  .copyWith(top: 5, bottom: 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: ColorManager.kPrimaryColor),
                              child: Text(
                                'getTested'.tr,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(color: ColorManager.kWhiteColor),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: Get.height * 0.01,
                      ),
                      const MySeparator(),
                      SizedBox(
                        height: Get.height * 0.01,
                      ),
                      widget.dp!.labInvestigation!.isNotEmpty
                          ? ListView.builder(
                              itemCount: widget.dp?.labInvestigation?.length,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                var lb = widget.dp?.labInvestigation?[index];
                                return CheckboxListTile(
                                    side: const BorderSide(
                                        color: ColorManager.kPrimaryColor,
                                        width: 2),
                                    contentPadding: EdgeInsets.zero,
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                    visualDensity: const VisualDensity(
                                        vertical: -4, horizontal: -4),
                                    checkColor: ColorManager.kWhiteColor,
                                    value: fixedLengthList[index],
                                    title: Text(
                                      '${lb?.labTestName}',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                              color:
                                                  ColorManager.kPrimaryColor),
                                    ),
                                    onChanged: (value) {
                                      setState(() {
                                        fixedLengthList[index] = value!;
                                      });
                                      Reportcontroller.j.addLabTest(
                                          value!, lb!, widget.index!);
                                    });
                              })
                          : Center(
                              child: Text(
                              'noLabInvestigationsFound'.tr,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                      color: ColorManager.kblackColor,
                                      fontSize: 11),
                            )),
                      SizedBox(
                        height: Get.height * 0.01,
                      ),
                      const Divider(
                        color: ColorManager.kblackColor,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'diagnostics'.tr,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(color: ColorManager.kPrimaryColor),
                          ),
                          InkWell(
                            onTap: () {
                              if (Reportcontroller
                                  .j.labDiagnostics.isNotEmpty) {
                                Get.to(() => ImagingBooking(
                                      isHereFromReports: true,
                                      title: 'Imaging Booking'.tr,
                                      imagePath: Images.microscope,
                                    ));
                              } else {
                                ToastManager.showToast(
                                    'noDiagnosticsSelected'.tr);
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.all(15)
                                  .copyWith(top: 5, bottom: 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: ColorManager.kPrimaryColor),
                              child: Text(
                                'getTested'.tr,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(color: ColorManager.kWhiteColor),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: Get.height * 0.01,
                      ),
                      const MySeparator(),
                      widget.dp!.diagnostics!.isNotEmpty
                          ? ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: widget.dp?.diagnostics?.length,
                              itemBuilder: (context, index) {
                                var dg = widget.dp?.diagnostics?[index];
                                return CheckboxListTile(
                                    side: const BorderSide(
                                        color: ColorManager.kPrimaryColor,
                                        width: 2),
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                    contentPadding: EdgeInsets.zero,
                                    title: Text(
                                      '${dg?.diagnosticName}',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                              color:
                                                  ColorManager.kPrimaryColor),
                                    ),
                                    visualDensity: const VisualDensity(
                                        vertical: -4, horizontal: -4),
                                    checkColor: ColorManager.kWhiteColor,
                                    value: diagnostics[index],
                                    onChanged: (value) {
                                      setState(() {
                                        diagnostics[index] = value!;
                                      });
                                      Reportcontroller.j.addDiagnostics(
                                          value!, dg!, widget.index!);
                                    });
                              })
                          : Center(
                              child: Text(
                              'noDiagnostics'.tr,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                      color: ColorManager.kblackColor,
                                      fontSize: 11),
                            )),
                      const Divider(
                        color: ColorManager.kblackColor,
                      ),
                      SizedBox(
                        height: Get.height * 0.01,
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Text(
                      //       'echo'.tr,
                      //       style: Theme.of(context)
                      //           .textTheme
                      //           .bodySmall
                      //           ?.copyWith(color: ColorManager.kPrimaryColor),
                      //     ),
                      //     Container(
                      //       padding: const EdgeInsets.all(15)
                      //           .copyWith(top: 5, bottom: 5),
                      //       decoration: BoxDecoration(
                      //           borderRadius: BorderRadius.circular(10),
                      //           color: ColorManager.kPrimaryColor),
                      //       child: Text(
                      //         'getTested'.tr,
                      //         style: Theme.of(context)
                      //             .textTheme
                      //             .bodySmall
                      //             ?.copyWith(color: ColorManager.kWhiteColor),
                      //       ),
                      //     )
                      //   ],
                      // ),
                      SizedBox(
                        height: Get.height * 0.01,
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Text(
                      //       'ecg'.tr,
                      //       style: Theme.of(context)
                      //           .textTheme
                      //           .bodySmall
                      //           ?.copyWith(color: ColorManager.kPrimaryColor),
                      //     ),
                      //     Container(
                      //       padding: const EdgeInsets.all(15)
                      //           .copyWith(top: 5, bottom: 5),
                      //       decoration: BoxDecoration(
                      //           borderRadius: BorderRadius.circular(10),
                      //           color: ColorManager.kPrimaryColor),
                      //       child: Text(
                      //         'getTested'.tr,
                      //         style: Theme.of(context)
                      //             .textTheme
                      //             .bodySmall
                      //             ?.copyWith(color: ColorManager.kWhiteColor),
                      //       ),
                      //     )
                      //   ],
                      // ),
                    ],
                  )
                : const SizedBox.shrink(),
            InkWell(
              onTap: () {
                setState(() {
                  isShowAllItems = !isShowAllItems;
                  Reportcontroller.j
                      .updateSelectedDigitalPrescription(widget.index!);
                });
              },
              child: Center(
                child: Image.asset(
                  isShowAllItems == true &&
                          Reportcontroller.j.selectedDigitalPrescription ==
                              widget.index
                      ? Images.dropdownIcon
                      : Images.dropdownIconDown,
                  color: ColorManager.kPrimaryColor,
                  height: 15,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class LabTestResultWidget extends StatefulWidget {
  final LabTestResult? labResult;
  const LabTestResultWidget({
    super.key,
    this.labResult,
  });

  @override
  State<LabTestResultWidget> createState() => _LabTestResultWidgetState();
}

class _LabTestResultWidgetState extends State<LabTestResultWidget> {
  bool showAllItems = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          showAllItems = !showAllItems;
        });
      },
      child: Container(
        margin:
            const EdgeInsets.all(AppPadding.p18).copyWith(left: 0, right: 0),
        padding: const EdgeInsets.all(AppPadding.p18),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: ColorManager.kPrimaryLightColor),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'prescribedBy'.tr,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: ColorManager.kPrimaryColor,
                        fontWeight: FontWeightManager.light,
                      ),
                ),
                Text(widget.labResult?.labNo ?? '',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: ColorManager.kblackColor,
                          fontWeight: FontWeightManager.light,
                        ))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: Get.width * 0.25,
                  child: Text(
                    '${widget.labResult?.prescribedBy}',
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: ColorManager.kPrimaryColor,
                          fontWeight: FontWeightManager.bold,
                        ),
                  ),
                ),
                SizedBox(
                  width: Get.width * 0.25,
                  child: Text(
                      '${"Visit Time".tr} | ${widget.labResult?.visitTime}',
                      textAlign: TextAlign.end,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: ColorManager.kblackColor,
                            fontWeight: FontWeightManager.light,
                          )),
                )
              ],
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            const MySeparator(),
            SizedBox(
              height: Get.height * 0.02,
            ),
            ListView.builder(
              itemCount: showAllItems
                  ? widget.labResult!.labTests!.length + 1
                  : (widget.labResult!.labTests!.length > 2 ? 2 + 1 : 3),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                if (index == 2 && !showAllItems) {
                  if (widget.labResult!.labTests!.length > 2) {
                    return Center(
                      child: IconButton(
                        splashRadius: 20,
                        color: ColorManager.kPrimaryDark,
                        onPressed: () {
                          setState(() {
                            showAllItems = !showAllItems;
                          });
                        },
                        icon: Image.asset(
                          showAllItems == false
                              ? Images.dropdownIcon
                              : Images.dropdownIconDown,
                          color: ColorManager.kPrimaryColor,
                          height: 12,
                        ),
                      ),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                } else if (index < widget.labResult!.labTests!.length) {
                  var result = widget.labResult?.labTests?[index];

                  return Table(
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    columnWidths: const {
                      1: FixedColumnWidth(70),
                      2: FixedColumnWidth(108),
                      3: FixedColumnWidth(70),
                    },
                    children: [
                      TableRow(
                        children: [
                          Text(
                            '${result?.testName}',
                            textAlign: TextAlign.start,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color: ColorManager.kPrimaryColor,
                                  fontSize: 12,
                                  fontWeight: FontWeightManager.bold,
                                ),
                          ),
                          Align(
                            alignment: Alignment.topCenter,
                            child: Text(
                              'report'.tr,
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color: ColorManager.kPrimaryColor,
                                    fontSize: 12,
                                  ),
                            ),
                          ),
                          result?.patientLabStatus == 'Ready for Print'
                              ? InkWell(
                                  onTap: () {
                                    Get.to(() => PdfViewerPage(
                                          url: result?.uRL,
                                          testName: result?.testName,
                                        ));
                                  },
                                  child: Image.asset(
                                    Images.docImages,
                                    height: 20,
                                  ))
                              : Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        result?.patientLabStatus ?? '',
                                        maxLines: 2,
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(
                                              color: ColorManager.kPrimaryColor,
                                              fontSize: 12,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                        ],
                      )
                    ],
                  );
                } else if (widget.labResult!.labTests!.length > 2) {
                  return Center(
                    child: IconButton(
                      splashRadius: 20,
                      color: ColorManager.kPrimaryColor,
                      onPressed: () {
                        setState(() {
                          showAllItems = !showAllItems;
                        });
                      },
                      icon: Image.asset(
                        showAllItems == false
                            ? Images.dropdownIcon
                            : Images.dropdownIconDown,
                        color: ColorManager.kPrimaryColor,
                        height: 12,
                      ),
                    ),
                  );
                }
                return null;
              },
            )
          ],
        ),
      ),
    );
  }
}
