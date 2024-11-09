// ignore_for_file: file_names, prefer_final_fields, unnecessary_null_comparison

import 'dart:developer';
import 'package:get/get.dart';
import 'package:tabib_al_bait/data/repositories/reports_repo/reports_repo.dart';
import 'package:tabib_al_bait/helpers/show_toast.dart';
import 'package:tabib_al_bait/models/diagnostic_booking_model/diagnostic_booking_model.dart';
import 'package:tabib_al_bait/models/digital_prescriptions_response/digital_prescriptions_response.dart';
import 'package:tabib_al_bait/models/labTestResultResponse/LabTestResultResponse.dart';
import 'package:tabib_al_bait/models/lab_test_model2.dart';
import 'package:tabib_al_bait/utils/constants.dart';

class Reportcontroller extends GetxController implements GetxService {
  List<ReportsData> _diagnosticReports = [];
  List<ReportsData> get diagnosticReports => _diagnosticReports;

  List<LabTestResult> _labTestReports = [];
  List<LabTestResult> get labTestReports => _labTestReports;

  List<DigitalPrescriptions> _digitalPrescriptionsList = [];
  List<DigitalPrescriptions> get digitalPrescriptionsList =>
      _digitalPrescriptionsList;

  bool? _isLoading = false;
  bool? get isLoading => _isLoading;

  int? _selectedTab = 0;
  int? get selectedTab => _selectedTab;

  int? _selectedDigitalPrescription = 0;
  int? get selectedDigitalPrescription => _selectedDigitalPrescription;

  updateSelectedDigitalPrescription(int index) {
    _selectedDigitalPrescription = index;
    Reportcontroller.j.updateLabTest([]);
    update();
  }

  updateSelectedTab(int value) {
    _selectedTab = value;
    log(_selectedTab.toString());
    update();
  }

  // Lab Investigations Reports
  int _labReportsUpcomingstartIndex = 0;
  int get labReportsUpcomingstartIndex => _labReportsUpcomingstartIndex;
  int _labReportsUpcomingTotalRecords = 0;
  int get labReportsUpcomingTotalRecords => _labReportsUpcomingTotalRecords;
  // Digital Prescriptions
  int _digitaPrescriptionsStartIndex = 0;
  int get digitalPrescriptionsStartIndex => _digitaPrescriptionsStartIndex;
  int _digitalPrescriptionsTotalRecords = 0;
  int get digitalPrescriptionsTotalRecords => _digitalPrescriptionsTotalRecords;

  // Diagnostic Imaging Reports
  int? _diagnosticImagingStartIndex = 0;
  int? get diagnosticImagingStartIndex => _diagnosticImagingStartIndex;
  int? _diagnosticImagingTotalRecords = 0;
  int? get diagnosticImagingTotalRecords => _diagnosticImagingTotalRecords;

  updateIsLoading(bool value) {
    _isLoading = value;
    update();
  }

  updateListOfReports(List<LabTestResult> reports) {
    _labTestReports = reports;
    update();
  }

  updateDigitalPrescriptionsList(List<DigitalPrescriptions> prescriptions) {
    _digitalPrescriptionsList = prescriptions;
    log('test5');
    update();
  }

  updateListOfDiagnosticImaging(List<ReportsData> data) {
    _diagnosticReports = data;
    update();
  }

  updateListOfLabTests(List<LabTests>? labTests) {
    labTests = labTests;
    update();
  }

  getLabTestReportsFromAPI(String? search) async {
    log('hi');
    if (_selectedTab == 1) {
      log('test1');
      if (_labReportsUpcomingstartIndex == 0) {
        _isLoading = true;
        _labTestReports = [];
        _labReportsUpcomingTotalRecords = 0;
        update();
      }
      LabTestResultsResponse response = await ReportsRepo()
          .displayLabReports(_labReportsUpcomingstartIndex, search ?? '');
      log(response.toJson().toString());
      if (response != null) {
        response.data?.forEach((element) {
          _labTestReports.add(element);
          update();
        });
        log('length of Lab Reports ${_labTestReports.length.toString()}');
      }
      updateListOfReports(_labTestReports);

      _labReportsUpcomingTotalRecords =
          response.totalRecord ?? _labReportsUpcomingTotalRecords;
      log('${response.filterRecord.toString()} filter records length');
      update();
    } else if (_selectedTab == 0) {
      log('test2');
      if (_digitaPrescriptionsStartIndex == 0) {
        _isLoading = true;
        _digitalPrescriptionsList = [];
        _digitalPrescriptionsTotalRecords = 0;
        log('test3');
        update();
      }
      DigitalPrescriptionsResponse response = await ReportsRepo()
          .digitalPrescriptions(_digitaPrescriptionsStartIndex, search);
      if (response != null) {
        log('test4');
        response.data?.forEach((element) {
          _digitalPrescriptionsList.add(element);
          update();
        });
        updateDigitalPrescriptionsList(_digitalPrescriptionsList);
        log(_digitalPrescriptionsList.length.toString());
        _digitalPrescriptionsTotalRecords =
            response.totalRecord ?? _digitalPrescriptionsTotalRecords;
        update();
        log('length of DigitalPrescriptions is ${_digitalPrescriptionsList.length.toString()}');
      }
      update();
    } else if (_selectedTab == 2) {
      log('test2');
      if (_diagnosticImagingStartIndex == 0) {
        _isLoading = true;
        _diagnosticReports = [];
        _diagnosticImagingTotalRecords = 0;
        log('test3');
        update();
      }
      DiagnosticReportsResponse response = await ReportsRepo()
          .diagnosticReports(_diagnosticImagingStartIndex!, search);
      log(response.toJson().toString());
      if (response != null) {
        log('test4');
        response.data?.forEach((element) {
          _diagnosticReports.add(element);
          log('${_diagnosticReports.length.toString()} is this');
          update();
        });
        updateListOfDiagnosticImaging(_diagnosticReports);
        log(_digitalPrescriptionsList.length.toString());
        _digitalPrescriptionsTotalRecords =
            response.totalRecord ?? _digitalPrescriptionsTotalRecords;
        update();
        log('length of DigitalPrescriptions is ${_digitalPrescriptionsList.length.toString()}');
      }
      update();
    }
  }

  clearData() {
    _isLoading = false;
    _labTestReports = [];
    _digitalPrescriptionsList = [];
    update();
  }

  setStartToFetchNextDataForUpcomingLabReports() async {
    if (_selectedTab == 1) {
      if ((_labReportsUpcomingstartIndex +
              AppConstants.maximumDataTobeFetched) <
          _labReportsUpcomingTotalRecords) {
        _labReportsUpcomingstartIndex =
            _labReportsUpcomingstartIndex + AppConstants.maximumDataTobeFetched;
        return true;
      } else {
        ToastManager.showToast("allrecordsfetched".tr);
        return false;
      }
    } else if (_selectedTab == 0) {
      if ((_digitaPrescriptionsStartIndex +
              AppConstants.maximumDataTobeFetched) <
          _digitalPrescriptionsTotalRecords) {
        _digitaPrescriptionsStartIndex = _digitaPrescriptionsStartIndex +
            AppConstants.maximumDataTobeFetched;
        return true;
      } else {
        ToastManager.showToast("allrecordsfetched".tr);
        return false;
      }
    } else if (_selectedTab == 2) {
      if ((_diagnosticImagingStartIndex! +
              AppConstants.maximumDataTobeFetched) <=
          _diagnosticImagingTotalRecords!) {
        _diagnosticImagingStartIndex =
            _diagnosticImagingStartIndex! + AppConstants.maximumDataTobeFetched;
        return true;
      } else {
        ToastManager.showToast("allrecordsfetched".tr);
        return false;
      }
    }
  }

  List<LabTestHome> _labTests = [];
  List<LabTestHome> get labTests => _labTests;

  updateLabTest(List<LabTestHome>? tests) {
    _labTests = tests!;
    update();
  }

  addLabTest(bool value, LabInvestigation test, int index) {
    if (_selectedDigitalPrescription == index) {
      if (value == true) {
        _labTests.add(LabTestHome(
          labtestId: test.labTestId,
          id: test.labTestId,
          name: test.labTestName,
        ));
      } else {
        _labTests.removeWhere((element) => element.labtestId == test.labTestId);
      }
      update();
    } else {
      _labTests = [];
    }

    log(_labTests.toString());
  }

  List<LabTestHome> _labDiagnostics = [];
  List<LabTestHome> get labDiagnostics => _labDiagnostics;

  addDiagnostics(bool value, Diagnostics test, int index) {
    if (_selectedDigitalPrescription == index) {
      if (value == true) {
        _labDiagnostics.add(LabTestHome(
          labtestId: test.diagnosticId,
          id: test.diagnosticId,
          name: test.diagnosticName,
        ));
      } else {
        _labDiagnostics
            .removeWhere((element) => element.labtestId == test.diagnosticId);
      }
      update();
    } else {
      _labDiagnostics = [];
    }

    log(_labDiagnostics.toString());
  }

  static Reportcontroller get j => Get.put(Reportcontroller());
}
