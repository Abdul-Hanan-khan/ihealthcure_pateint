// ignore_for_file: unused_local_variable

import 'dart:developer';
import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:tabib_al_bait/components/custom_textfields.dart';
import 'package:tabib_al_bait/components/images.dart';
import 'package:tabib_al_bait/components/primary_button.dart';
import 'package:tabib_al_bait/data/controller/auth_controller.dart';
import 'package:tabib_al_bait/data/controller/book_appointment_controller.dart';
import 'package:tabib_al_bait/data/controller/specialities_controller.dart';
import 'package:tabib_al_bait/data/localDB/local_db.dart';
import 'package:tabib_al_bait/helpers/color_manager.dart';
import 'package:tabib_al_bait/helpers/values_manager.dart';
import 'package:tabib_al_bait/main.dart';
import 'package:tabib_al_bait/models/consult_now/consult_now_body.dart';
import 'package:tabib_al_bait/models/doctor_consultation_fee.dart';
import 'package:tabib_al_bait/models/search_models.dart';
import 'package:tabib_al_bait/screens/auth_screens/login.dart';
import 'package:tabib_al_bait/screens/family_screens/family_members.dart';
import '../../data/repositories/specialities_repo/specialities_repo.dart';

class OnlineAppointmentConfirm extends StatefulWidget {
  final bool? isHereFromLogin;
  final Search? doctor;
  final ConsultancyDetail? details;
  const OnlineAppointmentConfirm(
      {super.key, this.doctor, this.details, this.isHereFromLogin});

  @override
  State<OnlineAppointmentConfirm> createState() =>
      _OnlineAppointmentConfirmState();
}

class _OnlineAppointmentConfirmState extends State<OnlineAppointmentConfirm> {
  TextEditingController appointmentNotes = TextEditingController();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BookAppointmentController.i.getPaymentMethods();
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: CustomAppBar(
            isScheduleScreen: widget.isHereFromLogin,
            title: "Consult Now",
          )),
      body: GetBuilder<SpecialitiesController>(builder: (cont) {
        return BlurryModalProgressHUD(
          inAsyncCall: cont.isConsultNowLoading,
          blurEffectIntensity: 4,
          progressIndicator: const SpinKitSpinningLines(
            color: Color(0xff1272d3),
            size: 60,
          ),
          dismissible: false,
          opacity: 0.4,
          color: Theme.of(context).scaffoldBackgroundColor,
          child: SafeArea(
            child: Center(
              child: GetBuilder<BookAppointmentController>(builder: (cont) {
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                          radius: 60,
                          backgroundColor:
                              ColorManager.kPrimaryLightColor, // Border color
                          child: AuthController.i.user?.imagePath != null
                              ? CircleAvatar(
                                  backgroundImage: CachedNetworkImageProvider(
                                      '${containsFile(AuthController.i.user?.imagePath)}/${AuthController.i.user?.imagePath}'),
                                  radius: 50,
                                  backgroundColor: Colors.transparent,
                                )
                              : const CircleAvatar(
                                  radius: 50,
                                  backgroundImage: AssetImage(Images.avatar),
                                )),
                      SizedBox(
                        height: Get.height * 0.01,
                      ),
                      Text(
                        '${AuthController.i.user?.fullName ?? ''} ',
                        style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.w900,
                            color: ColorManager.kPrimaryColor),
                      ),
                      SizedBox(
                        height: Get.height * 0.01,
                      ),
                      AuthController.i.user?.id != null
                          ? Text(
                              'MR No. ${AuthController.i.user?.mRNo ?? ''} ',
                              style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: ColorManager.kPrimaryColor),
                            )
                          : const SizedBox.shrink(),
                      SizedBox(
                        height: Get.height * 0.065,
                      ),
                      Stack(clipBehavior: Clip.none, children: [
                        Container(
                          height: Get.height * 0.65,
                          width: Get.width,
                          decoration: const BoxDecoration(
                            color: ColorManager.kPrimaryLightColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                          ),
                        ),
                        Positioned(
                          top: -45,
                          left: 0,
                          right: 0,
                          child: Center(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: ColorManager.kPrimaryColor,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                      color: ColorManager.kWhiteColor,
                                      width: 5)),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 90, right: 100, top: 15, bottom: 15),
                                child: Column(
                                  children: [
                                    Text(
                                      'paying'.tr,
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        color: ColorManager.kWhiteColor,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Text(
                                      ' ${widget.doctor!.consultancyFee}',
                                      style: GoogleFonts.poppins(
                                        fontSize: 20,
                                        color: ColorManager.kWhiteColor,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(AppPadding.p20),
                          child: SizedBox(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: Get.height * 0.08,
                                ),
                                Doctoronline(
                                  doctor: widget.doctor,
                                  details: widget.details,
                                ),
                                SizedBox(
                                  height: Get.height * 0.01,
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "appointmentNotes".tr,
                                    textAlign: TextAlign.start,
                                    style: GoogleFonts.poppins(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: ColorManager.kPrimaryColor),
                                  ),
                                ),
                                SizedBox(
                                  height: Get.height * 0.02,
                                ),
                                CustomTextField(
                                    fillColor: ColorManager.kWhiteColor,
                                    maxlines: 6,
                                    controller: appointmentNotes,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0, vertical: 12.0)),
                                SizedBox(
                                  height: Get.height * 0.03,
                                ),
                                PrimaryButton(
                                    fontSize: 20,
                                    title: 'payOnline'.tr,
                                    onPressed: () async {
                                      var patientId =
                                          await LocalDb().getPatientId();
                                      var branchID =
                                          await LocalDb().getBranchId();
                                      log('${widget.doctor!.id!} doctor id');
                                      log('$patientId');
                                      bool? isLoggedIn =
                                          await LocalDb().getLoginStatus();
                                      if (isLoggedIn == true) {
                                        var token = await LocalDb().getToken();
                                        dynamic branchid =
                                            await LocalDb().getBranchId();
                                        var deviceToken =
                                            await LocalDb().getDeviceToken();
                                        ConsultNowBody? body = ConsultNowBody(
                                            vouncherCode: '',
                                            discount: "15",
                                            discountType: "0",
                                            token: "$token",
                                            doctorId: widget.doctor?.id,
                                            patientId: patientId,
                                            consultancyFee:
                                                widget.details?.consultancyFee,
                                            paymentMethodId:
                                                BookAppointmentController.i
                                                    .consultNowPaymentMethod?.id
                                                    .toString(),
                                            deviceToken: deviceToken,
                                            branchId: branchid);

                                        await SpecialitiesRepo.consultNow(
                                            body, widget.doctor);
                                      } else {
                                        var token = await LocalDb().getToken();
                                        var branchID =
                                            await LocalDb().getBranchId();
                                        ConsultNowBody? body = ConsultNowBody(
                                            vouncherCode: '',
                                            discount: "15",
                                            discountType: "0",
                                            token: "$token",
                                            doctorId: widget.doctor?.id,
                                            patientId: patientId,
                                            consultancyFee:
                                                widget.details?.consultancyFee,
                                            paymentMethodId:
                                                BookAppointmentController
                                                    .i
                                                    .consultNowPaymentMethod
                                                    ?.id,
                                            branchId: branchID);
                                        LocalDb.saveSearchDoctor(
                                            widget.doctor!);
                                        LocalDb.saveConsultNowBody(
                                            widget.details!);
                                        Get.to(() => LoginScreen(
                                              isOnlineConsultation: true,
                                              body: body,
                                              isOnlineAppointmentConsultation:
                                                  true,
                                              isBookDoctorAppointmentScreen:
                                                  false,
                                              isLabInvestigationScreen: false,
                                              isHomeSampleScreen: false,
                                            ));
                                      }
                                    },
                                    color: ColorManager.kPrimaryColor,
                                    textcolor: ColorManager.kWhiteColor),
                              ],
                            ),
                          ),
                        ),
                      ])
                    ],
                  ),
                );
              }),
            ),
          ),
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
                      'paymentMethod'.tr,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: ColorManager.kPrimaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w900,
                          ),
                    ),
                    SizedBox(
                      height: Get.height * 0.04,
                    ),
                    SizedBox(
                      height: Get.height * 0.4,
                      width: 300,
                      child: ListView.builder(
                        itemCount:
                            BookAppointmentController.i.paymentMethods.length,
                        shrinkWrap: true,
                        // physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          log(BookAppointmentController
                              .i.paymentMethods[index].id!);
                          final payment =
                              BookAppointmentController.i.paymentMethods[index];

                          return buildStyledContainer(
                              '${payment.name}', context, index, false, () {
                            BookAppointmentController.i
                                .updateSelectedIndex(index);
                            BookAppointmentController.i
                                .updateConsultNowPaymentMethod(
                                    BookAppointmentController
                                        .i.paymentMethods[index]);
                            Get.back();
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    // PrimaryButton(
                    //     height: Get.height * 0.06,
                    //     fontSize: 12,
                    //     title: 'Confirm Payment',
                    //     onPressed: () {
                    //       BookAppointmentController.i
                    //           .updateConsultPayment(false);
                    //       setState(() {});

                    //       Get.back();
                    //     },
                    //     color: ColorManager.kPrimaryColor,
                    //     textcolor: ColorManager.kWhiteColor)
                    // Add more containers as needed
                  ],
                )),
              ));
        });
  }
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

class Doctoronline extends StatelessWidget {
  final Search? doctor;
  final bool? isOnline;
  final ConsultancyDetail? details;
  const Doctoronline(
      {super.key, this.doctor, this.isOnline = false, this.details});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: Get.height * 0.12,
          width: Get.width * 0.25,
          decoration: BoxDecoration(
            border: Border.all(
              color: ColorManager.kPrimaryColor,
              width: 3,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: doctor?.picturePath != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: CachedNetworkImage(
                    imageUrl:
                        '${containsFile(doctor?.picturePath)}/${doctor?.picturePath}',
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) => Image.asset(
                      Images.doctorAvatar,
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              : Image.asset(
                  Images.doctorAvatar,
                  fit: BoxFit.cover,
                ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    width: Get.width * 0.5,
                    child: Text(
                      '${doctor?.name}',
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: ColorManager.kblackColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.05,
                  )
                ],
              ),
              SizedBox(
                width: Get.width * 0.5,
                child: const Divider(
                  height: 1.0,
                  // Adjust the height as needed
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                width: Get.width * 0.5,
                child: Text(
                  doctor?.speciality ?? '',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontWeight: FontWeight.w600, fontSize: 12),
                ),
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    Images.onlineconsult,
                    height: 15,
                  ),
                  SizedBox(
                    width: Get.width * 0.01,
                  ),
                  Text(
                    "onlineConsultation".tr,
                    style: GoogleFonts.poppins(fontSize: 12),
                  ),
                  SizedBox(
                    width: Get.width * 0.14,
                  ),
                  Text(
                    "fee".tr,
                    style: GoogleFonts.poppins(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: ColorManager.kPrimaryColor),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    DateFormat('dd-MM-yyyy | hh:mma').format(DateTime.now()),
                    style:
                        GoogleFonts.poppins(fontSize: 10, color: Colors.grey),
                  ),
                  SizedBox(
                    width: Get.width * 0.2,
                  ),
                  Text(
                    '${doctor?.consultancyFee ?? 0.0}',
                    style: GoogleFonts.poppins(fontSize: 10),
                  ),
                ],
              ),
              // SizedBox(
              //   width: Get.width * 0.5,
              //   child: Text(
              //     doctor?.location ?? '',
              //     style: Theme.of(context)
              //         .textTheme
              //         .bodyMedium
              //         ?.copyWith(fontWeight: FontWeight.w600, fontSize: 12),
              //   ),
              // ),
              // Row(
              //   children: [
              //     Container(
              //       decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(5),
              //           color: ColorManager.kPrimaryColor),
              //       padding: const EdgeInsets.all(5),
              //       child: Text(
              //         'Change Location',
              //         style: Theme.of(context).textTheme.bodySmall?.copyWith(
              //             color: ColorManager.kWhiteColor,
              //             fontSize: 8,
              //             fontWeight: FontWeight.w900),
              //       ),
              //     ),
              //     SizedBox(
              //       width: Get.width * 0.02,
              //     ),
              //     Container(
              //       decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(5),
              //           color: isOnline == true
              //               ? ColorManager.kPrimaryColor
              //               : ColorManager.kPrimaryLightColor),
              //       padding: const EdgeInsets.all(5),
              //       child: Row(
              //         children: [
              //           const Icon(
              //             Icons.pin_drop_outlined,
              //             size: 12,
              //             color: ColorManager.kWhiteColor,
              //           ),
              //           Text(
              //             'Online',
              //             style: Theme.of(context)
              //                 .textTheme
              //                 .bodySmall
              //                 ?.copyWith(
              //                     color: ColorManager.kWhiteColor,
              //                     fontSize: 8,
              //                     fontWeight: FontWeight.w900),
              //           ),
              //         ],
              //       ),
              //     ),
              //     SizedBox(
              //       width: Get.width * 0.02,
              //     ),
              //     Container(
              //       decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(5),
              //           color: isOnline == true
              //               ? ColorManager.kPrimaryLightColor
              //               : ColorManager.kPrimaryColor),
              //       padding: const EdgeInsets.all(5),
              //       child: Row(
              //         children: [
              //           const Icon(
              //             Icons.pin_drop_outlined,
              //             size: 12,
              //             color: ColorManager.kWhiteColor,
              //           ),
              //           Text(
              //             'Offline',
              //             style: Theme.of(context)
              //                 .textTheme
              //                 .bodySmall
              //                 ?.copyWith(
              //                     color: ColorManager.kWhiteColor,
              //                     fontSize: 8,
              //                     fontWeight: FontWeight.w900),
              //           ),
              //         ],
              //       ),
              //     ),
              //   ],
              // )
              // SizedBox(
              //   height: Get.height * 0.08,
              //   width: Get.width * 0.4,
              //   child: ListView.builder(
              //       physics: const NeverScrollableScrollPhysics(),
              //       shrinkWrap: true,
              //       itemCount: doctor?.locations?.length,
              //       itemBuilder: (context, index) {
              //         return Text(
              //           doctor?.locations?[index].name ?? '',
              //           style: Theme.of(context)
              //               .textTheme
              //               .bodyMedium
              //               ?.copyWith(
              //                   fontWeight: FontWeight.w600, fontSize: 12),
              //         );
              //       }),
            ],
          ),
        )
      ],
    );
  }
}
