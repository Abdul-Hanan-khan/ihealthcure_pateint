import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tabib_al_bait/components/images.dart';
import 'package:tabib_al_bait/components/primary_button.dart';
import 'package:tabib_al_bait/data/controller/bottom_nav_bar_controller.dart';
import 'package:tabib_al_bait/data/controller/family_screens_controller.dart';
import 'package:tabib_al_bait/helpers/color_manager.dart';
import 'package:tabib_al_bait/helpers/font_manager.dart';
import 'package:tabib_al_bait/helpers/values_manager.dart';
import 'package:tabib_al_bait/main.dart';
import 'package:tabib_al_bait/models/family_members_response/family_members_response.dart';
import 'package:tabib_al_bait/screens/dashboard/menu_drawer.dart';
import 'package:tabib_al_bait/screens/family_screens/add_family_members.dart';

class FamilyMembers extends StatefulWidget {
  const FamilyMembers({super.key});
  @override
  State<FamilyMembers> createState() => _FamilyMembersState();
}

class _FamilyMembersState extends State<FamilyMembers> {
  @override
  void initState() {
    MyFamilyScreensController.i.getFamilyMembers();
    MyFamilyScreensController.i.getRelationShipsList();
    MyFamilyScreensController.i.getBloodGroups();
    MyFamilyScreensController.i.getMartialStatuses();
    // internetCheck();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: CustomAppBar(
            title: 'familyMembers'.tr,
          )),
      body: GetBuilder<MyFamilyScreensController>(builder: (cont) {
        return cont.isLoading == false
            ? RefreshIndicator(
                onRefresh: () {
                  return MyFamilyScreensController.i.getFamilyMembers();
                },
                child: Padding(
                  padding:
                      const EdgeInsets.all(AppPadding.p20).copyWith(top: 0),
                  child: Form(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          PrimaryButton(
                              title: 'Add Family Members',
                              onPressed: () {
                                Get.to(() => const AddFamilyMember());
                              },
                              color: ColorManager.kPrimaryColor,
                              fontSize: FontSize.s14,
                              textcolor: ColorManager.kWhiteColor),
                          ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              padding: const EdgeInsets.only(top: 10),
                              itemCount: cont.familyMembersData.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                var data = cont.familyMembersData[index];
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      top: AppPadding.p10),
                                  child: customListTile(context, data),
                                );
                              }),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            : const Center(
                child: CircularProgressIndicator(),
              );
      }),
    );
  }

  customListTile(BuildContext context, FamilyMembersData data) {
    return Container(
      padding: const EdgeInsets.all(AppPadding.p10),
      decoration: BoxDecoration(
          color: ColorManager.kPrimaryLightColor,
          borderRadius: BorderRadius.circular(15)),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25, // Adjust the radius as needed
            backgroundColor: ColorManager.kPrimaryLightColor, // Border color
            child: data.picturePath != null
                ? CachedNetworkImage(
                    imageUrl:
                        '${containsFile(data.picturePath)}/${data.picturePath}',
                    imageBuilder: (context, imageProvider) => CircleAvatar(
                      backgroundImage: imageProvider,
                      radius: 20,
                      backgroundColor: Colors.transparent,
                    ),
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(), // Placeholder while loading
                    errorWidget: (context, url, error) => const CircleAvatar(
                      radius: 20,
                      backgroundImage:
                          AssetImage(Images.avatar), // Error widget
                    ),
                  )
                : const CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage(Images.avatar),
                  ),
          ),

          const SizedBox(width: 10), // Adjust as needed
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: Get.width * 0.3,
                child: Text(
                  data.name?.split('(Private)').first.trimLeft() ?? '',
                  textAlign: TextAlign.left,
                  maxLines: 2,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: ColorManager.kPrimaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                'MR No. ${data.mRNo ?? '-'} ',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: ColorManager.kPrimaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 10),
              ),
            ],
          ),
          const Spacer(),
          const SizedBox(
            height: 50,
            child: VerticalDivider(),
          ),
          SizedBox(
            width: Get.width * 0.2,
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        width: Get.width * 0.15,
                        child: data.age?.split('').first != '0'
                            ? data.age != null
                                ? Text(
                                    '${data.age?.split('').first} years',
                                    textAlign: TextAlign.start,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                            fontSize: 11,
                                            color: ColorManager.kPrimaryColor,
                                            fontWeight:
                                                FontWeightManager.medium),
                                  )
                                : Text(
                                    '${'Less than 1'} years',
                                    textAlign: TextAlign.start,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                            fontSize: 11,
                                            color: ColorManager.kPrimaryColor,
                                            fontWeight:
                                                FontWeightManager.medium),
                                  )
                            : const SizedBox.shrink()),
                    data.relation != null
                        ? Text(
                            '${data.relation}',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    fontSize: 11,
                                    color: ColorManager.kPrimaryColor,
                                    fontWeight: FontWeightManager.medium),
                          )
                        : const SizedBox.shrink()
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget {
  final bool? isLogoPresent;
  final bool? isScheduleScreen;
  final bool? ishelp;
  final bool? isprofile;
  final String? title;
  final Widget? widget;
  const CustomAppBar({
    super.key,
    this.title,
    this.isScheduleScreen = false,
    this.ishelp = false,
    this.isLogoPresent = false,
    this.isprofile = false,
    this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
        leading: IconButton(
            onPressed: () {
              if (isScheduleScreen == true) {
                Get.offAll(const DrawerScreen());
                BottomBarController.i.navigateToPage(0);
              } else if (isprofile == true) {
                Get.offAll(const DrawerScreen());
                BottomBarController.i.navigateToPage(0);
              } else if (ishelp == true) {
                Get.offAll(const DrawerScreen());
                BottomBarController.i.navigateToPage(0);
              }
              {
                Get.back(closeOverlays: true);
              }
            },
            icon: const Icon(Icons.arrow_back_ios,
                size: 22, color: ColorManager.kPrimaryColor)),
        centerTitle: true,
        title: isLogoPresent == false
            ? Text(
                '$title',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontWeight: FontWeight.w600, fontSize: 22),
              )
            : widget);
  }
}
