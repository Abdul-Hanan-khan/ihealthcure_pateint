// ignore_for_file: unused_local_variable

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tabib_al_bait/components/custom_textfields.dart';
import 'package:tabib_al_bait/data/controller/specialities_controller.dart';
import 'package:tabib_al_bait/helpers/color_manager.dart';
import 'package:tabib_al_bait/helpers/font_manager.dart';
import 'package:tabib_al_bait/helpers/values_manager.dart';
import 'package:tabib_al_bait/main.dart';
import 'package:tabib_al_bait/models/search_models.dart';
import 'package:tabib_al_bait/screens/family_screens/family_members.dart';
import 'package:tabib_al_bait/screens/specialists_screen/specialists_screen.dart';
import '../../components/images.dart';

class BookyourAppointment extends StatefulWidget {
  const BookyourAppointment({super.key});

  @override
  State<BookyourAppointment> createState() => _BookyourAppointmentState();
}

class _BookyourAppointmentState extends State<BookyourAppointment> {
  TextEditingController search = TextEditingController();
  @override
  void initState() {
    // internetCheck();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var contr = Get.put<SpecialitiesController>(SpecialitiesController());
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(Get.height * 0.08),
            child: CustomAppBar(
              title: 'specialities'.tr,
            )),
        body: GetBuilder<SpecialitiesController>(builder: (cont) {
          return SafeArea(
            minimum: const EdgeInsets.all(AppPadding.p20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextField(
                    onchanged: (p0) {
                      Future.delayed(
                          const Duration(
                            seconds: 2,
                          ), (() {
                        SpecialitiesController.i.getSpecialities(query: p0);
                        setState(() {});
                      }));
                    },
                    controller: search,
                    hintText: 'searchForSpecialities'.tr,
                    prefixIcon: const Icon(
                      Icons.search,
                      color: ColorManager.kPrimaryColor,
                    ),
                  ),
                  // SizedBox(
                  //   height: Get.height * 0.01,
                  // ),
                  GetBuilder<SpecialitiesController>(builder: (cont) {
                    return ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: cont.doctors.length,
                        itemBuilder: (context, index) {
                          final doctor = cont.doctors?[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: ListTile(
                                minLeadingWidth: 20,
                                contentPadding:
                                    const EdgeInsets.all(AppPadding.p8)
                                        .copyWith(right: 20),
                                onTap: () async {
                                  log('over here');
                                  List<Search> search =
                                      await SpecialitiesController.i
                                          .getDoctors(doctor.id!, query: '');
                                  Get.to(() => Specialists(
                                        specielistId: doctor.id,
                                        doctors: search,
                                        title: doctor.name,
                                        icon:
                                            '${containsFile(doctor.icon!)}/${doctor.icon}',
                                        isNetworkImage: doctor.icon != null &&
                                                doctor.icon != ''
                                            ? true
                                            : false,
                                      ));
                                },
                                shape: RoundedRectangleBorder(
                                    side: const BorderSide(
                                        color: ColorManager.kPrimaryColor,
                                        width: 0.4),
                                    borderRadius: BorderRadius.circular(10)),
                                leading:
                                    doctor!.icon != null || doctor.icon == ''
                                        ? CircleAvatar(
                                            radius: 30,
                                            backgroundImage: NetworkImage(
                                                '${containsFile(doctor.icon!)}/${doctor.icon}'),
                                          )
                                        : const CircleAvatar(
                                            radius: 30,
                                            backgroundImage:
                                                AssetImage(Images.covid)),
                                title: doctor.name != null
                                    ? Text(
                                        '${doctor.name}',
                                        textAlign: TextAlign.left,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                                color: ColorManager.kblackColor,
                                                fontWeight:
                                                    FontWeightManager.bold),
                                      )
                                    : const SizedBox.shrink(),
                                subtitle: doctor.subSpecialities != null
                                    ? Text(
                                        doctor.subSpecialities
                                            .toString()
                                            .trim(),
                                        textAlign: TextAlign.left,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                                fontWeight:
                                                    FontWeightManager.light,
                                                fontSize: 12),
                                      )
                                    : const SizedBox.shrink()),
                          );
                        });
                  })
                ],
              ),
            ),
          );
        }));
  }
}
