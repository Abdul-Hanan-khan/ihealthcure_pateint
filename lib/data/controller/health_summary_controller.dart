import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tabib_al_bait/data/repositories/health_summary_repo/health_summary_repo.dart';
import 'package:tabib_al_bait/data/sqflite_db/sqflite_db.dart';
import 'package:tabib_al_bait/models/prescription_summary_response/prescription_summary_response.dart';
import '../../models/health_summary_model/health_summary_model.dart';

class HealthSummaryController extends GetxController implements GetxService {
  List<InvestigationsSummary>? investigationSummary = [];
  final formKey = GlobalKey<FormState>();

  List<HealthModel> history = [];
  bool? _isLoading = false;
  bool? get isLoading => _isLoading;
  static DateTime now = DateTime.now();
  String formattedDatetime = DateFormat('yyyy-MM-dd - hh:mm').format(now);
  late TextEditingController controller1;
  late TextEditingController controller2;

  HealthModel? normalglucose;
  HealthModel? fastingGlucose;
  HealthModel? bloodPressure;
  HealthModel? measurements;
  HealthModel? sp02;
  HealthModel? pulse;
  HealthModel? temperature;

  updateIsLoading(bool value) {
    _isLoading = value;
    update();
  }

  updateNormalGlucose(HealthModel? health) {
    normalglucose = health;
    update();
  }

  updateFastingGlucose(HealthModel? health) {
    fastingGlucose = health;
    update();
  }

  updatebloodPressure(HealthModel? health) {
    bloodPressure = health;
    update();
  }

  updatemeasurements(HealthModel? health) {
    measurements = health;
    update();
  }

  updatesp02(HealthModel? health) {
    sp02 = health;
    update();
  }

  updatePulse(HealthModel? health) {
    pulse = health;
    update();
  }

  updateTemperature(HealthModel? model) {
    temperature = model;
    update();
  }

  updateHistoryList(List<HealthModel> mylist) {
    history = mylist;
    update();
  }

  getHealthSummaryData() async {
    PrescriptionSummaryResponse? result =
        await HealthSummaryRepo.prescriptionSummary();
    if (result != null) {
      investigationSummary = result.investigationsSummary;
    }
    log('${investigationSummary!.length.toString()} this is it');
    update();
  }

  getLastDataBasedOnTitle() async {
    normalglucose =
        await SqfliteDB().getLastFastingAndNormalValue('Glucose', 'Normal');
    
    updateNormalGlucose(normalglucose);
    fastingGlucose =
        await SqfliteDB().getLastFastingAndNormalValue('Glucose', 'Fasting');
    updateFastingGlucose(fastingGlucose);
    bloodPressure =
        await SqfliteDB().getLastHealthModelWithTitle('bloodPressure'.tr);
    updatebloodPressure(bloodPressure);
    measurements =
        await SqfliteDB().getLastHealthModelWithTitle('measurements'.tr);
    updatemeasurements(measurements);
    sp02 = await SqfliteDB().getLastHealthModelWithTitle('Sp02%');
    updatesp02(sp02);
    pulse = await SqfliteDB().getLastHealthModelWithTitle('pulse'.tr);
    updatePulse(pulse);
    temperature =
        await SqfliteDB().getLastHealthModelWithTitle('temperature'.tr);
    updateTemperature(temperature);
  }

  static HealthSummaryController get i => Get.put(HealthSummaryController());

  @override
  void onInit() {
    controller1 = TextEditingController();
    controller2 = TextEditingController();
    getLastDataBasedOnTitle();
    super.onInit();
  }
}
