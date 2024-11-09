import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:tabib_al_bait/components/custom_textfields.dart';
import 'package:tabib_al_bait/components/images.dart';
import 'package:tabib_al_bait/data/controller/favorites_controller.dart';
import 'package:tabib_al_bait/data/controller/specialities_controller.dart';
import 'package:tabib_al_bait/data/localDB/local_db.dart';
import 'package:tabib_al_bait/data/repositories/specialities_repo/specialities_repo.dart';
import 'package:tabib_al_bait/helpers/color_manager.dart';
import 'package:tabib_al_bait/helpers/font_manager.dart';
import 'package:tabib_al_bait/helpers/show_toast.dart';
import 'package:tabib_al_bait/helpers/values_manager.dart';
import 'package:tabib_al_bait/main.dart';
import 'package:tabib_al_bait/models/doctor_consultation_fee.dart';
import 'package:tabib_al_bait/models/search_models.dart';
import 'package:tabib_al_bait/screens/family_screens/family_members.dart';
import 'package:tabib_al_bait/screens/online_appointment_confirm/online_appointment_confirm.dart';
import 'package:tabib_al_bait/screens/specialists_screen/doctor_schedule.dart';
import 'package:tabib_al_bait/screens/specialists_screen/specialist_details.dart';
import 'package:tabib_al_bait/utils/constants.dart';

class Specialists extends StatefulWidget {
  final bool? isNetworkImage;
  final String? icon;
  final List<Search>? doctors;
  final String? specielistId;
  final String? title;
  const Specialists(
      {super.key,
      this.doctors,
      this.title,
      this.icon,
      this.specielistId,
      this.isNetworkImage = false});

  @override
  State<Specialists> createState() => _SpecialistsState();
}

class _SpecialistsState extends State<Specialists> {
  call() async {
    SpecialitiesController.i.getlocations();
  }

  @override
  void initState() {
    // call();
    SpecialitiesController.i.filterDoctors = widget.doctors!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cont = Get.put<FavoritesController>(FavoritesController());
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(Get.height * 0.08),
          child: CustomAppBar(
            title: '${widget.title} ',
          )),
      body: BlurryModalProgressHUD(
        inAsyncCall: SpecialitiesController.i.isLoading,
        blurEffectIntensity: 20,
        progressIndicator: const SpinKitSpinningLines(
          color: Color(0xff1272d3),
          size: 60,
        ),
        dismissible: false,
        opacity: 0.4,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    FittedBox(
                      child: Container(
                          padding: const EdgeInsets.all(08),
                          decoration: BoxDecoration(
                            color: ColorManager.kPrimaryColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: widget.isNetworkImage == false
                              ? Image.asset(
                                  Images.doctorAvatar,
                                  height: Get.height * 0.038,
                                  fit: BoxFit.contain,
                                )
                              : Image.network(
                                  widget.icon ?? '',
                                  height: Get.height * 0.038,
                                  colorBlendMode: BlendMode.dstIn,
                                  fit: BoxFit.contain,
                                )),
                    ),
                    SizedBox(
                      width: Get.width * 0.02,
                    ),
                    Expanded(
                      child: CustomTextField(
                        controller: SpecialitiesController.i.searchDoctor,
                        onchanged: (p0) {
                          Future.delayed(const Duration(seconds: 2), (() async {
                            SpecialitiesController.i.filterDoctors =
                                await SpecialitiesController.i
                                    .getDoctors(widget.specielistId, query: p0);
                          }));

                          setState(() {});
                        },
                        prefixIcon: const Icon(
                          Icons.search,
                          color: ColorManager.kPrimaryColor,
                        ),
                        isSizedBoxAvailable: false,
                        hintText: 'searchDoctor'.tr,
                      ),
                    ),
                    SizedBox(
                      width: Get.width * 0.02,
                    ),
                    FittedBox(
                      child: InkWell(
                        onTap: () async {
                          SpecialitiesController.i.filterDoctors =
                              await SpecialitiesController.i
                                  .getDoctors(widget.specielistId);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(08),
                          decoration: BoxDecoration(
                            color: ColorManager.kPrimaryColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Image.asset(
                            Images.favourite,
                            height: Get.height * 0.038,
                            fit: BoxFit.contain,
                          ),
                          // child: widget.isNetworkImage == false
                          //     ? Image.asset(
                          //         Images.doctorAvatar,
                          //         height: Get.height * 0.04,
                          //       )
                          //     : Image.network(
                          //         widget.icon!,
                          //         height: Get.height * 0.04,
                          //       )
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                  ],
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                GetBuilder<SpecialitiesController>(builder: (cont) {
                  return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: SpecialitiesController.i.filterDoctors.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final doctor =
                            SpecialitiesController.i.filterDoctors[index];
                        return specialistsContainer(context,
                            title: widget.title, doctor: doctor);
                      });
                })
              ],
            ),
          ),
        ),
      ),
    );
  }

  specialistsContainer(BuildContext context, {Search? doctor, String? title}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30).copyWith(top: 5),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          InkWell(
            onTap: () async {
              await SpecialitiesController.i
                  .getDoctorWorkLocations(doctor!.id!);
              Get.to(() => SpecialistDetails(
                    doctors: doctor,
                    title: title,
                  ));
            },
            child: Container(
              width: Get.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color(0xFFDBEAF8)),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 10),
                  //   child: Align(
                  //       alignment: Alignment.topLeft,
                  //       child: Image.asset(Images.favoriteIcon)),)
                  //     ),
                  //     Align(
                  //       alignment: Alignment.topRight,
                  //       child: Container(
                  //         padding: const EdgeInsets.all(AppPadding.p8)
                  //             .copyWith(left: 20, right: 20),
                  //         decoration: const BoxDecoration(
                  //             borderRadius: BorderRadius.only(
                  //                 bottomLeft: Radius.circular(10),
                  //                 topRight: Radius.circular(10)),
                  //             color: ColorManager.kyellowContainer),
                  //         child: Text(
                  //           'Monday - Saturday | 9:00 AM - 6:00 PM',
                  //           style: Theme.of(context)
                  //               .textTheme
                  //               .bodySmall
                  //               ?.copyWith(
                  //                   fontSize: 12,
                  //                   color: ColorManager.kblackColor,
                  //                   fontWeight: FontWeight.w600),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  GetBuilder<FavoritesController>(builder: (cont) {
                    return Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.yellow,
                            ),
                            const Text('4.5'),
                            SizedBox(
                              width: Get.width * 0.02,
                            ),
                            InkWell(
                              onTap: () async {
                                var isLoggedin =
                                    await LocalDb().getLoginStatus();
                                if (isLoggedin == true) {
                                  await FavoritesController.i
                                      .addOrRemoveFromFavorites(doctor!);
                                  await listToLoad();
                                  SpecialitiesController.i.sortDoctors(
                                      SpecialitiesController.i.searchDoctors);
                                  // lengthOfList();
                                } else {
                                  ToastManager.showToast(
                                      'youarenotloggedin'.tr);
                                }
                              },
                              child: FavoritesController.i.favoriteDoctors.any(
                                          (favDoctor) =>
                                              favDoctor.id == doctor?.id) ==
                                      true
                                  ? const Icon(
                                      Icons.favorite_rounded,
                                      color: Colors.red,
                                    )
                                  : const Icon(
                                      Icons.favorite_border_sharp,
                                      color: Colors.red,
                                    ),
                            ),
                            SizedBox(
                              width: Get.width * 0.06,
                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Get.width * 0.04,
                              vertical: Get.height * 0.01),
                          child: Row(
                            children: [
                              Flexible(
                                child: Container(
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
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                '${containsFile(doctor?.picturePath)}/${doctor?.picturePath}',
                                            fit: BoxFit.cover,
                                            errorWidget:
                                                (context, url, error) =>
                                                    Image.asset(
                                                        Images.doctorAvatar),
                                          ),
                                        )
                                      : Image.asset(Images.doctorAvatar),
                                ),
                              ),
                              SizedBox(
                                width: Get.width * 0.02,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    doctor?.isOnline == true
                                        ? 'Online'
                                        : 'Offline',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          color: doctor?.isOnline == true
                                              ? Colors.green
                                              : Colors.red,
                                          fontWeight: FontWeightManager.bold,
                                          fontSize: 12,
                                        ),
                                  ),
                                  SizedBox(
                                    width: Get.width * 0.5,
                                    child: Text(
                                      '${doctor?.name?.trim()}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                            fontSize: 15,
                                            color: ColorManager.kblackColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  ),
                                  SizedBox(height: Get.height * 0.01),
                                  Row(
                                    children: [
                                      Container(
                                        width: Get.width * 0.5,
                                        margin: const EdgeInsets.symmetric(
                                                horizontal: 10)
                                            .copyWith(
                                          left: 0,
                                        ),
                                        padding: const EdgeInsets.all(
                                            AppPadding.p10),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: ColorManager.kPrimaryColor,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            doctor?.qualification != null &&
                                                    doctor?.qualification != ''
                                                ? Text(
                                                    doctor!.qualification!,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium
                                                        ?.copyWith(
                                                          color: ColorManager
                                                              .kWhiteColor,
                                                          fontSize: 10,
                                                        ),
                                                  )
                                                : const SizedBox.shrink(),
                                            RichText(
                                              text: TextSpan(
                                                style:
                                                    DefaultTextStyle.of(context)
                                                        .style,
                                                children: <TextSpan>[
                                                  TextSpan(
                                                    text:
                                                        '${'experience'.tr} : ',
                                                    style: const TextStyle(
                                                      color: ColorManager
                                                          .kWhiteColor,
                                                      fontSize: 10,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: numberOfExperienceInYears(
                                                        doctor!
                                                            .numberofExpereinceyear!),
                                                    style: const TextStyle(
                                                      color: Colors
                                                          .yellow, // Set the text color to yellow
                                                      fontSize: 10,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        // const Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [],
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.only(
                        //     right: 20,
                        //   ),
                        //   child: Align(
                        //       alignment: Alignment.centerRight,
                        //       child: Text(
                        //         ' ${doctor.consultancyFee}',
                        //         style: Theme.of(context)
                        //             .textTheme
                        //             .bodyMedium
                        //             ?.copyWith(
                        //                 color: ColorManager.kGreyColor,
                        //                 fontSize: 12),
                        //       )),
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.only(right: 20, bottom: 15),
                        //   child: Align(
                        //       alignment: Alignment.centerRight,
                        //       child: Text(
                        //         'Min. fee',
                        //         style: Theme.of(context)
                        //             .textTheme
                        //             .bodyMedium
                        //             ?.copyWith(
                        //                 color: ColorManager.kGreyColor,
                        //                 fontSize: 12),
                        //       )),
                        // )
                      ],
                    );
                  }),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0)
                        .copyWith(bottom: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          '${"atClinic".tr} ${doctor?.consultancyFee}',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(fontSize: 11),
                        ),
                        const Spacer(
                          flex: 4,
                        ),
                        daysFirstLetterWidget(
                            day: "sunday".tr, value: doctor?.sunday),
                        daysFirstLetterWidget(
                            day: 'Monday', value: doctor?.monday),
                        daysFirstLetterWidget(
                            day: 'Tuesday', value: doctor?.tuesday),
                        daysFirstLetterWidget(
                            day: 'Webnesday', value: doctor?.wednesday),
                        daysFirstLetterWidget(
                            day: 'Thursday', value: doctor?.thursday),
                        daysFirstLetterWidget(
                            day: 'Friday', value: doctor?.friday),
                        daysFirstLetterWidget(
                            day: 'Saturday', value: doctor?.saturday),
                        const Spacer(
                          flex: 2,
                        ),
                        Text(
                          '${'online'.tr} ${doctor?.consultancyFee}',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(fontSize: 11),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.07,
                  ),
                ],
              ),
            ),
          ),
          PositionedButtonWidget(
            onTap: () async {
              if (doctor?.isOnline == true) {
                var isLoggedIn = await LocalDb().getLoginStatus();
                ConsultancyDetail details =
                    await SpecialitiesRepo().getConsultancyFee(doctor!.id!);
                Get.to(() => OnlineAppointmentConfirm(
                      doctor: doctor,
                      details: details,
                    ));
              } else {
                ToastManager.showToast('doctorofflice'.tr);
              }
            },
            icon: Icons.video_call_outlined,
            offset: 25,
            alignment: Alignment.centerRight,
            iconColor: doctor?.isOnline == true ? Colors.green : Colors.red,
            borderColor: doctor?.isOnline == true ? Colors.green : Colors.red,
            buttonText: 'consultNow'.tr,
          ),
          PositionedButtonWidget(
            onTap: () async {
              await SpecialitiesController.i
                  .getDoctorWorkLocations(doctor!.id!);
              Get.to(() => DoctorSchedule(
                    frombookedappointment: false,
                    reschedule: false,
                    doctor: doctor,
                    title: widget.title,
                  ));
            },
            isImage: true,
            imagePath: Images.clinic,
            offset: 25,
            alignment: Alignment.centerLeft,
            iconColor: Colors.green,
            borderColor: Colors.green,
            buttonText: 'consultatclinic'.tr,
          ),
        ],
      ),
    );
  }

  daysFirstLetterWidget({String? day, int? value = 0}) {
    return Padding(
      padding: const EdgeInsets.all(3),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
                width: 0.8,
                color: value == 1
                    ? ColorManager.kblackColor
                    : ColorManager.kGreyColor)),
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1.5),
        child: Text(
          day?.split('').first ?? '',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontSize: 10,
              fontWeight: value == 1 ? FontWeight.bold : FontWeight.normal,
              color: value == 1
                  ? ColorManager.kblackColor
                  : ColorManager.kGreyColor),
        ),
      ),
    );
  }
}

class PositionedButtonWidget extends StatelessWidget {
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

  const PositionedButtonWidget({
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
    return Positioned(
      bottom: bottom ?? -10,
      right: alignment == Alignment.centerRight ? offset : null,
      left: alignment == Alignment.centerLeft ? offset : null,
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: Get.height * 0.065,
          decoration: BoxDecoration(
            // color: ColorManager.kPrimaryColor,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              width: 5,
              color: Colors.white,
            ),
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
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
                  Image.asset(
                    imagePath!,
                    color: borderColor,
                  )
                else
                  Icon(
                    icon,
                    color: borderColor,
                    size: 20,
                  ),
                SizedBox(width: Get.width * 0.006),
                Text(
                  '$buttonText',
                  textAlign: TextAlign.center,
                  style: Theme.of(Get.context!).textTheme.bodyMedium?.copyWith(
                      color: borderColor,
                      fontSize: Get.height * 0.015,
                      fontWeight: FontWeight.w900),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

bool? isOnlineOrOffline(String id) {
  Search? doctor = SpecialitiesController.i.allDoctors.firstWhereOrNull(
    (element) => element.id == id,
  );
  if (doctor?.isOnline == true) {
    return true;
  } else {
    return false;
  }
}

String? numberOfExperienceInYears(int years) {
  if (years < 1) {
    return 'Less than 1 Year';
  } else {
    return '$years years';
  }
}
