// ignore_for_file: unnecessary_null_comparison, must_be_immutable, unrelated_type_equality_checks

import 'dart:developer';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:tabib_al_bait/components/images.dart';
import 'package:tabib_al_bait/components/primary_button.dart';
import 'package:tabib_al_bait/components/searchable_cities.dart';
import 'package:tabib_al_bait/components/searchable_countries.dart';
import 'package:tabib_al_bait/components/searchable_provinces.dart';
import 'package:tabib_al_bait/data/controller/auth_controller.dart';
import 'package:tabib_al_bait/data/controller/controller.dart';
import 'package:tabib_al_bait/data/localDB/local_db.dart';
import 'package:tabib_al_bait/data/repositories/auth_repository/auth_repo.dart';
import 'package:tabib_al_bait/helpers/color_manager.dart';
import 'package:tabib_al_bait/helpers/show_toast.dart';
import 'package:tabib_al_bait/helpers/values_manager.dart';
import 'package:tabib_al_bait/models/cities_model.dart';
import 'package:tabib_al_bait/models/countries_model.dart';
import 'package:tabib_al_bait/models/genders_model.dart';
import 'package:tabib_al_bait/models/provinces_model.dart';
import 'package:tabib_al_bait/screens/auth_screens/login.dart';

class RegisterScreen extends StatefulWidget {
  bool fromlogin;
  RegisterScreen({super.key, required this.fromlogin});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  String? countryCode;

  @override
  void initState() {
    // AuthController.i.selectedCountry = Countries(name: 'Select Country');
    super.initState();
  }

  @override
  void dispose() {
    AuthController.i.fullname.clear();
    AuthController.i.phone.clear();
    AuthController.i.email.clear();
    AuthController.i.identity.clear();
    AuthController.i.password.clear();
    AuthController.i.retypePassword.clear();
    AuthController.i.street.clear();
    AuthController.i.selectedCity = Cities();
    AuthController.i.selectedCountry = Countries();
    AuthController.i.selectedProvince = Provinces();
    AuthController.i.address.clear();
    AuthController.i.file = null;

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var contr = Get.put<AuthController>(AuthController());
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        title: Image.asset(
          Images.logo,
          // fit: BoxFit.fill,
          height: Get.height * 0.065,
        ),
      ),
      body: Stack(
        children: [
          const BackgroundLogoimage(),
          GetBuilder<AuthController>(builder: (cont) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Center(
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'registerNow'.tr,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(fontWeight: FontWeight.w900),
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: contr.file != null
                                  ? DecorationImage(
                                      image: FileImage(File(contr.file!.path)),
                                      fit: BoxFit.cover)
                                  : const DecorationImage(
                                      image: AssetImage(Images.avatar),
                                      fit: BoxFit.cover)),
                          child: Align(
                              alignment: Alignment.bottomRight,
                              child: CircleAvatar(
                                radius: 15,
                                backgroundColor: Colors.green,
                                child: IconButton(
                                    onPressed: () async {
                                      contr.file = await contr.pickImage(
                                          type: FileType.image);
                                    },
                                    icon: const Icon(
                                      Icons.camera_alt_outlined,
                                      size: 15,
                                    )),
                              )),
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        AuthTextField(
                          validator: (p0) {
                            if (p0!.isEmpty) {
                              return 'Enter your full name';
                            }
                            return null;
                          },
                          controller: contr.fullname,
                          hintText: 'fullName'.tr,
                          formatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp('^[a-z A-Z]+')),
                          ],
                        ),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        IntlPhoneField(
                          textInputAction: TextInputAction.newline,
                          textAlignVertical: TextAlignVertical.center,
                          dropdownDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20)),
                          controller: contr.phone,
                          dropdownIcon: const Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black,
                            size: 20,
                          ),
                          disableLengthCheck: true,
                          initialCountryCode: 'SA',

                          keyboardType: TextInputType.number,
                          style: const TextStyle(
                              color: ColorManager.kblackColor, fontSize: 12),
                          pickerDialogStyle: PickerDialogStyle(
                            listTilePadding:
                                const EdgeInsets.symmetric(horizontal: 10),
                            searchFieldPadding:
                                const EdgeInsets.symmetric(horizontal: 5),
                            searchFieldInputDecoration: InputDecoration(
                              hintText: 'Search Country'.tr,
                              hintStyle: const TextStyle(
                                  fontSize: 12,
                                  color: ColorManager.kPrimaryColor),
                              fillColor: ColorManager.kPrimaryLightColor,
                              filled: true,
                              labelStyle: const TextStyle(
                                  color: ColorManager.kPrimaryColor),
                              disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: ColorManager.kDarkBlue),
                                  borderRadius: BorderRadius.circular(10)),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    color: ColorManager.kPrimaryLightColor,
                                    width: 0.5),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    color: ColorManager.kRedColor, width: 0.5),
                              ),
                            ),
                          ),
                          dropdownTextStyle: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  fontSize: 15, fontWeight: FontWeight.w500),
                          decoration: InputDecoration(
                            disabledBorder: const OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    color: ColorManager.kGreyColor)),
                            border: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: ColorManager.kGreyColor)),
                          ),
                          languageCode: "en",
                          onSaved: (newValue) {
                            log(cont.phone.text);
                          },
                          onSubmitted: (p0) {
                            cont.phone.text = p0;
                            log(cont.phone.text);
                          },
                          onChanged: (value) {
                            log(cont.phone.text);
                          },
                          onCountryChanged: (country) {
                            setState(() {
                              countryCode = country.dialCode;
                            });
                            log('Country changed to: ${country.name}');
                          },
                          // validator: (value) {
                          //   if (!value!.isValidNumber()) {
                          //     return 'Please enter a valid number';
                          //   }
                          //   if (cont.phone.text == null) {
                          //     return 'Please Enter your Phone Number';
                          //   }
                          //   return null;
                          // },
                        ),
                        // SizedBox(
                        //   height: Get.height * 0.01,
                        // ),
                        AuthController.i.phone.text.isEmpty &&
                                AuthController.i.chk == true &&
                                widget.fromlogin == false
                            ? const Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 4, vertical: 5),
                                    child: Text(
                                      "Enter your phone number",
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : const SizedBox.shrink(),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        AuthTextField(
                          validator: (value) {
                            if (value!.isEmpty || !value.isEmail) {
                              return 'Enter a valid email';
                            }
                            return null;
                          },
                          controller: cont.email,
                          hintText: 'email'.tr,
                        ),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        GetBuilder<FamilyScreensController>(builder: (fam) {
                          return Container(
                            padding: const EdgeInsets.all(AppPadding.p14)
                                .copyWith(left: 5),
                            width: Get.width,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: /* border color */
                                    ColorManager.kGreyColor,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: GestureDetector(
                              onTap: () async {
                                fam.ontap = true;
                                await fam.selectDateAndTime(
                                    context: context,
                                    isRegisterScreen: true,
                                    date: AuthController.arrival,
                                    formattedDate: cont.formatArrival);
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15), // Adjust padding as needed
                                child: Text(
                                  fam.ontap == true
                                      ? contr.formatArrival?.value ??
                                          'dateOfBirth'.tr
                                      : 'dateOfBirth'.tr,
                                  style: const TextStyle(
                                      fontSize: 12,
                                      color: ColorManager.kblackColor
                                      // Apply your desired text style here
                                      ),
                                ),
                              ),
                            ),
                          );
                        }),
                        contr.formatArrival == null &&
                                AuthController.i.chk == true &&
                                widget.fromlogin == false
                            ? const Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    child: Text(
                                      "Enter Date of Birth",
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : const SizedBox.shrink(),

                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        GetBuilder<AuthController>(builder: (cont) {
                          return Row(
                            children: [
                              Expanded(
                                //       InkWell(
                                //   onTap: () async {
                                //     selectedGender = null;
                                //     gender.clear();
                                //     await genderapi();
                                //     setState(() {});
                                //   },
                                //   child: Padding(
                                //     padding:
                                //         const EdgeInsets.symmetric(horizontal: 1),
                                //     child: DropdownButtonFormField(
                                //         decoration: checkval
                                //             ? InputDecoration(
                                //                 border: OutlineInputBorder(
                                //                     borderRadius:
                                //                         BorderRadius.circular(10),
                                //                     borderSide: const BorderSide(
                                //                         width: 1,
                                //                         color: Colors.black)),
                                //                 contentPadding:
                                //                     const EdgeInsets.symmetric(
                                //                         horizontal: 12,
                                //                         vertical: 10),
                                //               )
                                //             : InputDecoration(
                                //                 border: OutlineInputBorder(
                                //                     borderRadius:
                                //                         BorderRadius.circular(10),
                                //                     borderSide: const BorderSide(
                                //                         width: 1,
                                //                         color: Colors.black)),
                                //                 contentPadding:
                                //                     const EdgeInsets.symmetric(
                                //                         horizontal: 14,
                                //                         vertical: 10),
                                //               ),
                                //         value: selectedGender,
                                //         hint:  Text(
                                //           'gender'.tr,
                                //           style: const TextStyle(
                                //               color: Colors.grey, fontSize: 10),
                                //         ),
                                //         items: gender
                                //             .map<DropdownMenuItem<String>>(
                                //                 (Gender val) {
                                //           return DropdownMenuItem<String>(
                                //             value: val.id,
                                //             child: Text(val.name.toString()),
                                //           );
                                //         }).toList(),
                                //         style: const TextStyle(
                                //             color: Colors.black, fontSize: 14),
                                //         onChanged: (String? newValue) {
                                //           setState(() {
                                //             selectedGender = newValue;
                                //           });
                                //         },
                                //         validator: (value) {
                                //           if (value == null || value.isEmpty) {
                                //             return 'selectgender'.tr;
                                //           } else {
                                //             return null;
                                //           }
                                //         }),
                                //   ),
                                // ),
                                child: DropdownButtonFormField<GendersData>(
                                  isExpanded: true,
                                  hint: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Row(
                                        children: [
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text('selectGender'.tr,
                                              textAlign: TextAlign.left,
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  color: ColorManager
                                                      .kblackColor)),
                                        ],
                                      )),
                                  decoration: InputDecoration(
                                    // suffixIcon: const Icon(Icons.arrow_drop_down),

                                    hintStyle: const TextStyle(
                                        textBaseline: TextBaseline.alphabetic),
                                    disabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 1, color: Colors.black)),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                            width: 1,
                                            color: ColorManager.kGreyColor)),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                            width: 1, color: Colors.black)),
                                    contentPadding: const EdgeInsets.symmetric()
                                        .copyWith(right: 8, left: -8),
                                  ),
                                  icon: const Icon(
                                    Icons.arrow_drop_down,
                                    size: 20,
                                    color: Colors.black,
                                  ),
                                  items: AuthController.i.genders.isNotEmpty
                                      ? AuthController.i.genders
                                          .map<DropdownMenuItem<GendersData>>(
                                              (GendersData val) {
                                          return DropdownMenuItem<GendersData>(
                                            value: val,
                                            child: Text(
                                              '          ${val.name.toString()}',
                                            ),
                                          );
                                        }).toList()
                                      : [],
                                  validator: (value) {
                                    if (value == null) {
                                      return 'selectGender'.tr;
                                    } else {
                                      return null;
                                    }
                                  },

                                  onChanged: (value) async {
                                    cont.updateGender(value!);
                                    log(AuthController.i.selectedGender!.id
                                        .toString());
                                    var branchID =
                                        await LocalDb().getBranchId();
                                    log(branchID.toString());
                                  },

                                  // itemTextExtractor: (value) => value.name!,
                                ),
                              ),
                            ],
                          );
                        }),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        AuthTextField(
                          // formatters: [Masks().maskFormatter],
                          controller: cont.identity,
                          hintText: 'nationalID'.tr,
                          validator: (p0) {
                            if (p0!.isEmpty) {
                              return 'Enter National Id';
                            }
                            return null;
                          },
                        ),

                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        AuthTextField(
                          controller: cont.password,
                          suffixIcon: InkWell(
                            onTap: () {
                              cont.updateIsPassWordShow();
                            },
                            child: Icon(cont.isPasswordShown == false
                                ? Icons.visibility_off
                                : Icons.visibility),
                          ),
                          obscureText: cont.isPasswordShown,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter Your Password';
                            }
                            return null;
                          },
                          hintText: 'Password',
                        ),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        AuthTextField(
                          controller: cont.retypePassword,
                          obscureText: cont.isConfirmPasswordShown,
                          suffixIcon: InkWell(
                            onTap: () {
                              cont.updateIsConfirmPassword();
                            },
                            child: Icon(cont.isConfirmPasswordShown == false
                                ? Icons.visibility_off
                                : Icons.visibility),
                          ),
                          validator: (value) {
                            if (cont.password.text !=
                                cont.retypePassword.text) {
                              return 'Passwords do not match';
                            }
                            if (value!.isEmpty) {
                              return 'Enter confirm Password before proceeding';
                            }
                            return null;
                          },
                          hintText: 'Confirm Password',
                        ),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        InkWell(
                          onTap: () async {
                            AuthController.i.selectedCountry =
                                Countries(name: 'selectCountry'.tr);
                            await AuthController.i.getCountriesFromAPI();
                            setState(() {});
                            // ignore: use_build_context_synchronously
                            dynamic generic = await searchCountry(
                                context, contr.mycountries!);

                            // cont.selectedCountry?.name = null;
                            if (generic != null && generic != '') {
                              // ignore: prefer_interpolation_to_compose_strings
                              log('Countries selected Id' + generic.id);
                              cont.updateSelectedCountry(generic);
                              cont.selectedCountry.id = generic.id;
                              cont.selectedCountry.name =
                                  (generic.name == '') ? null : generic.name;
                              cont.provinces.clear();
                              cont.cities.clear();
                              await cont.getProvincesFromAPI(generic.id);
                              cont.selectedCity = Cities();
                              cont.selectedProvince = Provinces();
                              setState(() {});
                              AuthController.i.update();
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.grey, width: 0.8),
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.transparent,
                            ),
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: MediaQuery.of(context).size.height * 0.065,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 18)
                                      .copyWith(right: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    //"${selectedCountriesName?? "Country"}",
                                    // ignore: unnecessary_string_interpolations
                                    "${(cont.selectedCountry.name != null) ? (cont.selectedCountry.name.toString().length.isGreaterThan(30) ? ('${cont.selectedCountry.name!.substring(0, 30)}...') : cont.selectedCountry.name) : "country".tr}",
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: cont.selectedCountry.name != null
                                            ? Colors.grey
                                            : Colors.grey),
                                  ),
                                  // Image.asset(Images.dropdown)
                                  Icon(
                                    Icons.arrow_drop_down,
                                    size: 20,
                                    color: cont.selectedCountry.name != null
                                        ? Colors.black
                                        : Colors.black,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        AuthController.i.selectedCountry.id == null &&
                                AuthController.i.chk == true &&
                                widget.fromlogin == false
                            ? const Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    child: Text(
                                      "Select Country",
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : const SizedBox.shrink(),
                        // Row(
                        //   children: [
                        //     Flexible(
                        //       child: DropdownDataWidget<Countries>(
                        //           boxBorder: Border.all(
                        //               color: ColorManager.kGreyColor),
                        //           fillColor: Colors.transparent,
                        //           textColor: ColorManager.kGreyColor,
                        //           hint: 'select Country',
                        //           items: AuthController.i.mycountries!,
                        //           selectedValue:
                        //               AuthController.i.selectedCountry,
                        //           onChanged: (value) async {
                        //             cont.updateSelectedCountry(value!);

                        //             if (AuthController.i.provinces.isNotEmpty &&
                        //                 AuthController.i.provinces != null) {
                        //               log('country id ${value.id}');

                        //               cont.updateSelectedProvince(
                        //                   Provinces(name: 'Select Province'));
                        //               cont.updateCity(
                        //                   Cities(name: 'Select City'));
                        //               AuthController.i.selectedCity = null;
                        //               AuthController.i.selectedProvince = null;
                        //               AuthController.i.provinces = [];
                        //               AuthController.i.cities = [];
                        //             }
                        //             cont.updateSelectedCountry(value);
                        //             AuthController.i.provinces =
                        //                 await AuthController.i
                        //                     .getProvincesFromAPI(value.id!);
                        //           },
                        //           itemTextExtractor: (value) => value.name!),
                        //     ),
                        //   ],
                        // ),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        InkWell(
                          onTap: () async {
                            cont.selectedProvince = Provinces();
                            setState(() {});
                            Provinces? generic;
                            if (cont.provinces.isNotEmpty) {
                              generic = await searchableProvinces(
                                  context, cont.provinces);
                            } else {
                              ToastManager.showToast('someerroroccured'.tr,
                                  bgColor: ColorManager.kRedColor);
                            }
                            if (generic != null && generic != '') {
                              log(generic.id.toString());
                              cont.updateSelectedProvince(generic);
                              cont.selectedProvince.id = generic.id;

                              cont.cities.clear();
                              cont.selectedCity = Cities();
                            }
                            cont.cities =
                                await cont.getCitiesFromAPI(generic!.id!);
                            setState(() {});
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width * 0.001),
                            child: Container(
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey, width: 0.8),
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.transparent,
                              ),
                              height:
                                  MediaQuery.of(context).size.height * 0.065,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 18)
                                        .copyWith(right: 5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      // "${SelectedStateName?? "State"}",
                                      "${(cont.selectedProvince.name != null) ? (cont.selectedProvince.name!.length > 15 ? ('${cont.selectedProvince.name?.substring(0, 15)}...') : cont.selectedProvince.name) : "province/state".tr}",
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: cont.selectedProvince != null
                                              ? Colors.grey
                                              : Colors.grey),
                                    ),
                                    // Image.asset(Images.dropdown)?
                                    Icon(
                                      Icons.arrow_drop_down,
                                      size: 20,
                                      color: cont.selectedCountry.name != null
                                          ? Colors.black
                                          : Colors.black,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        AuthController.i.selectedProvince.id == null &&
                                AuthController.i.chk == true &&
                                widget.fromlogin == false
                            ? const Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    child: Text(
                                      "Select Province",
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : const SizedBox.shrink(),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        InkWell(
                          onTap: () async {
                            Cities? generic;
                            if (cont.cities.isNotEmpty) {
                              generic =
                                  await SearchableCity(context, cont.cities);
                            } else {
                              ToastManager.showToast('someerroroccured'.tr,
                                  bgColor: ColorManager.kRedColor);
                            }
                            if (generic!.name != null && generic.name != '') {
                              cont.updateCity(generic);
                              // setState(() {
                              //   iscityselected = false;
                              // });
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color: Colors.transparent,
                                border: Border.all(
                                    color: ColorManager.kblackColor,
                                    width: 0.5)),
                            height: MediaQuery.of(context).size.height * 0.065,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                          horizontal: 18.0)
                                      .copyWith(right: 5),
                                  child: Text(
                                    "${(cont.selectedCity.name != null) ? (cont.selectedCity.name.toString().length > 15 ? ('${cont.selectedCity.name?.substring(0, 15)}...') : cont.selectedCity.name) : cont.selectedCity.name ?? "city".tr}",
                                    semanticsLabel:
                                        "${(cont.selectedCity != null) ? (cont.selectedCity.name.toString().length > 20 ? ('${cont.selectedCity.name!.substring(0, 10)}...') : cont.selectedCity) : cont.selectedCity}",
                                    style: const TextStyle(
                                        fontSize: 12,
                                        color: ColorManager.kGreyColor),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 5),
                                  child: Icon(
                                    Icons.arrow_drop_down,
                                    size: 20,
                                    color: cont.selectedCountry.name != null
                                        ? Colors.black
                                        : Colors.black,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        AuthController.i.selectedCity.id == null &&
                                AuthController.i.chk == true &&
                                widget.fromlogin == false
                            ? const Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 5),
                                    child: Text(
                                      "Select City",
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : const SizedBox.shrink(),
                        // Row(
                        //   children: [
                        //     Flexible(
                        //       child: DropdownDataWidget<Cities>(
                        //           boxBorder: Border.all(
                        //               color: ColorManager.kGreyColor),
                        //           fillColor: Colors.transparent,
                        //           textColor: ColorManager.kGreyColor,
                        //           hint: 'select City',
                        //           items: cont.cities,
                        //           selectedValue: cont.selectedCity,
                        //           onChanged: (value) {
                        //             setState(() {
                        //               AuthController.i.selectedCity = value;
                        //             });
                        //             AuthController.i.update();
                        //             contr.updateCity(value!);
                        //           },
                        //           itemTextExtractor: (value) => value.name!),
                        //     ),
                        //   ],
                        // ),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        AuthTextField(
                          controller: AuthController.i.address,
                          hintText: 'address'.tr,
                          validator: (p0) {
                            if (p0!.isEmpty) {
                              return 'Enter your Address';
                            }
                            return null;
                          },
                        ),

                        SizedBox(
                          height: Get.height * 0.01,
                        ),

                        PrimaryButton(
                            isLoading: contr.isLoading,
                            title: 'register'.tr,
                            onPressed: () async {
                              widget.fromlogin = false;
                              setState(() {});
                              AuthController.i.updatefinalcheck(true);
                              log('$countryCode${cont.phone.text}');
                              if (_formKey.currentState!.validate()) {
                                if (cont.phone.text == '') {
                                  // ToastManager.showToast(
                                  //     'Enter Your Phone Number First');
                                } else if (AuthController
                                        .i.selectedGender!.name ==
                                    null) {
                                  ToastManager.showToast(
                                      'Enter Your Gender First');
                                } else if (AuthController
                                        .i.selectedCountry.name ==
                                    null) {
                                  ToastManager.showToast(
                                      'Country Field is Missing');
                                } else if (AuthController
                                        .i.selectedProvince.name ==
                                    null) {
                                  ToastManager.showToast(
                                      ' Province Field Missing');
                                } else if (AuthController.i.selectedCity.name ==
                                    null) {
                                  ToastManager.showToast('City Field Missing ');
                                } else if (AuthController.i.file == null) {
                                  ToastManager.showToast(
                                      "Upload your Profile Photo");
                                } else {
                                  await AuthRepo().signup(
                                      name: cont.fullname.text,
                                      email: cont.email.text,
                                      id: cont.identity.text,
                                      phoneNumber:
                                          ' $countryCode${cont.phone.text}',
                                      cityId: AuthController.i.selectedCity.id,
                                      file: AuthController.i.file,
                                      genderId:
                                          AuthController.i.selectedGender!.id,
                                      selectedDate: AuthController
                                          .i.formatArrival!.string,
                                      password: cont.password.text,
                                      retypePassword: cont.retypePassword.text);
                                }
                              } else {}
                            },
                            color: ColorManager.kPrimaryColor,
                            textcolor: ColorManager.kWhiteColor),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        SignupOrLoginText(
                          onTap: () => Get.to(() => const LoginScreen()),
                          pre: 'alreadyHaveAnAccount'.tr,
                          suffix: 'login'.tr,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
