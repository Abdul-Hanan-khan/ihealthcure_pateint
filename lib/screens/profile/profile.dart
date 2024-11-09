// ignore_for_file: must_be_immutable, unnecessary_string_interpolations, unused_local_variable

import 'dart:developer';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tabib_al_bait/components/custom_textfields.dart';
import 'package:tabib_al_bait/components/images.dart';
import 'package:tabib_al_bait/components/primary_button.dart';
import 'package:tabib_al_bait/components/searchable_cities.dart';
import 'package:tabib_al_bait/components/searchable_dropdown_country.dart';
import 'package:tabib_al_bait/components/searchable_provinces.dart';
import 'package:tabib_al_bait/data/controller/auth_controller.dart';
import 'package:tabib_al_bait/data/controller/controller.dart';
import 'package:tabib_al_bait/data/controller/edit_profile_controller.dart';
import 'package:tabib_al_bait/data/controller/family_screens_controller.dart';
import 'package:tabib_al_bait/data/localDB/local_db.dart';
import 'package:tabib_al_bait/data/repositories/auth_repository/auth_repo.dart';
import 'package:tabib_al_bait/data/repositories/upload_file_repo/upload_file.dart';
import 'package:tabib_al_bait/helpers/color_manager.dart';
import 'package:tabib_al_bait/helpers/show_toast.dart';
import 'package:tabib_al_bait/helpers/values_manager.dart';
import 'package:tabib_al_bait/models/cities_model.dart';
import 'package:tabib_al_bait/models/countries_model.dart';
import 'package:tabib_al_bait/models/genders_model.dart';
import 'package:tabib_al_bait/models/get_martial_statuses/get_martial_statuses.dart';
import 'package:tabib_al_bait/models/provinces_model.dart';
import 'package:tabib_al_bait/models/user_model.dart';
import 'package:tabib_al_bait/screens/family_screens/family_members.dart';
import 'package:tabib_al_bait/utils/constants.dart';

class EditProfile extends StatefulWidget {
  final bool? isProfile;
  final String? firstName;
  final String? dob;
  final String? cellNumber;
  final String? email;
  String? country;
  final String? province;
  final String? city;
  final String? patientAddress;

  EditProfile(
      {this.dob,
      this.cellNumber,
      this.city,
      this.email,
      this.country,
      this.province,
      this.patientAddress,
      this.firstName,
      super.key,
      this.isProfile = false});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  bool? isCountryselected = false;
  bool? isprovinceselected = false;
  bool? iscityselected = false;
  TextEditingController fullname = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController datetimecontroller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    fullname.text = widget.firstName?.trimLeft() ?? '';
    phone.text = widget.cellNumber ?? '';
    email.text = widget.email ?? '';
    address.text = widget.patientAddress ?? '';

    EditProfileController.arrival = null;
    log(cont.country!.length.toString());
    if (widget.country != null || widget.country != '') {
      cont.selectedcountry = cont.country
          ?.firstWhereOrNull((element) => element.name == widget.country);
    }
    getProvinces();
    getcities();
    if (widget.dob != null) {
      List<String> dobParts = widget.dob!.split('T');
      if (dobParts.isNotEmpty) {
        List<String> dateParts = dobParts[0].split('-');
        if (dateParts.length == 3) {
          String year = dateParts[0];
          String month = dateParts[1];
          String day = dateParts[2];
          cont.formatArrival?.value = '$month-$day-$year';
        }
      }
      call();
    }

    super.initState();
  }

  call() async {
    await AuthController.i.getGendersFromAPI();
    GendersData? data;
    data = AuthController.i.genders.firstWhereOrNull(
      (element) => element.name == AuthController.i.user?.genderName,
    );
    EditProfileController.i.updateSelectedGender(data ?? GendersData());
    await MyFamilyScreensController.i.getMartialStatuses();
    MartialStatuses? status;
    status = MyFamilyScreensController.i.martialStatuses.firstWhereOrNull(
      (element) => element.name == AuthController.i.user?.maritalStatus,
    );
    EditProfileController.i.updateMartialStatuses(status ?? MartialStatuses());
    // "MaritalStatusId": "${edit.status?.id}",
    // UserDataModel tempmodel = await LocalDb().getProfileData();
    // AuthController.i.user?.maritalStatus =
    //     AuthController.i.user?.maritalStatus ?? tempmodel.maritalStatus;
    // AuthController.i.user?.genderName =
    //     AuthController.i.user?.maritalStatus ?? tempmodel.genderName;
    setState(() {});
  }

  getProvinces() async {
    await FamilyScreensController.i.getprovince(
        AuthController.i.user?.countryId ?? cont.selectedcountry?.id ?? "");
  }

  getcities() async {
    await AuthRepo.getCities(AuthController.i.user?.stateOrProvinceId ??
        cont.selectedprovince?.id ??
        "");
    // if (widget.city != null || widget.city != '') {
    //   cont.selectedcity = cont.citylist
    //       ?.firstWhereOrNull((element) => element.name == widget.city);
    // }
  }

  @override
  void dispose() {
    FamilyScreensController.i.clearSelectedCountry();
    FamilyScreensController.i.clearprovince();
    FamilyScreensController.i.clearcity();
    FamilyScreensController.i.formatArrival = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var edit = Get.put<EditProfileController>(EditProfileController());
    var family = Get.put<FamilyScreensController>(FamilyScreensController());
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: CustomAppBar(
            title: 'editProfile'.tr,
            isScheduleScreen: widget.isProfile,
          )),
      body: Padding(
        padding: const EdgeInsets.all(AppPadding.p20),
        child: GetBuilder<EditProfileController>(builder: (cont) {
          return GetBuilder<FamilyScreensController>(builder: (cont) {
            return Form(
              key: _formKey,
              child: GetBuilder<AuthController>(builder: (auth) {
                return ListView(
                  children: [
                    Center(
                      child: InkWell(
                        onTap: () async {
                          AuthController.i.file = await AuthController.i
                              .pickImage(type: FileType.image);
                        },
                        child: Container(
                          height: Get.height * 0.15,
                          width: Get.height * 0.15,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: AuthController.i.file != null
                                ? DecorationImage(
                                    image: FileImage(AuthController.i.file!),
                                    fit: BoxFit.cover,
                                  )
                                : AuthController.i.user?.imagePath != null
                                    ? DecorationImage(
                                        image: NetworkImage(baseURL +
                                            AuthController.i.user!.imagePath!),
                                        fit: BoxFit.cover,
                                      )
                                    : const DecorationImage(
                                        image: AssetImage(Images.avatar),
                                        fit: BoxFit.cover,
                                      ),
                          ),
                          child: Align(
                              alignment: Alignment.bottomRight,
                              child: CircleAvatar(
                                radius: 10,
                                backgroundColor: Colors.green,
                                child: InkWell(
                                    onTap: () async {
                                      AuthController.i.file =
                                          await AuthController.i
                                              .pickImage(type: FileType.image);
                                    },
                                    child: const Icon(
                                      Icons.camera_alt_outlined,
                                      color: ColorManager.kWhiteColor,
                                      size: 14,
                                    )),
                              )),
                        ),
                      ),
                    ),
                    // InkWell(
                    //   onTap: () async {
                    //     AuthController.i.file = await AuthController.i
                    //         .pickImage(type: FileType.image);
                    //   },
                    //   child: CircleAvatar(
                    //       radius: 40, // Adjust the radius as needed
                    //       backgroundColor:
                    //           ColorManager.kPrimaryLightColor, // Border color
                    //       child: AuthController.i.user?.imagePath != null
                    //           ? CircleAvatar(
                    //               backgroundImage: CachedNetworkImageProvider(
                    //                   '${containsFile(AuthController.i.user?.imagePath)}/${AuthController.i.user?.imagePath}'),
                    //               radius:
                    //                   40, // Adjust the inner radius as needed
                    //               backgroundColor: Colors
                    //                   .transparent, // Transparent inner circle
                    //             )
                    //           : AuthController.i.file != null
                    //               ? CircleAvatar(
                    //                   radius: 50,
                    //                   backgroundImage:
                    //                       FileImage(AuthController.i.file!),
                    //                 )
                    //               : const CircleAvatar(
                    //                   radius: 50,
                    //                   backgroundImage:
                    //                       AssetImage(Images.avatar),
                    //                 )),
                    // ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    CustomTextField(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      hintText: "fullName".tr,
                      controller: fullname,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(
                            RegExp(r"[a-zA-Z\s]")),
                      ],
                      inputType: TextInputType.name,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your full name';
                        }
                        return null;
                      },
                    ),

                    InkWell(
                      onTap: () {
                        cont.selectDateAndTime(
                            context: context,
                            date: EditProfileController.arrival ??
                                toDateTime(
                                    AuthController.i.user?.dateofbirth) ??
                                toDateTime(DateFormat('dd/MM/yyyy')
                                    .format(DateTime.now())),
                            formattedDate: cont.formatArrival ?? ''.obs);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: ColorManager.kPrimaryLightColor,
                            border: Border.all(
                                color: ColorManager.kPrimaryLightColor,
                                width: 0.5)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AuthController.i.formatArrival?.value ??
                                  toDateTime(AuthController.i.user?.dateofbirth
                                              ?.split('T')
                                              .first ??
                                          toDateTime(DateFormat('dd/MM/yyyy')
                                              .format(DateTime.now())))
                                      .toString()
                                      .split(' ')
                                      .first,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: ColorManager.kPrimaryColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),

                    CustomTextField(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                      ],
                      hintText: 'Mobile Number'.tr,
                      inputType: TextInputType.number,
                      controller: phone,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please select Contact number';
                        }
                        return null;
                      },
                    ),
                    CustomTextField(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      // ignore: prefer_const_literals_to_create_immutables
                      inputFormatters: <TextInputFormatter>[
                        // FilteringTextInputFormatter.allow(
                        //     RegExp("[0-9a-zA-Z]")),
                      ], // Only numbers can be entered
                      hintText: 'email'.tr,
                      inputType: TextInputType.emailAddress,
                      controller: email,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please select Email';
                        } else if (!value.isEmail) {
                          return 'Please Enter a valid Email';
                        }
                        return null;
                      },
                    ),
                    InkWell(
                      onTap: () async {
                        cont.getallcountries();
                        cont.selectedcountry = null;
                        Countries generic = await searchablecountry(
                            context, cont.country ?? []);
                        if (generic.name != null && generic.name != '') {
                          widget.country = generic.name;
                          address.clear();
                          address.text = generic.name ?? '';
                          cont.updatecountries(generic);
                          cont.updateprovince(
                              Provinces(name: "Province/State"));
                          cont.updatecity(Cities(name: "City"));
                          setState(() {
                            isCountryselected = false;
                          });
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.only(right: AppPadding.p10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: ColorManager.kPrimaryLightColor,
                            border: Border.all(
                                color: ColorManager.kPrimaryLightColor,
                                width: 0.5)),
                        height: MediaQuery.of(context).size.height * 0.07,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              child: Text(
                                cont.selectedcountry?.name ??
                                    AuthController.i.user?.country ??
                                    "country".tr,
                                // "${(cont.selectedcountry != null && cont.selectedcountry!.name != null) ? (cont.selectedcountry!.name!.length > 10 ? ('${cont.selectedcountry?.name!.substring(0, 10)}...') : cont.selectedcountry?.name) : widget.country ?? "country".tr}",
                                // semanticsLabel:
                                //     "${(cont.selectedcountry != null) ? (cont.selectedcountry!.name!.length > 20 ? ('${cont.selectedcountry?.name!.substring(0, 10)}...') : cont.selectedcountry) : widget.country ?? "country".tr}",
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w900,
                                    color: ColorManager.kPrimaryColor),
                              ),
                            ),
                            Image.asset(Images.dropdown)
                            // Image.asset(
                            //   Images.dropdown,
                            //   width: MediaQuery.of(context).size.width * 0.1,
                            //   color: cont.selectedcountry != null
                            //       ? Colors.black
                            //       : Colors.grey[700],
                            // )
                          ],
                        ),
                      ),
                    ),
                    countryselection(),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    InkWell(
                      onTap: () async {
                        Provinces? generic = await searchableProvinces(
                          context,
                          cont.provinceslist ?? [],
                        );
                        if (generic!.name != null && generic.name != '') {
                          cont.updateprovince(generic);
                          if (widget.country != null) {
                            address.clear();
                            address.text = widget.country!;
                          }
// ignore: prefer_interpolation_to_compose_strings
                          address.text = '${address.text},${generic.name}';
                          cont.updatecity(Cities(name: "City"));
                          setState(() {
                            isprovinceselected = false;
                          });
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.only(right: AppPadding.p10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: ColorManager.kPrimaryLightColor,
                            border: Border.all(
                                color: ColorManager.kPrimaryLightColor,
                                width: 0.5)),
                        height: MediaQuery.of(context).size.height * 0.07,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              child: Text(
                                cont.selectedprovince?.name ??
                                    AuthController.i.user?.stateOrProvince ??
                                    "province/state".tr,
                                // "${(cont.selectedprovince != null && cont.selectedprovince!.name != null) ? (cont.selectedprovince!.name!.length > 15 ? ('${cont.selectedprovince?.name!.substring(0, 15)}...') : cont.selectedprovince?.name) : widget.province ?? "province/state".tr}",
                                // semanticsLabel:
                                //     "${(cont.selectedprovince != null) ? (cont.selectedprovince!.name!.length > 20 ? ('${cont.selectedprovince?.name!.substring(0, 10)}...') : cont.selectedprovince) : widget.province ?? "province/state".tr}",
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w900,
                                    color: ColorManager.kPrimaryColor),
                              ),
                            ),
                            Image.asset(Images.dropdown)
                            // Image.asset(
                            //   Images.dropdown,
                            //   width: MediaQuery.of(context).size.width * 0.1,
                            //   color: cont.selectedcity != null
                            //       ? Colors.black
                            //       : Colors.grey[700],
                            // )
                          ],
                        ),
                      ),
                    ),
                    provinceselection(),

                    //  cont.selectedprovince?.name =="Province/State" && cont.selectedprovince?.id==null?Text("Please Select provinces"):SizedBox(),

                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    InkWell(
                      onTap: () async {
                        Cities? generic =
                            await SearchableCity(context, cont.citylist ?? []);
                        if (generic!.name != null && generic.name != '') {
                          address.text = '${address.text},' '${generic.name}';
                          cont.updatecity(generic);
                          setState(() {
                            iscityselected = false;
                          });
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.only(right: AppPadding.p10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: ColorManager.kPrimaryLightColor,
                            border: Border.all(
                                color: ColorManager.kPrimaryLightColor,
                                width: 0.5)),
                        height: MediaQuery.of(context).size.height * 0.07,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              child: Text(
                                cont.selectedcity?.name ??
                                    AuthController.i.user?.city ??
                                    "city".tr,
                                // "${(cont.selectedcity != null && cont.selectedcity!.name != null) ? (cont.selectedcity!.name!.length > 15 ? ('${cont.selectedcity?.name!.substring(0, 15)}...') : cont.selectedcity?.name) : widget.city ?? "city".tr}",
                                // semanticsLabel:
                                //     "${(cont.selectedcity != null) ? (cont.selectedcity!.name!.length > 20 ? ('${cont.selectedcity?.name!.substring(0, 10)}...') : cont.selectedcity) : widget.city ?? "city".tr}",
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w900,
                                    color: ColorManager.kPrimaryColor),
                              ),
                            ),
                            Image.asset(Images.dropdown)
                            // Image.asset(
                            //   Images.dropdown,
                            //   width: MediaQuery.of(context).size.width * 0.15,
                            //   color: cont.selectedcity != null
                            //       ? Colors.black
                            //       : Colors.grey[700],
                            // ),
                          ],
                        ),
                      ),
                    ),
                    cityselection(),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    GetBuilder<EditProfileController>(builder: (cont) {
                      return InkWell(
                        onTap: () async {
                          await getGenders(context);

                          LocalDb.saveProfileData(UserDataModel(
                            genderName: AuthController.i.selectedGender?.name ??
                                AuthController.i.user?.genderName,
                          ));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: ColorManager.kPrimaryLightColor),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 15),
                          child: Padding(
                            padding: EdgeInsets.only(left: Get.width * 0.02),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  cont.selectedGender?.name ??
                                      AuthController.i.user?.genderName ??
                                      'gender'.tr,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                          color: ColorManager.kPrimaryColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                ),
                                Image.asset(Images.dropdown)
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    GetBuilder<EditProfileController>(builder: (cont) {
                      return InkWell(
                        onTap: () {
                          getMartialStatuses(context);
                          if (EditProfileController.i.status != null) {
                            LocalDb.saveProfileData(UserDataModel(
                              maritalStatus:
                                  EditProfileController.i.status?.name ??
                                      AuthController.i.user?.maritalStatus,
                            ));
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: ColorManager.kPrimaryLightColor),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 15),
                          child: Padding(
                            padding: EdgeInsets.only(left: Get.width * 0.02),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  cont.status?.name ??
                                      AuthController.i.user?.maritalStatus ??
                                      'martialStatus'.tr,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                          color: ColorManager.kPrimaryColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                ),
                                Image.asset(Images.dropdown)
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                    //  cont.selectedcity?.name =="City" && cont.selectedcity?.id==null?Text("Please Select City"):SizedBox(),

                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    CustomTextField(
                      padding: EdgeInsets.only(left: Get.width * 0.05),
                      inputType: TextInputType.streetAddress,
                      hintText: 'address'.tr,
                      controller: address,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please select address';
                        }
                        return null;
                      },
                    ),
                    PrimaryButton(
                        title: 'update'.tr,
                        onPressed: () async {
                          if (_formKey.currentState!.validate() &&
                              (cont.selectedcity?.name != "City" &&
                                  cont.selectedprovince?.name !=
                                      "Province/State")) {
                            if (EditProfileController.i.selectedGender ==
                                    null &&
                                AuthController.i.user?.genderName == null) {
                              ToastManager.showToast('Select a gender first',
                                  bgColor: ColorManager.kRedColor,
                                  textColor: ColorManager.kWhiteColor);
                            } else if (EditProfileController.i.status == null &&
                                AuthController.i.user?.maritalStatus == null) {
                              ToastManager.showToast(
                                  'Select Martial Status first',
                                  bgColor: ColorManager.kRedColor,
                                  textColor: ColorManager.kWhiteColor);
                            } else {
                              String? file;

                              if (AuthController.i.file != null) {
                                file = await UploadFileRepo()
                                    .updatePicture(AuthController.i.file!);
                              }
                              bool chk = await AuthRepo().updateaccount(
                                  fullname.text.isNotEmpty
                                      ? fullname.text.toString()
                                      : AuthController.i.user?.fullName
                                          ?.split('.')
                                          .last,
                                  phone.text.isNotEmpty
                                      ? phone.text.toString()
                                      : AuthController.i.user?.cellNumber,
                                  email.text.isNotEmpty
                                      ? email.text.toString()
                                      : AuthController.i.user?.email,
                                  address.text.isNotEmpty
                                      ? address.text.toString()
                                      : AuthController.i.user?.address,
                                  FamilyScreensController.i.formatArrival ==
                                          null
                                      ? AuthController.i.user?.dateofbirth
                                      : FamilyScreensController.i.formatArrival
                                          .toString(),
                                  cont.selectedcountry?.id ??
                                      AuthController.i.user?.countryId,
                                  cont.selectedprovince?.id ??
                                      AuthController.i.user?.stateOrProvinceId,
                                  cont.selectedcity?.id ??
                                      AuthController.i.user?.cityId,
                                  file ??
                                      AuthController.i.user?.imagePath ??
                                      "");
                              if (chk) {
                                cont.selectedcountry = null;
                                cont.selectedprovince = null;
                                cont.citylist = null;
                                AuthController.i.user?.firstName =
                                    fullname.text.isNotEmpty
                                        ? fullname.text.toString()
                                        : AuthController.i.user?.firstName;
                                AuthController.i.user?.cellNumber =
                                    phone.text.isNotEmpty
                                        ? phone.text.toString()
                                        : AuthController.i.user?.cellNumber;
                                AuthController.i.user?.email =
                                    email.text.isNotEmpty
                                        ? email.text.toString()
                                        : AuthController.i.user?.email;
                                AuthController.i.user?.patientAddress =
                                    address.text.isNotEmpty
                                        ? address.text.toString()
                                        : AuthController.i.user?.patientAddress;
                                AuthController.i.user?.country =
                                    FamilyScreensController
                                                .i.selectedcountry !=
                                            null
                                        ? FamilyScreensController
                                            .i.selectedcountry!.name
                                        : AuthController.i.user?.country;
                                AuthController.i.user
                                    ?.stateOrProvince = FamilyScreensController
                                            .i.selectedprovince !=
                                        null
                                    ? FamilyScreensController
                                        .i.selectedprovince!.name
                                    : AuthController.i.user?.stateOrProvince;
                                AuthController.i.user?.city =
                                    FamilyScreensController.i.selectedcity !=
                                            null
                                        ? FamilyScreensController
                                            .i.selectedcity!.name
                                        : AuthController.i.user?.city;
                                AuthController.i.user?.dateofbirth =
                                    FamilyScreensController.i.formatArrival !=
                                            null
                                        ? FamilyScreensController
                                            .i.formatArrival
                                            .toString()
                                        : AuthController.i.user?.dateofbirth;
                                await AuthRepo.getupdatedprofile();
                                ToastManager.showToast(
                                    'successfullyupdated'.tr);

                                Get.back();
                              } else {
                                ToastManager.showToast('failedtoupated'.tr);
                              }
                            }
                          } else {
                            setState(() {
                              isCountryselected = true;
                              isprovinceselected = true;
                              iscityselected = true;
                            });
                          }

                          // FamilyScreensController.i.updatedata(UserDataModel(fullName: ));
                        },
                        color: ColorManager.kPrimaryColor,
                        textcolor: ColorManager.kWhiteColor)
                  ],
                );
              }),
            );
          });
        }),
      ),
    );
  }

  getMartialStatuses(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return FractionallySizedBox(
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
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
                  itemCount: MyFamilyScreensController.i.martialStatuses.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final status =
                        MyFamilyScreensController.i.martialStatuses[index];
                    return InkWell(
                      onTap: () {
                        EditProfileController.i.updateMartialStatuses(status);
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
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
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
                  itemCount: AuthController.i.genders.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final gender = AuthController.i.genders[index];
                    return InkWell(
                      onTap: () {
                        EditProfileController.i.updateSelectedGender(gender);
                        Get.back();
                      },
                      child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: ColorManager.kPrimaryLightColor),
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          child: Text(
                            '${gender.name}',
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

  FamilyScreensController cont =
      Get.put<FamilyScreensController>(FamilyScreensController());

  String dOB() {
    if (cont.formatArrival != null) {
      if (cont.formatArrival != null) {
        return ' ${cont.formatArrival!.value}';
      } else {
        return DateTime.parse(AuthController.i.user!.dateofbirth!)
            .toString()
            .split('T')[0];
      }
    } else if (widget.dob != null) {
      return ' ${widget.dob!.split('T').first}';
    } else {
      return 'Date of Birth';
    }
  }

  Widget countryselection() {
    if (isCountryselected == true) {
      if (cont.selectedcountry == null && widget.country == null) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 25),
          child: Text(
            "selectcountry".tr,
            style: const TextStyle(color: Colors.red, fontSize: 12),
          ),
        );
      } else {
        return const SizedBox.shrink();
      }
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget provinceselection() {
    if (isprovinceselected == true) {
      if (cont.selectedprovince?.id == null &&
          AuthController.i.user?.stateOrProvince == null) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15),
          child: Text(
            "selectprovince".tr,
            style: const TextStyle(color: Colors.red, fontSize: 12),
          ),
        );
      } else {
        return const SizedBox();
      }
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget cityselection() {
    if (iscityselected == true) {
      if (cont.selectedcity?.id == null) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15),
          child: Text("selectcity".tr,
              style: const TextStyle(color: Colors.red, fontSize: 12)),
        );
      } else {
        return const SizedBox();
      }
    } else {
      return const SizedBox.shrink();
    }
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
                itemCount: MyFamilyScreensController.i.martialStatuses.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final status =
                      MyFamilyScreensController.i.martialStatuses[index];
                  return InkWell(
                    onTap: () {
                      EditProfileController.i.updateMartialStatuses(status);
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
