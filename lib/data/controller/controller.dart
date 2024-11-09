import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tabib_al_bait/data/controller/auth_controller.dart';
import 'package:tabib_al_bait/data/controller/family_screens_controller.dart';
import 'package:tabib_al_bait/data/repositories/auth_repository/auth_repo.dart';
import 'package:tabib_al_bait/models/cities_model.dart';
import 'package:tabib_al_bait/models/countries_model.dart';
import 'package:tabib_al_bait/models/provinces_model.dart';

class FamilyScreensController extends GetxController implements GetxService {
  static DateTime? arrival = DateTime.now();
  RxString? formatArrival = DateFormat('dd-MM-yyyy').format(arrival!).obs;
  Countries? selectedcountry;
  List<Countries>? country = [];
  Cities? selectedcity;
  List<Cities>? citylist = [];
  Provinces? selectedprovince;
  List<Provinces>? provinceslist = [];

  bool ontap = false;

  bool onTapped = false;

  updatecountries(Countries? countries) {
    selectedcountry = countries;

    update();
  }

  getallcountries() async {
    List<Countries> countries = await AuthRepo.getCountries();
    country = countries;

    update();
  }

  clearSelectedCountry() {
    selectedcountry = null;
    update();
  }

  getcities(String provinceId) async {
    try {
      List<Cities> cities = await AuthRepo.getCities(provinceId);
      citylist = cities;
      update();
    } catch (e) {
      // ToastManager.showToast(e.toString(), bgColor: ColorManager.kRedColor);
    }
  }

  updatecity(Cities? city) {
    selectedcity = city;

    update();
  }

  clearcity() {
    selectedcity = null;
    update();
  }

  getprovince(String countryId) async {
    try {
      List<Provinces> provinces = await AuthRepo.getProvinces(countryId);
      provinceslist = provinces;
      update();
    } catch (e) {
      // ToastManager.showToast(e.toString(), bgColor: ColorManager.kRedColor);
    }
  }

  updateprovince(Provinces? province) {
    selectedprovince = province;
    update();
  }

  updateproviceslist(List<Provinces>? province) {
    provinceslist = province;
    update();
  }

  updatecitylist(List<Cities>? city) {
    citylist = city;
    update();
  }

  clearprovince() {
    selectedprovince = null;
    update();
  }

  Future<void> selectDateAndTime({
    bool isRegisterScreen = false,
    bool isFamilyScreen = false,
    BuildContext? context,
    DateTime? date,
    RxString? formattedDate,
  }) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context!,
        confirmText: 'Ok',
        initialDate: date ?? DateTime.now(),
        firstDate: DateTime(1950),
        lastDate: DateTime(2050));
    if (pickedDate != null && pickedDate != date) {
      date = pickedDate;
      if (isRegisterScreen == true) {
        AuthController.arrival = date;
      }
      if (isFamilyScreen == true) {
        MyFamilyScreensController.dob = date;
        MyFamilyScreensController.i.formattedDob =
            DateFormat('dd-MM-yyyy').format(date).obs;
      }
      AuthController.i.formatArrival =
          DateFormat('dd-MM-yyyy').format(date).obs;
      formattedDate!.value = DateFormat('dd-MM-yyyy').format(date);

      update();
    }
  }

  static FamilyScreensController get i => Get.put(FamilyScreensController());
}
