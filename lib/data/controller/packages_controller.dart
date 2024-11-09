import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tabib_al_bait/data/controller/lab_investigations_controller.dart';
import 'package:tabib_al_bait/data/repositories/Packages_repo/Packages_repo.dart';
import 'package:tabib_al_bait/data/repositories/specialities_repo/specialities_repo.dart';
import 'package:tabib_al_bait/helpers/show_toast.dart';
import 'package:tabib_al_bait/models/date_wise_doctor_slots.dart';
import 'package:tabib_al_bait/models/doctor_locations_model.dart';
import 'package:tabib_al_bait/models/lab_test_model2.dart';
import 'package:tabib_al_bait/models/packages_model.dart';

class PackagesController extends GetxController implements GetxService {
  List<DTOPackageGroupDetail> package = [];
  List<LabPackages> searchpackage = [];
  List<LabPackages>? selectedLabPackages = [];
  LabPackages? selectedLabPackage;
  bool? isLoading = false;
  double finalTotal = 0;
  String? title;
  List<LabPackages> packages = [];
  LabPackages? labpackages;
  List<DoctorScheduleModel> scheduleList = [];
  List<Sessions> sessions = [];
  List<Slots>? slots = [];
  int selectedIndex = 0;
  String? _startTime;
  String? get startTime => _startTime;
  String? _endTime;
  String? get endTime => _endTime;
  static DateTime todaysDate = DateTime.now();
  String formateDate = DateFormat('yyyy-MM-dd').format(todaysDate);
  double totaldiscount = 0;
  double finalsubtotal = 0.0;

  updateStartTime(String time) {
    _startTime = time;
    update();
  }

  updatefinal(double payment) {
    finalTotal = payment;
    update();
  }

  updatesearch(String val) {
    title = val;
    update();
  }

  updatepackage(List<LabPackages> package) {
    packages = package;
    update();
  }

  updateselectednewpackage(LabPackages package) {
    selectedLabPackage = package;
    update();
  }

  updatediscount(double d, double sub) {
    finalsubtotal = finalsubtotal + sub;
    totaldiscount = totaldiscount + d;
    update();
  }

  updateEndTime(
    String time,
  ) {
    _endTime = time;
    update();
  }

  // ======================>
  late TextEditingController searchDoctor;
  late TextEditingController searchSpecialities;

  updateIsLoading(bool value) {
    isLoading = value;
    update();
  }

  getSpecialities() async {
    isLoading = true;
    log(isLoading.toString());
    // Specialities packages = await SpecialitiesRepo.getSpecialities();
    // package = packages;
    Timer(const Duration(milliseconds: 500), () {
      isLoading = false;
      update();
    });

    log(isLoading.toString());
    update();
  }

  Future<List<LabPackages>> getPackage() async {
    Packages package = await PackagesRepo().getsearchpackages();
    searchpackage = package.data!;
    return searchpackage;
  }

  double totalSum = 0;

  // double totalfinal = 0;
  // addpaymentpackage() {

  //     if (labpackages?.total != null) {
  //       log('over here ');
  //       packages!.add(labpackages!);
  //       log(packages.toString());
  //       finalTotal = finalTotal + labpackages!.total!;
  //     }

  //   update();
  // }

  getDoctorWorkLocations(String doctorId) async {
    scheduleList = await SpecialitiesRepo.getDoctorWorkLocations(doctorId);
    update();
  }

  removepackage(int index) {
    if (totalSum > 0.0) {
      totalSum = totalSum - selectedLabPackages![index].total!;
      update();
    }
    selectedLabPackages!.removeAt(index);

    update();
  }

  getDateWiseDoctorSlots(String doctorId, String workLocationId, String date,
      bool isOnline) async {
    log(date);
    sessions = await SpecialitiesRepo.getDateWiseDoctorSlots(
        doctorId, workLocationId, isOnline, date);
    for (int i = 0; i < sessions.length; i++) {
      slots = sessions[i].slots;
      updateSlots(slots!);
      update();
    }
    update();
  }

  updateSlots(List<Slots> myslots) {
    slots = myslots;
    update();
  }

  double packagessum = 0;

  addlabpackage() async {
    var cont = LabInvestigationController.i;
    log('add lab test');
    if (selectedLabPackages!.contains(selectedLabPackage)) {
      ToastManager.showToast('labpackagealready'.tr);
    } else if (LabInvestigationController.i.selectedLabTests.isNotEmpty) {
      ToastManager.showToast(
          'Cannot Select Packages when Lab Tests are selected'.tr);
    } else {
      selectedLabPackages!.add(selectedLabPackage!);
      updateselectednewpackage(selectedLabPackages![0]);
      log(selectedLabPackage!.toJson().toString());
      cont.returnPriceLabsAndPackages();
      LabInvestigationController.i.selectedLabTests = filterLabTests(
          selectedLabPackages!, LabInvestigationController.i.selectedLabTests);
      update();
    }
    update();
  }

  double totalPriceOfPackages() {
    double sum = 0.0;
    for (int i = 0; i < selectedLabPackages!.length; i++) {
      var list = selectedLabPackages?[i];
      sum = sum + list!.total!;
    }

    return sum;
  }

  double totalDiscountOfPackages() {
    double discount = 0.0;
    for (int i = 0; i < selectedLabPackages!.length; i++) {
      var list = selectedLabPackages?[i];
      if (list!.packageGroupDiscountType == 2 &&
          list.packageGroupDiscountRate! > 0) {
        discount =
            discount + (list.total! / 100) * list.packageGroupDiscountRate!;
        finalTotal = (list.total! - discount);
      } else if (list.packageGroupDiscountType == 1 &&
          list.packageGroupDiscountRate! > 0) {
        finalTotal = list.total! - list.packageGroupDiscountRate!;
        discount = discount + list.packageGroupDiscountRate!;
      }
    }
    return discount;
  }

  Future<double> totalVatPercentOfPackages() async {
    double? vatAmount = 0.0;
    for (int i = 0; i < selectedLabPackages!.length; i++) {
      var list = selectedLabPackages?[i];
      for (int i = 0; i < list!.dTOPackageGroupDetail!.length; i++) {
        var item = list.dTOPackageGroupDetail?[i];
        vatAmount = (vatAmount ?? 0.0) + (item!.vATPercentageAmount ?? 0.0);
      }
    }
    log('The vat amount is : ${vatAmount.toString()}');
    return vatAmount ?? 0.0;
  }

  Future<double> sumUpGrandTotal() async {
    double grandTotal = LabInvestigationController.i.totalSum +
        await totalVatPercentOfPackages() +
        totalPriceOfPackages() -
        totalDiscountOfPackages();
    if (grandTotal == 0.0) {
      return 0.0;
    } else {
      return grandTotal;
    }
  }

  // double totalPriceOfPackages() {
  //   double sum = 0.0;
  //   for (int i = 0; i < selectedLabPackages!.length; i++) {
  //     var list = selectedLabPackages?[i];
  //     sum = sum + list!.total!;
  //   }

  //   return sum;
  // }

  // double totalDiscountOfPackages() {
  //   double discount = 0.0;
  //   for (int i = 0; i < selectedLabPackages!.length; i++) {
  //     var list = selectedLabPackages?[i];
  //     if (list!.packageGroupDiscountType == 2 &&
  //         list!.packageGroupDiscountRate! > 0) {
  //       discount =
  //           discount + (list.total! / 100) * list.packageGroupDiscountRate!;
  //       finalTotal = (list.total! - discount);
  //     } else if (list.packageGroupDiscountType == 1 &&
  //         list.packageGroupDiscountRate! > 0) {
  //       finalTotal = list.total! - list.packageGroupDiscountRate!;
  //       discount = discount + list.packageGroupDiscountRate!;
  //     }
  //   }
  //   return discount;
  // }

  // Future<double> sumUpGrandTotal() async {
  //   double grandTotal = LabInvestigationController.i.totalSum +
  //       await totalPriceOfPackages() -
  //       totalDiscountOfPackages();
  //   if (grandTotal == 0.0) {
  //     return 0.0;
  //   } else {
  //     return grandTotal;
  //   }
  // }

  static PackagesController get i => Get.put(PackagesController());
  updateIsSelected(int index) {
    selectedIndex = index;
    update();
  }

  List<LabTestHome> filterLabTests(
      List<LabPackages> packages, List<LabTestHome> labTests) {
    List<String> packageLabIds = [];
    for (int i = 0; i < packages.length; i++) {
      var list = packages[i];
      for (int j = 0; j < list.dTOPackageGroupDetail!.length; j++) {
        packageLabIds.add(list.dTOPackageGroupDetail![j].id!);
        log(packageLabIds.toString());
      }
    }
    List<LabTestHome> filteredLabTests =
        labTests.where((test) => !packageLabIds.contains(test.id)).toList();
    List<LabTestHome> removePrices = labTests
        .where(
          (element) => packageLabIds.contains(element.id),
        )
        .toList();
    log(removePrices.length.toString());
    for (int i = 0; i < removePrices.length; i++) {
      log(removePrices[i].toJson().toString());
      if (LabInvestigationController.i.totalSum > 0.0) {
        LabInvestigationController.i.totalSum =
            LabInvestigationController.i.totalSum - removePrices[i].price!;
        log(LabInvestigationController.i.totalSum.toString());
      }
    }
    update();
    return filteredLabTests;
  }

  static LabInvestigationController get j =>
      Get.put(LabInvestigationController());

  @override
  void onInit() {
    searchDoctor = TextEditingController();
    searchSpecialities = TextEditingController();
    super.onInit();
  }
}
