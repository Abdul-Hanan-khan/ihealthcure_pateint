import 'dart:developer';

import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:tabib_al_bait/data/controller/schedule_controller.dart';
import 'package:tabib_al_bait/data/localDB/local_db.dart';
import 'package:tabib_al_bait/screens/auth_screens/login.dart';
import 'package:tabib_al_bait/screens/dashboard/dashboard.dart';

class BottomBarController extends GetxController implements GetxService {
  ZoomDrawerController drawerController = ZoomDrawerController();
  void navigateToPage(int index, {int? filterType = 0}) async {
    bool? isLoggedin = await LocalDb().getLoginStatus() ?? false;
    if (index == 1) {
      ScheduleController.i.updateSelectedService(-1);
      // bool? isLoggedin = await LocalDb().getLoginStatus();
      if ((isLoggedin) == false) {
        await Get.to(() => const LoginScreen(
              isprofile: true,
            ));

        log(selectedPage.toString());
      } else {
        ScheduleController.i.clearData();
        ScheduleController.i.ApplyFilterForAppointments(filterType ?? 0);
        ScheduleController.i.getAppointmentsList('');
      }
    } else if (index == 2) {
      ScheduleController.i.updateSelectedService(-1);
      // bool? isLoggedin = await LocalDb().getLoginStatus();
      if ((isLoggedin) == false) {
        await Get.to(() => const LoginScreen(
              isHerefromSchedule: true,
            ));
      }
    } else if (index == 3) {
      ScheduleController.i.updateSelectedService(-1);
      // bool? isLoggedin = await LocalDb().getLoginStatus();
      if ((isLoggedin) == false) {
        await Get.to(() => const LoginScreen(
              ishelp: true,
            ));
      }
    }
    bool? loggeding = await LocalDb().getLoginStatus();
    if ((loggeding ?? false) == true) {
      selectedPage = index;
    }

    update();

    // await listToLoad();
    // lengthOfList();
  }

  static BottomBarController get i => Get.put(BottomBarController());
}
