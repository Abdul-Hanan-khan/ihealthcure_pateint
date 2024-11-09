import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tabib_al_bait/data/controller/auth_controller.dart';
import 'package:tabib_al_bait/helpers/color_manager.dart';
import 'package:tabib_al_bait/helpers/values_manager.dart';
import 'package:tabib_al_bait/models/search_models.dart';
import 'package:tabib_al_bait/screens/family_screens/family_members.dart';
import 'package:tabib_al_bait/screens/family_screens/status_screen.dart';
import 'package:tabib_al_bait/screens/specialists_screen/specialist_details.dart';

class ConsultationDetails extends StatelessWidget {
  final String? startTime;
  final String? endTime;
  final bool? isPaid;
  final bool? isOnline;
  final String? bookingTime;
  final String? bookingDate;
  final Search? doctor;
  const ConsultationDetails(
      {super.key,
      this.doctor,
      this.bookingDate,
      this.bookingTime,
      this.isOnline = false,
      this.isPaid,
      this.startTime,
      this.endTime});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: CustomAppBar(
          title: 'myAppointments'.tr,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppPadding.p20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DoctorWidget(
              doctor: doctor!,
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            Text(
              'scheduledappointment'.tr,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: ColorManager.kPrimaryColor,
                  fontWeight: FontWeight.w900),
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            Text(
              '${bookingDate?.split('T').first}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(),
            ),
            Text(
              '${startTime?.split('.').first} - ${endTime?.split('.').first}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(),
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            Text(
              'patientinfo'.tr,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: ColorManager.kPrimaryColor,
                  fontWeight: FontWeight.w900),
            ),
            RecordWidget(
              isDoctorConsultationScreen: true,
              color: ColorManager.kblackColor,
              title: 'MR No.',
              name: AuthController.i.user?.mRNo ?? "-".tr,
            ),
            RecordWidget(
              isDoctorConsultationScreen: true,
              color: ColorManager.kblackColor,
              title: 'fullName'.tr,
              name: AuthController.i.user?.firstName ?? "-".tr,
            ),
            RecordWidget(
              isDoctorConsultationScreen: true,
              color: ColorManager.kblackColor,
              title: 'gender'.tr,
              name: AuthController.i.user?.genderName ?? "-".tr,
            ),
            RecordWidget(
              isDoctorConsultationScreen: true,
              color: ColorManager.kblackColor,
              title: 'age'.tr,
              name: "-".tr,
            ),
            RecordWidget(
              isDoctorConsultationScreen: true,
              color: ColorManager.kblackColor,
              title: 'appointmentNotes'.tr,
              name: "-".tr,
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            Container(
              decoration: BoxDecoration(
                color: ColorManager.kPrimaryLightColor,
                borderRadius: BorderRadius.circular(15),
              ),
              padding: const EdgeInsets.all(AppPadding.p16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'amount'.tr,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: ColorManager.kPrimaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                        textAlign: TextAlign.start,
                      ),
                      Text(
                        isOnline == true
                            ? 'consultNow'.tr
                            : 'consultatclinic'.tr,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color:
                                  isOnline == true ? Colors.green : Colors.red,
                            ),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${doctor?.consultancyFee ?? '-'}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: ColorManager.kPrimaryColor,
                              fontWeight: FontWeight.w900,
                            ),
                      ),
                      Text(
                        'paid'.tr,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: ColorManager.kPrimaryColor,
                              fontWeight: FontWeight.w900,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
