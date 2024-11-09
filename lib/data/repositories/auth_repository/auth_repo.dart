// ignore_for_file: use_build_context_synchronously, unused_local_variable, non_constant_identifier_names, unnecessary_brace_in_string_interps

import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pinput/pinput.dart';
import 'package:tabib_al_bait/components/images.dart';
import 'package:tabib_al_bait/components/primary_button.dart';
import 'package:tabib_al_bait/data/controller/auth_controller.dart';
import 'package:tabib_al_bait/data/controller/controller.dart';
import 'package:tabib_al_bait/data/controller/edit_profile_controller.dart';
import 'package:tabib_al_bait/data/controller/health_summary_controller.dart';
import 'package:tabib_al_bait/data/localDB/local_db.dart';
import 'package:tabib_al_bait/data/repositories/favorites_repo/favorites_repo.dart';
import 'package:tabib_al_bait/data/repositories/specialities_repo/specialities_repo.dart';
import 'package:tabib_al_bait/data/repositories/upload_file_repo/upload_file.dart';
import 'package:tabib_al_bait/helpers/color_manager.dart';
import 'package:tabib_al_bait/helpers/font_manager.dart';
import 'package:tabib_al_bait/helpers/show_toast.dart';
import 'package:tabib_al_bait/helpers/values_manager.dart';
import 'package:tabib_al_bait/main.dart';
import 'package:tabib_al_bait/models/appointment_booking_mode/appointment_booking_model.dart';
import 'package:tabib_al_bait/models/cities_model.dart';
import 'package:tabib_al_bait/models/consult_now/consult_now_body.dart';
import 'package:tabib_al_bait/models/countries_model.dart';
import 'package:tabib_al_bait/models/doctor_consultation_fee.dart';
import 'package:tabib_al_bait/models/genders_model.dart';
import 'package:tabib_al_bait/models/lab_test_model2.dart';
import 'package:tabib_al_bait/models/lab_tests_model.dart';
import 'package:tabib_al_bait/models/provinces_model.dart';
import 'package:tabib_al_bait/models/search_models.dart';
import 'package:tabib_al_bait/models/user_model.dart';
import 'package:tabib_al_bait/screens/auth_screens/login.dart';
import 'package:tabib_al_bait/screens/dashboard/menu_drawer.dart';
import 'package:tabib_al_bait/screens/doctor%20consultation/doctorconsultation.dart';
import 'package:tabib_al_bait/screens/health_summary/health_summary.dart';
import 'package:tabib_al_bait/screens/online_appointment_confirm/online_appointment_confirm.dart';
import 'package:tabib_al_bait/screens/services_home/services_home.dart';
import 'package:tabib_al_bait/screens/specialists_screen/appointment_creation.dart';
import 'package:tabib_al_bait/utils/constants.dart';
import '../../../screens/lab_screens/lab_investigations.dart';
import '../lab_investigation_repo/lab_investigation_repo.dart';

class AuthRepo {
  static getGenders() async {
    var body = {};
    var headers = {'Content-Type': 'application/json'};

    try {
      var response = await http.post(Uri.parse(AppConstants.getGenders),
          body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        if (result['Status'] == 1) {
          Genders genders = Genders.fromJson(result);
          log(genders.toJson().toString());
          log(genders.data.toString());
          return genders.data;
        }
      }
    } catch (e) {}
  }

  static getCountries() async {
    var body = {};
    var headers = {'Content-Type': 'application/json'};

    try {
      var response = await http.post(Uri.parse(AppConstants.getCountries),
          body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        if (result['Status'] == 1) {
          CountriesData countries = CountriesData.fromJson(result);
          return countries.data;
        } else {
          ToastManager.showToast('${result['Message']}',
              bgColor: ColorManager.kblackColor);
        }
      }
    } catch (e) {
      // ToastManager.showToast(e.toString(), bgColor: ColorManager.kblackColor);
    }
  }

  static getProvinces(String countryId) async {
    var body = {"CountryId": countryId};
    var headers = {'Content-Type': 'application/json'};
    try {
      var response = await http.post(
          Uri.parse(AppConstants.getStatesOrProvince),
          body: jsonEncode(body),
          headers: headers);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        if (result['Status'] == 1) {
          ProvincesData provinces = ProvincesData.fromJson(result);
          return provinces.data;
        } else {
          ToastManager.showToast('${result['Message']}',
              bgColor: ColorManager.kblackColor);
        }
      }
      ToastManager.showToast('${response.statusCode}',
          bgColor: ColorManager.kblackColor);
    } catch (e) {
      // ToastManager.showToast(e.toString(), bgColor: ColorManager.kblackColor);
    }
  }

  static getCities(String provinceId) async {
    var body = {"StateORProvinceId": provinceId};
    var headers = {'Content-Type': 'application/json'};
    try {
      var response = await http.post(Uri.parse(AppConstants.getCities),
          body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        if (result['Status'] == 1) {
          CitiesDatas cities = CitiesDatas.fromJson(result);
          return cities.data;
        } else {
          ToastManager.showToast('${result['Message']}');
        }
      }
      ToastManager.showToast('${response.statusCode}');
    } catch (e) {
      // ToastManager.showToast(e.toString());
    }
  }

  Future<bool> updateaccount(fullname, phone, email, address, formatArrival,
      countryid, provinceid, cityid, String file) async {
    var headers = {
      'Content-Type': 'application/json',
    };
    var edit = EditProfileController.i;
    var body = {
      'PatientId': await LocalDb().getPatientId(),
      'BranchId': await LocalDb().getBranchId(),
      'Token': await LocalDb().getToken(),
      'FirstName': fullname,
      'CellNumber': phone,
      'Email': email,
      'Address': address,
      'DateOfBirth': formatArrival,
      "PatientTypeId": "BEB03D33-E8AA-E711-80C1-A0B3CCE147BA",
      'CountryId': countryid,
      'StateOrProvinceId': provinceid,
      'CityId': cityid,
      'GenderId': '${edit.selectedGender?.id}',
      "MaritalStatusId": "${edit.status?.id}",
      "PicturePath": file,

      // "FileAttachment": file,
    };
    log(body.toString());
    try {
      var response = await http.post(Uri.parse(AppConstants.updateprofile),
          body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        var status = responseData['Status'];

        log('API Response: $responseData');
        if (status == 1) {
          getupdatedprofile();
          EditProfileController.arrival = null;
          return true;
        } else {
          return false;
        }
      }
    } catch (e) {
      // ToastManager.showToast(e.toString());

      return false;
    }
    return false;
  }

  static Future<bool> getupdatedprofile() async {
    var headers = {
      'Content-Type': 'application/json',
    };
    String PatientId = await LocalDb().getPatientId() ?? "";
    String BranchId = await LocalDb().getBranchId() ?? "";
    String Token = await LocalDb().getToken() ?? "";
    var body = {
      'PatientId': PatientId,
      'BranchId': BranchId,
      'Token': Token,
    };

    try {
      var response = await http.post(Uri.parse(AppConstants.getupdateprofile),
          body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200) {
        UserDataModel localUser = await LocalDb().getProfileData();
        var responseData = jsonDecode(response.body);
        AuthController.i.user?.address =
            responseData['Address'] ?? AuthController.i.user?.address;
        AuthController.i.user?.firstName =
            responseData['FirstName'] ?? AuthController.i.user?.firstName;
        AuthController.i.user?.address =
            responseData['PatientAddress'] ?? AuthController.i.user?.address;
        AuthController.i.user?.imagePath =
            responseData['PicturePath'] ?? AuthController.i.user?.imagePath;
        AuthController.i.user?.dateofbirth =
            responseData['DateOfBirth'] ?? AuthController.i.user?.dateofbirth;
        AuthController.i.user?.cellNumber =
            responseData['MobileNumber'] ?? AuthController.i.user?.cellNumber;
        AuthController.i.user?.country =
            responseData['Country'] ?? AuthController.i.user?.country;
        AuthController.i.user?.city =
            responseData['City'] ?? AuthController.i.user?.city;
        AuthController.i.user?.stateOrProvince =
            responseData['StateOrProvince'] ??
                AuthController.i.user?.stateOrProvince;
        AuthController.i.user?.maritalStatus = responseData['MaritalStatus'] ??
            AuthController.i.user?.maritalStatus;
        AuthController.i.user?.genderName = responseData['Gender'] ??
            AuthController.i.user?.genderName ??
            localUser.genderName;
        AuthController.i.user?.id =
            responseData['Id'] ?? AuthController.i.user?.id;
        AuthController.i.user?.mRNo =
            responseData['MRNo'] ?? AuthController.i.user?.mRNo;
        AuthController.i.user?.maritalStatus = responseData['MaritalStatus'] ??
            AuthController.i.user?.maritalStatus ??
            localUser.maritalStatus;
        AuthController.i.updateUser(AuthController.i.user);
        var status = responseData['Status'];
        var cont = FamilyScreensController.i;
        cont.selectedcity =
            Cities(id: responseData['CityId'], name: responseData['City']);

        log(' get Updated Response ${responseData.toString()}');
        // print(responseData);
        // print('API Response: $responseData');
        if (status == 1) {
          // return status;
        } else {
          return true;
        }
      }
    } catch (e) {
      // ToastManager.showToast('someerrorOccured'.tr,
      //     bgColor: ColorManager.kRedColor);
      return false;
    }
    return false;
  }

  // static Future<bool> getProfileUpdate() async {
  //   var headers = {
  //     'Content-Type': 'application/json',
  //   };

  //   var body = {
  //     'PatientId': await LocalDb().getPatientId(),
  //     'BranchId': await LocalDb().getBranchId(),
  //     'Token': await LocalDb().getToken(),
  //   };

  //   try {
  //     var response = await http.post(Uri.parse(AppConstants.getProfileUpdate),
  //         body: jsonEncode(body), headers: headers);
  //     if (response.statusCode == 200) {
  //       var responseData = jsonDecode(response.body);
  //       // AuthController.i.user?.firstName = responseData['FirstName'];
  //       // AuthController.i.user?.address = responseData['PatientAddress'];
  //       // AuthController.i.user?.imagePath = responseData['ImagePath'];
  //       // AuthController.i.user?.dateofbirth = responseData['DateOfBirth'];
  //       // AuthController.i.user?.cellNumber = responseData['MobileNumber'];
  //       // AuthController.i.user?.country = responseData['Country'];
  //       // AuthController.i.user?.city = responseData['City'];
  //       // AuthController.i.user?.stateOrProvince = responseData['SateORProvince'];
  //       // AuthController.i.user?.genderName = responseData['Gender'];
  //       // AuthController.i.user?.id = responseData['Id'];
  //       // AuthController.i.user?.mRNo = responseData['MRNo'];
  //       // AuthController.i.user?.maritalStatus = responseData['MaritalStatus'];
  //       AuthController.i.update();

  //       var status = responseData['Status'];
  //       var cont = FamilyScreensController.i;
  //       cont.selectedcity =
  //           Cities(id: responseData['CityId'], name: responseData['City']);

  //       log(responseData.toString());
  //       // print(responseData);
  //       // print('API Response: $responseData');
  //       if (status == 1) {
  //         // return status;
  //       } else {
  //         return true;
  //       }
  //     }
  //   } catch (e) {
  //     return false;
  //   }
  //   return false;
  // }
  signup(
      {String? name,
      String? id,
      String? selectedDate,
      String? phoneNumber,
      String? email,
      File? file,
      String? genderId,
      String? cityId,
      String? password,
      String? retypePassword}) async {
    log('$name, $id, $selectedDate, $phoneNumber, $email, ${file!.path}, $genderId, $cityId');
    var branchID = await LocalDb().getBranchId();
    var cont = AuthController.i;
    var files = await UploadFileRepo().updatePicture(file);
    var body = {
      "FirstName": "$name",
      "CNICNumber": "$id",
      "DateOfBirth": "$selectedDate",
      "CellNumber": "$phoneNumber",
      "TelephoneNumber": "",
      "Email": "$email",
      "PicturePath": files,
      "GenderId": "$genderId",
      "RelationshipTypeId": "",
      "CountryId": "${cont.selectedCountry.id}",
      "StateOrProvinceId": "${cont.selectedProvince.id}",
      "CityId": "$cityId",
      "BranchId": branchID,
      "Password": "$password",
      "ConfirmPassword": "$retypePassword",
      "PatientTypeId": "BEB03D33-E8AA-E711-80C1-A0B3CCE147BA",
    };

    var headers = {'Content-Type': 'application/json'};
    AuthController.i.updateIsloading(true);

    try {
      var response = await http.post(Uri.parse(AppConstants.signup),
          body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        if (result['Status'] == 1) {
          log(result.toString());
          ToastManager.showToast('${result['ErrorMessage']}');
          await showDialog(
            context: Get.context!,
            builder: (context) {
              return StatefulBuilder(
                builder: (context, setState) {
                  return FractionallySizedBox(
                    child: SizedBox(
                      child: AlertDialog(
                        contentPadding: const EdgeInsets.all(AppPadding.p20),
                        scrollable: true,
                        title: const Text("Enter Verification Code"),
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                                'Enter Verification Code Send to your email or Phone Number'),
                            SizedBox(
                              height: Get.height * 0.02,
                            ),
                            Pinput(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter validation Code';
                                }
                                return null;
                              },
                              length: 6,
                            )
                          ],
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () async {
                              await verifySignup(
                                  id: id, verificationCode: '123123');
                              Navigator.pop(context);
                              // await login(
                              //     cnic: id,
                              //     password: password,
                              //     context: Get.context);
                            },
                            child: Text("confirm".tr),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          );

          LocalDb().savePatientId(result['Token'] ?? '');
          if (result['Id'] != null) {
            await LocalDb().savePatientId(result['Id'] ?? '');
          }
          if (result['ErrorMessage']
              .toString()
              .contains('Verification Code has been sent')) {
            Get.offAll(() => const DrawerScreen());
          }

          AuthController.i.updateIsloading(false);
        } else {
          log(result.toString());
          AuthController.i.updateIsloading(false);
          ToastManager.showToast('${result['ErrorMessage']}');
        }
      } else {
        var result = jsonDecode(response.body);
        log(result.toString());
        ToastManager.showToast('${response.statusCode}');

        AuthController.i.updateIsloading(false);
      }
    } catch (e) {
      AuthController.i.updateIsloading(false);
      // log(e.toString());
    }
  }

  verifySignup({String? id, String? verificationCode}) async {
    var body = {"UserName": "$id", "VerificationCode": "$verificationCode"};
    var headers = {'Content-Type': 'application/json'};

    try {
      var response = await http.post(Uri.parse(AppConstants.verifySignUp),
          headers: headers, body: jsonEncode(body));
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        if (result['Status'] == 1) {
          ToastManager.showToast('${result['ErrorMessage']}');
        } else {
          ToastManager.showToast('${result['ErrorMessage']}');
        }
      }
    } catch (e) {
      // ToastManager.showToast(e.toString());
    }
  }

  static login({
    bool? isimagingBookingScreen,
    bool? isschedule,
    bool? isprofile,
    bool? isDoctorConsultaion,
    bool? isOnlineConsultation,
    bool? isServicesHomeScreen,
    bool? isHealthSummary,
    BuildContext? context,
    ConsultNowBody? consultNowBody,
    bool isLabInvestigationScreen = false,
    bool isBookAppointmentScreen = false,
    bool isHomeSampleScreen = false,
    List<LabTestHome>? list,
    List<LabTests>? services,
    String? cnic,
    String? password,
    // Map<String, dynamic>? map,
  }) async {
    String? deviceToken = await LocalDb().getDeviceToken();
    log('the device token received $deviceToken');
    String? model;
    String? manufacturer;
    String? appVersion;
    AndroidBuildVersion? deviceVersion;
    String? version;
    int sdkInt;
    String? release;
    String? iosDeviceVersion;
    AndroidBuildVersion? deviceVersions;

    if (Platform.isIOS) {
      var iosInfo = await DeviceInfoPlugin().iosInfo;
      manufacturer = iosInfo.name;
      appVersion = iosInfo.systemVersion;
      model = iosInfo.model;
      iosDeviceVersion = iosInfo.utsname.machine.toString();

      // log('$systemName $version, $name $model');
      // iOS 13.1, iPhone 11 Pro Max iPhone
    }

    var headers = {'Content-Type': 'application/json'};
    Map<String, String?> body;
    if (Platform.isAndroid) {
      var androidInfo = await DeviceInfoPlugin().androidInfo;
      release = androidInfo.version.release;
      sdkInt = androidInfo.version.sdkInt;
      manufacturer = androidInfo.manufacturer;
      deviceVersion = androidInfo.version;
      model = androidInfo.brand;
      appVersion = androidInfo.version.release;
    }

    body = {
      "UserName": "$cnic",
      "Password": "$password",
      "DeviceToken":
          "fSjjWTkIRemgO4j1aCWUUi:APA91bGpzNd9ONA3Y3Lq16cw1Oncz3BLqHd2u5NkNVcxbgzS97xfjuP2s7bYxu2f6re4D_lw9E7B3eckcWlWt6QYBxUoh6ll7Mj8uy2cbbyZv3MmBkVMA-qiPlwzP_YosC1s55E3vX1U",
      "Manufacturer": "$manufacturer",
      "Model": "$model",
      "AppVersion": "$appVersion",
      "DeviceVersion": Platform.isAndroid
          ? "${deviceVersion?.release}"
          : "${iosDeviceVersion}"
    };
    log(body.toString());

    // var headers = {'Content-Type': 'application/json'};
    AuthController.i.updateIsloading(true);
    try {
      var response = await http.post(Uri.parse(AppConstants.login),
          body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        if (result['Status'] == 1) {
          AuthController.i.updateisLoginPasswordVisible();
          UserDataModel user = UserDataModel.fromJson(result);
          await LocalDb.saveProfileData(user);
          await LocalDb().savePatientId(result['Id']);
          await LocalDb().saveToken(result['Token']);
          String? token = await LocalDb().getToken();
          await LocalDb().saveBranchId(result['BranchId']);
          getupdatedprofile();
          log('LOGIN TOKEN = $token');
          LocalDb().saveLoginStatus(true);
          await LocalDb().getPatientId();
          LocalDb.saveUserData(user).then((value) => LocalDb().getDataFromSP());
          AuthController.i.updateUser(user);
          AuthController.i.updateLoginStatus(true);
          FavoritesRepo.getAllFavoriteDoctors();

          AuthController.i.updateIsloading(false);
          AuthController.i.updateisChecked(false);
          await getupdatedprofile();
          ToastManager.showToast('loginsuccess'.tr);
          if (isprofile ?? false) {
            Get.close(2);
          }
          if (isschedule ?? false) {
            Get.close(2);
          } else if (isLabInvestigationScreen == true) {
            AuthController.i.loginchk = true;
            Get.back();
            // Get.off(() => LabInvestigations(
            //       imagePath: Images.microscope,
            //       isHereFromInvestigatiosAndServices: true,
            //       isHomeSamle: false,
            //       isLabInvestigationBooking: isLabInvestigationScreen,
            //       title: 'Lab Investigations',
            //     ));
            LabInvestigationRepo().bookLabInvestigationOrHomeSampling(
                isLabInvestigationBooking: true);
            // AuthController.i.updateIsloading(false);
          } else if (isBookAppointmentScreen == true) {
            AppointmentDataModel model = await LocalDb().getAppoinryMentData();
            Get.offAll(() => const AppointmentCreation(
                  isHereFromLogin: true,
                ));
            AuthController.i.updateIsloading(false);
            String? patientId = await LocalDb().getPatientId();
            SpecialitiesRepo.bookAppointment(
                model.doctorId!,
                patientId,
                model.bookDate,
                model.startTime,
                model.endTime,
                model.isOnlineConsultation!,
                model.workLocationId,
                model.sessionId,
                model.branchId,
                actualPrice: model.price);
          } else if (isHomeSampleScreen == true) {
            Get.off(() => const LabInvestigations(
                  imagePath: Images.microScope,
                  isHereFromInvestigatiosAndServices: true,
                  title: 'Lab Investigations ',
                ));
            LabInvestigationRepo().bookLabInvestigationOrHomeSampling(
                isLabInvestigationBooking: true);
            AuthController.i.updateIsloading(false);
          } else if (isOnlineConsultation == true) {
            ConsultancyDetail details = await LocalDb().getConsultNow();
            Search search = await LocalDb().getSearchDoctor();
            Get.off(() => OnlineAppointmentConfirm(
                  isHereFromLogin: true,
                  doctor: search,
                  details: details,
                ));
          } else if (isHealthSummary == true) {
            Get.offAll(() => const HealthSummary(
                  isHereFromLogin: true,
                ));
            HealthSummaryController.i.getLastDataBasedOnTitle();
          } else if (isServicesHomeScreen == true) {
            Get.off(() => const ServicesHome(
                  imagepath: Images.services,
                  title: 'Services(Home)',
                ));
            LabInvestigationRepo().bookServicesHome();
          } else if (isDoctorConsultaion == true) {
            Get.off(() => const doctorconsultation(
                  title: 'Doctor Consultation',
                ));
            LabInvestigationRepo().bookspecialitisservices();
          } else if (isimagingBookingScreen == true) {
            Get.close(2);
          } else {
            Get.offAll(() => const DrawerScreen());
            AuthController.i.updateIsloading(false);
          }

          await loadtheData();
          // lengthOfList();

          AuthController.i.updateIsloading(false);
        } else {
          ToastManager.showToast('${result['ErrorMessage']}');
          AuthController.i.updateIsloading(false);
        }
      } else {
        ToastManager.showToast('${response.statusCode}');
        AuthController.i.updateIsloading(false);
      }
    } catch (e) {
      // ToastManager.showToast(e.toString());
      log(e.toString());
      AuthController.i.updateIsloading(false);
    }
  }

  static Future<dynamic> disclaimerDialogue(
      {bool isHomeSamplingScreen = false,
      bool isLabInvestigationScreen = false,
      bool isBookDoctorAppointment = false}) {
    return showDialog(
        context: Get.context!,
        builder: (context) {
          return StatefulBuilder(builder: (context, setstate) {
            return Material(
              color: Colors.transparent,
              child: AlertDialog(
                scrollable: true,
                title: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'disclaimer'.tr,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: ColorManager.kblackColor,
                          fontSize: 13,
                          fontWeight: FontWeight.w900),
                    ),
                    const Divider(
                      color: ColorManager.kblackColor,
                    ),
                  ],
                ),
                backgroundColor: Colors.white,
                content: SizedBox(
                  width: Get.width,
                  child: Column(
                    children: [
                      SizedBox(
                        height: Get.height * 0.5,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'consentTitle'.tr,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        color: ColorManager.kblackColor,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w900),
                              ),
                              Text(
                                'consent'.tr,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        fontSize: 12,
                                        color: ColorManager.kblackColor),
                              ),
                              Text(
                                'informationWeCollect'.tr,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        fontSize: 13,
                                        color: ColorManager.kblackColor,
                                        fontWeight: FontWeight.w900),
                              ),
                              SizedBox(
                                height: Get.height * 0.01,
                              ),
                              Text(
                                'information1'.tr,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        fontSize: 12,
                                        color: ColorManager.kblackColor),
                              ),
                              SizedBox(
                                height: Get.height * 0.02,
                              ),
                              Text(
                                'information2'.tr,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        fontSize: 12,
                                        color: ColorManager.kblackColor),
                              ),
                              SizedBox(
                                height: Get.height * 0.02,
                              ),
                              Text(
                                'usageTitle'.tr,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        fontSize: 13,
                                        color: ColorManager.kblackColor,
                                        fontWeight: FontWeight.w900),
                              ),
                              SizedBox(
                                height: Get.height * 0.02,
                              ),
                              Text(
                                'usage'.tr,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        fontSize: 12,
                                        color: ColorManager.kblackColor),
                              ),
                              Text(
                                'disclosureTitle'.tr,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        fontSize: 13,
                                        color: ColorManager.kblackColor,
                                        fontWeight: FontWeight.w900),
                              ),
                              Text(
                                'disclosure'.tr,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        fontSize: 12,
                                        color: ColorManager.kblackColor),
                              ),
                              SizedBox(
                                height: Get.height * 0.02,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Get.height * 0.03,
                      ),
                      GetBuilder<AuthController>(builder: (cont) {
                        return SizedBox(
                          height: Get.height * 0.06,
                          width: Get.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Checkbox(
                                fillColor: MaterialStateProperty.all(
                                    ColorManager.kPrimaryColor),
                                value: cont.isChecked,
                                onChanged: (bool? newVal) {
                                  cont.updateisChecked(newVal!);
                                },
                              ),
                              Expanded(
                                child: RichText(
                                  text: TextSpan(
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: 'iHaveRead'.tr,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.copyWith(
                                                color: ColorManager.kblackColor,
                                                fontWeight:
                                                    FontWeightManager.bold,
                                                fontSize: 12),
                                        children: const <InlineSpan>[
                                          WidgetSpan(
                                            alignment:
                                                PlaceholderAlignment.baseline,
                                            baseline: TextBaseline.alphabetic,
                                            child: SizedBox(),
                                          ),
                                        ],
                                      ),
                                      TextSpan(
                                        children: <InlineSpan>[
                                          WidgetSpan(
                                            child: SizedBox(
                                                width: Get.width * 0.01),
                                          ),
                                        ],
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.copyWith(
                                                color: ColorManager.kblackColor,
                                                fontWeight:
                                                    FontWeightManager.bold,
                                                fontSize: 12),
                                        text: 'theTermsAndCondition'.tr,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                      SizedBox(
                        height: Get.height * 0.02,
                      ),
                      GetBuilder<AuthController>(builder: (cont) {
                        return Row(
                          children: [
                            Expanded(
                                child: PrimaryButton(
                                    isDisabled:
                                        !AuthController.i.isChecked == false
                                            ? false
                                            : true,
                                    fontSize: 12,
                                    height: Get.height * 0.06,
                                    title: 'accept'.tr,
                                    onPressed: () {
                                      Get.back();
                                      log('i am pressed');
                                    },
                                    color: ColorManager.kPrimaryColor,
                                    textcolor: ColorManager.kWhiteColor)),
                            SizedBox(
                              width: Get.width * 0.03,
                            ),
                            Expanded(
                                child: PrimaryButton(
                                    fontSize: 12,
                                    height: Get.height * 0.06,
                                    title: 'decline'.tr,
                                    onPressed: () async {
                                      await LocalDb.saveUserData(
                                          UserDataModel());
                                      LocalDb().saveLoginStatus(false);
                                      Get.off(() => const LoginScreen());
                                    },
                                    color: ColorManager.kPrimaryColor,
                                    textcolor: ColorManager.kWhiteColor))
                          ],
                        );
                      })
                    ],
                  ),
                ),
              ),
            );
          });
        });
  }

  static deleteAccount({
    String? patientId,
    String? token,
  }) async {
    log('$patientId, $token');
    var body = {"PatientId": "$patientId", "Token": "$token"};

    var headers = {'Content-Type': 'application/json'};

    try {
      var response = await http.post(Uri.parse(AppConstants.deleteAccountURI),
          body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        log(result.toString());
        if (result['Status'] == 1) {
          //
          ToastManager.showToast('${result['Message']}');
          LocalDb.saveUserData(UserDataModel());
          LocalDb().savePatientId(null);
          LocalDb().saveToken(null);
          AuthController.i.updateLoginStatus(false);
          AuthController.i.updateUser(UserDataModel());
          LocalDb().saveLoginStatus(false);
        } else {
          ToastManager.showToast('${result['ErrorMessage']}');
        }
      } else {
        ToastManager.showToast('${response.statusCode}');
      }
    } catch (e) {
      // ToastManager.showToast(e.toString());
    }
  }

  static logout() async {
    var patientID = await LocalDb().getPatientId();
    var token = await LocalDb().getToken();
    var deviceToken = await LocalDb().getDeviceToken();
    var branchId = await LocalDb().getBranchId();
    String? model;
    String? manufacturer;
    String? appVersion;
    AndroidBuildVersion? deviceVersion;

    if (Platform.isIOS) {
      var iosInfo = await DeviceInfoPlugin().iosInfo;
      var systemName = iosInfo.systemName;
      var version = iosInfo.systemVersion;
      var name = iosInfo.name;
      var model = iosInfo.model;
      log('$systemName $version, $name $model');
      // iOS 13.1, iPhone 11 Pro Max iPhone
    }

    var headers = {'Content-Type': 'application/json'};
    Map<String, String?> body;
    if (Platform.isAndroid) {
      var androidInfo = await DeviceInfoPlugin().androidInfo;
      var release = androidInfo.version.release;
      var sdkInt = androidInfo.version.sdkInt;
      var manufacturer = androidInfo.manufacturer;
      var version = androidInfo.version;
      var model = androidInfo.model;
      body = {
        "PatientId": "$patientID",
        "DeviceToken": deviceToken,
        "Model": model,
        "DeviceVersion": "$version",
        "Manufacturer": manufacturer,
        "AppVersion": "",
        "Token": "$token",
        "BranchId": branchId
      };
    } else {
      var iosInfo = await DeviceInfoPlugin().iosInfo;
      var systemName = iosInfo.systemName;
      var version = iosInfo.systemVersion;
      var name = iosInfo.name;
      var model = iosInfo.model;
      log('$systemName $version, $name $model');
      body = {
        "PatientId": "$patientID",
        "DeviceToken": deviceToken,
        "Model": model,
        "DeviceVersion": version,
        "Manufacturer": "$manufacturer",
        "AppVersion": "",
        "Token": "$token",
        "BranchId": branchId
      };
    }
    try {
      var response = await http.post(Uri.parse(AppConstants.logoutURI),
          body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        if (result['Status'] == 1) {
          log(response.body);
          LocalDb().saveLoginStatus(false);
          LocalDb.saveUserData(UserDataModel());
          LocalDb().savePatientId(null);
          LocalDb().saveToken(null);
          AuthController.i.updateLoginStatus(false);
          AuthController.i.updateUser(UserDataModel());
        } else {
          log(response.body);
        }
      }
    } catch (e) {
      log(e.toString());
    }
  }

  getBranchPreferences() async {
    String? deviceToken = await LocalDb().getDeviceToken();
    var headers = {'Content-Type': 'application/json'};

    try {
      var response = await http
          .post(Uri.parse(AppConstants.getBranchPreference), headers: headers);
      if (response.statusCode == 200) {}
    } catch (e) {}
    log('the device token received $deviceToken');
  }
}
