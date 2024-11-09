import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tabib_al_bait/components/images.dart';
import 'package:tabib_al_bait/components/primary_button.dart';
import 'package:tabib_al_bait/components/text_container.dart';
import 'package:tabib_al_bait/data/controller/favorites_controller.dart';
import 'package:tabib_al_bait/data/controller/schedule_controller.dart';
import 'package:tabib_al_bait/data/localDB/local_db.dart';
import 'package:tabib_al_bait/data/repositories/favorites_repo/favorites_repo.dart';
import 'package:tabib_al_bait/helpers/color_manager.dart';
import 'package:tabib_al_bait/helpers/font_manager.dart';
import 'package:tabib_al_bait/helpers/values_manager.dart';
import 'package:tabib_al_bait/main.dart';
import 'package:tabib_al_bait/models/search_models.dart';
import 'package:tabib_al_bait/screens/specialists_screen/specialist_details.dart';

class DoctorsAppointmentCard extends StatelessWidget {
  final String statusText;
  final Color statusColor;
  final String name;
  final String date;
  final String time;
  final String type;
  final String rating;
  final bool showButtons;

  final void Function() onBookAgainPressed;
  final void Function() onLeaveReviewPressed;

  const DoctorsAppointmentCard({
    Key? key,
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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(AppPadding.p4),
      padding: const EdgeInsets.all(AppPadding.p16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: ColorManager.kPrimaryLightColor),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  flex: 4,
                  child: Container(
                      height: Get.height * 0.15,
                      width: Get.width * 0.6,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: const DecorationImage(
                            image: AssetImage(
                              Images.profile,
                            ),
                          )))),
              Expanded(
                  flex: 6,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                TextContainer(
                                    color: statusColor, text: statusText),
                                Text(
                                  name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                          color: ColorManager.kblackColor,
                                          fontWeight: FontWeight.w900),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        SizedBox(
                          width: Get.width * 0.4,
                          child: const Divider(
                            height: 2,
                            thickness: 2,
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        Text(
                          type,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color: ColorManager.kblackColor,
                                  fontWeight: FontWeightManager.bold,
                                  fontSize: 12),
                        ),
                        Flexible(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '$date | $time',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        color: ColorManager.kblackColor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12),
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Icon(
                                      Icons.location_on,
                                      color: ColorManager.kPrimaryColor,
                                    ),
                                    const Icon(
                                      Icons.star,
                                      color: ColorManager.kyellowContainer,
                                    ),
                                    Text(
                                      rating,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: ColorManager.kblackColor,
                                          ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ))
            ],
          ),
          SizedBox(
            height: Get.height * 0.04,
          ),
          if (showButtons)
            Row(
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
                      border: Border.all(color: ColorManager.kPrimaryColor),
                      title: 'Book Again',
                      onPressed: onBookAgainPressed,
                      color: ColorManager.kPrimaryLightColor,
                      textcolor: ColorManager.kPrimaryColor),
                ),
                SizedBox(
                  width: Get.width * 0.08,
                ),
                Flexible(
                  child: PrimaryButton(
                      radius: 5,
                      fontSize: 12,
                      height: Get.height * 0.05,
                      border: Border.all(color: ColorManager.kPrimaryColor),
                      title: 'Leave a Review',
                      onPressed: onLeaveReviewPressed,
                      color: ColorManager.kPrimaryColor,
                      textcolor: ColorManager.kWhiteColor),
                ),
                SizedBox(
                  width: Get.width * 0.02,
                ),
              ],
            )
        ],
      ),
    );
  }
}

class FavoriteDoctorsCard extends StatelessWidget {
  final Search doctor;
  const FavoriteDoctorsCard({
    Key? key,
    required this.doctor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => SpecialistDetails(
              doctors: doctor,
              title: doctor.speciality,
            ));
      },
      child: Container(
        margin: const EdgeInsets.all(AppPadding.p4),
        padding: const EdgeInsets.all(AppPadding.p20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: ColorManager.kPrimaryLightColor),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          borderRadius: BorderRadius.circular(20),
                          child: CachedNetworkImage(
                            imageUrl:
                                '${containsFile(doctor.picturePath)}/${doctor.picturePath}',
                            fit: BoxFit.cover,
                            errorWidget: (context, url, error) => Image.asset(
                              Images.doctorAvatar,
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        )
                      : Image.asset(Images.doctorAvatar),
                ),
                Expanded(
                    flex: 5,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          doctor.isOnline!
                              ? Row(
                                  children: [
                                    Text(
                                      'online'.tr,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                              color: Colors.green,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w900),
                                    ),
                                    SizedBox(
                                      width: Get.width * 0.02,
                                    ),
                                    Image.asset(
                                      Images.signal,
                                      height: 15,
                                    )
                                  ],
                                )
                              : const SizedBox.shrink(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  child: Text(
                                '${doctor.name}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(fontWeight: FontWeight.w900),
                              )),
                              InkWell(
                                  onTap: () async {
                                    var branchID =
                                        await LocalDb().getBranchId();
                                    var patientId =
                                        await LocalDb().getPatientId();
                                    await FavoritesRepo.removeFromFavorites(
                                        doctorId: doctor.id,
                                        patientId: patientId,
                                        branchId: branchID);
                                    await FavoritesController.i
                                        .getAllFavoriteDoctors();
                                    await ScheduleController.i
                                        .ApplyFilterForAppointments(1);
                                    await ScheduleController.i
                                        .changeStatusofOpenedTab(true);

                                    // await listToLoad();
                                    // lengthOfList();
                                  },
                                  child: const Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                  ))
                            ],
                          ),
                          SizedBox(
                            height: Get.height * 0.01,
                          ),
                          const Divider(
                            height: 2,
                            thickness: 2,
                          ),
                          SizedBox(
                            height: Get.height * 0.01,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                flex: 5,
                                child: Text(
                                  doctor.speciality ?? '',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                          color: ColorManager.kblackColor,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 10),
                                ),
                              ),
                              SizedBox(
                                width: Get.width * 0.05,
                              ),
                              const Icon(
                                Icons.star,
                                color: ColorManager.kyellowContainer,
                              ),
                              Text(
                                '${doctor.noOfVotes ?? ''}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: ColorManager.kblackColor,
                                    ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ))
              ],
            ),
            // SizedBox(
            //   height: Get.height * 0.04,
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     SizedBox(
            //       width: Get.width * 0.08,
            //     ),
            //     SizedBox(
            //       width: Get.width * 0.02,
            //     ),
            //   ],
            // )
          ],
        ),
      ),
    );
  }
}
