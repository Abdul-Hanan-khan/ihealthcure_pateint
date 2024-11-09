// ignore_for_file: unused_local_variable

import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:tabib_al_bait/components/images.dart';
import 'package:tabib_al_bait/data/controller/notificationcontroller.dart';
import 'package:tabib_al_bait/helpers/color_manager.dart';
import 'package:tabib_al_bait/helpers/values_manager.dart';
import 'package:tabib_al_bait/main.dart';
import 'package:tabib_al_bait/screens/family_screens/family_members.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  final ScrollController scrollController = ScrollController();
  @override
  void initState() {
    // internetCheck();
    Notificationcontroller.i.callback();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        var isCallToFetchData =
            Notificationcontroller.i.SetStartToFetchNextData();
        if (isCallToFetchData) {
          Notificationcontroller.i.length =
              Notificationcontroller.i.length + 10;
          Notificationcontroller.i.callback();
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final contr = Get.put(Notificationcontroller());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,

        title: CustomAppBar(
          title: 'notifications'.tr,
          isScheduleScreen: true,
        ), //Text("notifications".tr),
      ),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
              opacity: 0.4,
              image: AssetImage(Images.logoBackground))),
        child: GetBuilder<Notificationcontroller>(builder: (cont) {
          return BlurryModalProgressHUD(
              inAsyncCall: cont.isLoading,
              blurEffectIntensity: 4,
              progressIndicator: const SpinKitSpinningLines(
                color: Color(0xff1272d3),
                size: 60,
              ),
              dismissible: false,
              opacity: 0.4,
              color: Theme.of(context).scaffoldBackgroundColor,
              child: cont.data.isNotEmpty
                  ? ListView.builder(
                      shrinkWrap: true,
                      controller: scrollController,
                      itemCount: cont.data.length,
                      itemBuilder: (itemBuilder, index) {
                        return Padding(
                          padding: const EdgeInsets.all(AppPadding.p20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                cont.data[index].title.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color: ColorManager.kGreyColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                              Text(
                                "${cont.data[index].body!.split(" at ").first}\n${calculateTimeAgo(cont.data[index].dateTime)}",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color: Colors.grey,
                                      fontSize: 10,
                                    ),
                              ),
                            ],
                          ),
                        );
                      },
                    )
                  : Center(
                      child: SizedBox(
                        child: Text("norecordfound".tr),
                      ),
                    ));
        }),
      ),
    );
  }

  String calculateTimeAgo(String? dateTimeString) {
    if (dateTimeString == null) {
      return 'Unknown Date';
    }
    final dateTime = DateTime.parse(dateTimeString);
    final now = DateTime.now();
    final difference = now.difference(dateTime);
    final years = difference.inDays ~/ 365;
    final months = (difference.inDays % 365) ~/ 30;
    final days = (difference.inDays % 365) % 30;
    final hours = difference.inHours % 24;
    final minutes = difference.inMinutes % 60;
    String timeAgo = '';
    if (years > 0) {
      timeAgo = '$years year${years > 1 ? 's' : ''}';
    } else if (months > 0) {
      timeAgo = '$months month${months > 1 ? 's' : ''}';
    } else if (days > 0) {
      timeAgo = '$days day${days > 1 ? 's' : ''}';
    } else if (hours > 0) {
      timeAgo = '$hours hour${hours > 1 ? 's' : ''}';
    } else if (minutes > 0) {
      timeAgo = '$minutes minute${minutes > 1 ? 's' : ''}';
    } else {
      timeAgo = 'Just now';
    }
    return '$timeAgo ago';
  }
}
