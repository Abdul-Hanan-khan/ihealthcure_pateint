// ignore_for_file: deprecated_member_use

import 'dart:developer';

import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:tabib_al_bait/components/custom_textfields.dart';
import 'package:tabib_al_bait/components/images.dart';
import 'package:tabib_al_bait/components/primary_button.dart';
import 'package:tabib_al_bait/data/controller/auth_controller.dart';
import 'package:tabib_al_bait/data/controller/family_screens_controller.dart';
import 'package:tabib_al_bait/data/repositories/family_screens_repo/family_screens_repo.dart';
import 'package:tabib_al_bait/helpers/color_manager.dart';
import 'package:tabib_al_bait/helpers/font_manager.dart';
import 'package:tabib_al_bait/helpers/show_toast.dart';
import 'package:tabib_al_bait/helpers/values_manager.dart';
import 'package:tabib_al_bait/models/search_family_member_model/search_family_member_model.dart';
import 'package:tabib_al_bait/screens/family_screens/family_members.dart';
import '../../components/image_container.dart';

class StatusScreen extends StatefulWidget {
  final SearchFamilyMemberResponse? data;
  const StatusScreen({super.key, this.data});

  @override
  State<StatusScreen> createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // var cont = Get.put<MyFamilyScreensController>(MyFamilyScreensController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: CustomAppBar(
          title: 'familyMember'.tr,
        ),
      ),
      body: GetBuilder<MyFamilyScreensController>(builder: (myfam) {
        return GetBuilder<AuthController>(builder: (cont) {
          return BlurryModalProgressHUD(
            inAsyncCall: myfam.existingFamilyMemberLoader,
            blurEffectIntensity: 4,
            progressIndicator: const SpinKitSpinningLines(
              color: Color(0xff1272d3),
              size: 60,
            ),
            dismissible: false,
            opacity: 0.4,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(AppPadding.p20),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30)),
                      color: ColorManager.kPrimaryColor),
                  width: Get.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                          child: Text(
                        'recordFound'.tr,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: ColorManager.kWhiteColor,
                            fontWeight: FontWeightManager.bold),
                      )),
                      SizedBox(
                        height: Get.height * 0.02,
                      ),
                      RecordWidget(
                          title: 'Full Name',
                          name: '${widget.data?.data?.first.name}'),
                      SizedBox(
                        height: Get.height * 0.02,
                      ),
                      RecordWidget(
                          title: 'Gender',
                          name: '${widget.data?.data?.first.gender}'),
                      SizedBox(
                        height: Get.height * 0.02,
                      ),
                      RecordWidget(
                          title: 'Registration\nDate',
                          name:
                              '${widget.data?.data?.first.registerationDate?.split('T').first}'),
                      SizedBox(
                        height: Get.height * 0.02,
                      ),
                      RecordWidget(
                          title: 'Age',
                          name: '${widget.data?.data?.first.age} years'),
                      SizedBox(
                        height: Get.height * 0.02,
                      ),
                      RecordWidget(
                          title: 'ID',
                          name: '${widget.data?.data?.first.identityNo} '),
                      SizedBox(
                        height: Get.height * 0.04,
                      ),
                      GetBuilder<MyFamilyScreensController>(builder: (cont) {
                        return InkWell(
                          onTap: () {
                            paymentMethodDialogue(context);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: ColorManager.kPrimaryLightColor),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 12),
                            child: GetBuilder<MyFamilyScreensController>(
                                builder: (myfam) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    MyFamilyScreensController
                                            .i.relationShip?.name ??
                                        'yourrelation'.tr,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                            color: ColorManager.kPrimaryColor,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                  ),
                                  Image.asset(Images.dropdown)
                                ],
                              );
                            }),
                          ),
                        );
                      }),
                      SizedBox(
                        height: Get.height * 0.02,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextField(
                              isSizedBoxAvailable: false,
                              fillColor: ColorManager.kWhiteColor,
                              hintText: MyFamilyScreensController.i.file != null
                                  ? MyFamilyScreensController.i.file?.path
                                      .split('/')
                                      .last
                                  : 'Document Of Proof',
                              readonly: true,
                            ),
                          ),
                          SizedBox(
                            width: Get.width * 0.02,
                          ),
                          ImageContainer(
                            onpressed: () async {
                              MyFamilyScreensController.i.file =
                                  await AuthController.i
                                      .pickImage(context: context);
                            },
                            color: ColorManager.kPrimaryColor,
                            isSvg: false,
                            backgroundColor: ColorManager.kWhiteColor,
                            imagePath: Images.add,
                          )
                        ],
                      )
                    ],
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(AppPadding.p20),
                  child: PrimaryButton(
                    title: 'Add Family Member',
                    onPressed: () {
                      log(widget.data!.toJson().toString());
                      if (MyFamilyScreensController.i.relationShip != null) {
                        FamilyScreensRepo().addExistingFamilyMember(
                            age: widget.data!.data![0].age,
                            id: widget.data!.data![0].id!,
                            cnic: widget.data!.data![0].identityNo ?? '',
                            mrNo: widget.data!.data![0].mRNo ?? '',
                            document: MyFamilyScreensController.i.file?.path
                                    .split('/')
                                    .last ??
                                '',
                            relationId:
                                MyFamilyScreensController.i.relationShip!.id!,
                            dob: widget.data!.data![0].registerationDate
                                .toString());
                      } else {
                        ToastManager.showToast('Select Relationship');
                      }
                      // showDialog(
                      //     context: context,
                      //     builder: (context) {
                      //       return Material(
                      //           type: MaterialType.transparency,
                      //           shape: const RoundedRectangleBorder(),
                      //           color: ColorManager.kWhiteColor,
                      //           child: AlertDialog(
                      //             content: Column(
                      //               mainAxisSize: MainAxisSize.min,
                      //               children: [
                      //                 Align(
                      //                     alignment: Alignment.topRight,
                      //                     child: Image.asset(Images.crossicon)),
                      //                 SizedBox(
                      //                   height: Get.height * 0.04,
                      //                 ),
                      //                 Text(
                      //                   'Family Member Add Request',
                      //                   style: Theme.of(context)
                      //                       .textTheme
                      //                       .bodyMedium!
                      //                       .copyWith(
                      //                           color: ColorManager.kPrimaryColor,
                      //                           fontSize: 14,
                      //                           fontWeight: FontWeight.w900),
                      //                 ),
                      //                 SizedBox(
                      //                   height: Get.height * 0.04,
                      //                 ),
                      //                 InkWell(
                      //                   onTap: () {
                      //                     Get.back();
                      //                   },
                      //                   child: const CircleAvatar(
                      //                     radius: 35,
                      //                     backgroundImage: AssetImage(Images.profile),
                      //                   ),
                      //                 ),
                      //                 SizedBox(
                      //                   height: Get.height * 0.01,
                      //                 ),
                      //                 Text(
                      //                   'Muhammad Yousaf',
                      //                   style: Theme.of(context)
                      //                       .textTheme
                      //                       .bodyMedium!
                      //                       .copyWith(
                      //                           color: ColorManager.kPrimaryColor,
                      //                           fontSize: 14,
                      //                           fontWeight: FontWeight.w900),
                      //                 ),
                      //                 SizedBox(
                      //                   height: Get.height * 0.01,
                      //                 ),
                      //                 Text(
                      //                   'Mr. No 1234 567890',
                      //                   style: Theme.of(context)
                      //                       .textTheme
                      //                       .bodyMedium!
                      //                       .copyWith(
                      //                           color: ColorManager.kPrimaryColor,
                      //                           fontSize: 11,
                      //                           fontWeight: FontWeight.w400),
                      //                 ),
                      //                 SizedBox(
                      //                   height: Get.height * 0.01,
                      //                 ),
                      //                 Text(
                      //                   AppConstants.requestText,
                      //                   textAlign: TextAlign.center,
                      //                   style: Theme.of(context)
                      //                       .textTheme
                      //                       .bodyMedium!
                      //                       .copyWith(
                      //                           color: ColorManager.kblackColor,
                      //                           fontSize: 10,
                      //                           fontWeight: FontWeight.w400),
                      //                 ),
                      //                 SizedBox(
                      //                   height: Get.height * 0.05,
                      //                 ),
                      //                 Row(
                      //                   mainAxisAlignment:
                      //                       MainAxisAlignment.spaceBetween,
                      //                   children: [
                      //                     Expanded(
                      //                         child: PrimaryButton(
                      //                             height: Get.height * 0.06,
                      //                             title: 'Accept',
                      //                             fontSize: 12,
                      //                             onPressed: () {},
                      //                             color: ColorManager.kPrimaryColor,
                      //                             textcolor:
                      //                                 ColorManager.kWhiteColor)),
                      //                     SizedBox(
                      //                       width: Get.width * 0.05,
                      //                     ),
                      //                     Expanded(
                      //                         child: PrimaryButton(
                      //                             border: Border.all(
                      //                                 color:
                      //                                     ColorManager.kPrimaryColor),
                      //                             height: Get.height * 0.06,
                      //                             title: 'Deny',
                      //                             fontSize: 12,
                      //                             onPressed: () {},
                      //                             color: ColorManager.kWhiteColor,
                      //                             textcolor:
                      //                                 ColorManager.kPrimaryColor)),
                      //                   ],
                      //                 )
                      //               ],
                      //             ),
                      //           ));
                      //     });
                    },
                    color: ColorManager.kPrimaryColor,
                    textcolor: ColorManager.kWhiteColor,
                    fontSize: 14,
                    fontweight: FontWeight.w900,
                  ),
                )
              ],
            ),
          );
        });
      }),
    );
  }
}

class RecordWidget extends StatelessWidget {
  final bool? isDoctorConsultationScreen;
  final String? title;
  final String? name;
  final Color? color;

  const RecordWidget(
      {Key? key,
      this.title,
      this.name,
      this.color,
      this.isDoctorConsultationScreen = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: isDoctorConsultationScreen == false ? 30 : 0),
      child: Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: isDoctorConsultationScreen == false
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 4,
                  child: Text(
                    '${title?.trimLeft()}',
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: color ?? Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                  ),
                ),
                const SizedBox(
                  width: 4,
                ),
                Expanded(
                  flex: 4,
                  // flex: 1,
                  child: Center(
                    child: Text(
                      ':',
                      style: TextStyle(
                        color: color ?? Colors.white,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 7,
                  child: Text(
                    '${name?.trim()}',
                    maxLines: 2,
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: color ?? Colors.white,
                          fontWeight: FontWeight.w300,
                          fontSize: 12,
                        ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: Get.height * 0.01,
            ),
          ],
        ),
      ),
    );
  }
}

paymentMethodDialogue(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        return FractionallySizedBox(
          child: AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Spacer(),
                  Text('relationship'.tr),
                  const Spacer(),
                  CircleAvatar(
                      radius: 15,
                      backgroundColor: ColorManager.kRedColor,
                      child: IconButton(
                        icon: const Icon(
                          Icons.close,
                        ),
                        onPressed: () {
                          Get.back();
                        },
                        iconSize: 15,
                        color: ColorManager.kWhiteColor,
                      ))
                ]),
            content: SizedBox(
              width: double.maxFinite,
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: MyFamilyScreensController.i.relationShipsList.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  var relation =
                      MyFamilyScreensController.i.relationShipsList[index];
                  log(relation.id.toString());
                  return InkWell(
                    onTap: () {
                      MyFamilyScreensController.i
                          .updateSelectedRelationShip(relation);
                      log(relation.id.toString());
                      Get.back();
                    },
                    child: Container(
                      margin: const EdgeInsets.all(5),
                      padding: const EdgeInsets.all(AppPadding.p10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: ColorManager.kPrimaryLightColor),
                      child: Row(
                        children: [
                          Text(
                            '${relation.name}',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(color: ColorManager.kPrimaryColor),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      });
}
