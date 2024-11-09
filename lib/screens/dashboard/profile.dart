import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tabib_al_bait/components/images.dart';
import 'package:tabib_al_bait/components/primary_button.dart';
import 'package:tabib_al_bait/data/controller/auth_controller.dart';
import 'package:tabib_al_bait/helpers/color_manager.dart';
import 'package:tabib_al_bait/screens/dashboard/home.dart';
import 'package:tabib_al_bait/screens/family_screens/family_members.dart';
import 'package:tabib_al_bait/screens/family_screens/status_screen.dart';
import 'package:tabib_al_bait/screens/profile/profile.dart';
import 'package:tabib_al_bait/utils/constants.dart';

class Profile extends StatefulWidget {
  final bool? isProfile;
  const Profile({super.key, this.isProfile = false});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Timer? _timer;
  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    DateTime currentTime = DateTime.now();

    // String truncateText(String text, int wordLimit) {
    //   List<String> words = text.split(' ');
    //   if (words.length <= wordLimit) {
    //     return text;
    //   }
    //   return '${words.sublist(0, wordLimit).join(' ')}...';
    // }

    // ignore: unused_element
    void initState() {
      super.initState();

      Timer(const Duration(seconds: 2), () {
        if (mounted) {}
      });
    }

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: CustomAppBar(
            isScheduleScreen: widget.isProfile,
            title: 'profile'.tr,
          )),
      body: SafeArea(
        minimum: EdgeInsets.only(top: Get.height * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: AuthController.i.user?.fullName == null
                  ? const CircleAvatar(
                      backgroundImage: AssetImage(Images.doctorAvatar),
                    )
                  : CircleAvatar(
                      radius: 35,
                      backgroundImage: NetworkImage(
                          '$baseURL/${AuthController.i.user?.imagePath}'),
                    ),
              title: Text(
                AuthController.i.user?.firstName?.trim() ?? "patient".tr,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontSize: 25),
              ),
              subtitle: Text(
                getGreetingMessage(),
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: 12,
                      letterSpacing: 3,
                    ),
              ),
            ),
            const Spacer(),
            Container(
              alignment: Alignment.bottomCenter,
              width: Get.width,
              padding: EdgeInsets.symmetric(vertical: Get.height * 0.08),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                  color: ColorManager.kPrimaryColor),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: Get.height * 0.05,
                    child: RecordWidget(
                      title: 'fullName'.tr,
                      name: AuthController.i.user?.firstName ?? "-".tr,
                    ),
                  ),
                  RecordWidget(
                    title: 'dateOfBirth'.tr,
                    name: (AuthController.i.user?.dateofbirth != null)
                        ? DateFormat('MM-dd-y').format(DateTime.parse(
                            AuthController.i.user!.dateofbirth!.split("T")[0]))
                        : "-",
                  ),
                  RecordWidget(
                    title: 'contact'.tr,
                    name: AuthController.i.user?.cellNumber ?? "-",
                  ),
                  RecordWidget(
                    title: 'email'.tr,
                    name: AuthController.i.user?.email ?? "-",
                  ),
                  RecordWidget(
                    title: 'country'.tr,
                    name: AuthController.i.user?.country ?? "-",
                  ),
                  RecordWidget(
                    title: 'province/state'.tr,
                    name: AuthController.i.user?.stateOrProvince ?? "-",
                  ),
                  RecordWidget(
                    title: 'city'.tr,
                    name: AuthController.i.user?.city ?? "-".tr,
                  ),
                  RecordWidget(
                    title: 'address'.tr,
                    name: AuthController.i.user?.address ?? "-".tr,
                  ),
                  SizedBox(
                    height: Get.height * 0.068,
                  ),
                  PrimaryButton(
                      width: Get.width * 0.8,
                      height: Get.height * 0.06,
                      title: 'editProfile'.tr,
                      onPressed: () {
                        Get.to(() => EditProfile(
                              firstName: AuthController.i.user?.firstName ?? "",
                              dob: AuthController.i.user?.dateofbirth ?? "",
                              cellNumber:
                                  AuthController.i.user?.cellNumber ?? "",
                              email: AuthController.i.user?.email ?? "",
                              country: AuthController.i.user?.country ?? "",
                              province:
                                  AuthController.i.user?.stateOrProvince ?? "",
                              city: AuthController.i.user?.city ?? "",
                              patientAddress:
                                  AuthController.i.user?.address ?? "",
                            ));
                      },
                      color: ColorManager.kWhiteColor,
                      textcolor: ColorManager.kPrimaryColor),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
