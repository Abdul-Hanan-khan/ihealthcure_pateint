// ignore_for_file: unused_local_variable, non_constant_identifier_names

import 'dart:developer';
import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:tabib_al_bait/components/custom_textfields.dart';
import 'package:tabib_al_bait/components/images.dart';
import 'package:tabib_al_bait/components/primary_button.dart';
import 'package:tabib_al_bait/data/controller/book_appointment_controller.dart';
import 'package:tabib_al_bait/data/controller/my_appointments_controller.dart';
import 'package:tabib_al_bait/data/controller/specialities_controller.dart';
import 'package:tabib_al_bait/data/localDB/local_db.dart';
import 'package:tabib_al_bait/data/repositories/schedule_repo/schedule_repo.dart';
import 'package:tabib_al_bait/data/repositories/specialities_repo/specialities_repo.dart';
import 'package:tabib_al_bait/helpers/color_manager.dart';
import 'package:tabib_al_bait/helpers/enums.dart';
import 'package:tabib_al_bait/helpers/values_manager.dart';
import 'package:tabib_al_bait/main.dart';
import 'package:tabib_al_bait/models/DoctorConsultationAppointmentHistory.dart';
import 'package:tabib_al_bait/models/appointment_booking_mode/appointment_booking_model.dart';
import 'package:tabib_al_bait/models/doctor_locations_model.dart';
import 'package:tabib_al_bait/models/payment_response.dart';
import 'package:tabib_al_bait/screens/auth_screens/login.dart';
import 'package:tabib_al_bait/screens/family_screens/family_members.dart';
import 'package:tabib_al_bait/screens/specialists_screen/specialist_details.dart';
import 'package:tabib_al_bait/utils/card_utils/card_utils.dart';
import 'package:tabib_al_bait/utils/constants.dart';
import '../../models/search_models.dart';

bool? isPaymentComplete = false;

class AppointmentCreation extends StatefulWidget {
  final DoctorScheduleModel? model;
  final String? AppointmentSlotDisplayType;
  final DoctorConsultationAppointmentHistoryDataList? list;
  final bool? isHereFrombookedAppointments;
  final bool? isHereFromLogin;
  final Search? doctor;
  final String? doctorId;
  final String? workLocationId;
  final bool? isOnline;
  final String? date;

  final String? appointmentid;
  final String? patientappointmentid;

  const AppointmentCreation({
    this.AppointmentSlotDisplayType,
    this.appointmentid,
    this.patientappointmentid,
    this.isHereFromLogin = false,
    super.key,
    this.doctorId,
    this.workLocationId,
    this.isOnline,
    this.date,
    this.doctor,
    this.isHereFrombookedAppointments = false,
    this.list,
    this.model,
  });

  @override
  State<AppointmentCreation> createState() => _AppointmentCreationState();
}

class _AppointmentCreationState extends State<AppointmentCreation> {
  CardType? cardType;
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController expiryDateController = TextEditingController();
  TextEditingController cvvController = TextEditingController();
  TextEditingController cardHolderController = TextEditingController();

  void getCardTypeFrmNumber() {
    if (cardNumberController.text.length <= 6) {
      String input = CardUtils.getCleanedNumber(cardNumberController.text);
      CardType type = CardUtils.getCardTypeFrmNumber(input);
      if (type != cardType) {
        setState(() {
          cardType = type;
        });
      }
    }
  }

  String _extractTime(String? time) {
    if (time == null) {
      return '';
    }
    final parts = time.split(':');
    if (parts.length >= 2) {
      return '${parts[0]}:${parts[1]}';
    } else {
      return '';
    }
  }

  @override
  void dispose() {
    cardNumberController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BookAppointmentController.i.getPaymentMethods();
      setState(() {});
    });

    BookAppointmentController.i.newDate = toDateTime(widget.date);

    cardNumberController.addListener(
      () {
        getCardTypeFrmNumber();
      },
    );
    if (widget.isHereFromLogin == true) {
      searchDoctor();
    }
    super.initState();
  }

  Search? search;
  searchDoctor() async {
    search = await LocalDb().getSearchDoctor();
  }

  @override
  Widget build(BuildContext context) {
    var controller =
        Get.put<MyAppointmentsController>(MyAppointmentsController());
    return GetBuilder<BookAppointmentController>(builder: (cont) {
      return BlurryModalProgressHUD(
        inAsyncCall: cont.isBookAppointmentLoading,
        blurEffectIntensity: 4,
        progressIndicator: const SpinKitSpinningLines(
          color: Color(0xff1272d3),
          size: 60,
        ),
        dismissible: false,
        opacity: 0.4,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: PreferredSize(
                  preferredSize: const Size.fromHeight(50),
                  child: CustomAppBar(
                    isScheduleScreen: widget.isHereFromLogin,
                    title: 'bookAppointment'.tr,
                  )),
              body: GetBuilder<SpecialitiesController>(builder: (cont) {
                return GetBuilder<BookAppointmentController>(builder: (book) {
                  return Padding(
                    padding: const EdgeInsets.all(AppPadding.p20),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DoctorWidget(
                            isOnline: widget.isOnline,
                            doctor: widget.doctor ?? search,
                          ),
                          SizedBox(
                            height: Get.height * 0.01,
                          ),
                          Text(
                            'selectdate'.tr,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    fontWeight: FontWeight.w900,
                                    color: ColorManager.kPrimaryColor),
                          ),
                          SizedBox(
                            height: Get.height * 0.02,
                          ),
                          Container(
                            height: Get.height * 0.13,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: ColorManager.kPrimaryLightColor),
                            child: DatePicker(
                              BookAppointmentController.i.newDate ??
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
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12),
                              monthTextStyle: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      color: ColorManager.kPrimaryColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12),
                              deactivatedColor: ColorManager.kPrimaryLightColor,
                              initialSelectedDate:
                                  BookAppointmentController.i.newDate,
                              selectionColor: ColorManager.kPrimaryColor,
                              selectedTextColor: Colors.white,
                              onDateChange: (date) {
                                BookAppointmentController.i.updateDate(date);
                                log('the Date us $date');
                                SpecialitiesController.i.getDateWiseDoctorSlots(
                                    widget.doctorId.toString(),
                                    widget.workLocationId.toString(),
                                    date.toString().split(' ').first,
                                    widget.isOnline ?? false);

                                log(date.toString());
                              },
                            ),
                          ),
                          SizedBox(
                            height: Get.height * 0.01,
                          ),
                          Text(
                            'selecttime'.tr,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    fontWeight: FontWeight.w900,
                                    color: ColorManager.kPrimaryColor),
                          ),
                          SizedBox(
                            height: Get.height * 0.02,
                          ),
                          SpecialitiesController.i.sessions.isNotEmpty
                              ? GetBuilder<SpecialitiesController>(
                                  builder: (cont) {
                                  return GridView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: SpecialitiesController
                                          .i.sessions[0].slots?.length,
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        mainAxisExtent: 25,
                                        crossAxisCount: 4,
                                        crossAxisSpacing: 10,
                                        mainAxisSpacing: 10,
                                        childAspectRatio: 1.1,
                                      ),
                                      itemBuilder: ((context, index) {
                                        final slots = SpecialitiesController
                                            .i.sessions[0].slots![index];

                                        return InkWell(
                                          onTap: () {
                                            cont.updateslotdisplaytype(slots
                                                .appointmentSlotDisplayType
                                                .toString());
                                            cont.updateIsSelected(index);
                                            cont.updateStartTime(
                                                slots.slotTime!);
                                            cont.updateEndTime(
                                                slots.slotEndTime!);
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: slots.isBooked == true
                                                    ? cont.selectedIndex ==
                                                            index
                                                        ? ColorManager
                                                            .kPrimaryColor
                                                        : ColorManager
                                                            .kGreyColor
                                                    : cont.selectedIndex ==
                                                            index
                                                        ? ColorManager
                                                            .kPrimaryColor
                                                        : ColorManager
                                                            .kPrimaryLightColor,
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: Center(
                                                child: Text(
                                              '${'(${index + 1}) '}${_extractTime(slots.slotTime)}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium
                                                  ?.copyWith(
                                                    color: slots.isBooked ==
                                                            true
                                                        ? cont.selectedIndex ==
                                                                index
                                                            ? ColorManager
                                                                .kWhiteColor
                                                            : ColorManager
                                                                .kPrimaryLightColor
                                                        : cont.selectedIndex ==
                                                                index
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
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Center(child: Text('noSessions'.tr))
                                  ],
                                ),
                          SizedBox(
                            height: Get.height * 0.02,
                          ),
                          Text(
                            'Appointment Notes',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    color: ColorManager.kPrimaryColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w900),
                          ),
                          SizedBox(
                            height: Get.height * 0.02,
                          ),
                          const CustomTextField(
                            padding: EdgeInsets.all(AppPadding.p14),
                            maxlines: 3,
                            hintText: '',
                          ),
                          // SizedBox(
                          //   height: Get.height * 0.02,
                          // ),
                          // const Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //   children: [
                          //     PositionedButtonWidget(
                          //       bottom: 0,
                          //       icon: Icons.video_call_outlined,
                          //       alignment: Alignment.centerRight,
                          //       iconColor: Color(0xFFF21F61),
                          //       borderColor: Color(0xFFF21F61),
                          //       buttonText: 'Get Appointment',
                          //     ),
                          //     PositionedButtonWidget(
                          //       bottom: 0,
                          //       isImage: true,
                          //       imagePath: Images.clinic,
                          //       alignment: Alignment.centerLeft,
                          //       iconColor: Color(0xFF0B8AA0),
                          //       borderColor: Color(0xFF0B8AA0),
                          //       buttonText: 'Consult at Clinic',
                          //     ),
                          //   ],
                          // ),
                          SizedBox(
                            height: Get.height * 0.01,
                          ),
                          // CustomTextField(
                          //   hintText: BookAppointmentController.i.bookAppointmentMethod != null ? '${BookAppointmentController.i.bookAppointmentMethod?.name}' : "Payment Method",
                          //   readonly: true,
                          //   isSizedBoxAvailable: false,
                          //   suffixIcon: InkWell(
                          //       onTap: () {
                          //         paymentMethodDialogue(context);
                          //       },
                          //       child: Image.asset(Images.masterCard)),
                          // ),
                          Text(
                            'paymentMethod'.tr,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color: ColorManager.kPrimaryColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w900,
                                ),
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
                                      BookAppointmentController
                                                  .i.bookAppointmentMethod !=
                                              null
                                          ? '${BookAppointmentController.i.bookAppointmentMethod!.name}'
                                          : 'Payment Method',
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
                          PrimaryButton(
                              fontSize: 14,
                              title:
                                  widget.isHereFrombookedAppointments == false
                                      ? 'bookAppointment'.tr
                                      : 'reschedule'.tr,
                              onPressed: () async {
                                var patientId = await LocalDb().getPatientId();
                                bool? isLoggedIn =
                                    await LocalDb().getLoginStatus();
                                var branchID = await LocalDb().getBranchId();
                                if (isLoggedIn == true) {
                                  if (widget.isHereFrombookedAppointments ==
                                      false) {
                                    log(widget.model!.toJson().toString());
                                    SpecialitiesRepo.bookAppointment(
                                      widget.doctorId!,
                                      '$patientId',
                                      BookAppointmentController.i.formattedDate,
                                      "${BookAppointmentController.i.formattedDate.toString()} ${cont.startTime}",
                                      "${BookAppointmentController.i.formattedDate.toString()} ${cont.endTime}",
                                      widget.isOnline!,
                                      widget.workLocationId,
                                      SpecialitiesController
                                          .i.sessions[0].sessionId,
                                      branchID,
                                      appointmentnotes: 'I have a headache',
                                      actualPrice:
                                          widget.model!.actualFee.toString(),
                                    );
                                  } else {
                                    await ScheduleRepo.rescheduleDoctorAppointment(
                                        appointmentDisplayType: SpecialitiesController
                                                .i.appointmentslotdisplaytype ??
                                            widget.AppointmentSlotDisplayType!
                                                .toString(),
                                        slotTokenNumber: widget
                                            .list!.SlotTokenNumber!
                                            .toString(),
                                        isOnlineAppointment: widget.isOnline,
                                        appointmentId: widget.appointmentid,
                                        patientAppointmentId:
                                            widget.patientappointmentid!,
                                        doctorId: widget.doctor!.id!,
                                        bookDate: BookAppointmentController
                                            .i.formattedDate,
                                        workLocationId: widget.list!.WorkLocation
                                            .toString(),
                                        isOnlineConsultation:
                                            widget.list!.IsOnlineConsultation,
                                        startTime: BookAppointmentController
                                                    .i.formattedDate !=
                                                null
                                            ? '${BookAppointmentController.i.formattedDate.toString()} ${cont.startTime}'
                                            : widget.list?.StartTime,
                                        endTime: BookAppointmentController.i.formattedDate != null
                                            ? '${BookAppointmentController.i.formattedDate.toString()} ${cont.endTime}'
                                            : widget.list?.EndTime,
                                        sessionId: SpecialitiesController
                                                .i.sessions[0].sessionId ??
                                            widget.list!.SessionId);
                                  }
                                } else {
                                  await LocalDb.saveSearchDoctor(
                                      widget.doctor!);
                                  await LocalDb.saveAppointmentData(
                                      AppointmentDataModel(
                                    doctorId: widget.doctor!.id!,
                                    patientId: '$patientId',
                                    bookDate: BookAppointmentController
                                        .i.formattedDate,
                                    price: widget.model?.actualFee.toString(),
                                    startTime:
                                        "${BookAppointmentController.i.formattedDate.toString()} ${cont.startTime}",
                                    endTime:
                                        "${BookAppointmentController.i.formattedDate.toString()} ${cont.endTime}",
                                    isOnlineConsultation:
                                        widget.doctor!.isOnline!,
                                    workLocationId: widget.workLocationId,
                                    sessionId: SpecialitiesController
                                        .i.sessions[0].sessionId,
                                    branchId: branchID,
                                  ));
                                  Get.to(() => const LoginScreen(
                                        isBookDoctorAppointmentScreen: true,
                                        isLabInvestigationScreen: false,
                                        isHomeSampleScreen: false,
                                      ));
                                }
                              },
                              color: ColorManager.kPrimaryColor,
                              textcolor: ColorManager.kWhiteColor)
                        ],
                      ),
                    ),
                  );
                });
              })),
        ),
      );
    });
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
                  IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Image.asset(
                        Images.cross,
                        height: Get.height * 0.03,
                      ))
                ],
              ),
              content: SizedBox(
                width: double.maxFinite,
                child: ListView.builder(
                  itemCount: BookAppointmentController.i.paymentMethods.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final payment =
                        BookAppointmentController.i.paymentMethods[index];
                    return buildStyledContainer(
                        '${payment.name}', context, index, payment, false, () {
                      BookAppointmentController.i.updateSelectedIndex(index);
                      BookAppointmentController.i
                          .updateBookAppointmentPayment(payment);
                      Get.back();
                    });
                  },
                ),
              ),
            ),
          );
        });
  }

  buildStyledContainer(String text, BuildContext context, int index,
      PaymentMethod method, bool? hasMasterCardImage, Function()? onTap) {
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
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: ColorManager.kPrimaryColor,
                )),
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
                      '${containsFile(method.imagePath)}${method.imagePath}',
                  errorWidget: (context, url, error) {
                    return const SizedBox.shrink();
                  },
                )
                // Image.network(
              ],
            ),
          ),
        ),
      );
    });
  }
}

class CreditCardFormField extends StatelessWidget {
  const CreditCardFormField({
    super.key,
    this.controller,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
    this.validator,
  });

  final TextEditingController? controller;
  final String hintText;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      validator: validator,
      style: const TextStyle(
        color: ColorManager.kPrimaryColor,
        fontWeight: FontWeight.w900,
      ),
      decoration: InputDecoration(
        hintStyle: const TextStyle(
          fontWeight: FontWeight.w300,
          color: ColorManager.kblackColor,
          fontSize: 12,
        ),
        hintText: hintText,
        filled: true,
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: ColorManager.kPrimaryLightColor),
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: ColorManager.kPrimaryLightColor),
        ),
        fillColor: ColorManager.kPrimaryLightColor,
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: ColorManager.kPrimaryLightColor),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
