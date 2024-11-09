// ignore_for_file: unused_local_variable, must_be_immutable
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tabib_al_bait/components/images.dart';
import 'package:tabib_al_bait/data/controller/favorites_controller.dart';
import 'package:tabib_al_bait/data/controller/schedule_controller.dart';
import 'package:tabib_al_bait/data/controller/specialities_controller.dart';
import 'package:tabib_al_bait/data/localDB/local_db.dart';
import 'package:tabib_al_bait/data/repositories/specialities_repo/specialities_repo.dart';
import 'package:tabib_al_bait/helpers/color_manager.dart';
import 'package:tabib_al_bait/helpers/show_toast.dart';
import 'package:tabib_al_bait/helpers/values_manager.dart';
import 'package:tabib_al_bait/main.dart';
import 'package:tabib_al_bait/models/doctor_consultation_fee.dart';
import 'package:tabib_al_bait/models/search_models.dart';
import 'package:tabib_al_bait/screens/family_screens/family_members.dart';
import 'package:tabib_al_bait/screens/specialists_screen/doctor_schedule.dart';
import 'package:tabib_al_bait/utils/constants.dart';
import '../online_appointment_confirm/online_appointment_confirm.dart';
import 'package:cached_network_image/cached_network_image.dart';

class SpecialistDetails extends StatelessWidget {
  final String? title;
  final Search? doctors;
  SpecialistDetails({super.key, this.doctors, this.title});

  String locationname = "";
  String temp = "null";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: CustomAppBar(
            title: '$title',
          )),
      body: Padding(
        padding: const EdgeInsets.all(AppPadding.p20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DoctorWidget(
                doctor: doctors,
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.max,
                children: [
                  customColumn(context,
                      backgroundColor: ColorManager.kPrimaryColor,
                      icon: Icons.people_outline,
                      title: '${doctors!.noOfVotes}+',
                      subtitle: 'patients'.tr),
                  customColumn(context,
                      icon: Icons.auto_graph_sharp,
                      title: '${doctors!.numberofExpereinceyear}',
                      subtitle: 'yearExperience'.tr,
                      backgroundColor: Colors.green),
                  customColumn(context,
                      icon: Icons.star_border_rounded,
                      title: '${4.5}',
                      subtitle: 'rating'.tr,
                      backgroundColor: ColorManager.kyellowContainer),
                ],
              ),
              const Divider(
                thickness: 2,
              ),
              Text(
                'description'.tr,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: ColorManager.kblackColor,
                    fontWeight: FontWeight.w600),
              ),
              doctors!.professionalsummary != null
                  ? Text(
                      doctors!.professionalsummary!,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: ColorManager.kblackColor, fontSize: 12),
                    )
                  : const SizedBox.shrink(),
              SizedBox(
                height: Get.height * 0.01,
              ),
              const Divider(),
              Text(
                'workingTime'.tr,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: ColorManager.kblackColor,
                    fontWeight: FontWeight.w900),
              ),
              ListView.builder(
                  itemCount: SpecialitiesController.i.scheduleList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, idx) {
                    final location = SpecialitiesController.i.scheduleList[idx];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (location.name !=
                                SpecialitiesController
                                    .i
                                    .scheduleList[idx != 0 ? idx - 1 : 0]
                                    .name ||
                            idx == 0)
                          Text(SpecialitiesController
                                  .i.scheduleList[idx].address ??
                              ""),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              location.day ?? "day".tr,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            Row(
                              children: [
                                Text(int.parse(
                                            location.startTime!.split(':')[0]) >
                                        12
                                    ? (int.parse(location.startTime!
                                                .split(':')[0]) -
                                            12)
                                        .toString()
                                    : "${int.parse(location.startTime!.split(':')[0])}:${location.startTime!.split(':')[1]} "),
                                Text(int.parse(
                                            location.startTime!.split(':')[0]) >
                                        11
                                    ? "PM "
                                    : "AM "),
                                const Text(' - '),
                                Row(
                                  children: [
                                    Text(int.parse(location.endTime!
                                                .split(':')[0]) >
                                            12
                                        ? "${int.parse(location.endTime!.split(':')[0]) - 12}"
                                        : location.endTime!.split(':')[0]),
                                    const Text(":"),
                                    Text(location.endTime!
                                        .toString()
                                        .split(':')[1]),
                                    Text(int.parse(location.endTime!
                                                .split(':')[0]) >
                                            11
                                        ? "PM "
                                        : "AM "),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    );
                    // } else {
                    //   return const SizedBox.shrink();
                    // }
                  }),
              Text(
                'online&Clinic'.tr,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
              Row(
                children: [
                  Text(
                    'online'.tr,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.green, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    ' -  ${doctors!.onlineVideoConsultationFee} & ',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: ColorManager.kblackColor,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    'home'.tr,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: ColorManager.kRedColor,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    ' - ',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: ColorManager.kblackColor,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    '${doctors?.consultancyFee}',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: ColorManager.kblackColor,
                        fontWeight: FontWeight.w600),
                  )
                ],
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: ButtonWidget(
                      onTap: () async {
                        await SpecialitiesController.i
                            .getDoctorWorkLocations(doctors!.id!);
                        Get.to(() => DoctorSchedule(
                              frombookedappointment: false,
                              reschedule: false,
                              doctor: doctors!,
                            ));
                      },
                      isImage: true,
                      imagePath: Images.clinic,
                      alignment: Alignment.centerLeft,
                      iconColor: Colors.green,
                      borderColor: Colors.green,
                      buttonText: 'getAppointment'.tr,
                    ),
                  ),
                  SizedBox(
                    width: Get.width * 0.04,
                  ),
                  Flexible(
                    child: ButtonWidget(
                      onTap: () async {
                        if (doctors!.isOnline == true) {
                          var isLoggedIn = await LocalDb().getLoginStatus();
                          ConsultancyDetail details = await SpecialitiesRepo()
                              .getConsultancyFee(doctors!.id!);
                          Get.to(() => OnlineAppointmentConfirm(
                                doctor: doctors,
                                details: details,
                              ));
                        } else {
                          ToastManager.showToast('doctorofflice'.tr);
                        }
                      },
                      icon: Icons.video_call_outlined,
                      alignment: Alignment.centerRight,
                      iconColor: const Color(0xFFF21F61),
                      borderColor: const Color(0xFFF21F61),
                      buttonText: 'consultNow'.tr,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  int scheduleindex = 0;
  customColumn(BuildContext context,
      {IconData? icon,
      String? title,
      String? subtitle,
      Color? backgroundColor}) {
    return FractionallySizedBox(
      // width: Get.width * 0.22,
      child: Column(
        children: [
          CircleAvatar(
              backgroundColor: backgroundColor,
              radius: 25,
              child: Icon(
                icon,
                size: 25,
                color: ColorManager.kWhiteColor,
              )),
          SizedBox(
            height: Get.height * 0.01,
          ),
          Text(
            '$title',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: ColorManager.kPrimaryColor,
                fontWeight: FontWeight.w600,
                fontSize: 12),
          ),
          Text(
            '$subtitle',
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontSize: 12, fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }
}

class DoctorWidget extends StatelessWidget {
  final bool? isConsultationScreen;
  final bool? isRowAvailable;
  final Search? doctor;
  final bool? isOnline;
  const DoctorWidget({
    super.key,
    this.doctor,
    this.isOnline = false,
    this.isRowAvailable = true,
    this.isConsultationScreen = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: Container(
              height: Get.height * 0.15,
              width: Get.height * 0.15,
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
                            '${containsFile(doctor!.picturePath!)}/${doctor?.picturePath!}',
                        fit: BoxFit.fitHeight,
                        errorWidget: (context, url, error) => Image.asset(
                          Images.doctorAvatar,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    )
                  : Image.asset(Images.doctorAvatar),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(
                      width: Get.width * 0.4,
                      child: Text(
                        '${doctor?.name?.trim()}',
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: ColorManager.kblackColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                    ),
                    GetBuilder<FavoritesController>(builder: (cont) {
                      return IconButton(
                        onPressed: () async {
                          bool? isLoggedIn = await LocalDb().getLoginStatus();
                          if (isLoggedIn == true) {
                            cont.addOrRemoveFromFavorites(doctor!);
                            await ScheduleController.i
                                .ApplyFilterForAppointments(1);
                            await ScheduleController.i
                                .changeStatusofOpenedTab(true);
                            await ScheduleController.i.clearData();
                            await ScheduleController.i
                                .getUpcomingAppointment("", true);
                            await listToLoad();
                          } else {
                            // ignore: use_build_context_synchronously
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('pleaseloginfirst'.tr),
                                duration: const Duration(seconds: 3),
                              ),
                            );
                          }
                        },
                        icon: cont.favoriteDoctors
                                .any((favDoctor) => favDoctor.id == doctor?.id)
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
                Flexible(
                  child: SizedBox(
                    width: Get.width * 0.5,
                    child: const Divider(
                      height: 1.0,
                      // Adjust the height as needed
                      color: Colors.grey,
                    ),
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
                  width: Get.width * 0.5,
                  child: Text(
                    doctor?.location ?? '',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w600, fontSize: 12),
                  ),
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: ColorManager.kPrimaryColor),
                        padding: const EdgeInsets.all(5),
                        child: Text(
                          'changeLocation'.tr,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                  color: ColorManager.kWhiteColor,
                                  fontSize: 8,
                                  fontWeight: FontWeight.w900),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: Get.width * 0.02,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: isOnline == true
                              ? ColorManager.kPrimaryColor
                              : ColorManager.kPrimaryLightColor),
                      padding: const EdgeInsets.all(5),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.pin_drop_outlined,
                            size: 12,
                            color: ColorManager.kWhiteColor,
                          ),
                          Text(
                            'online'.tr,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                    color: ColorManager.kWhiteColor,
                                    fontSize: 8,
                                    fontWeight: FontWeight.w900),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: Get.width * 0.02,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: isOnline == true
                              ? ColorManager.kPrimaryLightColor
                              : ColorManager.kPrimaryColor),
                      padding: const EdgeInsets.all(5),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.pin_drop_outlined,
                            size: 12,
                            color: ColorManager.kWhiteColor,
                          ),
                          Text(
                            'offline'.tr,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                    color: ColorManager.kWhiteColor,
                                    fontSize: 8,
                                    fontWeight: FontWeight.w900),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
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
      ),
    );
  }
}

class ButtonWidget extends StatelessWidget {
  final double? bottom;
  final String? imagePath;
  final bool? isImage;
  final IconData? icon;
  final double? offset;
  final Alignment? alignment;
  final Color? iconColor;
  final Color? borderColor;
  final String? buttonText;
  final Function()? onTap;

  const ButtonWidget({
    Key? key,
    this.bottom,
    this.imagePath,
    this.isImage = false,
    this.icon,
    this.offset,
    this.alignment,
    this.iconColor,
    this.borderColor,
    this.buttonText,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: Get.height * 0.065,
        padding: const EdgeInsets.all(AppPadding.p8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
                color: ColorManager.kGreyColor,
                blurRadius: 0.8,
                spreadRadius: 1,
                offset: Offset(-2, 2))
          ],
          border: Border.all(
            color: borderColor!,
          ),
          color: ColorManager.kWhiteColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isImage == true)
              Image.asset(imagePath!)
            else
              Icon(
                icon,
                color: borderColor,
                size: 20,
              ),
            SizedBox(width: Get.width * 0.005),
            SizedBox(
              width: Get.width * 0.22,
              child: FittedBox(
                child: Text(
                  '$buttonText',
                  textAlign: TextAlign.center,
                  style: Theme.of(Get.context!).textTheme.bodyMedium?.copyWith(
                      color: borderColor,
                      fontSize: 10,
                      fontWeight: FontWeight.w600),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
