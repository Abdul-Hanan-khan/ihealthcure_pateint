// ignore_for_file: prefer_final_fields

import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tabib_al_bait/data/repositories/auth_repository/auth_repo.dart';
import 'package:tabib_al_bait/helpers/color_manager.dart';
import 'package:tabib_al_bait/helpers/show_toast.dart';
import 'package:tabib_al_bait/models/countries_model.dart';
import 'package:tabib_al_bait/models/genders_model.dart';
import 'package:tabib_al_bait/models/provinces_model.dart';
import 'package:tabib_al_bait/models/user_model.dart';

import '../../models/cities_model.dart';

class AuthController extends GetxController implements GetxService {
  bool fingerprint = false;
  updateFingerPrint(bool? value) {
    fingerprint = value!;
    update();
  }

  File? file;
  bool? loginchk = false;
  late TextEditingController fullname;
  late TextEditingController phone;
  late TextEditingController email;
  late TextEditingController address;
  late TextEditingController identity;
  late TextEditingController password;
  late TextEditingController retypePassword;
  late TextEditingController street;

  UserDataModel? user;

  bool chk = false;

  bool? _isRegistrationLoading = false;
  bool? get isRegistrationLoading => _isRegistrationLoading;

  updatefinalcheck(bool val) {
    chk = val;
    update();
  }

  updateIsLoading(bool value) {
    _isRegistrationLoading = value;
    update();
  }

  updateUser(UserDataModel? responseUser) {
    user = responseUser;
    update();
  }

  bool _isChecked = false;
  bool get isChecked => _isChecked;

  updateisChecked(bool value) {
    _isChecked = value;
    update();
  }

  bool? _loginStatus = false;
  bool? get loginStatus => _loginStatus;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  updateIsloading(bool value) {
    _isLoading = value;
    update();
  }

  updateLoginStatus(bool value) {
    _loginStatus = value;
    update();
  }

// =======> LoginControllers
  late TextEditingController emailController;
  late TextEditingController passwordController;

  datepickerupdater() {
    datepicker = true;
    update();
  }

// ===========>
  List<GendersData> genders = [];
  GendersData? selectedGender;
  bool datepicker = false;
  static DateTime? arrival;
  RxString? formatArrival;
  List<Countries>? mycountries = [];
  Countries selectedCountry = Countries();
  List<Provinces> provinces = [];
  Provinces selectedProvince = Provinces();
  List<Cities> cities = [];
  Cities selectedCity = Cities();

  // ===============>
  bool? _isPasswordShown = true;
  bool? get isPasswordShown => _isPasswordShown;

  bool? _isConfirmPasswordShown = true;
  bool? get isConfirmPasswordShown => _isConfirmPasswordShown;

  updateIsPassWordShow() {
    _isPasswordShown = !_isPasswordShown!;
    update();
  }

  updateIsConfirmPassword() {
    _isConfirmPasswordShown = !_isConfirmPasswordShown!;
    update();
  }

  Future<File?> pickImage(
      {bool allowMultiple = false,
      BuildContext? context,
      FileType? type = FileType.any}) async {
    File? pickedFile;
    try {
      FilePickerResult? result = await FilePicker.platform
          .pickFiles(allowMultiple: allowMultiple, type: type ?? FileType.any);
      if (result != null) {
        pickedFile = File(result.files.first.path!);
        // log('${result.files.first.path} the picked file is');
      }
    } catch (e) {
      if (e is SocketException) {
        ToastManager.showToast('No Internet Connection',
            bgColor: ColorManager.kRedColor);
      } else if (e is TimeoutException) {
        ToastManager.showToast('Request Time Out',
            bgColor: ColorManager.kRedColor);
      } else {
        ToastManager.showToast('An Unknown Error Occured');
      }
    }
    update();
    return pickedFile;
  }

// =================> update isLoading

// =================> Genders
  updateGender(GendersData genders) {
    selectedGender = genders;
    update();
  }

  getGendersFromAPI() async {
    try {
      genders = await AuthRepo.getGenders();
    } catch (e) {
      // if (e is SocketException) {
      //   ToastManager.showToast('No Internet Connection',
      //       bgColor: ColorManager.kRedColor);
      // } else if (e is TimeoutException) {
      //   ToastManager.showToast('Request Time Out',
      //       bgColor: ColorManager.kRedColor);
      // } else {
      //   ToastManager.showToast('An Unknown Error Occured');
      // }
    }

    update();
  }

  updateGenders(List<GendersData> data) {
    genders = data;
    update();
  }
//===========================> Countries

  updateSelectedCountry(Countries country) {
    selectedCountry = country;
    update();
  }

  getCountriesFromAPI() async {
    try {
      mycountries = await AuthRepo.getCountries();
      update();
      log('the countries are ${mycountries!.length}');
    } catch (e) {
      // if (e is SocketException) {
      //   ToastManager.showToast('No Internet Connection',
      //       bgColor: ColorManager.kRedColor);
      // } else if (e is TimeoutException) {
      //   ToastManager.showToast('Request Time Out',
      //       bgColor: ColorManager.kRedColor);
      // } else {
      //   ToastManager.showToast('An Unknown Error Occured');
      // }
    }
  }

  // Login Password Visibility
  bool _isLoginPasswordVisible = true;
  bool get isLoginPasswordVisible => _isLoginPasswordVisible;

  updateisLoginPasswordVisible() {
    _isLoginPasswordVisible = !_isLoginPasswordVisible;
    update();
  }

  // updateisLoginPasswordVisible(bool isVisible) {}
  updateCountries(List<Countries> data) {
    mycountries = data;
    update();
  }

//===========================> Provinces

  updateSelectedProvince(Provinces? province) {
    selectedProvince = province!;
    update();
  }

  getProvincesFromAPI(String countryId) async {
    try {
      provinces = await AuthRepo.getProvinces(countryId);
      update();
      log('the countries are ${mycountries!.length}');
    } catch (e) {
      // if (e is SocketException) {
      //   ToastManager.showToast('No Internet Connection',
      //       bgColor: ColorManager.kRedColor);
      // } else if (e is TimeoutException) {
      //   ToastManager.showToast('Request Time Out',
      //       bgColor: ColorManager.kRedColor);
      // } else {
      //   ToastManager.showToast('An Unknown Error Occured');
      // }
    }
  }

  getCitiesFromAPI(String provinceId) async {
    try {
      cities = await AuthRepo.getCities(provinceId);
      update();
      log('the countries are ${cities.length}');
    } catch (e) {
      // if (e is SocketException) {
      //   ToastManager.showToast('No Internet Connection',
      //       bgColor: ColorManager.kRedColor);
      // } else if (e is TimeoutException) {
      //   ToastManager.showToast('Request Timed Out',
      //       bgColor: ColorManager.kRedColor);
      // } else {
      //   ToastManager.showToast('An Unknown Error Occured');
      // }
    }
  }

  updateProvince(Provinces data) {
    selectedProvince = data;
    update();
  }
  //=========================> Cities

  updateCity(Cities city) {
    selectedCity = city;
    update();
  }

  updateFile(File? value) {
    file = value;
    update();
  }

  @override
  void onInit() {
    address = TextEditingController();
    fullname = TextEditingController();
    phone = TextEditingController();
    email = TextEditingController();
    identity = TextEditingController();
    password = TextEditingController();
    retypePassword = TextEditingController();
    street = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    // selectedGender  = genders![0];
    // log(genders![0].name.toString());

    super.onInit();
  }

  static AuthController get i => Get.put(AuthController());
}
