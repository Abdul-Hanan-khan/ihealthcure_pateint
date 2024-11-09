// ignore_for_file: non_constant_identifier_names

import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tabib_al_bait/data/controller/packages_controller.dart';
import 'package:tabib_al_bait/data/repositories/lab_investigation_repo/lab_investigation_repo.dart';
import 'package:tabib_al_bait/helpers/color_manager.dart';
import 'package:tabib_al_bait/helpers/show_toast.dart';
import 'package:tabib_al_bait/models/diagnostics/diagnosticsession.dart';
import 'package:tabib_al_bait/models/diagnostics/disgnosticscenter.dart';
import 'package:tabib_al_bait/models/doctorconsultationmodel.dart';
import 'package:tabib_al_bait/models/doctors_data.dart';
import 'package:tabib_al_bait/models/lab_test_model2.dart';
import 'package:tabib_al_bait/models/labservices.dart';
import 'package:tabib_al_bait/models/packages_model.dart';
import 'package:tabib_al_bait/models/payment_response.dart';
import 'package:tabib_al_bait/models/specialities_model.dart';
import '../../models/lab_tests_model.dart';

class LabInvestigationController extends GetxController implements GetxService {
  int? _selectedValue;
  int? _selectedValue1 = 26;
  int? _selectedValue2 = 0;
  int? _selectedLabValue = 0;
  double finalsubtotal = 0.0;

  int? get selectedalue1 => _selectedValue1;
  int? get selectedalue => _selectedValue;
  int? get selectedalue2 => _selectedValue2;
  int? get selectedLabValue => _selectedLabValue;
  List<Slots> dianosticsslot = [];
  Slots? selectedslot;
  File? file;

  List<LabTestHome>? labtests = [];
  List<LabTestHome>? diagnostics = [];
  List<LabTests> labservices = [];
  List<Data> specialities = [];

  List<LabTests> doctorconsultation = [];
  List<LabPackages>? labPackages = [];

  Data? doctorspeciality;
  static TimeOfDay selectedTime = TimeOfDay.now();
  TimeOfDay currentTime = TimeOfDay.now();
  String? formattedSelectedTime;
  bool _isloading = false;
  bool get isLoading => _isloading;

  LabTestHome? selectedLabtest;
  LabTests? selectedservice;
  LabTests? selectedspaciality;
  Data? selecteddata;
  Doctors? selectspeciality;
  Doctorconsult? doctorcons;
  LabPackages? selectedLabPackage;
  DateTime? selectedDate = DateTime.now();
  late TextEditingController? description;
  List<Doctors> doctors = [];
  Doctors? selectedDoctor;

  List<LabTestHome> selectedLabTests = [];
  List<LabTests>? selectedservicelist = [];
  List<LabTests>? selectedconsultservice = [];

  PaymentMethod? selectedPaymentMethod;
  PaymentMethod? selectedPaymentMethod1;
  PaymentMethod? selectedPaymentMethod2;
  String? prescribedBy = 'Self';
  String? ServicesBy = 'Nursing';
  String? Status = 'Offline';
  List<Diagnosticscenter> diagnosticscenter = [];
  String? selecteddate;
  bool? _isServicesLoading = false;
  bool? get isServicesLoading => _isServicesLoading;

  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  TextEditingController doctorname = TextEditingController();

  updateselecteddate(String dt) {
    selecteddate = dt;
    update();
  }

  updatediagnosticslots(List<Slots> slots) {
    dianosticsslot = slots;
    update();
  }

  File? prescriptionreport;
  updateprescriptionreport(File x) {
    prescriptionreport = x;
    update();
  }

  clearData() {
    LabInvestigationController.i.selectedslot = null;
    LabInvestigationController.i.diagnosticscenter = [];
    LabInvestigationController.i.dianosticsslot = [];
    LabInvestigationController.i.diagnostics = [];
    LabInvestigationController.i.selectedLabtest = null;
    update();
  }

  updateselectedslot(Slots st) {
    selectedslot = st;
    update();
  }

  updatediagnosticscenter(List<Diagnosticscenter> dt) {
    diagnosticscenter = dt;
    update();
  }

  getdiagnosticcenter(String id) {
    LabInvestigationRepo.getDiagnosticCenter(id);
  }

  Future<int> updateSelectedIndex(int index) async {
    _selectedIndex = index;
    update();
    return _selectedIndex;
  }

  updateIsLoading(bool value) {
    _isloading = value;
    update();
  }

  updatefinalsubtotal(double d) {
    finalsubtotal = finalsubtotal + d;
    update();
  }

  updateSelectedLab(int value) {
    _selectedLabValue = value;
    update();
  }

  updatePrescribedBy(String prescriptionBy) {
    prescribedBy = prescriptionBy;
    update();
  }

  List<Map<String, dynamic>> radioOptions = [
    {'value': 26, 'labelText': 'Physiotherapy'},
    {'value': 25, 'labelText': 'Nursing'},
    {'value': 27, 'labelText': 'Caregiver'},
    {'value': 28, 'labelText': 'Respiratory Therapy'},
    {'value': 29, 'labelText': 'Dietitian'},
  ];

  swapList(List<Map<String, dynamic>> list) {
    radioOptions = list;
    update();
  }

  updateservicesprecription(String prescriptionBy) {
    ServicesBy = prescriptionBy;
    update();
  }

  updatestatus(String status) {
    Status = status;
    update();
  }

  getDoctors() async {
    doctors = await LabInvestigationRepo.getDoctors();

    update();
  }

  updateDoctor(Doctors doctor) {
    selectedDoctor = doctor;
    log(selectedDoctor!.id.toString());
    update();
  }

  prescription() {
    if (_selectedValue == 0) {
      updatePrescribedBy('self'.tr);
    } else if (_selectedValue == 1) {
      updatePrescribedBy('doctor'.tr);
    } else {
      updatePrescribedBy('outdoorDoctor'.tr);
    }
  }

  Serivcesprecription() {
    if (_selectedValue1 == 25) {
      updateservicesprecription('Nursing');
    } else if (_selectedValue1 == 26) {
      updateservicesprecription('Physiotherapy');
    } else if (_selectedValue1 == 27) {
      updateservicesprecription('Caregiver');
    } else if (_selectedValue1 == 28) {
      updateservicesprecription('Respiratory Therapy');
    } else if (_selectedValue1 == 29) {
      updateservicesprecription('Dietitian');
    }
  }

  online() {
    if (_selectedValue2 == 0) {
      updatestatus('Offline');
    } else if (_selectedValue2 == 1) {
      updatestatus('Online');
    }
  }

  double totalSum = 0;

  addLabTest() {
    log('add lab test');
    if (selectedLabTests.contains(selectedLabtest)) {
      ToastManager.showToast('labtestalreadyselected'.tr,
          bgColor: ColorManager.kblackColor);
    } else if (PackagesController.i.selectedLabPackages!.isNotEmpty) {
      ToastManager.showToast(
          'Cannot select individual tests when Package is Selected'.tr,
          bgColor: ColorManager.kblackColor);
    } else if (PackagesController.i.selectedLabPackages!.any((element) =>
        element.dTOPackageGroupDetail!
            .any((element) => element.id == selectedLabtest?.id))) {
      ToastManager.showToast('labtestpresent'.tr,
          bgColor: ColorManager.kblackColor);
    } else {
      selectedLabTests.add(selectedLabtest!);
      log(selectedLabtest!.toJson().toString());
      totalSum = totalSum + selectedLabtest!.price!;
    }
    update();
  }

  dynamic totaldiagnostic = 0;

  updatetotal() {
    totaldiagnostic = 0;
    update();
  }

  Future<String> returnPriceLabsAndPackages() async {
    var packageContr = PackagesController.i;
    var doubleSum = packageContr.totalPriceOfPackages();
    double sum = totalSum + doubleSum;

    if (sum == 0.0) {
      update();
      return '0.0';
    } else {
      update();
      totaldiagnostic = totaldiagnostic + sum;
      update();
      return sum.toStringAsFixed(1);
    }
  }

  Future<String> returnDiscountOfPackages() async {
    var packageContr = PackagesController.i;
    double doubleSum = packageContr.totalDiscountOfPackages();
    if (doubleSum == 0.0) {
      return '';
    } else {
      return doubleSum.toStringAsFixed(1);
    }
  }

  double discount = 0.0;
  double finalTotal = 0.0;

  double totalSum1 = 0;
  addservices() {
    if (selectedservicelist!.contains(selectedservice!)) {
      ToastManager.showToast('servicealreadyselected'.tr,
          bgColor: ColorManager.kblackColor);
      log('here');
    } else {
      if (selectedservice?.actualPrice != null) {
        selectedservicelist!.add(selectedservice!);
        log(selectedservicelist.toString());
        totalSum1 = totalSum1 + selectedservice!.price!;
      }
    }
    update();
  }

  double totalSum2 = 0;
  addconsultservices() {
    if (selectedconsultservice!.contains(selectedspaciality!)) {
      ToastManager.showToast('servicealreadyselected'.tr,
          bgColor: ColorManager.kblackColor);
    } else {
      selectedconsultservice!.add(selectedspaciality!);
      totalSum2 = totalSum2 + selectedspaciality!.price!;
    }
    update();
  }

  removeLabTest(int index) {
    if (totalSum > 0.0) {
      totalSum = totalSum - selectedLabTests[index].price!;
      update();
    }
    selectedLabTests.removeAt(index);
    update();
  }

  removeserviceslist(int index) {
    if (totalSum1 > 0.0) {
      totalSum1 = totalSum1 - selectedservicelist![index].price!;
      update();
    }
    selectedservicelist!.removeAt(index);
    update();
  }

  removeconserviceslist(int index) {
    if (totalSum2 > 0.0) {
      totalSum2 = totalSum2 - selectedconsultservice![index].price!;
      update();
    }
    selectedconsultservice!.removeAt(index);
    update();
  }

  bool? _payButtonDisabled = true;
  bool? get payButtonDisabled => _payButtonDisabled;

  updatePayment(bool value) {
    _payButtonDisabled = value;
    update();
  }

  updatePaymentMethod(PaymentMethod method) {
    selectedPaymentMethod = method;
    if (selectedPaymentMethod?.paymentMethodValue == 5) {
      log('true');
    }
    update();
  }

  updatePaymentMethod1(PaymentMethod method) {
    selectedPaymentMethod1 = method;
    update();
  }

  updatePaymentMethod2(PaymentMethod method) {
    selectedPaymentMethod2 = method;
    update();
  }

  updateSelectedValue(int value) {
    _selectedValue = value;
    update();
  }

  updateSampleValue(int value) {}

  updateSelecteddoctor(int value) {
    _selectedValue1 = value;
    update();
  }

  updateSelectedservices(int value) {
    _selectedValue1 = value;
    selectedservicelist = [];
    ServicesBy = null;
    selectedPaymentMethod1 = null;
    totalSum1 = 0.0;
    selectedDate = DateTime.now();
    update();
  }

  updateSelectedstatus(int value) {
    _selectedValue2 = value;
    update();
  }

  updateSelectedDatae(DateTime date) {
    selectedDate = date;
    update();
  }

  updatePackages(List<LabPackages>? packages) {
    labPackages = packages;
    update();
  }

  updateSelectedLabPackage(LabPackages packages) {
    selectedLabPackage = packages;
    update();
  }

  bool isPackagesLoading = false;

  getAllPackages() async {
    isPackagesLoading = true;
    update();
    List<LabPackages> packages = await LabInvestigationRepo().getPackages();
    updatePackages(packages);
    isPackagesLoading = false;
    update();
    return packages;

    // log('${labPackages?.length}');
  }

  updateFormattedTime(String value) {
    formattedSelectedTime = value;
    update();
  }

  Future<void> selectTime(
    BuildContext context,
    TimeOfDay time,
    String? formattedTime,
  ) async {
    final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: time,
        builder: (context, childWidget) {
          return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                  // Using 24-Hour format
                  alwaysUse24HourFormat: false),
              // If you want 12-Hour format, just change alwaysUse24HourFormat to false or remove all the builder argument
              child: childWidget!);
        });

    if (pickedTime != null && pickedTime != time) {
      time = pickedTime;
      selectedTime = time;
      formattedTime = time.format(Get.context!);
      updateFormattedTime(formattedTime);
      log(selectedTime.toString());
      update();
    }
  }

  getLabTests() async {
    LabTestsModelHome result = await LabInvestigationRepo.getLabTests();
    labtests = result.data;
    log(labtests!.length.toString());
  }

  getDiagnostics() async {
    LabTestsModelHome result = await LabInvestigationRepo.getDiagnostics();
    diagnostics = result.data;
    log(labtests!.length.toString());
  }

  updateIsServicesLoading(bool loading) {
    _isServicesLoading = loading;
    update();
  }

  getserviceslist() async {
    updateIsServicesLoading(true);
    labservices.clear();
    List<servicesmodel> result =
        await LabInvestigationRepo.getLabservices(_selectedValue1!);
    // labservices = result.data??[];
    LabTestsModel results =
        await LabInvestigationRepo.getservices(result[0].id, _selectedValue1!);
    labservices = results.data ?? [];
    log(result.toString());
    updateIsServicesLoading(false);
  }

  getstatus() async {
    List<servicesmodel> result =
        await LabInvestigationRepo.getLabservices(_selectedValue2!);
    // labservices = result.data??[];
    LabTestsModel results =
        await LabInvestigationRepo.getservices(result[0].id, _selectedValue2!);
    labservices = results.data ?? [];
    log(result.toString());
  }

  getspecialityserve() async {
    List<servicesmodel> result =
        await LabInvestigationRepo.getspecialityservices();
    LabTestsModel results = await LabInvestigationRepo.getconsultservices(
      result[0].id,
    );
    doctorconsultation = results.data ?? [];
    log(result.toString());
  }

  getspeciality() async {
    Specialities result = await LabInvestigationRepo.getspecialities();
    List<Data>? lst = result.data;
    specialities = lst ?? [];
    log(lst.toString());
    return lst;
  }

  updatespeciality(Data? data) {
    doctorspeciality = data!;
    update();
  }

  updateservice(LabTests labservices) {
    selectedservice = labservices;
    log('selected lab Test ${labservices.name}');
    update();
  }

  //  updatedoctorconsult(Doctorconsult consult) {
  //   doctorcons = consult;
  //   log('selected consultation ${consult.name}');
  //   update();
  // }
  updateLabTest(LabTestHome labTest) {
    selectedLabtest = labTest;
    log('selected lab Test ${labTest.name}');
    update();
  }

  @override
  void onInit() {
    description = TextEditingController();

    super.onInit();
  }

  initTime(BuildContext context) {
    formattedSelectedTime = selectedTime.format(context);
    log('$formattedSelectedTime');
  }

  static LabInvestigationController get i =>
      Get.put(LabInvestigationController());
}
