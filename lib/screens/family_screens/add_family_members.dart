// ignore_for_file: unused_local_variable, avoid_unnecessary_containers

import 'dart:developer';

import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:tabib_al_bait/components/custom_textfields.dart';
import 'package:tabib_al_bait/components/images.dart';
import 'package:tabib_al_bait/components/primary_button.dart';
import 'package:tabib_al_bait/data/controller/auth_controller.dart';
import 'package:tabib_al_bait/data/controller/controller.dart';
import 'package:tabib_al_bait/data/controller/family_screens_controller.dart';
import 'package:tabib_al_bait/data/localDB/local_db.dart';
import 'package:tabib_al_bait/data/repositories/family_screens_repo/family_screens_repo.dart';
import 'package:tabib_al_bait/helpers/color_manager.dart';
import 'package:tabib_al_bait/helpers/show_toast.dart';
import 'package:tabib_al_bait/helpers/values_manager.dart';
import 'package:tabib_al_bait/models/get_blood_groups/get_blood_groups.dart';
import 'package:tabib_al_bait/models/get_martial_statuses/get_martial_statuses.dart';
import 'package:tabib_al_bait/models/relation_ships_model/relation_ship_model.dart';
import 'package:tabib_al_bait/models/search_family_member_model/search_family_member_model.dart';
import 'package:tabib_al_bait/screens/family_screens/family_members.dart';
import 'package:tabib_al_bait/screens/family_screens/status_screen.dart';
import 'package:tabib_al_bait/utils/textfield_masks/masks.dart';

class AddFamilyMember extends StatefulWidget {
  const AddFamilyMember({super.key});

  @override
  State<AddFamilyMember> createState() => _AddFamilyMemberState();
}

class _AddFamilyMemberState extends State<AddFamilyMember> {
  @override
  void dispose() {
    controller.clear();
    firstName.clear();
    lastName.clear();
    fathersName.clear();
    phoneNumber.clear();
    idNumber.clear();
    address.clear();
    MyFamilyScreensController.i
        .updateBloodGroup(BloodGroups(name: null, id: null));
    MyFamilyScreensController.i
        .updateMartialStatuses(MartialStatuses(name: null, id: null));
    MyFamilyScreensController.i
        .updateSelectedRelation(RelationShipsData(name: null, id: null));

    super.dispose();
  }

  TextEditingController controller = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController fathersName = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController idNumber = TextEditingController();
  TextEditingController address = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  // final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var contr = Get.put<FamilyScreensController>(FamilyScreensController());
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: CustomAppBar(title: "familyMembers".tr)),
      body: GetBuilder<MyFamilyScreensController>(builder: (cont) {
        return BlurryModalProgressHUD(
          inAsyncCall: MyFamilyScreensController.i.familyMembersAddLoader,
          blurEffectIntensity: 4,
          progressIndicator: const SpinKitSpinningLines(
            color: Color(0xff1272d3),
            size: 60,
          ),
          dismissible: false,
          opacity: 0.4,
          color: Theme.of(context).scaffoldBackgroundColor,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(AppPadding.p20),
              child: SingleChildScrollView(
                child: GetBuilder<FamilyScreensController>(builder: (contr) {
                  return GetBuilder<MyFamilyScreensController>(
                      builder: (myfam) {
                    return Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          CustomTextField(
                            inputFormatters: [Masks().maskFormatter],
                            controller: controller,
                            hintText: 'Mr. No',
                            inputType: TextInputType.number,
                          ),
                          PrimaryButton(
                              title: 'Connect Family Member',
                              onPressed: () async {
                                SearchFamilyMemberResponse data =
                                    await FamilyScreensRepo()
                                        .searchFamilyMember(controller.text);
                                log(data.toJson().toString());
                                if (data.data!.isEmpty ||
                                    controller.text.isEmpty) {
                                  Fluttertoast.showToast(
                                      msg: "No Record Found",
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.SNACKBAR,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: ColorManager.kRedColor,
                                      textColor: ColorManager.kWhiteColor,
                                      webBgColor:
                                          "linear-gradient(to right, #00b09b, #1272D3)",
                                      fontSize: 16.0);
                                } else {
                                  var branchId = await LocalDb().getBranchId();
                                  log(branchId.toString());
                                  Get.to(() => StatusScreen(
                                        data: data,
                                      ));
                                }
                              },
                              fontweight: FontWeight.w900,
                              fontSize: 14,
                              color: ColorManager.kPrimaryColor,
                              textcolor: ColorManager.kWhiteColor),
                          SizedBox(
                            height: Get.height * 0.01,
                          ),
                          Text(
                            'addFamilyMembers'.tr,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                    fontSize: 13, fontWeight: FontWeight.w900),
                          ),
                          Text(
                            'personalInformation'.tr,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                    fontSize: 10, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: Get.height * 0.01,
                          ),
                          CustomTextField(
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r"[a-zA-Z\s]")),
                            ],
                            validator: (p0) {
                              if (p0!.isEmpty) {
                                return 'First name field is required';
                              }
                              return null;
                            },
                            controller: firstName,
                            hintText: 'First Name',
                          ),
                          CustomTextField(
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r"[a-zA-Z\s]")),
                            ],
                            validator: (p0) {
                              if (p0!.isEmpty) {
                                return 'Last name is Required';
                              }
                              return null;
                            },
                            controller: lastName,
                            hintText: 'Last Name',
                          ),
                          CustomTextField(
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r"[a-zA-Z\s]")),
                            ],
                            controller: fathersName,
                            hintText: 'Father Name',
                          ),
                          GetBuilder<MyFamilyScreensController>(
                              builder: (cont) {
                            return InkWell(
                              onTap: () {
                                FamilyScreensController.i.onTapped = true;
                                FamilyScreensController.i.selectDateAndTime(
                                    context: context,
                                    date: MyFamilyScreensController.dob,
                                    isFamilyScreen: true,
                                    formattedDate: cont.formattedDob!);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: ColorManager.kPrimaryLightColor),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 12),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      FamilyScreensController.i.onTapped == true
                                          ? '${MyFamilyScreensController.i.formattedDob ?? 'dateOfBirth'.tr}'
                                          : "dateOfBirth".tr,
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
                                ),
                              ),
                            );
                          }),
                          SizedBox(
                            height: Get.height * 0.02,
                          ),
                          CustomTextField(
                            controller: phoneNumber,
                            hintText: 'Phone Number',
                            inputType: TextInputType.phone,
                            validator: (p0) {
                              if (p0!.isEmpty) {
                                return 'Enter Phone Number';
                              }
                              return null;
                            },
                          ),
                          GetBuilder<FamilyScreensController>(builder: (cont) {
                            return InkWell(
                              onTap: () {
                                getRelationShips(context);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: ColorManager.kPrimaryLightColor),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${MyFamilyScreensController.i.selectedRelationShip?.name ?? 'relation'.tr} ',
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
                                ),
                              ),
                            );
                          }),
                          SizedBox(
                            height: Get.height * 0.02,
                          ),
                          CustomTextField(
                            inputType: TextInputType.phone,
                            validator: (p0) {
                              if (p0!.isEmpty) {
                                return 'National ID is required';
                              }
                              return null;
                            },
                            controller: idNumber,
                            hintText: 'ID 123 4567 8910',
                          ),
                          GetBuilder<FamilyScreensController>(builder: (cont) {
                            return InkWell(
                              onTap: () {
                                getGenders(context);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: ColorManager.kPrimaryLightColor),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      MyFamilyScreensController
                                              .i.selectedGender?.name ??
                                          'gender'.tr,
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
                                ),
                              ),
                            );
                          }),
                          SizedBox(
                            height: Get.height * 0.02,
                          ),
                          GetBuilder<FamilyScreensController>(builder: (cont) {
                            return InkWell(
                              onTap: () {
                                getMartialStatuses(context);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: ColorManager.kPrimaryLightColor),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      myfam.status?.name ?? 'martialStatus'.tr,
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
                                ),
                              ),
                            );
                          }),
                          SizedBox(
                            height: Get.height * 0.02,
                          ),
                          GetBuilder<FamilyScreensController>(builder: (cont) {
                            return InkWell(
                              onTap: () {
                                getBloodGroups(context);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: ColorManager.kPrimaryLightColor),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      myfam.selectedBloodGroup?.name ??
                                          'bloodGroup'.tr,
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
                                ),
                              ),
                            );
                          }),
                          SizedBox(
                            height: Get.height * 0.02,
                          ),
                          CustomTextField(
                            validator: (p0) {
                              if (p0!.isEmpty) {
                                return 'Address field is required';
                              }
                              return null;
                            },
                            controller: address,
                            hintText: 'Address',
                          ),
                          PrimaryButton(
                              title: 'addFamilyMember'.tr,
                              fontSize: 14,
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  if (myfam.selectedRelationShip == null) {
                                    ToastManager.showToast(
                                        'Relation not selected',
                                        bgColor: ColorManager.kRedColor);
                                  } else if (myfam.selectedGender == null) {
                                    ToastManager.showToast(
                                        'Gender not selected',
                                        bgColor: ColorManager.kRedColor);
                                  } else if (myfam.selectedBloodGroup == null) {
                                    ToastManager.showToast(
                                        'Blood Group not selected',
                                        bgColor: ColorManager.kRedColor);
                                  } else if (myfam.status == null) {
                                    ToastManager.showToast(
                                        'Martial Status not selected',
                                        bgColor: ColorManager.kRedColor);
                                  } else {
                                    int? val = await FamilyScreensRepo()
                                        .addNewFamilyMember(
                                            firstName.text,
                                            lastName.text,
                                            '',
                                            idNumber.text,
                                            myfam.formattedDob!.toString(),
                                            phoneNumber.text,
                                            '',
                                            '',
                                            '',
                                            fathersName.text,
                                            address.text,
                                            myfam.selectedBloodGroup?.id,
                                            myfam.selectedRelationShip?.id);
                                    if (val != null && val == 1) {
                                      Get.back();
                                    }
                                  }
                                }
                              },
                              color: ColorManager.kPrimaryColor,
                              textcolor: ColorManager.kWhiteColor)
                        ],
                      ),
                    );
                  });
                }),
              ),
            ),
          ),
        );
      }),
    );
  }
}

getMartialStatuses(BuildContext context) {
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
                  Text('selectMaritalStatus'.tr),
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
                itemCount: MyFamilyScreensController.i.martialStatuses.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final status =
                      MyFamilyScreensController.i.martialStatuses[index];
                  return InkWell(
                    onTap: () {
                      MyFamilyScreensController.i.updateMartialStatuses(status);
                      Get.back();
                    },
                    child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: ColorManager.kPrimaryLightColor),
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        child: Text(
                          '${status.name}',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                  color: ColorManager.kPrimaryColor,
                                  fontWeight: FontWeight.bold),
                        )),
                  );
                },
              ),
            ),
          ),
        );
      });
}

getGenders(BuildContext context) {
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
                  Text('selectGender'.tr),
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
                itemCount: AuthController.i.genders!.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final gender = AuthController.i.genders?[index];
                  return InkWell(
                    onTap: () {
                      MyFamilyScreensController.i.updateSelectedGender(gender!);
                      Get.back();
                    },
                    child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: ColorManager.kPrimaryLightColor),
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        child: Text(
                          '${gender?.name}',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                  color: ColorManager.kPrimaryColor,
                                  fontWeight: FontWeight.bold),
                        )),
                  );
                },
              ),
            ),
          ),
        );
      });
}

getBloodGroups(BuildContext context) {
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
                  Text('selectBloodGroup'.tr),
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
                itemCount: MyFamilyScreensController.i.bloodGroupds!.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final gender =
                      MyFamilyScreensController.i.bloodGroupds?[index];
                  return InkWell(
                    onTap: () {
                      MyFamilyScreensController.i.updateBloodGroup(gender!);
                      Get.back();
                    },
                    child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: ColorManager.kPrimaryLightColor),
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        child: Text(
                          '${gender?.name}',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                  color: ColorManager.kPrimaryColor,
                                  fontWeight: FontWeight.bold),
                        )),
                  );
                },
              ),
            ),
          ),
        );
      });
}

getRelationShips(BuildContext context) {
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
                  Text('relationShip'.tr),
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
                          .updateSelectedRelation(relation);
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
