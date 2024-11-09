// ignore_for_file: use_build_context_synchronously, deprecated_member_use, unused_local_variable

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:tabib_al_bait/components/images.dart';
import 'package:tabib_al_bait/data/controller/auth_controller.dart';
import 'package:tabib_al_bait/data/controller/bottom_nav_bar_controller.dart';
import 'package:tabib_al_bait/data/localDB/local_db.dart';
import 'package:tabib_al_bait/helpers/color_manager.dart';
import 'package:tabib_al_bait/helpers/values_manager.dart';
import 'package:tabib_al_bait/screens/dashboard/home.dart';
// import 'package:tabib_al_bait/screens/dashboard/menu_drawer.dart';
import 'package:tabib_al_bait/screens/dashboard/profile.dart';
import 'package:tabib_al_bait/screens/dashboard/schedule.dart';
import 'package:url_launcher/url_launcher.dart';

launchWhatsApp() async {
  const contact = "+971551660911";
  const androidUrl = "whatsapp://send?phone=$contact&text=Hi, I need some help";
  const iosUrl = "https://wa.me/$contact?text=Hi,%20I%20need%20some%20help";
  try {
    if (Platform.isIOS) {
      await launchUrl(Uri.parse(iosUrl));
    } else {
      await launchUrl(Uri.parse(androidUrl));
    }
  } on Exception {
    Fluttertoast.showToast(msg: 'WhatsApp Not Installed on your device');
  }
}

int selectedPage = 0;

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> with WidgetsBindingObserver {
  call() async {
    bool? value = await LocalDb().getfingerprintstatus();
    AuthController.i.updateFingerPrint(value);
  }

  @override
  void initState() {
    call();
    // TODO: implement initState
    super.initState();
  }

  DateTime timeBackPressed = DateTime.now();
  bool isKeyboardVisible = false;

  final List<Widget> pages = const [
    HomeScreen(),
    ScheduledAppointments(),
    Profile(
      isProfile: true,
    ),

    // AllChats(),
    // Settings(),
  ];

  // void navigateToPage(int index) async {
  //   if (index == 1) {
  //     bool? isLoggedin = await LocalDb().getLoginStatus();
  //     if ((isLoggedin ?? false) == false) {
  //       Get.off(() => const LoginScreen(
  //             isHerefromSchedule: true,
  //           ));
  //     } else {
  //       ScheduleController.i.clearData();
  //       ScheduleController.i.ApplyFilterForAppointments(0);
  //       ScheduleController.i.getAppointmentsSummery();
  //     }
  //   } else if (index == 2) {
  //     bool? isLoggedin = await LocalDb().getLoginStatus();
  //     if ((isLoggedin ?? false) == false) {
  //       Get.off(() => const LoginScreen(
  //             isprofile: true,
  //           ));
  //     }
  //   } else if (index == 3) {
  //     bool? isLoggedin = await LocalDb().getLoginStatus();
  //     if ((isLoggedin ?? false) == false) {
  //       Get.off(() => const LoginScreen(
  //             ishelp: true,
  //           ));
  //     } else {
  //       launchWhatsApp();
  //     }
  //   }

  //   setState(() {
  //     selectedPage = index;
  //   });
  //   // await listToLoad();
  //   // lengthOfList();
  // }

  @override
  Widget build(BuildContext context) {
    Future<bool> showExitPopup() async {
      if (selectedPage == 0) {
        if (ZoomDrawer.of(context)!.isOpen()) {
          await ZoomDrawer.of(context)?.close();
        }
        return await showDialog(
              //show confirm dialogue
              //the return value will be from "Yes" or "No" options
              context: context,
              builder: (context) => AlertDialog(
                title: Text('ExitApp'.tr),
                content: Text('DoYouwantToExit'.tr),
                actions: [
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    //return false when click on "NO"
                    child: Text('no'.tr),
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    //return true when click on "Yes"
                    child: Text('yes'.tr),
                  ),
                ],
              ),
            ) ??
            false;
      } else {
        selectedPage = 0;
        BottomBarController.i.update();
        return false;
      }
      //if showDialouge had returned null, then return false
    }

    var cont = Get.put<BottomBarController>(BottomBarController());
    return GetBuilder<BottomBarController>(builder: (cont) {
      return WillPopScope(
        onWillPop: showExitPopup,
        child: Scaffold(
          body: IndexedStack(
            index: selectedPage,
            children: pages,
          ),
          bottomNavigationBar: bottomAppbar(context),
        ),
      );
    });
  }

  bottomAppbar(BuildContext context) {
    return BottomAppBar(
      // shadowColor: Colors.red,
      height: Get.height * 0.13,
      elevation: 5,
      color: Colors.white,
      notchMargin: 10.0,
      shape: const CircularNotchedRectangle(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.max,
        children: [
          buildBottomNavItem(Images.homeIcon, 'home'.tr, 0, isSvg: true),
          buildBottomNavItem(Images.user, 'profile'.tr, 2, isSvg: false),
          buildBottomNavItem(Images.schedule, 'schedule'.tr, 1, isSvg: false),
          buildBottomNavItem(Images.help, 'help'.tr, 3, isSvg: false),
        ],
      ),
    );
  }

  buildMenuItem(IconData icon, String label, {Function()? onPressed}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Material(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        child: InkWell(
          onTap: onPressed,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  size: 1,
                ),
                const SizedBox(width: 10),
                Text(label),
              ],
            ),
          ),
        ),
      ),
    );
  }

  buildBottomNavItem(String imagePath, String label, int index,
      {bool? isSvg = false}) {
    final isSelected = selectedPage == index;
    return InkWell(
      onTap: () {
        if (index == 3) {
          launchWhatsApp();
        } else {
          BottomBarController.i.navigateToPage(index);
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            imagePath.isEmpty
                ? const SizedBox()
                : isSvg == false
                    ? Container(
                        padding: const EdgeInsets.all(AppPadding.p8),
                        decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
                                color: ColorManager.kGreyColor,
                                blurRadius: 1.0,
                                spreadRadius: 1,
                                blurStyle: BlurStyle.normal,
                                offset: Offset(
                                  1,
                                  2,
                                ),
                              )
                            ],
                            shape: BoxShape.circle,
                            color: isSelected == true
                                ? ColorManager.kPrimaryColor
                                : ColorManager.kWhiteColor),
                        child: Image.asset(
                          imagePath,
                          color: isSelected
                              ? ColorManager.kWhiteColor
                              : ColorManager.kPrimaryDark,
                          height: Get.height * 0.025,
                        ),
                      )
                    : Container(
                        padding: const EdgeInsets.all(AppPadding.p8),
                        decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
                                color: ColorManager.kGreyColor,
                                blurRadius: 1.0,
                                spreadRadius: 1,
                                blurStyle: BlurStyle.normal,
                                offset: Offset(
                                  1,
                                  2,
                                ),
                              )
                            ],
                            shape: BoxShape.circle,
                            color: isSelected == true
                                ? ColorManager.kPrimaryColor
                                : ColorManager.kWhiteColor),
                        child: SvgPicture.asset(imagePath,
                            color: isSelected
                                ? ColorManager.kWhiteColor
                                : ColorManager.kPrimaryDark,
                            height: Get.height * 0.025),
                      ),
            SizedBox(
              height: Get.height * 0.01,
            ),
            Text(
              label,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontSize: 12, color: ColorManager.kPrimaryDark),
            )
          ],
        ),
      ),
    );
  }
}
