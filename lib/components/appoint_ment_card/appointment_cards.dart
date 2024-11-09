// ignore_for_file: non_constant_identifier_names, must_be_immutable

import 'dart:developer';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tabib_al_bait/components/images.dart';
import 'package:tabib_al_bait/components/primary_button.dart';
import 'package:tabib_al_bait/data/controller/lab_investigations_controller.dart';
import 'package:tabib_al_bait/data/repositories/schedule_repo/schedule_repo.dart';
import 'package:tabib_al_bait/helpers/color_manager.dart';
import 'package:tabib_al_bait/helpers/values_manager.dart';
import 'package:tabib_al_bait/main.dart';
import 'package:tabib_al_bait/models/UpComingLabInvestigation.dart';
import 'package:tabib_al_bait/models/UpcomingDiagnosticAppointment.dart';
import 'package:tabib_al_bait/models/appointment_request_response/appointment_request_response.dart';
import 'package:tabib_al_bait/models/search_models.dart';
import 'package:tabib_al_bait/screens/doctor_consultation_details/doctor_consultation_details.dart';
import 'package:tabib_al_bait/screens/imaging_screen/imaging_booking.dart';
import 'package:tabib_al_bait/screens/specialists_screen/doctor_schedule.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../data/controller/schedule_controller.dart';
import '../../data/controller/specialities_controller.dart';
import '../../models/DoctorConsultationAppointmentHistory.dart';

_callNumber(String? number) async {
  // const number = '03359305593'; //set the number here
  launchUrl(Uri.parse("tel://03359305593"));
}

textMe(String number) async {
  // Android
  if (Platform.isAndroid) {
    //FOR Android
    var url = 'sms:$number?body=message';
    await launch(url);
  } else if (Platform.isIOS) {
    //FOR IOS
    var url = 'sms:$number&body=message';
    await launch(url);
  }
}

class DoctorsAppointmentCards extends StatelessWidget {
  final bool? showRescheduleButton;
  final String statusText;
  final Color statusColor;
  final String name;
  final String date;
  final String time;
  final String type;
  final String rating;
  final bool showButtons;

  final DoctorConsultationAppointmentHistoryDataList? list;

  final void Function() onBookAgainPressed;
  final void Function() onLeaveReviewPressed;
  String? Address;
  String? firstButtonText;
  String? secondButtonText;
  String? Designation;

  DoctorsAppointmentCards(
      {Key? key,
      required this.statusText,
      required this.statusColor,
      required this.name,
      required this.date,
      required this.time,
      required this.type,
      required this.rating,
      required this.showButtons,
      required this.onBookAgainPressed,
      required this.onLeaveReviewPressed,
      this.Address,
      this.firstButtonText,
      this.secondButtonText,
      this.Designation,
      this.showRescheduleButton,
      this.list})
      : super(key: key);
  bool isOpen = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => ConsultationDetails(
              startTime: list?.StartTime,
              endTime: list?.EndTime,
              isPaid: list?.Status == 'Paid' ? true : false,
              isOnline: list?.IsOnlineAppointment,
              bookingDate: list?.BookingDate,
              bookingTime: list?.StartTime,
              doctor: Search(
                id: list?.DoctorId,
                name: list?.DoctorName,
                designation: list?.Designation,
                isOnline: list?.IsOnlineAppointment,
                picturePath: list?.ImagePath,
                location: list?.WorkLocation,
                consultancyFee: list?.ConsultancyFee,
                speciality: list?.Speciality,
              ),
            ));
      },
      child: Container(
        margin: const EdgeInsets.all(AppPadding.p4),
        padding: statusText == 'Pending'
            ? const EdgeInsets.all(AppPadding.p10)
            : const EdgeInsets.all(AppPadding.p10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: ColorManager.kPrimaryLightColor),
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: Get.height * 0.01,
                      ),
                      Flexible(
                        child: Container(
                          height: Get.height * 0.13,
                          width: Get.height * 0.13,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: ColorManager.kPrimaryColor,
                              width: 3,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: list?.ImagePath != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        '${containsFile(list?.ImagePath)}/${addImageIfNull(list!.DoctorId!)}',
                                    fit: BoxFit.cover,
                                    errorWidget: (context, url, error) =>
                                        Image.asset(
                                      Images.doctorAvatar,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: CachedNetworkImage(
                                    useOldImageOnUrlChange: true,
                                    imageUrl:
                                        '${containsFile(list?.ImagePath)}/${addImageIfNull(list!.DoctorId!)}',
                                    fit: BoxFit.cover,
                                    errorWidget: (context, url, error) =>
                                        Image.asset(
                                      Images.doctorAvatar,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      list?.Status != 'Cancelled'
                          ? Row(
                              children: [
                                if (list?.IsOnlineConsultation == true)
                                  Text(
                                    'consultnow'.tr,
                                    style: const TextStyle(
                                        color: Colors.orange,
                                        fontWeight: FontWeight.bold),
                                  )
                                else
                                  Text(
                                    'consultatclinic'.tr,
                                    style: const TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold),
                                  ),
                                SizedBox(
                                  width: Get.width * 0.05,
                                ),
                                if (list?.IsOnlineConsultation == true)
                                  const Icon(
                                    Icons.videocam_outlined,
                                    color: Colors.blue,
                                    size: 30,
                                  )
                                else
                                  const Icon(
                                    Icons.message_outlined,
                                    color: Colors.blue,
                                    size: 25,
                                  )
                              ],
                            )
                          : Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 2),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(
                                      width: 2, color: ColorManager.kRedColor)),
                              child: Text(
                                '${list?.Status}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10,
                                        color: ColorManager.kRedColor),
                              ),
                            ),
                      SizedBox(
                        width: Get.width * 0.5,
                        child: Text(
                          name,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  fontWeight: FontWeight.w900, fontSize: 12),
                        ),
                      ),
                      SizedBox(
                        width: Get.width * 0.4,
                        child: const Divider(),
                      ),
                      (list?.Speciality != null)
                          ? Text(
                              '${(list?.Speciality.toString())} ',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(fontSize: 10),
                            )
                          : const SizedBox.shrink(),
                      Row(
                        children: [
                          Text(
                            '$date ${ScheduleController.i.convertTimeFormat(time)}',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                    color: ColorManager.kblackColor,
                                    fontSize: 12),
                          ),
                          SizedBox(
                            width: Get.width * 0.01,
                          ),
                          const Icon(
                            Icons.star,
                            color: ColorManager.kyellowContainer,
                          ),
                          const Text('4.5')
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
            if (showButtons) ...[
              SizedBox(
                height: Get.height * 0.04,
              ),
              statusText == 'Completed'
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: Get.width * 0.02,
                        ),
                        Flexible(
                          child: PrimaryButton(
                              fontweight: FontWeight.bold,
                              radius: 5,
                              fontSize: 12,
                              height: Get.height * 0.05,
                              border:
                                  Border.all(color: ColorManager.kPrimaryColor),
                              title: ((firstButtonText == null)
                                  ? 'Book Again'
                                  : (firstButtonText.toString())),
                              onPressed: onBookAgainPressed,
                              color: ColorManager.kPrimaryLightColor,
                              textcolor: ColorManager.kPrimaryColor),
                        ),
                        SizedBox(
                          width: Get.width * 0.08,
                        ),
                        statusText == 'Completed'
                            ? Flexible(
                                child: PrimaryButton(
                                    radius: 5,
                                    fontSize: 12,
                                    height: Get.height * 0.05,
                                    border: Border.all(
                                        color: ColorManager.kPrimaryColor),
                                    title: ((secondButtonText == null)
                                        ? 'Book Again'
                                        : (secondButtonText.toString())),
                                    onPressed: onLeaveReviewPressed,
                                    color: ColorManager.kPrimaryColor,
                                    textcolor: ColorManager.kWhiteColor),
                              )
                            : const SizedBox.shrink(),
                        SizedBox(
                          width: Get.width * 0.02,
                        ),
                      ],
                    )
                  : const SizedBox.shrink()
            ],
            statusText == 'Pending' || statusText == 'Confirmed'
                ? SizedBox(
                    height: Get.height * 0.02,
                  )
                : const SizedBox.shrink(),
            statusText == 'Pending' || statusText == 'Confirmed'
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: Get.width * 0.02,
                      ),
                      Flexible(
                        child: PrimaryButton(
                            radius: 5,
                            fontSize: 12,
                            height: Get.height * 0.05,
                            border:
                                Border.all(color: ColorManager.kPrimaryColor),
                            title: ((secondButtonText == null)
                                ? 'reschedule'.tr
                                : (secondButtonText.toString())),
                            onPressed: () async {
                              await SpecialitiesController.i
                                  .getDateWiseDoctorSlots(
                                list!.DoctorId!,
                                list!.WorkLocationId.toString(),
                                list!.BookingDate!,
                                list!.IsOnlineAppointment!,
                              );
                              await SpecialitiesController.i
                                  .getDoctorWorkLocations(list?.DoctorId ?? "");
                              Get.to(() => DoctorSchedule(
                                    frombookedappointment: true,
                                    appointmentid: list?.Id ?? "",
                                    AppointmentSlotDisplayType: list
                                        ?.AppointmentSlotDisplayType
                                        .toString(),
                                    patientappointmentid:
                                        list?.PatientAppointmentId ?? "",
                                    reschedule: true,
                                    rescduledata: list,
                                    doctor: Search(
                                      picturePath:
                                          addImageIfNull(list!.DoctorId!),
                                      qualification: list!.Designation,
                                      isOnline: list?.IsOnlineAppointment,
                                      location: list!.WorkLocation,
                                      id: list!.DoctorId!,
                                      consultancyFee: list?.ConsultancyFee,
                                      speciality: list!.Speciality,
                                      locations: [
                                        Locations(
                                            name: list?.Address.toString(),
                                            cityName: list!.CityName)
                                      ],
                                      name: list?.DoctorName,
                                    ),
                                    title: list?.Speciality,
                                    // list: list,
                                    // isHereFrombookedAppointments: true,
                                    // doctorId: list!.DoctorId,
                                    // workLocationId: list!.WorkLocationId,
                                    // date: list!.BookingDate,
                                    // isOnline: list!.IsOnlineAppointment,
                                  ));
                            },
                            color: Colors.transparent,
                            textcolor: ColorManager.kPrimaryColor),
                      ),
                      SizedBox(
                        width: Get.width * 0.08,
                      ),
                      Flexible(
                        child: PrimaryButton(
                            fontweight: FontWeight.bold,
                            radius: 5,
                            fontSize: 12,
                            height: Get.height * 0.05,
                            border:
                                Border.all(color: ColorManager.kPrimaryColor),
                            title: ((firstButtonText == null)
                                ? 'cancel'.tr
                                : (firstButtonText.toString())),
                            onPressed: (() {
                              ScheduleRepo.cancelDoctorAppointment(
                                  list!.Id!, list!.PatientAppointmentId!);
                            }),
                            color: ColorManager.kPrimaryColor,
                            textcolor: ColorManager.kWhiteColor),
                      ),
                      SizedBox(
                        width: Get.width * 0.02,
                      ),
                    ],
                  )
                : const SizedBox.shrink(),
            SizedBox(height: Get.height * 0.01)
          ],
        ),
      ),
    );
  }
}

class LabInvestigationAppointmentCards extends StatefulWidget {
  final String statusText;
  final Color statusColor;
  final String name;
  final String date;
  final String time;
  final String type;
  final String rating;
  final String? firstButtonName;
  final String? secondButtonName;
  final String? address;
  final bool showButtons;
  final List<dynamic>? list;
  final bool? showReportStatusAtEnd;
  final bool? isCountingShown;
  final String? ReportStatus;
  final bool? isTestsListisInstanceofList;
  final UpComingLabIvestigationDataList? listData;
  final void Function() onBookAgainPressed;
  final void Function() onLeaveReviewPressed;

  const LabInvestigationAppointmentCards(
      {Key? key,
      required this.statusText,
      required this.statusColor,
      required this.name,
      required this.date,
      required this.time,
      required this.type,
      required this.rating,
      required this.showButtons,
      required this.onBookAgainPressed,
      required this.onLeaveReviewPressed,
      this.firstButtonName,
      this.secondButtonName,
      this.address,
      this.list,
      this.showReportStatusAtEnd,
      this.isCountingShown,
      this.ReportStatus,
      this.isTestsListisInstanceofList,
      this.listData})
      : super(key: key);

  @override
  State<LabInvestigationAppointmentCards> createState() =>
      _LabInvestigationAppointmentCardsState();
}

class _LabInvestigationAppointmentCardsState
    extends State<LabInvestigationAppointmentCards> {
  bool isListShown = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isListShown = !isListShown;
          log(isListShown.toString());
        });
      },
      child: Container(
        margin: const EdgeInsets.all(AppPadding.p4),
        padding: widget.statusText == 'Pending'
            ? const EdgeInsets.all(AppPadding.p16).copyWith(bottom: 0)
            : const EdgeInsets.all(AppPadding.p16).copyWith(bottom: 0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: ColorManager.kPrimaryLightColor),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                widget.listData?.PickupAddress == null ||
                        widget.listData?.PickupAddress == ''
                    ? Flexible(
                        flex: 3,
                        child: Container(
                          height: Get.height * 0.13,
                          width: Get.height * 0.13,
                          decoration: BoxDecoration(
                            color: ColorManager.kyellowContainer,
                            borderRadius: BorderRadius.circular(10),
                            image: const DecorationImage(
                              image: AssetImage(Images.microscope),
                              fit: BoxFit.fitHeight,
                              alignment: Alignment.center,
                            ),
                          ),
                        ),
                      )
                    : Flexible(
                        flex: 3,
                        child: Container(
                          height: Get.height * 0.13,
                          width: Get.height * 0.13,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10),
                            image: const DecorationImage(
                              image: AssetImage(Images.home),
                              fit: BoxFit.fitHeight,
                              alignment: Alignment.center,
                            ),
                          ),
                        ),
                      ),
                SizedBox(
                  width: Get.width * 0.02,
                ),
                Flexible(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            widget.listData?.PickupAddress == null ||
                                    widget.listData?.PickupAddress == ''
                                ? Text(
                                    widget.statusText,
                                    style: const TextStyle(
                                      color: Colors.orange,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  )
                                : Text(
                                    widget.statusText,
                                    style: const TextStyle(
                                      color: Colors.orange,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                            widget.listData?.PickupAddress == null ||
                                    widget.listData?.PickupAddress == ''
                                ? const SizedBox.shrink()
                                : Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          textMe('+923359305593');
                                        },
                                        child: const Icon(
                                          Icons.message_outlined,
                                          color: Colors.blue,
                                          size: 20,
                                        ),
                                      ),
                                      SizedBox(
                                        width: Get.width * 0.01,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          _callNumber("+923359305593");
                                        },
                                        child: const Icon(
                                          Icons.phone_outlined,
                                          color: Colors.blue,
                                          size: 20,
                                        ),
                                      ),
                                    ],
                                  )
                          ],
                        ),
                      ),
                      widget.listData?.PickupAddress == null ||
                              widget.listData?.PickupAddress == ''
                          ? widget.listData?.LabName != null
                              ? Text(
                                  widget.listData?.LabName ?? "",
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                )
                              : const SizedBox.shrink()
                          : const SizedBox.shrink(),
                      const Divider(
                        color: Colors.grey,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          widget.listData?.PickupAddress == null ||
                                  widget.listData?.PickupAddress == ''
                              ? Text(
                                  "labInvestions".tr,
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                  ),
                                )
                              : Text(
                                  "homesampling".tr,
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                  ),
                                ),
                          const Spacer(
                            flex: 2,
                          ),
                          const SizedBox(
                            height: 2,
                            width: 3,
                          ),
                          widget.listData?.PickupAddress == null ||
                                  widget.listData?.PickupAddress == ''
                              ? const Icon(
                                  Icons.location_on_sharp,
                                  color: Colors.blue,
                                )
                              : const SizedBox.shrink(),
                          widget.listData?.PickupAddress == null ||
                                  widget.listData?.PickupAddress == ''
                              ? const Icon(
                                  Icons.star,
                                  color: Color.fromARGB(255, 255, 230, 0),
                                )
                              : const SizedBox.shrink(),
                          widget.listData?.PickupAddress == null ||
                                  widget.listData?.PickupAddress == ''
                              ? Text(widget.rating)
                              : const SizedBox.shrink(),
                        ],
                      ),
                      GetBuilder<ScheduleController>(builder: (cont) {
                        return SizedBox(
                          // width: Get.width * 0.5,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${widget.listData?.Date?.split('T').first}",
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                " | ${"${widget.listData?.Time?.split(":")[0]}:${widget.listData?.Time?.split(":")[1]}"}",
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                ),
                              ),
                              const Spacer(),
                              // SizedBox(
                              //   width: Get.width * 0.15,
                              // ),
                              isListShown == true
                                  ? Image.asset(
                                      Images.dropdownIcon,
                                      height: 12,
                                    )
                                  : Image.asset(
                                      Images.dropdownIconDown,
                                      height: 12,
                                    )
                            ],
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ],
            ),
            isListShown == false
                ? SizedBox(
                    height: Get.height * 0.02,
                  )
                : const SizedBox.shrink(),
            isListShown == true
                ? const Divider(
                    color: Colors.grey,
                  )
                : const SizedBox.shrink(),
            isListShown == true
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "test".tr,
                        style: const TextStyle(
                            fontSize: 12,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Text(
                            "prescribedBy".tr,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 12,
                                overflow: TextOverflow.ellipsis,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            ": ${widget.listData?.PrescribedBy ?? ""}",
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 12,
                                overflow: TextOverflow.ellipsis,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  )
                : const SizedBox.shrink(),
            isListShown == true
                ? ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: widget.listData?.LabTests?.length,
                    itemBuilder: (context, index) {
                      final test = widget.listData?.LabTests?[index];
                      // log(test.toJson().toString());
                      if (test != null) {
                        if (test.toString().contains('Instance')) {
                          return SizedBox(
                            child: Text(
                              test.toJson()['Name'].toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                      color: ColorManager.kPrimaryColor,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500),
                            ),
                          );
                        }
                        return SizedBox(
                          width: Get.width * 0.5,
                          child: Text(
                            test,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    color: ColorManager.kPrimaryColor,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500),
                          ),
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    })
                : const SizedBox.shrink(),
            if (widget.showButtons) ...[
              widget.statusText == 'Completed'
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: Get.width * 0.02,
                        ),
                        Flexible(
                          child: PrimaryButton(
                              fontweight: FontWeight.bold,
                              radius: 5,
                              fontSize: 12,
                              height: Get.height * 0.05,
                              border:
                                  Border.all(color: ColorManager.kPrimaryColor),
                              title: ((widget.firstButtonName == null)
                                  ? 'Book Again'
                                  : (widget.firstButtonName.toString())),
                              onPressed: widget.onBookAgainPressed,
                              color: ColorManager.kPrimaryLightColor,
                              textcolor: ColorManager.kPrimaryColor),
                        ),
                        SizedBox(
                          width: Get.width * 0.08,
                        ),
                        widget.statusText == 'Completed'
                            ? Flexible(
                                child: PrimaryButton(
                                    radius: 5,
                                    fontSize: 12,
                                    height: Get.height * 0.05,
                                    border: Border.all(
                                        color: ColorManager.kPrimaryColor),
                                    title: ((widget.secondButtonName == null)
                                        ? 'Book Again'
                                        : (widget.secondButtonName.toString())),
                                    onPressed: widget.onLeaveReviewPressed,
                                    color: ColorManager.kPrimaryColor,
                                    textcolor: ColorManager.kWhiteColor),
                              )
                            : const SizedBox.shrink(),
                        SizedBox(
                          width: Get.width * 0.02,
                        ),
                      ],
                    )
                  : const SizedBox.shrink()
            ],
            // isListShown == true
            //     ? SizedBox(
            //         height: Get.height * 0.02,
            //       )
            //     : const SizedBox.shrink(),
            SizedBox(
              height: Get.height * 0.01,
            ),
            widget.listData?.Status == "Pending Payment"
                ? Column(
                    children: [
                      widget.statusText != "Cancelled"
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: Get.width * 0.02,
                                ),
                                Flexible(
                                  child: PrimaryButton(
                                      radius: 5,
                                      fontSize: 12,
                                      height: Get.height * 0.05,
                                      border: Border.all(
                                          color: ColorManager.kPrimaryColor),
                                      title: ((widget.firstButtonName == null)
                                          ? 'reschedule'.tr
                                          : (widget.firstButtonName
                                              .toString())),
                                      onPressed: () async {
                                        await showDialog(
                                            barrierDismissible: false,
                                            context: context,
                                            builder: (BuildContext context) {
                                              return FractionallySizedBox(
                                                child: Dialog(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.0)), //this right here
                                                  child: SizedBox(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              AppPadding.p20),
                                                      child: GetBuilder<
                                                              LabInvestigationController>(
                                                          builder: (cnt) {
                                                        return Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            Text(
                                                              "selectdatetime"
                                                                  .tr,
                                                              style: GoogleFonts.poppins(
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                            const Divider(
                                                              thickness: 2,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                            Container(
                                                              height:
                                                                  Get.height *
                                                                      0.13,
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8),
                                                                  color: ColorManager
                                                                      .kPrimaryLightColor),
                                                              child: DatePicker(
                                                                DateTime.now(),
                                                                dateTextStyle: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyMedium!
                                                                    .copyWith(
                                                                        color: ColorManager
                                                                            .kPrimaryColor,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w900,
                                                                        fontSize:
                                                                            12),
                                                                dayTextStyle: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyMedium!
                                                                    .copyWith(
                                                                        color: ColorManager
                                                                            .kPrimaryColor,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w900,
                                                                        fontSize:
                                                                            12),
                                                                monthTextStyle: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyMedium!
                                                                    .copyWith(
                                                                        color: ColorManager
                                                                            .kPrimaryColor,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w300,
                                                                        fontSize:
                                                                            12),
                                                                deactivatedColor:
                                                                    ColorManager
                                                                        .kPrimaryLightColor,
                                                                // height: Get.height * 0.14,
                                                                initialSelectedDate:
                                                                    DateTime
                                                                        .now(),
                                                                selectionColor:
                                                                    ColorManager
                                                                        .kPrimaryColor,
                                                                selectedTextColor:
                                                                    Colors
                                                                        .white,
                                                                onDateChange:
                                                                    (date) {
                                                                  rescheduledate = date
                                                                      .toString()
                                                                      .split(
                                                                          ' ')[0];
                                                                },
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height:
                                                                  Get.height *
                                                                      0.02,
                                                            ),
                                                            InkWell(
                                                                onTap: () {
                                                                  LabInvestigationController.i.selectTime(
                                                                      context,
                                                                      LabInvestigationController
                                                                          .selectedTime,
                                                                      LabInvestigationController
                                                                          .i
                                                                          .formattedSelectedTime);
                                                                },
                                                                child:
                                                                    Container(
                                                                  width:
                                                                      Get.width,
                                                                  padding: const EdgeInsets
                                                                      .all(
                                                                      AppPadding
                                                                          .p14),
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10),
                                                                      color: ColorManager
                                                                          .kPrimaryLightColor),
                                                                  child: Text(
                                                                    LabInvestigationController
                                                                            .i
                                                                            .formattedSelectedTime ??
                                                                        "selecttime"
                                                                            .tr,
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .bodySmall!
                                                                        .copyWith(
                                                                            color:
                                                                                ColorManager.kPrimaryColor,
                                                                            fontWeight: FontWeight.w900),
                                                                  ),
                                                                )),
                                                            SizedBox(
                                                              height:
                                                                  Get.height *
                                                                      0.02,
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
                                                                  child: ElevatedButton(
                                                                      style: ButtonStyle(shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)))),
                                                                      child: Text("reschedule".tr),
                                                                      onPressed: () async {
                                                                        ScheduleRepo().rescheduleLabAppointment(
                                                                            context:
                                                                                context,
                                                                            formatteddt:
                                                                                rescheduledate,
                                                                            labID: widget.listData?.LabId ??
                                                                                "",
                                                                            labNO:
                                                                                widget.listData?.LabNO,
                                                                            packageGroupDiscountRate: widget.listData?.PackageGroupDiscountRate,
                                                                            packageGroupDiscountType: widget.listData?.PackageGroupDiscountType,
                                                                            packageGroupId: widget.listData?.PackageGroupName,
                                                                            packageGroupName: widget.listData?.PackageGroupName,
                                                                            time: LabInvestigationController.i.formattedSelectedTime);
                                                                        SchedulerBinding
                                                                            .instance
                                                                            .addPostFrameCallback((_) {
                                                                          Get.back();
                                                                        });
                                                                      }),
                                                                ),
                                                                SizedBox(
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.3,
                                                                  child: ElevatedButton(
                                                                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white), shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)))),
                                                                      child: Text(
                                                                        "cancel"
                                                                            .tr,
                                                                        style: GoogleFonts.poppins(
                                                                            color:
                                                                                Colors.black),
                                                                      ),
                                                                      onPressed: () {
                                                                        Get.back();
                                                                      }),
                                                                )
                                                              ],
                                                            )
                                                          ],
                                                        );
                                                      }),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            });
                                        // await SpecialitiesController.i
                                        //     .getDateWiseDoctorSlots(
                                        //   // list!.DoctorId!,
                                        //   // list!.WorkLocationId.toString(),
                                        //   // list!.BookingDate!,
                                        //   // list!.IsOnlineAppointment!,
                                        // )

                                        // Get.to(() => AppointmentCreation(
                                        //     doctor: Search(
                                        //         // qualification: list!.Designation,
                                        //         // isOnline: list?.IsOnlineAppointment,
                                        //         // location: list!.WorkLocation,
                                        //         // id: list!.DoctorId!,
                                        //         // consultancyFee: list?.ConsultancyFee,
                                        //         // speciality: list!.Speciality,
                                        //         // locations: [
                                        //         //   Locations(
                                        //         //       name: list?.Address.toString(),
                                        //         //       cityName: list!.CityName)
                                        //         // ],
                                        //         //     name: list?.DoctorName),
                                        //         // list: list,
                                        //         // isHereFrombookedAppointments: true,
                                        //         // doctorId: list!.DoctorId,
                                        //         // workLocationId: list!.WorkLocationId,
                                        //         // date: list!.BookingDate,
                                        //         // isOnline: list!.IsOnlineAppointment,
                                        //         )));
                                      },
                                      color: Colors.transparent,
                                      textcolor: ColorManager.kPrimaryColor),
                                ),
                                SizedBox(
                                  width: Get.width * 0.08,
                                ),
                                Flexible(
                                  child: PrimaryButton(
                                      fontweight: FontWeight.bold,
                                      radius: 5,
                                      fontSize: 12,
                                      height: Get.height * 0.05,
                                      border: Border.all(
                                          color: ColorManager.kPrimaryColor),
                                      title: ((widget.secondButtonName == null)
                                          ? 'cancel'.tr
                                          : (widget.secondButtonName
                                              .toString())),
                                      onPressed: (() async {
                                        await ScheduleRepo.cancelLabAppointment(
                                            context: context,
                                            labChallanNumber:
                                                widget.listData?.LabNO,
                                            labId: widget.listData?.LabId);
                                        // ScheduleController.i.clearData();
                                      }),
                                      color: ColorManager.kPrimaryColor,
                                      textcolor: ColorManager.kWhiteColor),
                                ),
                                // SizedBox(
                                //   width: Get.width * 0.02,
                                // ),
                              ],
                            )
                          : const SizedBox.shrink(),
                      // widget.listData?.Status == "Pending Payment" ||
                      //         widget.listData?.Status == "Requested"
                      isListShown == true || widget.listData?.Status != null
                          ? SizedBox(height: Get.height * 0.02)
                          : widget.statusText == "Completed"
                              ? SizedBox(
                                  height: Get.height * 0.02,
                                )
                              : const SizedBox.shrink()
                      // const SizedBox.shrink()
                    ],
                  )
                : const SizedBox.shrink(),
            // widget.statusText != "Cancelled"
            //     ? SizedBox(
            //         height: Get.height * 0.02,
            //       )
            //     : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }

  String? rescheduledate;
}

class ServicesAppointmentsCards extends StatefulWidget {
  // final String statusText;
  // final Color statusColor;
  // final String name;
  // final String date;
  // final String time;
  // final String type;
  // final String rating;
  final String? firstButtonName;
  final String? secondButtonName;
  final String? address;
  final bool showButtons;
  final List<dynamic>? list;
  final bool? showReportStatusAtEnd;
  final bool? isCountingShown;
  final String? ReportStatus;
  final AppointmentsList? listData;
  final void Function() onBookAgainPressed;
  final void Function() onLeaveReviewPressed;

  const ServicesAppointmentsCards(
      {Key? key,
      required this.showButtons,
      required this.onBookAgainPressed,
      required this.onLeaveReviewPressed,
      this.firstButtonName,
      this.secondButtonName,
      this.address,
      this.list,
      this.showReportStatusAtEnd,
      this.isCountingShown,
      this.ReportStatus,
      this.listData})
      : super(key: key);

  @override
  State<ServicesAppointmentsCards> createState() =>
      _ServicesAppointmentsCardsState();
}

class _ServicesAppointmentsCardsState extends State<ServicesAppointmentsCards> {
  String? rescheduledate;
  bool isListShown = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(2),
      padding: const EdgeInsets.all(AppPadding.p20).copyWith(),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: ColorManager.kPrimaryLightColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Flexible(
                flex: 2,
                child: Container(
                  height: Get.height * 0.12,
                  width: Get.width * 0.27,
                  decoration: BoxDecoration(
                    color: ColorManager.kPrimaryColor,
                    borderRadius: BorderRadius.circular(10),
                    image: const DecorationImage(
                      image: AssetImage(Images.services),
                      fit: BoxFit.contain,
                      alignment: Alignment.center,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: Get.width * 0.02,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: Get.width * 0.3,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'homeServices'.tr,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                  color: ColorManager.kPrimaryColor,
                                  fontWeight: FontWeight.w900),
                        )
                        // const Spacer(),
                      ],
                    ),
                  ),
                  widget.listData!.statusType! != null
                      ? Text(
                          '${ScheduleController.i.selectedTab == 'OverDue' ? widget.listData?.appointmentStatus : widget.listData?.status}',
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w900,
                            color: Colors.black,
                          ),
                        )
                      : const SizedBox.shrink(),
                  SizedBox(
                    width: Get.width * 0.5,
                    child: const Divider(
                      color: Colors.grey,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: Get.width * 0.5,
                        child: Text(
                          "${widget.listData?.labTest?.trim()}",
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 11,
                          ),
                        ),
                      ),
                      // ignore: unnecessary_null_comparison
                      widget.listData!.appointmentStatus! == null
                          ? const Icon(
                              Icons.location_on_sharp,
                              color: Colors.blue,
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                  GetBuilder<ScheduleController>(builder: (cont) {
                    return SizedBox(
                      width: Get.width * 0.5,
                      child: Row(
                        children: [
                          Text(
                            "${widget.listData?.bookingDate?.split('T').first}",
                            style: const TextStyle(
                                fontSize: 11,
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            " | ${"${widget.listData?.time?.split(":")[0]}:${widget.listData?.time?.split(":")[1]} ${amOrPm('${widget.listData?.time?.split(":")[0]}')}"}",
                            style: const TextStyle(
                                fontSize: 11,
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
                          const Spacer(),
                          const Icon(
                            Icons.star,
                            color: ColorManager.kyellowContainer,
                          ),
                          const Text('4.5')
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ],
          ),

          // SizedBox(
          //   height: Get.height * 0.02,
          // ),
          // const Divider(
          //   color: Colors.grey,
          // ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     const Text(
          //       "Test",
          //       style: TextStyle(
          //           fontSize: 12,
          //           color: Colors.blue,
          //           fontWeight: FontWeight.bold),
          //     ),
          //     Text(
          //       "Prescribed By: ${widget.listData?.prescribedBy ?? ""}",
          //       overflow: TextOverflow.ellipsis,
          //       style: const TextStyle(
          //           fontSize: 12,
          //           overflow: TextOverflow.ellipsis,
          //           color: Colors.blue,
          //           fontWeight: FontWeight.bold),
          //     ),
          //   ],
          // ),

          if (widget.showButtons) ...[
            widget.ReportStatus == 'Completed'
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: Get.width * 0.02,
                      ),
                      Flexible(
                        child: PrimaryButton(
                            fontweight: FontWeight.bold,
                            radius: 5,
                            fontSize: 12,
                            height: Get.height * 0.05,
                            border:
                                Border.all(color: ColorManager.kPrimaryColor),
                            title: ((widget.firstButtonName == null)
                                ? 'Book Again'
                                : (widget.firstButtonName.toString())),
                            onPressed: widget.onBookAgainPressed,
                            color: ColorManager.kPrimaryLightColor,
                            textcolor: ColorManager.kPrimaryColor),
                      ),
                      SizedBox(
                        width: Get.width * 0.08,
                      ),
                      widget.ReportStatus == 'Completed'
                          ? Flexible(
                              child: PrimaryButton(
                                  radius: 5,
                                  fontSize: 12,
                                  height: Get.height * 0.05,
                                  border: Border.all(
                                      color: ColorManager.kPrimaryColor),
                                  title: ((widget.secondButtonName == null)
                                      ? 'Book Again'
                                      : (widget.secondButtonName.toString())),
                                  onPressed: widget.onLeaveReviewPressed,
                                  color: ColorManager.kPrimaryColor,
                                  textcolor: ColorManager.kWhiteColor),
                            )
                          : const SizedBox.shrink(),
                      SizedBox(
                        width: Get.width * 0.02,
                      ),
                    ],
                  )
                : const SizedBox.shrink()
          ],
          widget.listData?.statusValue != 5
              ? SizedBox(
                  height: Get.height * 0.02,
                )
              : const SizedBox.shrink(),

          widget.listData?.appointmentStatus == "Upcomming" &&
                  widget.listData?.providerId == null
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // SizedBox(
                    //   width: Get.width * 0.02,
                    // ),
                    widget.listData?.statusValue != 5
                        ? Flexible(
                            child: PrimaryButton(
                                radius: 5,
                                fontSize: 12,
                                width: Get.width,
                                height: Get.height * 0.05,
                                border: Border.all(
                                    color: ColorManager.kPrimaryColor),
                                title: ((widget.firstButtonName == null)
                                    ? 'reschedule'.tr
                                    : (widget.firstButtonName.toString())),
                                onPressed: () async {
                                  await showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (BuildContext context) {
                                        return FractionallySizedBox(
                                          child: Dialog(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        20.0)), //this right here
                                            child: SizedBox(
                                              child: Padding(
                                                padding: const EdgeInsets.all(
                                                    AppPadding.p20),
                                                child: GetBuilder<
                                                        LabInvestigationController>(
                                                    builder: (cnt) {
                                                  return Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        "selectdatetime".tr,
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
                                                      Container(
                                                        height:
                                                            Get.height * 0.12,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                            color: ColorManager
                                                                .kPrimaryLightColor),
                                                        child: DatePicker(
                                                          DateTime.now(),
                                                          dateTextStyle: Theme
                                                                  .of(context)
                                                              .textTheme
                                                              .bodyMedium!
                                                              .copyWith(
                                                                  color: ColorManager
                                                                      .kPrimaryColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w900,
                                                                  fontSize: 12),
                                                          dayTextStyle: Theme
                                                                  .of(context)
                                                              .textTheme
                                                              .bodyMedium!
                                                              .copyWith(
                                                                  color: ColorManager
                                                                      .kPrimaryColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w900,
                                                                  fontSize: 12),
                                                          monthTextStyle: Theme
                                                                  .of(context)
                                                              .textTheme
                                                              .bodyMedium!
                                                              .copyWith(
                                                                  color: ColorManager
                                                                      .kPrimaryColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w300,
                                                                  fontSize: 12),
                                                          deactivatedColor:
                                                              ColorManager
                                                                  .kPrimaryLightColor,
                                                          // height: Get.height * 0.14,
                                                          initialSelectedDate:
                                                              DateTime.now(),
                                                          selectionColor:
                                                              ColorManager
                                                                  .kPrimaryColor,
                                                          selectedTextColor:
                                                              Colors.white,
                                                          onDateChange: (date) {
                                                            rescheduledate =
                                                                date
                                                                    .toString()
                                                                    .split(
                                                                        ' ')[0];
                                                          },
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height:
                                                            Get.height * 0.02,
                                                      ),
                                                      InkWell(
                                                          onTap: () {
                                                            LabInvestigationController.i.selectTime(
                                                                context,
                                                                LabInvestigationController
                                                                    .selectedTime,
                                                                LabInvestigationController
                                                                    .i
                                                                    .formattedSelectedTime);
                                                          },
                                                          child: Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(
                                                                    AppPadding
                                                                        .p10),
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                color: ColorManager
                                                                    .kPrimaryLightColor),
                                                            width: Get.width,
                                                            child: Text(
                                                              LabInvestigationController
                                                                      .i
                                                                      .formattedSelectedTime ??
                                                                  "selecttime"
                                                                      .tr,
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodySmall
                                                                  ?.copyWith(
                                                                      color: ColorManager
                                                                          .kPrimaryColor,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                            ),
                                                          )),
                                                      SizedBox(
                                                        height:
                                                            Get.height * 0.02,
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
                                                                        "reschedule"
                                                                            .tr),
                                                                    onPressed:
                                                                        () async {
                                                                      await ScheduleRepo().rescheduleLabAppointment(
                                                                          context:
                                                                              context,
                                                                          formatteddt:
                                                                              rescheduledate,
                                                                          labID: widget.listData?.labId ??
                                                                              "",
                                                                          labNO: widget
                                                                              .listData
                                                                              ?.labNo,
                                                                          packageGroupDiscountRate: widget
                                                                              .listData
                                                                              ?.packageGroupDiscountRate
                                                                              .toString(),
                                                                          packageGroupDiscountType: widget
                                                                              .listData
                                                                              ?.packageGroupDiscountType
                                                                              .toString(),
                                                                          packageGroupId: widget
                                                                              .listData
                                                                              ?.packageGroupName,
                                                                          packageGroupName: widget
                                                                              .listData
                                                                              ?.packageGroupName,
                                                                          time: LabInvestigationController
                                                                              .i
                                                                              .formattedSelectedTime);
                                                                      Get.back();
                                                                      setState(
                                                                          () {});
                                                                      ScheduleController
                                                                          .i
                                                                          .clearData();

                                                                      ScheduleController
                                                                          .i
                                                                          .getAppointmentsList(
                                                                              '');
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
                                                                      "cancel"
                                                                          .tr,
                                                                      style: GoogleFonts.poppins(
                                                                          color:
                                                                              Colors.black),
                                                                    ),
                                                                    onPressed:
                                                                        () {
                                                                      Get.back();
                                                                    }),
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  );
                                                }),
                                              ),
                                            ),
                                          ),
                                        );
                                      });
                                  // await SpecialitiesController.i
                                  //     .getDateWiseDoctorSlots(
                                  //   // list!.DoctorId!,
                                  //   // list!.WorkLocationId.toString(),
                                  //   // list!.BookingDate!,
                                  //   // list!.IsOnlineAppointment!,
                                  // )

                                  // Get.to(() => AppointmentCreation(
                                  //     doctor: Search(
                                  //         // qualification: list!.Designation,
                                  //         // isOnline: list?.IsOnlineAppointment,
                                  //         // location: list!.WorkLocation,
                                  //         // id: list!.DoctorId!,
                                  //         // consultancyFee: list?.ConsultancyFee,
                                  //         // speciality: list!.Speciality,
                                  //         // locations: [
                                  //         //   Locations(
                                  //         //       name: list?.Address.toString(),
                                  //         //       cityName: list!.CityName)
                                  //         // ],
                                  //         //     name: list?.DoctorName),
                                  //         // list: list,
                                  //         // isHereFrombookedAppointments: true,
                                  //         // doctorId: list!.DoctorId,
                                  //         // workLocationId: list!.WorkLocationId,
                                  //         // date: list!.BookingDate,
                                  //         // isOnline: list!.IsOnlineAppointment,
                                  //         )));
                                },
                                color: Colors.transparent,
                                textcolor: ColorManager.kPrimaryColor),
                          )
                        : const SizedBox.shrink(),
                    widget.listData?.statusValue != 5
                        ? SizedBox(
                            width: Get.width * 0.08,
                          )
                        : const SizedBox.shrink(),
                    widget.listData?.statusValue != 5
                        ? Flexible(
                            child: PrimaryButton(
                                fontweight: FontWeight.bold,
                                radius: 5,
                                fontSize: 12,
                                height: Get.height * 0.05,
                                border: Border.all(
                                    color: ColorManager.kPrimaryColor),
                                title: ((widget.secondButtonName == null)
                                    ? 'cancel'.tr
                                    : (widget.secondButtonName.toString())),
                                onPressed: (() async {
                                  int status =
                                      await ScheduleRepo.cancelLabAppointment(
                                          context: context,
                                          labChallanNumber:
                                              widget.listData?.labNo,
                                          labId: widget.listData?.labId);
                                  if (status == 1) {
                                    ScheduleController.i
                                        .removehomeservices(widget.listData!);
                                  }
                                  // ScheduleController.i.clearData();
                                }),
                                color: ColorManager.kPrimaryColor,
                                textcolor: ColorManager.kWhiteColor),
                          )
                        : const SizedBox.shrink(),
                    SizedBox(
                      width: Get.width * 0.02,
                    ),
                  ],
                )
              : const SizedBox.shrink(),
          // SizedBox(height: Get.height * 0.02)
        ],
      ),
    );
    // } else {
    //   return const SizedBox.shrink();
    // }
  }
}

String? addImageIfNull(String id) {
  Search? doctor = SpecialitiesController.i.allDoctors
      .firstWhereOrNull((element) => element.id == id);
  return doctor?.picturePath;
}

class ImaginBookingCard extends StatefulWidget {
  final String statusText;
  final Color statusColor;
  final String name;
  final String date;
  final String time;
  final String type;
  final String rating;
  final String? firstButtonName;
  final String? secondButtonName;
  final String? address;
  final bool showButtons;
  final List<dynamic>? list;
  final bool? showReportStatusAtEnd;
  final bool? isCountingShown;
  final String? ReportStatus;
  final bool? isTestsListisInstanceofList;
  final DiagnositicAppointmentListData? listData;
  final void Function() onBookAgainPressed;
  final void Function() onLeaveReviewPressed;

  const ImaginBookingCard(
      {Key? key,
      required this.statusText,
      required this.statusColor,
      required this.name,
      required this.date,
      required this.time,
      required this.type,
      required this.rating,
      required this.showButtons,
      required this.onBookAgainPressed,
      required this.onLeaveReviewPressed,
      this.firstButtonName,
      this.secondButtonName,
      this.address,
      this.list,
      this.showReportStatusAtEnd,
      this.isCountingShown,
      this.ReportStatus,
      this.isTestsListisInstanceofList,
      this.listData})
      : super(key: key);

  @override
  State<ImaginBookingCard> createState() => _ImaginBookingCardState();
}

class _ImaginBookingCardState extends State<ImaginBookingCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.all(AppPadding.p4),
        padding: widget.statusText == 'Pending'
            ? const EdgeInsets.all(AppPadding.p16).copyWith(bottom: 10)
            : const EdgeInsets.all(AppPadding.p16).copyWith(bottom: 0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: ColorManager.kPrimaryLightColor),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Flexible(
                  flex: 2,
                  child: Container(
                    height: Get.height * 0.13,
                    width: Get.height * 0.13,
                    decoration: BoxDecoration(
                      color: ColorManager.kCyanBlue,
                      borderRadius: BorderRadius.circular(10),
                      image: const DecorationImage(
                        image: AssetImage(
                          Images.imaging,
                        ),
                        alignment: Alignment.center,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: Get.width * 0.02,
                ),
                Flexible(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: Get.width * 0.6,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            widget.listData?.Status != null
                                ? Text(
                                    "${widget.listData?.Status}",
                                    style: const TextStyle(
                                      color: Colors.orange,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  )
                                : Text(
                                    widget.statusText,
                                    style: const TextStyle(
                                      color: Colors.orange,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                            const Spacer(),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${widget.listData?.DiagnosticCenter}',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    color: ColorManager.kblackColor,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 12),
                          ),
                          const Icon(Icons.pin_drop_outlined)
                        ],
                      ),
                      // widget.listData?.PickupAddress == null ||
                      //         widget.listData?.PickupAddress == ''
                      //     ? widget.listData?.LabName != null
                      //         ? Text(
                      //             widget.listData?.LabName ?? "",
                      //             textAlign: TextAlign.start,
                      //             style: const TextStyle(
                      //               fontSize: 12,
                      //               fontWeight: FontWeight.bold,
                      //               color: Colors.black,
                      //             ),
                      //           )
                      //         : const SizedBox.shrink()
                      //     : const SizedBox.shrink(),
                      SizedBox(
                        width: Get.width * 0.6,
                        child: const Divider(
                          color: Colors.grey,
                        ),
                      ),

                      // Row(
                      //   children: [
                      //     widget.listData?.PickupAddress == null ||
                      //             widget.listData?.PickupAddress == ''
                      //         ? Text(
                      //             "labInvestions".tr,
                      //             textAlign: TextAlign.start,
                      //             style: const TextStyle(
                      //               color: Colors.black,
                      //               fontSize: 12,
                      //             ),
                      //           )
                      //         : Text(
                      //             "homesampling".tr,
                      //             textAlign: TextAlign.start,
                      //             style: const TextStyle(
                      //               color: Colors.black,
                      //               fontSize: 12,
                      //             ),
                      //           ),
                      //     SizedBox(
                      //       width: Get.width * 0.12,
                      //     ),
                      //     widget.listData?.PickupAddress == null ||
                      //             widget.listData?.PickupAddress == ''
                      //         ? const Icon(
                      //             Icons.location_on_sharp,
                      //             color: Colors.blue,
                      //           )
                      //         : const SizedBox.shrink(),
                      //     widget.listData?.PickupAddress == null ||
                      //             widget.listData?.PickupAddress == ''
                      //         ? const Icon(
                      //             Icons.star,
                      //             color: Color.fromARGB(255, 255, 230, 0),
                      //           )
                      //         : const SizedBox.shrink(),
                      //     widget.listData?.PickupAddress == null ||
                      //             widget.listData?.PickupAddress == ''
                      //         ? Text(widget.rating)
                      //         : const SizedBox.shrink(),
                      //   ],
                      // ),

                      GetBuilder<ScheduleController>(builder: (cont) {
                        return SizedBox(
                          width: Get.width * 0.5,
                          child: Row(
                            children: [
                              Text(
                                "${widget.listData?.AppointmentDate?.split('T').first}",
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                " | ${"${widget.listData?.BookingTime?.split(":")[0]}:${widget.listData?.BookingTime?.split(":")[1]}"}",
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(
                                width: Get.width * 0.15,
                              ),
                            ],
                          ),
                        );
                      }),
                      Text(
                        '${widget.listData?.DiagnosticName}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: ColorManager.kPrimaryColor,
                            fontWeight: FontWeight.w900,
                            fontSize: 12),
                      )
                    ],
                  ),
                ),
              ],
            ),
            // SizedBox(
            //   height: Get.height * 0.02,
            // ),

            // isListShown == true
            //     ? ListView.builder(
            //         physics: const NeverScrollableScrollPhysics(),
            //         shrinkWrap: true,
            //         itemCount: widget.listData?.LabTests?.length,
            //         itemBuilder: (context, index) {
            //           final test = widget.listData?.LabTests?[index];
            //           // log(test.toJson().toString());
            //           if (test != null) {
            //             if (test.toString().contains('Instance')) {
            //               return SizedBox(
            //                 child: Text(
            //                   test.toJson()['Name'].toString(),
            //                   style: Theme.of(context)
            //                       .textTheme
            //                       .bodyMedium
            //                       ?.copyWith(
            //                           color: ColorManager.kPrimaryColor,
            //                           fontSize: 10,
            //                           fontWeight: FontWeight.w500),
            //                 ),
            //               );
            //             }
            //             return SizedBox(
            //               width: Get.width * 0.5,
            //               child: Text(
            //                 test,
            //                 style: Theme.of(context)
            //                     .textTheme
            //                     .bodyMedium
            //                     ?.copyWith(
            //                         color: ColorManager.kPrimaryColor,
            //                         fontSize: 10,
            //                         fontWeight: FontWeight.w500),
            //               ),
            //             );
            //           } else {
            //             return const SizedBox.shrink();
            //           }
            //         })
            //     : const SizedBox.shrink(),
            if (widget.showButtons) ...[
              widget.statusText == 'Completed'
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: Get.width * 0.02,
                        ),
                        Flexible(
                          child: PrimaryButton(
                              fontweight: FontWeight.bold,
                              radius: 5,
                              fontSize: 12,
                              height: Get.height * 0.05,
                              border:
                                  Border.all(color: ColorManager.kPrimaryColor),
                              title: ((widget.firstButtonName == null)
                                  ? 'Book Again'
                                  : (widget.firstButtonName.toString())),
                              onPressed: widget.onBookAgainPressed,
                              color: ColorManager.kPrimaryLightColor,
                              textcolor: ColorManager.kPrimaryColor),
                        ),
                        SizedBox(
                          width: Get.width * 0.08,
                        ),
                        widget.statusText == 'Completed'
                            ? Flexible(
                                child: PrimaryButton(
                                    radius: 5,
                                    fontSize: 12,
                                    height: Get.height * 0.05,
                                    border: Border.all(
                                        color: ColorManager.kPrimaryColor),
                                    title: ((widget.secondButtonName == null)
                                        ? 'Book Again'
                                        : (widget.secondButtonName.toString())),
                                    onPressed: widget.onLeaveReviewPressed,
                                    color: ColorManager.kPrimaryColor,
                                    textcolor: ColorManager.kWhiteColor),
                              )
                            : const SizedBox.shrink(),
                        SizedBox(
                          width: Get.width * 0.02,
                        ),
                      ],
                    )
                  : const SizedBox.shrink()
            ],
            SizedBox(
              height: Get.height * 0.02,
            ),
            widget.listData?.Status == "Pending Payment"
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: Get.width * 0.02,
                          ),
                          Flexible(
                            child: PrimaryButton(
                                radius: 5,
                                fontSize: 12,
                                height: Get.height * 0.05,
                                border: Border.all(
                                    color: ColorManager.kPrimaryColor),
                                title: ((widget.firstButtonName == null)
                                    ? 'reschedule'.tr
                                    : (widget.firstButtonName.toString())),
                                onPressed: () async {
                                  Get.to(() => ImagingBooking(
                                        isReschedule: true,
                                        title:
                                            ("${'reschedule'.tr} ${'diagnostics'.tr}"),
                                        listData: widget.listData,
                                      ));
                                },
                                color: Colors.transparent,
                                textcolor: ColorManager.kPrimaryColor),
                          ),
                          SizedBox(
                            width: Get.width * 0.08,
                          ),
                          Flexible(
                            child: PrimaryButton(
                                fontweight: FontWeight.bold,
                                radius: 5,
                                fontSize: 12,
                                height: Get.height * 0.05,
                                border: Border.all(
                                    color: ColorManager.kPrimaryColor),
                                title: ((widget.secondButtonName == null)
                                    ? 'cancel'.tr
                                    : (widget.secondButtonName.toString())),
                                onPressed: (() async {
                                  int status = await ScheduleRepo
                                      .CancelDiagnosticAppointment(
                                          context: context,
                                          DiagnosticAppointmentId:
                                              widget.listData?.Id,
                                          PatientDiagnosticAppointmentId: widget
                                              .listData
                                              ?.PatientDiagnosticAppointmentId,
                                          DiagnosticCenterId: widget
                                              .listData?.DiagnosticCenterId!);
                                  if (status == 1) {
                                    ScheduleController.i
                                        .removeDiagnosticAppointment(
                                            widget.listData!);
                                  }
                                  ScheduleController.i.clearData();
                                }),
                                color: ColorManager.kPrimaryColor,
                                textcolor: ColorManager.kWhiteColor),
                          ),
                          SizedBox(
                            width: Get.width * 0.02,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: Get.height * 0.02,
                      )
                    ],
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }

  String? rescheduledate;
}

String amOrPm(String time) {
  if (int.parse(time) < 12) {
    return 'AM';
  } else {
    return 'PM';
  }
}
