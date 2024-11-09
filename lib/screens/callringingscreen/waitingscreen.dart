// ignore_for_file: must_be_immutable

import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tabib_al_bait/components/images.dart';
import 'package:tabib_al_bait/data/localDB/local_db.dart';
import 'package:tabib_al_bait/data/repositories/callingrepo/callingrepo.dart';
import 'package:tabib_al_bait/helpers/color_manager.dart';
import 'package:tabib_al_bait/main.dart';
import 'package:tabib_al_bait/models/callscreenmodel.dart';
import 'package:tabib_al_bait/models/search_models.dart';

class Patientwaitingscreen extends StatefulWidget {
  Search doctor;
  Patientwaitingscreen({
    super.key,
    required this.doctor,
  });

  @override
  State<Patientwaitingscreen> createState() => _PatientwaitingscreenState();
}

class _PatientwaitingscreenState extends State<Patientwaitingscreen> {
  Timer? timer;
  int minutes = 9;
  int seconds = 60;
  @override
  void initState() {
    // TODO: implement initState
    // timer = Timer.periodic(const Duration(seconds: 1), (tim) {
    //   if (minutes > 0) {
    //     if (seconds == 0) {
    //       minutes = minutes - 1;
    //       setState(() {});
    //     } else {
    //       seconds = seconds - 1;
    //       setState(() {});
    //     }
    //   } else {
    //     timer!.cancel();
    //     Get.back();
    //   }
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: const Icon(Icons.arrow_back_ios_new),
        ),
        centerTitle: true,
        title: Text("onlineConsultation".tr),
      ),
      body: Center(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: Get.height * 0.05,
            ),
            Text(
              'waitingfordoctor'.tr,
              style: GoogleFonts.poppins(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: ColorManager.kblackColor,
              ),
            ),
            SizedBox(
              height: Get.height * 0.04,
            ),
            SizedBox(width: Get.width * 0.5, child: Image.asset(Images.logo)),
            SizedBox(
              height: Get.height * 0.04,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
              child: Container(
                height: Get.height * 0.15,
                width: Get.height * 0.15,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: ColorManager.kPrimaryColor,
                    width: 3,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: widget.doctor.picturePath != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          imageUrl: containsFile(
                              "${widget.doctor.picturePath!}/${widget.doctor.picturePath}"),
                          fit: BoxFit.cover,
                          errorWidget: (context, url, error) => Image.asset(
                            Images.doctorAvatar,
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      )
                    : Image.asset(Images.doctorAvatar),
              ),
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            Text(
              widget.doctor.name ?? "doctorName".tr,
              style: GoogleFonts.poppins(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: ColorManager.kblackColor,
              ),
            ),
            SizedBox(
              height: Get.height * 0.01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("estimatedtime".tr),
                Text("$minutes:$seconds "),
                Text("minutes".tr),
              ],
            ),
            SizedBox(
              height: Get.height * 0.1,
            ),
            InkWell(
              onTap: () async {
                Callingscreenmodel data = Callingscreenmodel();
                data.branchId = widget.doctor.branchId;
                data.doctorId = widget.doctor.id;
                data.patientId = await LocalDb().getPatientId();
                CallRepo().cancelconsultation(data);
              },
              child: Container(
                height: Get.height * 0.06,
                width: Get.width * 0.7,
                decoration: BoxDecoration(
                  color: ColorManager.kPrimaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    'cancel'.tr,
                    style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: ColorManager.kWhiteColor),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
