import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tabib_al_bait/components/images.dart';
import 'package:tabib_al_bait/data/repositories/callingrepo/callingrepo.dart';
import 'package:tabib_al_bait/helpers/color_manager.dart';
import 'package:tabib_al_bait/main.dart';
import 'package:tabib_al_bait/models/callscreenmodel.dart';
import 'package:tabib_al_bait/screens/callringingscreen/callscreen.dart';

class Ringerscreen extends StatelessWidget {
  Ringerscreen({super.key, required this.data});
  // "PrescribedInValue":"2","IsFirstTimeVisit":"true","IsOnline":"true"}

  Callingscreenmodel? data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
        onPressed: () {
          Get.back();
          FlutterRingtonePlayer.stop();
        },
        icon: const Icon(Icons.arrow_back),
      )),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                opacity: 0.4,
                image: AssetImage(
                  Images.logoBackground,
                ),
                alignment: Alignment.centerLeft)),
        height: Get.height * 1,
        width: Get.width * 1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SizedBox(
            //   height: Get.height * 0.2,
            //   width: Get.width * 0.15,
            //   child: CachedNetworkImage(
            //     imageUrl: baseURL! + data?.doctorImagePath,
            //     fit: BoxFit.contain,
            //     errorWidget: (context, url, error) => Image.asset(
            //       Images.doctorAvatar,
            //       fit: BoxFit.contain,
            //     ),
            //   ),
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: [
            //     IconButton(
            //         onPressed: () async {
            //           int val = await CallRepo().acceptcall(data!);
            //           if (val == 1) {
            //             Get.to(() => Callaccept(
            //                   data: data!,
            //                 ));
            //           }
            //         },
            //         icon: const Icon(
            //           Icons.call,
            //           color: Colors.green,
            //         )),
            //     IconButton(
            //         onPressed: () async {
            //           int val = await CallRepo().rejectcall(data!);
            //           if (val == 1) {
            //             Get.back();
            //           }
            //         },
            //         icon: const Icon(
            //           Icons.call,
            //           color: Colors.red,
            //         ))
            //   ],
            // ),
            SizedBox(
              height: Get.height * 0.05,
            ),
            Text(
              'doctoriscalling'.tr,
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
                child: data?.doctorImagePath != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          imageUrl: containsFile(
                              "${data?.doctorImagePath!}/${data?.doctorImagePath!}"),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  data?.callername ?? "doctorName".tr,
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: ColorManager.kblackColor,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: Get.height * 0.01,
            ),

            SizedBox(
              height: Get.height * 0.1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () async {
                    FlutterRingtonePlayer.stop();
                    int i = await CallRepo().acceptcall(data!);
                    if (i == 1) {
                      Get.to(() => Callaccept(
                            data: data!,
                          ));
                    }
                  },
                  child: const CircleAvatar(
                    backgroundColor: Colors.green,
                    child: Icon(
                      Icons.call,
                      color: Colors.white,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    FlutterRingtonePlayer.stop();
                    int i = await CallRepo().rejectcall(data!);
                    if (i == 1) {
                      Get.back();
                    }
                  },
                  child: const CircleAvatar(
                    backgroundColor: Colors.red,
                    child: Icon(
                      Icons.call_end,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
