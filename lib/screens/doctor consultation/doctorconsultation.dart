// ignore_for_file: use_build_context_synchronously, unrelated_type_equality_checks, camel_case_types, unnecessary_null_comparison

import 'dart:developer';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tabib_al_bait/components/custom_textfields.dart';
import 'package:tabib_al_bait/components/image_container.dart';
import 'package:tabib_al_bait/components/images.dart';
import 'package:tabib_al_bait/components/primary_button.dart';
import 'package:tabib_al_bait/components/radiobutton_status.dart';
import 'package:tabib_al_bait/components/serachabledropdownconsult.dart';
import 'package:tabib_al_bait/data/controller/google_maps_controller.dart';
import 'package:tabib_al_bait/data/controller/lab_investigations_controller.dart';
import 'package:tabib_al_bait/data/localDB/local_db.dart';
import 'package:tabib_al_bait/data/repositories/lab_investigation_repo/lab_investigation_repo.dart';
import 'package:tabib_al_bait/helpers/color_manager.dart';
import 'package:tabib_al_bait/helpers/show_toast.dart';
import 'package:tabib_al_bait/helpers/values_manager.dart';
import 'package:tabib_al_bait/main.dart';
import 'package:tabib_al_bait/screens/auth_screens/login.dart';
import 'package:tabib_al_bait/screens/family_screens/family_members.dart';
import 'package:tabib_al_bait/screens/googe_maps/google_maps.dart';
import 'package:tabib_al_bait/utils/constants.dart';
import '../../data/controller/book_appointment_controller.dart';
import '../../models/lab_tests_model.dart';

class doctorconsultation extends StatefulWidget {
  final bool? isHereFromDoctorConsultant;
  final String? title;
  final bool? isdoctorconsult;
  const doctorconsultation(
      {super.key,
      this.title,
      this.isdoctorconsult,
      this.isHereFromDoctorConsultant});

  @override
  State<doctorconsultation> createState() => _doctorconsultationState();
}

class _doctorconsultationState extends State<doctorconsultation> {
  var cont = AddressController.i;
  TextEditingController appointmentnotes = TextEditingController();

  @override
  void initState() {
    LabInvestigationController.i.selectedLabtest =
        LabInvestigationController.i.labtests?[0];
    BookAppointmentController.i.getPaymentMethods();
    LabInvestigationController.i.selectedDoctor =
        LabInvestigationController.i.doctors[0];
    LabInvestigationController.i.initTime(Get.context!);
    LabInvestigationController.i.getserviceslist();
    LabInvestigationController.i.getspeciality();
    LabInvestigationController.i.getspecialityserve();

    super.initState();
  }

  @override
  void dispose() {
    LabInvestigationController.i.selectedconsultservice = [];
    LabInvestigationController.i.Status = null;
    LabInvestigationController.i.selectedPaymentMethod2 = null;
    LabInvestigationController.i.totalSum2 = 0.0;
    LabInvestigationController.i.selectedDate = DateTime.now();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    var cont =
        Get.put<LabInvestigationController>(LabInvestigationController());

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: CustomAppBar(
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
                        const RadioButtonStatus(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const ImageContainer(
                              isSvg: false,
                              imagePath: Images.microscope,
                              color: ColorManager.kWhiteColor,
                              backgroundColor: ColorManager.kPrimaryColor,
                            ),
                            SizedBox(
                              width: Get.width * 0.02,
                            ),
                            InkWell(
                              onTap: () async {
                                // cont.selectedspaciality = null;
                                cont.getspecialityserve();
                                LabTests generic = await Searchableconsult(
                                    context, cont.doctorconsultation);
                                cont.selectedspaciality = generic;

                                if (generic != null && generic != '') {
                                  cont.selectedspaciality = generic;
                                  cont.selectedspaciality = (generic == '')
                                      ? null
                                      : cont.selectedspaciality;
                                }
                                setState(() {});
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: ColorManager.kPrimaryColor,
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: ColorManager.kPrimaryLightColor,
                                ),
                                height:
                                    MediaQuery.of(context).size.height * 0.055,
                                child: SizedBox(
                                  width: Get.width * 0.55,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        "${(cont.selectedspaciality != null && cont.selectedspaciality?.name != null) ? (cont.selectedspaciality!.name!.length > 20 ? ('${cont.selectedspaciality?.name!.substring(0, 20)}...') : cont.selectedspaciality?.name) : "services".tr}",
                                        semanticsLabel:
                                            "${(cont.selectedspaciality != null) ? (cont.selectedspaciality!.name!.length > 20 ? ('${cont.selectedspaciality?.name!.substring(0, 20)}...') : cont.selectedspaciality) : "services".tr}",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: cont.selectedservice?.name !=
                                                    null
                                                ? Colors.black
                                                : Colors.grey[700]),
                                      ),
                                      Icon(
                                        Icons.arrow_drop_down,
                                        size:
                                            MediaQuery.of(context).size.width *
                                                0.06,
                                        color: cont.selectedLabtest != null
                                            ? Colors.black
                                            : Colors.grey[700],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: Get.width * 0.02,
                            ),
                            ImageContainer(
                              onpressed: () {
                                cont.addconsultservices();
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
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                              child: Container(
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
                                          fontWeight: FontWeight.w900),
                                  dayTextStyle: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                          color: ColorManager.kPrimaryColor,
                                          fontWeight: FontWeight.w300),
                                  monthTextStyle: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                          color: ColorManager.kPrimaryColor,
                                          fontWeight: FontWeight.w300),
                                  deactivatedColor:
                                      ColorManager.kPrimaryLightColor,
                                  height: Get.height * 0.18,
                                  initialSelectedDate: DateTime.now(),
                                  selectionColor: ColorManager.kPrimaryColor,
                                  selectedTextColor: Colors.white,
                                  onDateChange: (date) {
                                    cont.updateSelectedDatae(date);
                                    log('${cont.selectedDate}');
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        GetBuilder<LabInvestigationController>(builder: (cont) {
                          return CustomTextField(
                            hintText: 'Time:  ${cont.formattedSelectedTime}',
                            readonly: true,
                            isSizedBoxAvailable: false,
                            suffixIcon: InkWell(
                                onTap: () {
                                  cont.selectTime(
                                      context,
                                      LabInvestigationController.selectedTime,
                                      cont.formattedSelectedTime);
                                },
                                child: Image.asset(Images.dropdown)),
                            suffixStyle: const TextStyle(
                                color: ColorManager.kGreyColor, fontSize: 12),
                          );
                        }),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        SummaryWidget(
                          title: widget.title,
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),

                        widget.isdoctorconsult == true
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
                                                          20.0)), //this right here
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
                                                            "${AppConstants.appName} ${'collectsData'.tr}"),
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
                                                                              position: LatLng(value!.latitude, value.longitude),
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
                                              AddressController.address == null
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
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        Text(
                          "paymentMethod".tr,
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
                                    cont.selectedPaymentMethod2 != null
                                        ? '${cont.selectedPaymentMethod2!.name}'
                                        : 'paymentMethod'.tr,
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
                        // SizedBox(
                        //   height: Get.height * 0.08,
                        //   child: ListView.builder(
                        //       scrollDirection: Axis.horizontal,
                        //       itemCount: BookAppointmentController
                        //           .i.paymentMethods.length,
                        //       shrinkWrap: true,
                        //       itemBuilder: (context, index) {
                        //         final method = BookAppointmentController
                        //             .i.paymentMethods[index];
                        //         return Padding(
                        //           padding: const EdgeInsets.symmetric(
                        //                   horizontal: AppPadding.p16)
                        //               .copyWith(left: 0),
                        //           child: Row(
                        //             mainAxisAlignment:
                        //                 MainAxisAlignment.spaceBetween,
                        //             mainAxisSize: MainAxisSize.max,
                        //             children: [
                        //               Radio<PaymentMethod>(
                        //                 fillColor: MaterialStateProperty.all(
                        //                     ColorManager.kPrimaryColor),
                        //                 value: method,
                        //                 groupValue: cont.selectedPaymentMethod2,
                        //                 onChanged: (value) {
                        //                   cont.updatePaymentMethod2(
                        //                       BookAppointmentController
                        //                           .i.paymentMethods[index]);
                        //                 },
                        //               ),
                        //               Text(
                        //                 '${method.name}',
                        //                 style: Theme.of(context)
                        //                     .textTheme
                        //                     .bodyMedium
                        //                     ?.copyWith(
                        //                         fontFamily:
                        //                             GoogleFonts.poppins()
                        //                                 .fontFamily,
                        //                         color:
                        //                             ColorManager.kPrimaryColor,
                        //                         fontSize: 12),
                        //               ),
                        //             ],
                        //           ),
                        //         );
                        //       }),
                        // ),
                        // SizedBox(
                        //   height: Get.height*0.08,
                        //   width: Get.width,
                        //   child: ListView(
                        //     children: [

                        //     ],
                        //   ),
                        // ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        // SizedBox(
                        //   height: Get.height * 0.02,
                        // ),
                        Text(
                          'appointmentNotes'.tr,
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
                        CustomTextField(
                          // hintText: "  Enter Notes",
                          maxlines: 4,
                          padding: EdgeInsets.all(Get.height * 0.02),
                          controller: appointmentnotes,
                        ),

                        PrimaryButton(
                            title: 'appointmentConfirm'.tr,
                            fontSize: 14,
                            onPressed: () async {
                              if (cont.selectedconsultservice!.isEmpty) {
                                ToastManager.showToast('noservices'.tr);
                              } else if (widget.isdoctorconsult == true &&
                                  AddressController.address == null) {
                                ToastManager.showToast('noaddress'.tr);
                              } else if (cont.selectedPaymentMethod2 == null) {
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
                              } else {
                                bool? isLoggedin =
                                    await LocalDb().getLoginStatus();
                                log('$isLoggedin');
                                if (_formKey.currentState!.validate()) {
                                  if (isLoggedin == true) {
                                    if (cont.labtests!.isEmpty) {
                                    } else {
                                      LabInvestigationRepo()
                                          .bookspecialitisservices(
                                              appointmentnotes:
                                                  appointmentnotes.text);
                                    }
                                  } else {
                                    Get.to(() => LoginScreen(
                                          isdoctorConsultation: true,
                                          consultServices:
                                              cont.doctorconsultation,
                                        ));
                                  }
                                } else {}
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
          return Material(
              type: MaterialType.transparency,
              shape: const RoundedRectangleBorder(),
              color: ColorManager.kWhiteColor,
              child: AlertDialog(
                content: SingleChildScrollView(
                    child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Image.asset(Images.crossicon),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.04,
                    ),
                    Text(
                      'paymentmethod'.tr,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: ColorManager.kPrimaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w900,
                          ),
                    ),
                    SizedBox(
                      height: Get.height * 0.09,
                    ),
                    SizedBox(
                      height: Get.height * 0.4,
                      width: 300,
                      child: ListView.builder(
                        itemCount:
                            BookAppointmentController.i.paymentMethods.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final payment =
                              BookAppointmentController.i.paymentMethods[index];
                          return buildStyledContainer(
                              '${payment.name}', context, index, false, () {
                            BookAppointmentController.i
                                .updateSelectedIndex(index);
                            LabInvestigationController.i
                                .updatePaymentMethod2(payment);
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
              ));
        });
  }

  buildStyledContainer(String text, BuildContext context, int index,
      bool? hasMasterCardImage, Function()? onTap) {
    return GetBuilder<BookAppointmentController>(builder: (cont) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: InkWell(
          onTap: onTap,
          child: Container(
            width: Get.width,
            decoration: BoxDecoration(
              color: cont.selectedIndex == index
                  ? ColorManager.kRedColor
                  : ColorManager.kPrimaryColor,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(text,
                    style: const TextStyle(
                        fontSize: 12, color: ColorManager.kWhiteColor)),
                SizedBox(
                  height: Get.height * 0.02,
                ),
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
  const SummaryWidget({
    this.title,
    super.key,
  });

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
        return Column(
          children: [
            LabInvestigationController.i.selectedDate != null &&
                    LabInvestigationController.i.formattedSelectedTime != null
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${'date'.tr} & ${'hour'.tr}',
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'test'.tr,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.w900, fontSize: 12),
                ),
                Text(
                  'charges'.tr,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.w900, fontSize: 12),
                ),
              ],
            ),
            SizedBox(
              height: Get.height * 0.01,
            ),
            GetBuilder<LabInvestigationController>(builder: (cont) {
              return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: cont.selectedconsultservice!.length,
                  itemBuilder: (context, index) {
                    final test = cont.selectedconsultservice?[index];
                    return Row(
                      children: [
                        InkWell(
                          onTap: () {
                            cont.removeconserviceslist(index);
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
                            '${test!.name}',
                            textAlign: TextAlign.start,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontSize: 12),
                          ),
                        ),
                        const Spacer(),
                        Text(
                          '${test.actualPrice}',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontSize: 14),
                        ),
                      ],
                    );
                  });
            }),
            SizedBox(
              height: Get.height * 0.02,
            ),
            const Divider(
              color: ColorManager.kGreyColor,
              height: 2,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                '${'subTotal'.tr}: ${cont.totalSum2}',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontSize: 14),
                textAlign: TextAlign.end,
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontSize: 14),
                '${'grandTotal'.tr} : ${cont.totalSum2}',
                textAlign: TextAlign.end,
              ),
            )
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
