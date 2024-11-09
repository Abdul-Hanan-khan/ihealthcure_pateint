// ignore_for_file: unrelated_type_equality_checks, use_build_context_synchronously, unused_local_variable, must_be_immutable

import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tabib_al_bait/components/custom_textfields.dart';
import 'package:tabib_al_bait/components/dropdown_data_widget.dart';
import 'package:tabib_al_bait/components/image_container.dart';
import 'package:tabib_al_bait/components/images.dart';
import 'package:tabib_al_bait/components/primary_button.dart';
import 'package:tabib_al_bait/components/radio_button.dart';
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
import 'package:tabib_al_bait/helpers/color_manager.dart';
import 'package:tabib_al_bait/helpers/show_toast.dart';
import 'package:tabib_al_bait/helpers/values_manager.dart';
import 'package:tabib_al_bait/main.dart';
import 'package:tabib_al_bait/models/UpComingLabInvestigation.dart';
import 'package:tabib_al_bait/models/doctors_data.dart';
import 'package:tabib_al_bait/models/lab_test_model2.dart';
import 'package:tabib_al_bait/models/packages_model.dart';
import 'package:tabib_al_bait/models/payment_response.dart';
import 'package:tabib_al_bait/screens/auth_screens/login.dart';
import 'package:tabib_al_bait/screens/family_screens/family_members.dart';
import 'package:tabib_al_bait/screens/googe_maps/google_maps.dart';
import 'package:tabib_al_bait/screens/lab_screens/packages_list.dart';
import '../../data/controller/book_appointment_controller.dart';
import '../../models/lab_tests_model.dart';

class LabInvestigations extends StatefulWidget {
  final bool? isHereFromReports;
  final bool? isLabInvestigationBooking;
  final bool? isHereFromInvestigatiosAndServices;
  final String? imagePath;
  final UpComingLabIvestigationDataList? list;
  final DateTime? date;
  final TimeOfDay? timeOfDay;
  final LabTests? labTest;
  final bool? isReschedule;
  final bool? isHomeSamle;
  final String? title;
  const LabInvestigations(
      {super.key,
      this.title,
      this.isHomeSamle,
      this.isReschedule = false,
      this.labTest,
      this.date,
      this.timeOfDay,
      this.list,
      this.imagePath,
      this.isHereFromInvestigatiosAndServices = false,
      this.isLabInvestigationBooking = false,
      this.isHereFromReports = false});

  @override
  State<LabInvestigations> createState() => _LabInvestigationsState();
}

class _LabInvestigationsState extends State<LabInvestigations> {
  TextEditingController discreb = TextEditingController();
  var cont = AddressController.i;

  @override
  void initState() {
    BookAppointmentController.i.getPaymentMethods();
    LabInvestigationController.i.getLabTests();
    LabInvestigationController.i.selectedservice = null;

    if (widget.isHereFromReports == true) {
      addLabTestsFromReports();
    }
    // LabInvestigationController.i.selectedLabtest =
    //     LabInvestigationController.i.labtests?[0];

    WidgetsBinding.instance.addPostFrameCallback((_) {
      LabInvestigationController.i.updateSelecteddoctor(0);
      BookAppointmentController.i.getPaymentMethods();
      LabInvestigationController.i.selectedDoctor =
          LabInvestigationController.i.doctors[0];
      callback();

      LabInvestigationController.selectedTime = TimeOfDay.now();
      LabInvestigationController.i.initTime(Get.context!);
    });

    super.initState();
  }

  addLabTestsFromReports() async {
    for (int i = 0; i < Reportcontroller.j.labTests.length; i++) {
      var report = Reportcontroller.j.labTests[i];
      var labController = LabInvestigationController.i;
      labController.selectedLabtest = LabInvestigationController.i.labtests!
          .firstWhereOrNull((element) => element.id == report.labtestId);
      labController.addLabTest();
    }
  }

  callback() async {
    Packages lt = await PackagesRepo().getsearchpackages();
    PackagesController.i.updatepackage(lt.data ?? []);
  }

  @override
  void dispose() {
    LabInvestigationController.i.selectedLabTests = [];
    LabInvestigationController.i.selectedLabtest = null;
    LabInvestigationController.i.prescribedBy = null;
    LabInvestigationController.i.totalSum = 0.0;
    LabInvestigationController.i.selectedDate = DateTime.now();
    PackagesController.i.selectedLabPackages = [];
    PackagesController.i.selectedLabPackage = null;
    PackagesController.i.selectedLabPackage?.total;

    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var cont =
        Get.put<LabInvestigationController>(LabInvestigationController());
    var controller = Get.put<PackagesController>(PackagesController());
    var reports = Get.put<Reportcontroller>(Reportcontroller());
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Center(
                              child: ImageContainer(
                                // height: Get.height * 0.07,
                                // width: Get.width * 0.15,
                                isSvg: false,
                                imagePath: widget.imagePath,
                                // color: ColorManager.kWhiteColor,
                                backgroundColor: ColorManager.kPrimaryColor,
                              ),
                            ),

                            InkWell(
                              onTap: () async {
                                // cont.selectedLabtest = null;
                                LabTestHome generic = await searchabledropdown(
                                    context, cont.labtests ?? []);
                                LabInvestigationController.i.update();
                                cont.selectedLabtest = null;
                                cont.updateLabTest(generic);

                                if (generic != '') {
                                  cont.selectedLabtest = generic;
                                  cont.selectedLabtest = (generic == '')
                                      ? null
                                      : cont.selectedLabtest;
                                }
                                setState(() {});
                              },
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: ColorManager.kPrimaryLightColor,
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: ColorManager.kPrimaryLightColor,
                                ),
                                width: Get.width * 0.55,
                                height:
                                    MediaQuery.of(context).size.height * 0.06,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${(cont.selectedLabtest != null && cont.selectedLabtest?.name != null) ? (cont.selectedLabtest!.name!.length > 20 ? ('${cont.selectedLabtest?.name!.substring(0, 20)}...') : cont.selectedLabtest?.name) : "Select Tests".tr}",
                                      semanticsLabel:
                                          "${(cont.selectedLabtest != null) ? (cont.selectedLabtest!.name!.length > 20 ? ('${cont.selectedLabtest?.name!.substring(0, 10)}...') : cont.selectedLabtest) : "Select Tests".tr}",
                                      style: TextStyle(
                                          fontSize: 12,
                                          color:
                                              cont.selectedLabtest?.name != null
                                                  ? ColorManager.kPrimaryColor
                                                  : ColorManager.kPrimaryColor,
                                          fontWeight: FontWeight.w900),
                                    ),
                                    Icon(
                                      Icons.arrow_drop_down,
                                      size: MediaQuery.of(context).size.width *
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
                            // SizedBox(
                            //   width: Get.width * 0.02,
                            // ),
                            ImageContainer(
                              // height: Get.height * 0.072,
                              // width: Get.width * 0.15,
                              onpressed: () {
                                LabInvestigationController.i
                                    .updatefinalsubtotal(
                                        LabInvestigationController
                                            .i.selectedLabtest!.price!);
                                cont.addLabTest();
                              },
                              imagePath: Images.add,
                              isSvg: false,
                              color: ColorManager.kWhiteColor,
                              backgroundColor: ColorManager.kPrimaryColor,
                            )
                          ],
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),

                        GetBuilder<PackagesController>(builder: (controller) {
                          return Row(
                            children: [
                              InkWell(
                                onTap: () async {
                                  Get.to(() => const PackagesList());
                                  // cont.selectedLabtest = null;
                                  // LabPackages generic = await searchablepackage(
                                  //     context, controller.packages);
                                  // controller.updateselectednewpackage(generic);

                                  // if (generic != '') {
                                  //   controller.selectedLabPackage = generic;
                                  //   controller.selectedLabPackage =
                                  //       (generic == '')
                                  //           ? null
                                  //           : controller.selectedLabPackage;
                                  // }
                                  // setState(() {});
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: ColorManager.kPrimaryLightColor,
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: ColorManager.kPrimaryLightColor,
                                  ),
                                  width: Get.width * 0.72,
                                  height:
                                      MediaQuery.of(context).size.height * 0.06,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "${(controller.selectedLabPackage != null && controller.selectedLabPackage?.packageGroupName != null) ? (controller.selectedLabPackage!.packageGroupName!.length > 20 ? ('${controller.selectedLabPackage?.packageGroupName!.substring(0, 20)}...') : controller.selectedLabPackage?.packageGroupName) : "Select Package".tr}",
                                        semanticsLabel:
                                            "${(controller.selectedLabPackage != null) ? (controller.selectedLabPackage!.packageGroupName!.length > 20 ? ('${controller.selectedLabPackage?.packageGroupName!.substring(0, 10)}...') : controller.selectedLabPackage) : "Select Package".tr}",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: controller.selectedLabPackage
                                                        ?.packageGroupName !=
                                                    null
                                                ? ColorManager.kPrimaryColor
                                                : ColorManager.kPrimaryColor,
                                            fontWeight: FontWeight.w900),
                                      ),
                                      Icon(
                                        Icons.arrow_drop_down,
                                        size:
                                            MediaQuery.of(context).size.width *
                                                0.06,
                                        color: controller.selectedLabPackage !=
                                                null
                                            ? Colors.black
                                            : Colors.grey[700],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              const Spacer(),
                              GetBuilder<PackagesController>(
                                  builder: (packageContr) {
                                return ImageContainer(
                                  onpressed: () async {
                                    await PackagesController.i.updatediscount(
                                        PackagesController.i.selectedLabPackage!
                                            .packageGroupDiscountRate!,
                                        PackagesController
                                            .i.selectedLabPackage!.total!);
                                    await controller.addlabpackage();
                                  },
                                  imagePath: Images.add,
                                  isSvg: false,
                                  color: ColorManager.kWhiteColor,
                                  backgroundColor: ColorManager.kPrimaryColor,
                                );
                              })
                            ],
                          );
                        }),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        Text(
                          'Test ${PackagesController.i.selectedLabPackages!.isNotEmpty && PackagesController.i.selectedLabPackages!.length < 2 ? ('(Package)') : PackagesController.i.selectedLabPackages!.length > 1 ? '(Packages)' : ''}',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  fontWeight: FontWeight.w900,
                                  color: ColorManager.kPrimaryColor),
                        ),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        Container(
                          padding: const EdgeInsets.all(AppPadding.p12),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border:
                                  Border.all(color: ColorManager.kGreyColor)),
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
                              PackagesController
                                      .i.selectedLabPackages!.isNotEmpty
                                  ? SizedBox(
                                      height: Get.height * 0.02,
                                    )
                                  : const SizedBox.shrink(),
                              GetBuilder<LabInvestigationController>(
                                  builder: (cont) {
                                return GetBuilder<PackagesController>(
                                    builder: (packagesContr) {
                                  return ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: packagesContr
                                          .selectedLabPackages?.length,
                                      itemBuilder: (context, index) {
                                        final test = packagesContr
                                            .selectedLabPackages![index];
                                        int myindex = index;
                                        return ListView.builder(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: test
                                                .dTOPackageGroupDetail?.length,
                                            itemBuilder: (context, index) {
                                              final data =
                                                  test.dTOPackageGroupDetail?[
                                                      index];
                                              return Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  InkWell(
                                                    onTap: () async {
                                                      // log(index.toString());
                                                      int groupIndex = test
                                                          .dTOPackageGroupDetail!
                                                          .indexOf(data!);
                                                      int index = await cont
                                                          .updateSelectedIndex(
                                                              groupIndex);
                                                      packagesContr
                                                          .removepackage(
                                                              myindex);
                                                    },
                                                    child: cont.selectedIndex ==
                                                            index
                                                        ? const Icon(
                                                            Icons.cancel,
                                                            color: ColorManager
                                                                .kRedColor,
                                                            size: 15,
                                                          )
                                                        : const SizedBox(
                                                            width: 15),
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  SizedBox(
                                                    width: Get.width * 0.5,
                                                    child: Text(
                                                      testName(data!.name!)
                                                          .toString(),
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium!
                                                          .copyWith(
                                                              fontSize: 12),
                                                    ),
                                                  ),
                                                  const Spacer(),
                                                  Text(
                                                    data.total
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
                                      });
                                });
                              }),
                              GetBuilder<LabInvestigationController>(
                                  builder: (cont) {
                                return ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: cont.selectedLabTests.length,
                                    itemBuilder: (context, index) {
                                      final test = cont.selectedLabTests[index];
                                      return Row(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              cont.removeLabTest(index);
                                            },
                                            child: const Icon(
                                              Icons.cancel,
                                              color: ColorManager.kRedColor,
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
                                                    (Match m) => '${m[1]},'),
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
                                  future: cont.returnPriceLabsAndPackages(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      if (snapshot.data == '0.0') {
                                        return const SizedBox.shrink();
                                      } else {
                                        return Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            '${'subTotal'.tr} : ${snapshot.data}',
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
                                      WidgetsBinding.instance
                                          .addPostFrameCallback((_) {
                                        LabInvestigationController.i.update();
                                      });

                                      return const SizedBox.shrink();
                                    } else {
                                      WidgetsBinding.instance
                                          .addPostFrameCallback((_) {
                                        LabInvestigationController.i.update();
                                      });
                                      return const SizedBox.shrink();
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
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            'Discount : ${snapshot.data.toString()}',
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
                                      .totalVatPercentOfPackages(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      if (snapshot.data == 0.0) {
                                        return const SizedBox.shrink();
                                      } else {
                                        return Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            '${'Vat Amount'.tr} : ${snapshot.data.toString()}',
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
                                    } else if (!snapshot.hasData) {
                                      return const SizedBox.shrink();
                                    } else {
                                      return const SizedBox.shrink();
                                    }
                                  }),
                              FutureBuilder<double>(
                                  future:
                                      PackagesController.i.sumUpGrandTotal(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      if (snapshot.data == 0.0) {
                                        return const SizedBox.shrink();
                                      } else {
                                        return Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            '${'grandTotal'.tr} : ${snapshot.data!}',
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
                                      return const Align(
                                          alignment: Alignment.centerRight,
                                          child: Text('0.0'));
                                    }
                                  })
                            ],
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),

                        const SamplesRadioButton(),
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
                            onDateChange: (date) {
                              cont.updateSelectedDatae(date);
                              log('${cont.selectedDate}');
                            },
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        GetBuilder<LabInvestigationController>(builder: (cont) {
                          return InkWell(
                            onTap: () {
                              cont.selectTime(
                                  context,
                                  LabInvestigationController.selectedTime,
                                  cont.formattedSelectedTime);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: ColorManager.kPrimaryLightColor),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${'timer'.tr} : ',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                            color: ColorManager.kPrimaryColor,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    cont.formattedSelectedTime ??
                                        'selectTime'.tr,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                            color: ColorManager.kPrimaryColor,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        CustomTextField(
                          padding: const EdgeInsets.all(15).copyWith(top: 10),
                          maxlines: 5,
                          hintText: 'description'.tr,
                          controller: discreb,
                        ),

                        cont.selectedLabValue == 0
                            ? GetBuilder<AddressController>(builder: (cont) {
                                return InkWell(
                                  onTap: () async {
                                    LocationPermission permission;
                                    permission =
                                        await Geolocator.checkPermission();
                                    var isFirstTime = await LocalDb()
                                        .getDisclosureDialogueValue();
                                    if (permission ==
                                            LocationPermission.whileInUse ||
                                        permission ==
                                            LocationPermission.always ||
                                        isFirstTime == true) {
                                      log('test a');
                                      Get.to(() => const GoogleMaps());
                                    } else {
                                      await showDialog(
                                          barrierDismissible: false,
                                          context: context,
                                          builder: (BuildContext context) {
                                            return Dialog(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0)),
                                              child: SizedBox(
                                                height: Get.height * 0.5,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      12.0),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Text(
                                                        "permissions".tr,
                                                        style:
                                                            GoogleFonts.poppins(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                      ),
                                                      const Divider(
                                                        thickness: 2,
                                                        color: Colors.black,
                                                      ),
                                                      Center(
                                                        child: Text(
                                                            "collectLocationData"
                                                                .tr),
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          SizedBox(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.3,
                                                            child:
                                                                ElevatedButton(
                                                                    style: ButtonStyle(
                                                                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                                                                            borderRadius: BorderRadius.circular(
                                                                                20)))),
                                                                    child: Text(
                                                                      "agree"
                                                                          .tr,
                                                                      style: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .bodyMedium
                                                                          ?.copyWith(
                                                                              color: ColorManager.kWhiteColor,
                                                                              fontSize: 12,
                                                                              fontWeight: FontWeight.bold),
                                                                    ),
                                                                    onPressed:
                                                                        () async {
                                                                      await LocalDb()
                                                                          .disclosureDialogvalue();
                                                                      Get.back();
                                                                      await determinePosition()
                                                                          .then(
                                                                              (value) {
                                                                        setState(
                                                                            () {
                                                                          AddressController
                                                                              .i
                                                                              .markers
                                                                              .clear();
                                                                          AddressController.i.markers.add(Marker(
                                                                              infoWindow: const InfoWindow(title: 'Current Location', snippet: 'current Location'),
                                                                              position: LatLng(value?.latitude ?? 0.0, value?.longitude ?? 0.0),
                                                                              markerId: const MarkerId('1')));
                                                                          AddressController
                                                                              .i
                                                                              .currentPlaceList
                                                                              .clear();
                                                                          AddressController
                                                                              .i
                                                                              .getcurrentLocation()
                                                                              .then((value) {
                                                                            AddressController.i.latitude =
                                                                                value.latitude;
                                                                            AddressController.i.longitude =
                                                                                value.longitude;
                                                                            AddressController.i.initialAddress(value.latitude,
                                                                                value.longitude);
                                                                            log('latitude: ${AddressController.i.latitude} , longitude ${AddressController.i.longitude}');
                                                                            AddressController.i.markers.clear();
                                                                            AddressController.i.markers.add(Marker(
                                                                                infoWindow: const InfoWindow(title: 'Current Location', snippet: 'This is my current Location'),
                                                                                position: LatLng(AddressController.i.latitude!, AddressController.i.longitude!),
                                                                                markerId: const MarkerId('1')));
                                                                          });
                                                                        });
                                                                      });
                                                                      Get.to(() =>
                                                                          const GoogleMaps());
                                                                    }),
                                                          ),
                                                          SizedBox(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.3,
                                                            child:
                                                                ElevatedButton(
                                                                    style: ButtonStyle(
                                                                        backgroundColor:
                                                                            MaterialStateProperty.all(Colors
                                                                                .white),
                                                                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                                                                            borderRadius: BorderRadius.circular(
                                                                                20)))),
                                                                    child: Text(
                                                                      "deny".tr,
                                                                      style: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .bodyMedium
                                                                          ?.copyWith(
                                                                              color: ColorManager.kPrimaryColor,
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: 12),
                                                                    ),
                                                                    onPressed:
                                                                        () {
                                                                      Get.back();
                                                                    }),
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          });
                                    }
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
                                          Icons.location_on_outlined,
                                          color: ColorManager.kPrimaryColor,
                                        ),
                                        SizedBox(
                                          width: Get.width * 0.035,
                                        ),
                                        Flexible(
                                          child: Text(
                                              AddressController
                                                              .address ==
                                                          null ||
                                                      AddressController
                                                              .address ==
                                                          ''
                                                  ? 'address'.tr
                                                  : '${AddressController.address}',
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium
                                                  ?.copyWith(
                                                      color: ColorManager
                                                          .kPrimaryColor,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w900)),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              })
                            : const SizedBox.shrink(),
                        cont.selectedLabValue == 0
                            ? SizedBox(
                                height: Get.height * 0.02,
                              )
                            : const SizedBox.shrink(),
                        // Text(
                        //   'paymentMethod'.tr,
                        //   style:
                        //       Theme.of(context).textTheme.bodyMedium!.copyWith(
                        //             color: ColorManager.kPrimaryColor,
                        //             fontSize: 14,
                        //             fontWeight: FontWeight.w900,
                        //           ),
                        // ),

                        InkWell(
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
                                        : 'modeOfPayment'.tr,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                            color: ColorManager.kPrimaryColor,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w900)),
                                const Spacer(),
                                Image.asset(Images.masterCard)
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        Text(
                          'prescribedBy'.tr,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(
                                  color: ColorManager.kPrimaryColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                        ),

                        const RadioButtonRow(),

                        Visibility(
                          visible: cont.selectedalue == 1,
                          child: DropdownDataWidget<Doctors>(
                              hint: 'doctor'.tr,
                              items: cont.doctors,
                              selectedValue: cont.selectedDoctor,
                              onChanged: (value) {
                                cont.updateDoctor(value!);
                                // cont.addLabTest();
                                // cont.totalLabPackagesPrice(false);
                              },
                              itemTextExtractor: (value) => value.name!),
                        ),
                        Visibility(
                          visible: cont.selectedalue == 2,
                          child: Column(
                            children: [
                              // SizedBox(
                              //   height: Get.height * 0.02,
                              // ),
                              CustomTextField(
                                hintText: 'doctorName'.tr,
                              ),
                              // SizedBox(
                              //   height: Get.height * 0.02,
                              // ),
                              PrimaryButton(
                                  border: Border.all(
                                      color: ColorManager.kPrimaryColor,
                                      width: 2),
                                  title: 'attachPrescription'.tr,
                                  onPressed: () async {
                                    LabInvestigationController.i.file =
                                        await AuthController.i.pickImage(
                                            type: FileType.image,
                                            context: context);
                                  },
                                  fontSize: 20,
                                  color: ColorManager.kWhiteColor,
                                  textcolor: ColorManager.kPrimaryColor),
                              SizedBox(
                                height: Get.height * 0.01,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height:
                              cont.selectedalue == 0 || cont.selectedalue == 2
                                  ? 0
                                  : Get.height * 0.01,
                        ),
                        Text(
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
                          height: Get.height * 0.01,
                        ),
                        SummaryWidget(
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
                              if (widget.isReschedule == false) {
                                if (cont.selectedLabTests.isEmpty &&
                                    PackagesController
                                        .i.selectedLabPackages!.isEmpty) {
                                  ToastManager.showToast(
                                      'noservicespackages'.tr);
                                } else if (cont.selectedPaymentMethod == null) {
                                  ToastManager.showToast('nopaymentmethod'.tr);
                                } else if (cont.selectedDate != null &&
                                    cont.selectedDate!.day ==
                                        DateTime.now().day &&
                                    (LabInvestigationController
                                                .selectedTime.hour <
                                            TimeOfDay.now().hour ||
                                        (LabInvestigationController
                                                    .selectedTime.hour ==
                                                DateTime.now().hour &&
                                            LabInvestigationController
                                                    .selectedTime.minute <=
                                                DateTime.now().minute))) {
                                  log(LabInvestigationController.selectedTime
                                      .toString());
                                  ToastManager.showToast('thisdatetime'.tr);
                                } else if (cont.selectedLabValue == 0 &&
                                    (AddressController.address == null ||
                                        AddressController.address == "")) {
                                  ToastManager.showToast('noaddress'.tr);
                                } else {
                                  bool? isLoggedin =
                                      await LocalDb().getLoginStatus();
                                  log('$isLoggedin');
                                  if (_formKey.currentState!.validate()) {
                                    if (isLoggedin == true) {
                                      if (cont.labtests!.isEmpty) {
                                      } else {
                                        LabInvestigationRepo()
                                            .bookLabInvestigationOrHomeSampling(
                                          isHereFromReports:
                                              widget.isHereFromReports,
                                          isHerefromHomeSample:
                                              widget.isHomeSamle,
                                          isLabInvestigationBooking:
                                              widget.isLabInvestigationBooking,
                                        );
                                      }
                                    } else {
                                      Get.to(() => LoginScreen(
                                            isLabInvestigationScreen: true,
                                            map: cont.selectedLabTests,
                                          ));
                                    }
                                  } else {}
                                }
                              } else {
                                log('over here');
                                ScheduleRepo().rescheduleLabAppointment(
                                    labNO: widget.list!.LabNO,
                                    labID: widget.list!.LabId,
                                    context: context,
                                    time: cont.formattedSelectedTime,
                                    date: cont.selectedDate,
                                    packageGroupId: widget.list?.PackageGroupId,
                                    packageGroupName:
                                        widget.list?.PackageGroupName,
                                    packageGroupDiscountRate:
                                        widget.list?.PackageGroupDiscountRate,
                                    packageGroupDiscountType:
                                        widget.list?.PackageGroupDiscountType);
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
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Spacer(),
                    Text('modeOfPayment'.tr),
                    const Spacer(),
                    CircleAvatar(
                        radius: 15,
                        backgroundColor: ColorManager.kRedColor,
                        child: IconButton(
                          icon: const Icon(
                            Icons.close,
                          ),
                          onPressed: () {
                            Get.back();
                          },
                          iconSize: 15,
                          color: ColorManager.kWhiteColor,
                        ))
                  ]),
              content: SizedBox(
                width: double.maxFinite,
                child: BookAppointmentController.i.paymentMethods.isNotEmpty
                    ? ListView.builder(
                        itemCount:
                            BookAppointmentController.i.paymentMethods.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final payment =
                              BookAppointmentController.i.paymentMethods[index];
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
                      )
                    : Text(
                        'noPaymentsFound'.tr,
                        textAlign: TextAlign.center,
                      ),
              ),
            ),
          );
        });
  }

  buildStyledContainer(String text, BuildContext context, int index,
      String payment, bool? hasMasterCardImage, Function()? onTap,
      {PaymentMethod? method}) {
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
                CachedNetworkImage(
                  imageUrl:
                      '${containsFile(method?.imagePath)}${method?.imagePath}',
                  errorWidget: (context, url, error) {
                    return const SizedBox.shrink();
                  },
                )
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
      padding: const EdgeInsets.all(AppPadding.p8),
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
                        'modeOfPayment'.tr,
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
            const Divider(
              color: ColorManager.kblackColor,
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
