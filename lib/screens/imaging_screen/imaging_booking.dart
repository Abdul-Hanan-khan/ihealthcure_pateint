// ignore_for_file: use_build_context_synchronously, unrelated_type_equality_checks, unnecessary_null_comparison, non_constant_identifier_names, unused_local_variable, must_be_immutable

import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tabib_al_bait/components/custom_textfields.dart';
import 'package:tabib_al_bait/components/dropdown_data_widget.dart';
import 'package:tabib_al_bait/components/image_container.dart';
import 'package:tabib_al_bait/components/images.dart';
import 'package:tabib_al_bait/components/primary_button.dart';
import 'package:tabib_al_bait/components/radio_button_imaging.dart';
import 'package:tabib_al_bait/components/searchable_dropdown.dart';
import 'package:tabib_al_bait/data/controller/auth_controller.dart';
import 'package:tabib_al_bait/data/controller/google_maps_controller.dart';
import 'package:tabib_al_bait/data/controller/lab_investigations_controller.dart';
import 'package:tabib_al_bait/data/controller/packages_controller.dart';
import 'package:tabib_al_bait/data/controller/reportcontroller.dart';
import 'package:tabib_al_bait/data/localDB/local_db.dart';
import 'package:tabib_al_bait/data/repositories/Packages_repo/Packages_repo.dart';
import 'package:tabib_al_bait/data/repositories/lab_investigation_repo/lab_investigation_repo.dart';
import 'package:tabib_al_bait/data/repositories/schedule_repo/schedule_repo.dart';
import 'package:tabib_al_bait/data/repositories/upload_file_repo/upload_file.dart';
import 'package:tabib_al_bait/helpers/color_manager.dart';
import 'package:tabib_al_bait/helpers/show_toast.dart';
import 'package:tabib_al_bait/helpers/values_manager.dart';
import 'package:tabib_al_bait/models/UpComingLabInvestigation.dart';
import 'package:tabib_al_bait/models/UpcomingDiagnosticAppointment.dart';
import 'package:tabib_al_bait/models/diagnostics/bookdiagnosticbody.dart';
import 'package:tabib_al_bait/models/doctors_data.dart';
import 'package:tabib_al_bait/models/lab_test_model2.dart';
import 'package:tabib_al_bait/models/packages_model.dart';
import 'package:tabib_al_bait/screens/auth_screens/login.dart';
import 'package:tabib_al_bait/screens/family_screens/family_members.dart';
import 'package:tabib_al_bait/utils/constants.dart';
import '../../data/controller/book_appointment_controller.dart';
import '../../models/lab_tests_model.dart';

class ImagingBooking extends StatefulWidget {
  final LabTestHome? diagnostic;
  final bool? isHereFromReports;
  final bool? isimagingBooking;
  final bool? isHereFromInvestigatiosAndServices;
  final String? imagePath;
  final UpComingLabIvestigationDataList? list;
  final DateTime? date;
  final TimeOfDay? timeOfDay;
  final LabTests? labTest;
  final bool? isReschedule;
  final bool? isHomeSamle;
  final String? title;
  final DiagnositicAppointmentListData? listData;
  final bool? isHereFromLogin;
  const ImagingBooking(
      {super.key,
      this.listData,
      this.title,
      this.isHomeSamle,
      this.isReschedule = false,
      this.labTest,
      this.date,
      this.timeOfDay,
      this.list,
      this.imagePath,
      this.isHereFromInvestigatiosAndServices = false,
      this.isimagingBooking = false,
      this.isHereFromReports = false,
      this.diagnostic,
      this.isHereFromLogin = false});

  @override
  State<ImagingBooking> createState() => _ImagingBookingState();
}

class _ImagingBookingState extends State<ImagingBooking> {
  TextEditingController discreb = TextEditingController();
  var cont = AddressController.i;
  @override
  void initState() {
    if (widget.isHereFromReports == true) {
      addDiagnosticsFromReports();
    }
    LabInvestigationController.i.selecteddate =
        DateTime.now().toString().split(' ')[0];

    // LabInvestigationController.i.selectedLabtest =
    //     LabInvestigationController.i.labtests?[0];
    LabInvestigationController.i.getDiagnostics();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      LabInvestigationController.i.updateSelecteddoctor(0);
      BookAppointmentController.i.getPaymentMethods();
      LabInvestigationController.i.selectedDoctor =
          LabInvestigationController.i.doctors[0];
      callback();
      LabInvestigationController.selectedTime = TimeOfDay.now();
      LabInvestigationController.i.initTime(Get.context!);
    });
    log(LabInvestigationController.i.diagnosticscenter.toString());
    LabInvestigationController.i.diagnosticscenter = [];

    super.initState();
  }

  addDiagnosticsFromReports() async {
    for (int i = 0; i < Reportcontroller.j.labDiagnostics.length; i++) {
      var report = Reportcontroller.j.labDiagnostics[i];
      var labController = LabInvestigationController.i;
      labController.selectedLabtest = LabInvestigationController.i.diagnostics!
          .firstWhereOrNull((element) => element.id == report.labtestId);
      labController.addLabTest();
    }
  }

  callback() async {
    Packages lt = await PackagesRepo().getsearchpackages();
    PackagesController.i.updatepackage(lt.data!);
  }

  @override
  void dispose() {
    LabInvestigationController.i.selectedLabTests = [];
    LabInvestigationController.i.prescribedBy = null;
    LabInvestigationController.i.totalSum = 0.0;
    LabInvestigationController.i.selectedLabtest = null;
    LabInvestigationController.i.selectedDate = DateTime.now();
    PackagesController.i.selectedLabPackages = [];
    PackagesController.i.selectedLabPackage!.total;
    LabInvestigationController.i.diagnosticscenter = [];

    LabInvestigationController.i.diagnosticscenter.clear();

    // LabInvestigationController.i.update();
    LabInvestigationController.i.clearData();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var cont =
        Get.put<LabInvestigationController>(LabInvestigationController());
    var controller = Get.put<PackagesController>(PackagesController());
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: CustomAppBar(
            isScheduleScreen: widget.isHereFromInvestigatiosAndServices,
            title: '${widget.title}',
          )),
      body: GetBuilder<LabInvestigationController>(builder: (cont) {
        return cont.isLoading == false
            ? Padding(
                padding: const EdgeInsets.all(AppPadding.p20),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        widget.isReschedule ?? true
                            ? const SizedBox.shrink()
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ImageContainer(
                                    height: Get.height * 0.072,
                                    width: Get.width * 0.15,
                                    isSvg: false,
                                    imagePath: Images.imageicon,
                                    // color: ColorManager.kWhiteColor,
                                    backgroundColor: ColorManager.kPrimaryColor,
                                  ),

                                  InkWell(
                                    onTap: () async {
                                      // cont.selectedLabtest = null;
                                      LabTestHome generic =
                                          await searchabledropdown(
                                              context, cont.diagnostics ?? []);
                                      LabInvestigationController.i.update();
                                      cont.selectedLabtest = null;
                                      cont.updateLabTest(generic);

                                      if (generic != null && generic != '') {
                                        // PackagesController.i.selectedLabPackages
                                        //     ?.clear();

                                        cont.selectedLabtest = generic;
                                        cont.selectedLabtest = (generic == '')
                                            ? null
                                            : cont.selectedLabtest;
                                      }
                                      setState(() {});
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color:
                                              ColorManager.kPrimaryLightColor,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        color: ColorManager.kPrimaryLightColor,
                                      ),
                                      width: Get.width * 0.55,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.07,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "${(cont.selectedLabtest != null && cont.selectedLabtest?.name != null) ? (cont.selectedLabtest!.name!.length > 20 ? ('${cont.selectedLabtest?.name!.substring(0, 20)}...') : cont.selectedLabtest?.name) : "Select Diagnostic".tr}",
                                            semanticsLabel:
                                                "${(cont.selectedLabtest != null) ? (cont.selectedLabtest!.name!.length > 20 ? ('${cont.selectedLabtest?.name!.substring(0, 10)}...') : cont.selectedLabtest) : "Select Diagnostic".tr}",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: cont.selectedLabtest
                                                            ?.name !=
                                                        null
                                                    ? ColorManager.kPrimaryColor
                                                    : ColorManager
                                                        .kPrimaryColor,
                                                fontWeight: FontWeight.w900),
                                          ),
                                          Icon(
                                            Icons.arrow_drop_down,
                                            size: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.06,
                                            color: cont.selectedLabtest != null
                                                ? Colors.black
                                                : Colors.grey[700],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),

                                  // GetBuilder<PackagesController>(
                                  //     builder: (cont) {
                                  //   return Flexible(
                                  //     child: DropdownDataWidget<LabPackages>(
                                  //         hint: 'Lab Packages',
                                  //         items: cont.packages,
                                  //         selectedValue: cont.selectedLabPackage,
                                  //         onChanged: (value) {
                                  //           // cont.updateLabTest(value!);
                                  //           // cont.totalLabPackagesPrice(false);
                                  //           log(cont.selectedLabPackage!
                                  //               .toJson()
                                  //               .toString());
                                  //         },
                                  //         itemTextExtractor: (value) => value.packageGroupName!),
                                  //   );
                                  // }),

                                  ImageContainer(
                                    height: Get.height * 0.072,
                                    width: Get.width * 0.15,
                                    onpressed: () {
                                      if (LabInvestigationController
                                              .i.selectedLabtest !=
                                          null) {
                                        LabInvestigationController
                                            .i.selectedLabTests
                                            .clear();
                                        LabInvestigationController.i
                                            .addLabTest();
                                        LabInvestigationController.i
                                            .updatefinalsubtotal(
                                                LabInvestigationController
                                                    .i.selectedLabtest!.price!);
                                        LabInvestigationController.i
                                            .getdiagnosticcenter(
                                                LabInvestigationController.i
                                                        .selectedLabtest?.id ??
                                                    "");
                                      }
                                    },
                                    imagePath: Images.add,
                                    isSvg: false,
                                    color: ColorManager.kWhiteColor,
                                    backgroundColor: ColorManager.kPrimaryColor,
                                  )
                                ],
                              ),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        widget.isReschedule ?? true
                            ? const SizedBox.shrink()
                            : LabInvestigationController
                                    .i.diagnosticscenter.isNotEmpty
                                ? ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: LabInvestigationController
                                        .i.diagnosticscenter.length,
                                    itemBuilder: (itemBuilder, index) {
                                      var center = LabInvestigationController
                                          .i.diagnosticscenter[index];
                                      return Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CachedNetworkImage(
                                            imageUrl:
                                                baseURL! + center.imagePath,
                                            errorWidget: (context, url, error) {
                                              return Image.asset(
                                                Images.hospital,
                                                height: Get.height * 0.09,
                                              );
                                            },
                                          ),
                                          SizedBox(
                                            width: Get.width * 0.02,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                center.name,
                                                style: GoogleFonts.poppins(
                                                    fontSize: 10),
                                              ),
                                              Text(
                                                center.address,
                                                style: GoogleFonts.poppins(
                                                    fontSize: 10),
                                              ),
                                              Text(
                                                center.diagnosticName,
                                                style: GoogleFonts.poppins(
                                                    fontSize: 10),
                                              ),
                                            ],
                                          ),
                                          const Spacer(),
                                          SizedBox(
                                            height: Get.height * 0.09,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                const Spacer(),
                                                Text(
                                                  center.price.toString(),
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 10),
                                                ),
                                              ],
                                            ),
                                          ),
                                          // const Spacer(),
                                          // Row(
                                          //   // mainAxisAlignment:
                                          //   //     MainAxisAlignment.end,
                                          //   crossAxisAlignment:
                                          //       CrossAxisAlignment.end,
                                          //   children: [

                                          //   ],
                                          // )
                                        ],
                                      );
                                    },
                                  )
                                : const SizedBox.shrink(),

                        widget.isReschedule ?? true
                            ? const SizedBox.shrink()
                            : Text(
                                '${'test'.tr} ${PackagesController.i.selectedLabPackages!.isNotEmpty ? ('(Packages)') : ''}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                        fontWeight: FontWeight.w900,
                                        color: ColorManager.kPrimaryColor),
                              ),

                        widget.isReschedule ?? true
                            ? const SizedBox.shrink()
                            : SizedBox(
                                height: Get.height * 0.01,
                              ),
                        widget.isReschedule ?? true
                            ? const SizedBox.shrink()
                            : Container(
                                padding: const EdgeInsets.all(AppPadding.p10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: ColorManager.kGreyColor)),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'test'.tr,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall
                                              ?.copyWith(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 12),
                                        ),
                                        Text(
                                          'price'.tr,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall
                                              ?.copyWith(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 12),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: Get.height * 0.02,
                                    ),
                                    GetBuilder<LabInvestigationController>(
                                        builder: (cont) {
                                      return ListView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount:
                                              cont.selectedLabTests.isNotEmpty
                                                  ? 1
                                                  : 0,
                                          itemBuilder: (context, index) {
                                            final test =
                                                cont.selectedLabTests[index];
                                            return Row(
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    cont.removeLabTest(index);
                                                  },
                                                  child: const Icon(
                                                    Icons.cancel,
                                                    color:
                                                        ColorManager.kRedColor,
                                                    size: 15,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                SizedBox(
                                                  width: Get.width * 0.5,
                                                  child: Text(
                                                    '${test.name}',
                                                    textAlign: TextAlign.start,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium!
                                                        .copyWith(fontSize: 12),
                                                  ),
                                                ),
                                                const Spacer(),
                                                Text(
                                                  test.actualPrice
                                                      .toString()
                                                      .replaceAllMapped(
                                                          RegExp(
                                                              r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                                          (Match m) =>
                                                              '${m[1]},'),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .copyWith(fontSize: 14),
                                                ),
                                              ],
                                            );
                                          });
                                    }),
                                    const Divider(
                                      color: ColorManager.kblackColor,
                                    ),
                                    FutureBuilder<String>(
                                        future:
                                            cont.returnPriceLabsAndPackages(),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            if (snapshot.data == '0.0') {
                                              return const SizedBox.shrink();
                                            } else {
                                              return Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Text(
                                                  '${'subTotal'.tr} : ${cont.selectedLabTests.last.actualPrice}',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium
                                                      ?.copyWith(
                                                        fontSize: 12,
                                                      ),
                                                ),
                                              );
                                            }
                                          } else {
                                            return const Text('0.0');
                                          }
                                        }),
                                    FutureBuilder<String>(
                                        future: cont.returnDiscountOfPackages(),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            if (snapshot.data == '') {
                                              return const SizedBox.shrink();
                                            } else {
                                              return Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Text(
                                                  '${'Discount'.tr} : ${0.0}',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium
                                                      ?.copyWith(
                                                        fontSize: 12,
                                                      ),
                                                ),
                                              );
                                            }
                                          } else if (!snapshot.hasData) {
                                            return const SizedBox.shrink();
                                          } else {
                                            return const SizedBox.shrink();
                                          }
                                        }),
                                    FutureBuilder<double>(
                                        future: PackagesController.i
                                            .sumUpGrandTotal(),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            if (snapshot.data == 0.0) {
                                              return const SizedBox.shrink();
                                            } else {
                                              return Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Text(
                                                  '${'grandTotal'.tr} : ${cont.selectedLabTests.last.actualPrice} ',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium
                                                      ?.copyWith(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                ),
                                              );
                                            }
                                          } else {
                                            return const Text('0.0');
                                          }
                                        })
                                  ],
                                ),
                              ),
                        widget.isReschedule ?? true
                            ? const SizedBox.shrink()
                            : SizedBox(
                                height: Get.height * 0.01,
                              ),

                        // const SamplesRadioButton(),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        Container(
                          height: Get.height * 0.13,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: ColorManager.kPrimaryLightColor),
                          child: DatePicker(
                            DateTime.now(),
                            dateTextStyle: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    color: ColorManager.kPrimaryColor,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 12),
                            dayTextStyle: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    color: ColorManager.kPrimaryColor,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 12),
                            monthTextStyle: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    color: ColorManager.kPrimaryColor,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 12),
                            deactivatedColor: ColorManager.kPrimaryLightColor,
                            // height: Get.height * 0.14,
                            initialSelectedDate: DateTime.now(),
                            selectionColor: ColorManager.kPrimaryColor,
                            selectedTextColor: Colors.white,
                            onDateChange: cont.selectedLabtest?.id == null
                                ? (dt) {}
                                : (date) {
                                    if (cont.selectedLabtest?.id != null &&
                                        widget.isReschedule == false) {
                                      if (cont.diagnosticscenter.isNotEmpty) {
                                        cont.updateselecteddate(
                                            date.toString().split(' ')[0]);
                                        LabInvestigationRepo.getDiagnosticSlots(
                                          cont.selectedLabtest?.id ?? "",
                                          cont.diagnosticscenter.first.id,
                                          date.toString(),
                                        );
                                      } else if (widget.isReschedule == true) {
                                        cont.updateselecteddate(
                                            date.toString().split(' ')[0]);
                                        LabInvestigationRepo.getDiagnosticSlots(
                                          widget.listData?.DiagnosticId ?? "",
                                          widget.listData?.DiagnosticCenterId ??
                                              "",
                                          date.toString(),
                                        );
                                      } else {
                                        ToastManager.showToast(
                                            "No Diagnostic center Avaible");
                                      }
                                    } else if (widget.isReschedule != null
                                        ? true
                                        : false) {
                                      cont.updateselecteddate(
                                          date.toString().split(' ')[0]);
                                      LabInvestigationRepo.getDiagnosticSlots(
                                        // cont.selectedLabtest?.id ?? "",
                                        // cont.diagnosticscenter.first.id,
                                        widget.listData!.DiagnosticId!,
                                        widget.listData!.DiagnosticCenterId!,
                                        date.toString(),
                                      );
                                    } else {
                                      ToastManager.showToast(
                                          "Add Diagnostic First");
                                    }

                                    cont.updateSelectedDatae(date);
                                    log('${cont.selectedDate}');
                                  },
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        cont.dianosticsslot.isNotEmpty
                            ? GetBuilder<LabInvestigationController>(
                                builder: (cnt) {
                                return GridView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: cnt.dianosticsslot.length,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      mainAxisExtent: 25,
                                      crossAxisCount: 4,
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 10,
                                      childAspectRatio: 1.1,
                                    ),
                                    itemBuilder: ((context, index) {
                                      final slots = cnt.dianosticsslot[index];
                                      return InkWell(
                                        onTap: () {
                                          if (slots.isBooked == false) {
                                            cnt.updateselectedslot(
                                                cnt.dianosticsslot[index]);
                                          }
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: slots.isBooked == true
                                                  ? ColorManager.kGreyColor
                                                  : cnt.selectedslot ==
                                                          cnt.dianosticsslot[
                                                              index]
                                                      ? ColorManager
                                                          .kPrimaryColor
                                                      : ColorManager
                                                          .kPrimaryLightColor,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Center(
                                              child: Text(
                                            '${'(${index + 1}) '}${"${cnt.dianosticsslot[index].slotTime.toString().split(':')[0]}:${cnt.dianosticsslot[index].slotTime.toString().split(':')[1]}"}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium
                                                ?.copyWith(
                                                  color: slots.isBooked == true
                                                      ? ColorManager
                                                          .kPrimaryLightColor
                                                      : cont.selectedslot ==
                                                              cont.dianosticsslot[
                                                                  index]
                                                          ? ColorManager
                                                              .kWhiteColor
                                                          : ColorManager
                                                              .kPrimaryColor,
                                                  fontWeight: FontWeight.w900,
                                                  fontSize: 12,
                                                ),
                                          )),
                                        ),
                                      );
                                    }));
                              })
                            : cont.selecteddate != null
                                ? SizedBox(
                                    child: Center(child: Text('noSessions'.tr)),
                                  )
                                : const SizedBox.shrink(),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),

                        widget.isReschedule ?? true
                            ? const SizedBox.shrink()
                            : Text(
                                'prescribedBy'.tr,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                        color: ColorManager.kPrimaryColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                              ),
                        widget.isReschedule ?? true
                            ? const SizedBox.shrink()
                            : SizedBox(
                                height: Get.height * 0.02,
                              ),
                        widget.isReschedule ?? true
                            ? const SizedBox.shrink()
                            : const ImagingRadioButton(),
                        widget.isReschedule ?? true
                            ? const SizedBox.shrink()
                            : SizedBox(
                                height: Get.height * 0.02,
                              ),

                        widget.isReschedule ?? true
                            ? const SizedBox.shrink()
                            : Visibility(
                                visible: cont.selectedalue == 1,
                                child: DropdownDataWidget<Doctors>(
                                    hint: 'select Doctor'.tr,
                                    items: cont.doctors,
                                    selectedValue: cont.selectedDoctor,
                                    onChanged: (value) {
                                      cont.updateDoctor(value!);
                                      // cont.addLabTest();
                                      // cont.totalLabPackagesPrice(false);
                                    },
                                    itemTextExtractor: (value) => value.name!),
                              ),
                        widget.isReschedule ?? true
                            ? const SizedBox.shrink()
                            : Visibility(
                                visible: cont.selectedalue == 2,
                                child: Column(
                                  children: [
                                    cont.selectedalue == 1
                                        ? SizedBox(
                                            height: Get.height * 0.02,
                                          )
                                        : const SizedBox.shrink(),
                                    CustomTextField(
                                      controller: cont.doctorname,
                                      hintText: 'doctorName'.tr,
                                    ),
                                    cont.selectedalue == 1
                                        ? SizedBox(
                                            height: Get.height * 0.02,
                                          )
                                        : const SizedBox.shrink(),
                                    PrimaryButton(
                                        title: 'attachPrescription'.tr,
                                        onPressed: () async {
                                          cont.prescriptionreport =
                                              await AuthController.i
                                                  .pickImage();
                                        },
                                        fontSize: 14,
                                        color: ColorManager.kPrimaryColor,
                                        textcolor: ColorManager.kWhiteColor),
                                    cont.selectedalue == 1
                                        ? SizedBox(
                                            height: Get.height * 0.02,
                                          )
                                        : const SizedBox.shrink(),
                                  ],
                                ),
                              ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),

                        widget.isReschedule ?? true
                            ? const SizedBox.shrink()
                            : InkWell(
                                onTap: () {
                                  paymentMethodDialogue(context);
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                          vertical: 12, horizontal: 10)
                                      .copyWith(right: 15),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: ColorManager.kPrimaryLightColor),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.payment,
                                        color: ColorManager.kPrimaryColor,
                                      ),
                                      SizedBox(
                                        width: Get.width * 0.035,
                                      ),
                                      Text(
                                          cont.selectedPaymentMethod != null
                                              ? '${cont.selectedPaymentMethod!.name}'
                                              : 'paymentMethod'.tr,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                                  color: ColorManager
                                                      .kPrimaryColor,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w900)),
                                      const Spacer(),
                                      Image.asset(Images.masterCard)
                                    ],
                                  ),
                                ),
                              ),
                        widget.isReschedule ?? true
                            ? const SizedBox.shrink()
                            : SizedBox(
                                height: Get.height * 0.02,
                              ),

                        widget.isReschedule ?? true
                            ? const SizedBox.shrink()
                            : Text(
                                'summary'.tr,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                        color: ColorManager.kPrimaryColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                              ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        widget.isReschedule ?? true
                            ? const SizedBox.shrink()
                            : SummaryWidget(
                                title: widget.title,
                              ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        PrimaryButton(
                            title: widget.isReschedule == false
                                ? 'appointmentConfirm'.tr
                                : "rescheduleAppointment".tr,
                            fontSize: 14,
                            onPressed: () async {
                              String? url;
                              if (widget.isReschedule == false) {
                                if (cont.selecteddate != null) {
                                  if (cont.selectedslot != null) {
                                    if (cont.selectedLabtest != null) {
                                      if (cont.diagnosticscenter.isNotEmpty) {
                                        if (cont.selectedDoctor != null ||
                                            (cont.doctorname != null &&
                                                cont.prescriptionreport !=
                                                    null)) {
                                          if (cont.prescriptionreport != null) {
                                            url = await UploadFileRepo()
                                                .updatePicture(
                                                    cont.prescriptionreport!);
                                          }
                                          String patientid =
                                              await LocalDb().getPatientId() ??
                                                  "";
                                          String token =
                                              await LocalDb().getToken() ?? "";
                                          var loggedIn =
                                              await LocalDb().getLoginStatus();
                                          if (loggedIn == true) {
                                            LabInvestigationRepo.bookimageboking(
                                                Bookdiagnosticbody(
                                                    fileAttachment: url ?? "",
                                                    bookingDate: cont
                                                        .selecteddate,
                                                    bookingTime: cont
                                                        .selectedslot?.slotTime,
                                                    clinicalHistory: "",
                                                    diagnosticCenterId: cont
                                                        .diagnosticscenter
                                                        .first
                                                        .id,
                                                    diagnosticId: cont
                                                        .selectedLabtest?.id,
                                                    discountStatus: "",
                                                    isReserve: "0",
                                                    patientId: patientid,
                                                    prescribedByDoctorId:
                                                        cont.selectedDoctor !=
                                                                null
                                                            ? cont
                                                                .selectedDoctor
                                                                ?.id
                                                            : cont
                                                                    .doctorname
                                                                    .text
                                                                    .isNotEmpty
                                                                ? cont
                                                                    .doctorname
                                                                    .text
                                                                    .toString()
                                                                : "",
                                                    sessionId: cont.selectedslot
                                                        ?.sessionId,
                                                    token: token,
                                                    workLocationId: ""));
                                          } else {
                                            await Get.to(() =>
                                                const LoginScreen(
                                                    isimagingbookingScreen:
                                                        true));
                                            LabInvestigationRepo.bookimageboking(
                                                Bookdiagnosticbody(
                                                    fileAttachment: url ?? "",
                                                    bookingDate: cont
                                                        .selecteddate,
                                                    bookingTime: cont
                                                        .selectedslot?.slotTime,
                                                    clinicalHistory: "",
                                                    diagnosticCenterId: cont
                                                        .diagnosticscenter
                                                        .first
                                                        .id,
                                                    diagnosticId: cont
                                                        .selectedLabtest?.id,
                                                    discountStatus: "",
                                                    isReserve: "0",
                                                    patientId: patientid,
                                                    prescribedByDoctorId:
                                                        cont.selectedDoctor !=
                                                                null
                                                            ? cont
                                                                .selectedDoctor
                                                                ?.id
                                                            : cont
                                                                    .doctorname
                                                                    .text
                                                                    .isNotEmpty
                                                                ? cont
                                                                    .doctorname
                                                                    .text
                                                                    .toString()
                                                                : "",
                                                    sessionId: cont.selectedslot
                                                        ?.sessionId,
                                                    token: token,
                                                    workLocationId: ""));
                                          }
                                        } else {
                                          ToastManager.showToast(
                                              "Select Doctor or enter Doctor name with precription");
                                        }
                                      } else {
                                        ToastManager.showToast(
                                            "No Clinic found against selected Diagnostic");
                                      }
                                    } else {
                                      ToastManager.showToast(
                                          "Select Booking Time");
                                    }
                                  } else {
                                    ToastManager.showToast(
                                        "Select Booking Date");
                                  }
                                }
                              } else {
                                ScheduleRepo.rescheduleDiagnosticAppointment(
                                    bookingDate: cont.selecteddate ??
                                        widget.listData?.AppointmentDate,
                                    bookingTime: cont.selectedslot?.slotTime ??
                                        widget.listData?.BookingTime,
                                    diagnosticAppointmentId:
                                        widget.listData?.Id,
                                    diagnosticCenterId:
                                        widget.listData?.DiagnosticCenterId,
                                    diagnosticId: widget.listData?.DiagnosticId,
                                    patientDiagnosticAppointmentId: widget
                                        .listData
                                        ?.PatientDiagnosticAppointmentId,
                                    prescribedByDoctorId:
                                        widget.listData?.PrescribedByDoctor,
                                    sessionID: cont.selectedslot?.sessionId ??
                                        widget.listData?.SessionId,
                                    workLocationId: "");
                                log('over here');
                              }
                            },
                            color: ColorManager.kPrimaryColor,
                            textcolor: ColorManager.kWhiteColor)
                      ],
                    ),
                  ),
                ))
            : const Center(
                child: CircularProgressIndicator(),
              );
      }),
    );
  }

  paymentMethodDialogue(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return FractionallySizedBox(
            child: Material(
                type: MaterialType.transparency,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                color: ColorManager.kWhiteColor,
                child: AlertDialog(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Center(
                        child: Text(
                          'paymentMethod'.tr,
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: ColorManager.kPrimaryColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w900,
                                  ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Image.asset(Images.crossicon),
                        ),
                      ),
                    ],
                  ),
                  content: SingleChildScrollView(
                      child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // SizedBox(
                      //   height: Get.height * 0.09,
                      // ),
                      SizedBox(
                        width: 300,
                        child: ListView.builder(
                          itemCount:
                              BookAppointmentController.i.paymentMethods.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final payment = BookAppointmentController
                                .i.paymentMethods[index];

                            return buildStyledContainer(
                                '${payment.name}',
                                context,
                                index,
                                payment.imagePath ?? '',
                                true, () {
                              BookAppointmentController.i
                                  .updateSelectedIndex(index);
                              LabInvestigationController.i
                                  .updatePaymentMethod(payment);
                              LabInvestigationController.i.updatePayment(false);
                              Get.back();
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        height: Get.height * 0.02,
                      ),
                    ],
                  )),
                )),
          );
        });
  }

  buildStyledContainer(String text, BuildContext context, int index,
      String payment, bool? hasMasterCardImage, Function()? onTap) {
    return GetBuilder<BookAppointmentController>(builder: (cont) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: InkWell(
          onTap: onTap,
          child: Container(
            width: Get.width,
            decoration: BoxDecoration(
              color: cont.selectedIndex == index
                  ? ColorManager.kPrimaryColor
                  : ColorManager.kWhiteColor,
              border: Border.all(color: ColorManager.kPrimaryColor),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(text,
                    style: TextStyle(
                        fontSize: 12,
                        color: cont.selectedIndex == index
                            ? ColorManager.kWhiteColor
                            : ColorManager.kPrimaryColor)),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                // Image.network(payment)
              ],
            ),
          ),
        ),
      );
    });
  }
}

class SummaryWidget extends StatelessWidget {
  final String? title;
  SummaryWidget({
    this.title,
    super.key,
  });

  double discount = 0.0;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppPadding.p10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: ColorManager.kGreyColor,
          )),
      child: GetBuilder<LabInvestigationController>(builder: (cont) {
        if (PackagesController.i.selectedLabPackage != null) {
          // sum = LabInvestigationController.i.totalSum+PackagesController.i.selectedLabPackage!.total!;
          discount = PackagesController
              .i.selectedLabPackage!.packageGroupDiscountRate!;
        }

        return Column(
          children: [
            LabInvestigationController.i.selectedDate != null &&
                    LabInvestigationController.i.formattedSelectedTime != null
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${'date'.tr} & ${'time'.tr}',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(fontSize: 12),
                      ),
                      Text(
                        '${cont.selectedDate.toString().split(' ').first} | ${cont.formattedSelectedTime}',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(fontSize: 12),
                      )
                    ],
                  )
                : const SizedBox.shrink(),

            LabInvestigationController.i.prescribedBy != null
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'prescribedBy'.tr,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(fontSize: 12),
                      ),
                      Text(
                        '${cont.prescribedBy == 'Doctor' ? cont.selectedDoctor?.name : cont.prescribedBy}',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(fontSize: 12),
                      )
                    ],
                  )
                : const SizedBox.shrink(),
            LabInvestigationController.i.selectedPaymentMethod != null
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'paymentMethod'.tr,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(fontSize: 12),
                      ),
                      Text(
                        '${cont.selectedPaymentMethod?.name}',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(fontSize: 12),
                      )
                    ],
                  )
                : const SizedBox.shrink(),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Text(
            //       'test'.tr,
            //       style: Theme.of(context)
            //           .textTheme
            //           .bodyMedium!
            //           .copyWith(fontWeight: FontWeight.w900, fontSize: 12),
            //     ),
            //     Text(
            //       'price'.tr,
            //       style: Theme.of(context)
            //           .textTheme
            //           .bodyMedium!
            //           .copyWith(fontWeight: FontWeight.w900, fontSize: 12),
            //     ),
            //   ],
            // ),
            const Divider(
              color: ColorManager.kblackColor,
            ),
            const Center(
              child: Text(''),
            ),
          ],
        );
      }),
    );
  }
}

class SummaryContainer extends StatelessWidget {
  final String? title;
  final bool? isOnlinePay;
  final List<Widget> summaryWidgets;

  const SummaryContainer({
    Key? key,
    this.isOnlinePay = false,
    this.title,
    required this.summaryWidgets,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$title',
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(fontSize: 14, fontWeight: FontWeight.w900),
        ),
        SizedBox(height: Get.height * 0.02),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            border: Border.all(color: ColorManager.kGreyColor),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: summaryWidgets, // Use the passed list of widgets
          ),
        ),
      ],
    );
  }
}

class DetailsRow extends StatelessWidget {
  final String? title;
  final String? description;
  const DetailsRow({
    super.key,
    this.title,
    this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '$title',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontWeight: FontWeight.w300, fontSize: 12),
            ),
            Text(
              '$description',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontWeight: FontWeight.w900, fontSize: 12),
            )
          ],
        ),
        SizedBox(
          height: Get.height * 0.02,
        )
      ],
    );
  }
}

String parseInvestigationData(String input) {
  List<String> parts = input.split(';');

  if (parts.length == 3) {
    String investigationName = parts[0];
    int value1 = int.tryParse(parts[1]) ?? 0;
    int value2 = int.tryParse(parts[2]) ?? 0;

    return investigationName;
  } else {
    return "Invalid data format";
  }
}

String testName(String input) {
  String? testName = parseInvestigationData(input);
  String? result = testName.split('--').last;
  return result;
}
