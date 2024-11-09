// ignore_for_file: non_constant_identifier_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tabib_al_bait/components/images.dart';
import 'package:tabib_al_bait/data/controller/book_appointment_controller.dart';
import 'package:tabib_al_bait/data/controller/favorites_controller.dart';
import 'package:tabib_al_bait/data/controller/schedule_controller.dart';
import 'package:tabib_al_bait/data/controller/specialities_controller.dart';
import 'package:tabib_al_bait/data/localDB/local_db.dart';
import 'package:tabib_al_bait/helpers/color_manager.dart';
import 'package:tabib_al_bait/helpers/values_manager.dart';
import 'package:tabib_al_bait/main.dart';
import 'package:tabib_al_bait/models/DoctorConsultationAppointmentHistory.dart';
import 'package:tabib_al_bait/models/search_models.dart';
import 'package:tabib_al_bait/screens/family_screens/family_members.dart';
import 'package:tabib_al_bait/screens/specialists_screen/appointment_creation.dart';
import 'package:tabib_al_bait/utils/constants.dart';

class DoctorSchedule extends StatelessWidget {
  final DoctorConsultationAppointmentHistoryDataList? rescduledata;
  final bool reschedule;
  final Search doctor;
  final String? title;
  final String? appointmentid;
  final String? patientappointmentid;
  final String? AppointmentSlotDisplayType;
  final bool? frombookedappointment;
  const DoctorSchedule(
      {super.key,
      this.rescduledata,
      this.AppointmentSlotDisplayType,
      required this.doctor,
      this.frombookedappointment = false,
      this.title,
      this.reschedule = false,
      this.appointmentid,
      this.patientappointmentid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: CustomAppBar(
          title: '${doctor.speciality}',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppPadding.p20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(AppPadding.p10),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: Get.height * 0.15,
                          width: Get.height * 0.15,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: ColorManager.kPrimaryColor,
                              width: 3,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: doctor.picturePath != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        '${containsFile(doctor.picturePath)}/${doctor.picturePath!}',
                                    fit: BoxFit.fitHeight,
                                    errorWidget: (context, url, error) =>
                                        Image.asset(
                                      Images.doctorAvatar,
                                      fit: BoxFit.fitHeight,
                                    ),
                                  ),
                                )
                              : Image.asset(Images.doctorAvatar),
                        ),
                        SizedBox(
                          width: Get.width * 0.015,
                        ),
                        Expanded(
                            flex: 6,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        doctor.name!,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    GetBuilder<FavoritesController>(
                                        builder: (cont) {
                                      return IconButton(
                                        onPressed: () async {
                                          bool? isLoggedIn =
                                              await LocalDb().getLoginStatus();
                                          if (isLoggedIn == true) {
                                            cont.addOrRemoveFromFavorites(
                                                doctor);
                                            await ScheduleController.i
                                                .ApplyFilterForAppointments(1);
                                            await ScheduleController.i
                                                .changeStatusofOpenedTab(true);
                                            await ScheduleController.i
                                                .clearData();
                                            await ScheduleController.i
                                                .getUpcomingAppointment(
                                                    "", true);
                                            await listToLoad();
                                          } else {
                                            // ignore: use_build_context_synchronously
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content:
                                                    Text('pleaseloginfirst'.tr),
                                                duration:
                                                    const Duration(seconds: 3),
                                              ),
                                            );
                                          }
                                        },
                                        icon: cont.favoriteDoctors.any(
                                                (favDoctor) =>
                                                    favDoctor.id == doctor.id)
                                            ? const Icon(
                                                Icons.favorite_rounded,
                                                color: Colors.red,
                                              )
                                            : const Icon(
                                                Icons.favorite_border_sharp,
                                                color: Colors.red,
                                              ),
                                      );
                                    })
                                  ],
                                ),
                                const Divider(
                                  color: ColorManager.kblackColor,
                                ),
                                Text(
                                  doctor.speciality ?? '',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  doctor.location ?? '',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                ),
                              ],
                            )),
                      ],
                    ),
                    // const Align(
                    //   alignment: Alignment.centerRight,
                    //   child: Text(
                    //     '1000/',
                    //     textAlign: TextAlign.right,
                    //   ),
                    // ),
                    // Align(
                    //   alignment: Alignment.centerRight,
                    //   child: Text(
                    //     'minFee'.tr,
                    //     textAlign: TextAlign.right,
                    //   ),
                    // ),
                  ],
                ),
              ),
              SpecialitiesController.i.scheduleList.isNotEmpty &&
                      SpecialitiesController.i.scheduleList.any(
                          (element) => element.isOnlineConfiguration == false)
                  ? ListView.builder(
                      padding: const EdgeInsets.all(10),
                      itemCount: SpecialitiesController.i.scheduleList.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final list =
                            SpecialitiesController.i.scheduleList[index];
                        return list.isOnlineConfiguration == true
                            ? const SizedBox.shrink()
                            : InkWell(
                                onTap: () async {
                                  final selectedDay =
                                      list; // Replace with the selected day from your list
                                  BookAppointmentController.i.newDate =
                                      BookAppointmentController.i
                                          .findClosestFutureDate(
                                              selectedDay.day!);
                                  BookAppointmentController.i.updateDate(
                                      BookAppointmentController.i.newDate!);
                                  await SpecialitiesController.i
                                      .getDateWiseDoctorSlots(
                                    list.doctorId!,
                                    '${list.id}',
                                    BookAppointmentController.i.newDate
                                        .toString(),
                                    list.isOnlineConfiguration!,
                                  );

                                  Get.to(() => AppointmentCreation(
                                        model: list,
                                        list: rescduledata,
                                        AppointmentSlotDisplayType:
                                            AppointmentSlotDisplayType,
                                        appointmentid: appointmentid,
                                        patientappointmentid:
                                            patientappointmentid,
                                        isHereFrombookedAppointments:
                                            frombookedappointment,
                                        doctor: doctor,
                                        doctorId: list.doctorId,
                                        workLocationId: list.id,
                                        date: BookAppointmentController
                                            .i.formattedDate,
                                        isOnline: list.isOnlineConfiguration,
                                      ));
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: Container(
                                    padding:
                                        const EdgeInsets.all(AppPadding.p10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: ColorManager.kPrimaryLightColor,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '${list.day}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall
                                                  ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.w900,
                                                      color: ColorManager
                                                          .kPrimaryColor),
                                            ),
                                            Text(
                                              '${getCurrentTimeWithAMorPM(list.startTime!)} - ${getCurrentTimeWithAMorPM(list.endTime!)}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium
                                                  ?.copyWith(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: Get.height * 0.01,
                                        ),
                                        const MySeparator(
                                          color: ColorManager.kGreyColor,
                                        ),
                                        SizedBox(
                                          height: Get.height * 0.01,
                                        ),
                                        Text(
                                          consultation(
                                              list.isOnlineConfiguration!,
                                              list.address!),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                                  color:
                                                      list.isOnlineConfiguration ==
                                                              true
                                                          ? Colors.green
                                                          : ColorManager
                                                              .kPrimaryColor,
                                                  fontWeight: FontWeight.w800),
                                        ),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.pin_drop_outlined,
                                              color: ColorManager.kPrimaryColor,
                                            ),
                                            Text(
                                              isOnline(
                                                  list.isOnlineConfiguration!,
                                                  address: list.address,
                                                  location: list.address),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium
                                                  ?.copyWith(
                                                      color: ColorManager
                                                          .kblackColor,
                                                      fontSize: 12),
                                            ),
                                            const Spacer(),
                                            Column(
                                              children: [
                                                Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Text(
                                                      'fee'.tr,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium
                                                          ?.copyWith(
                                                              color: ColorManager
                                                                  .kPrimaryColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                    )),
                                                Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Text(
                                                      '${list.actualFee}',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium
                                                          ?.copyWith(
                                                              color: ColorManager
                                                                  .kblackColor,
                                                              fontSize: 12),
                                                    )),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: Get.height * 0.01,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                      })
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: Get.height * 0.3,
                        ),
                        const Center(
                          child: Text('No Work Locations Found'),
                        ),
                      ],
                    )
            ],
          ),
        ),
      ),
    );
  }
}

String isOnline(bool value, {String? location, String? address}) {
  if (value == true) {
    return '$address';
  } else {
    return '$location';
  }
}

String consultation(bool value, String location) {
  if (value == true) {
    return 'Online Consultation';
  } else {
    return location;
  }
}

String getCurrentTimeWithAMorPM(String timeStr) {
  // Convert the time string to a DateTime object.
  DateTime time = DateFormat('hh:mm:ss').parse(timeStr);

  // Get the hour of the day.
  int hour = time.hour;

  // If the hour is before 12, then show AM.
  if (hour < 12) {
    return DateFormat('hh:mm a').format(time);
  } else {
    return DateFormat('hh:mm a').format(time);
  }
}

class MySeparator extends StatelessWidget {
  const MySeparator({Key? key, this.height = 1, this.color = Colors.black})
      : super(key: key);
  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashWidth = 5.0;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
        );
      },
    );
  }
}
