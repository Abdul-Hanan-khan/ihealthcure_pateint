import 'dart:convert';
import 'dart:developer';
import 'package:tabib_al_bait/data/controller/reportcontroller.dart';
import 'package:tabib_al_bait/data/localDB/local_db.dart';
import 'package:http/http.dart' as http;
import 'package:tabib_al_bait/helpers/show_toast.dart';
import 'package:tabib_al_bait/models/diagnostic_booking_model/diagnostic_booking_model.dart';
import 'package:tabib_al_bait/models/digital_prescriptions_response/digital_prescriptions_response.dart';
import 'package:tabib_al_bait/models/labTestResultResponse/LabTestResultResponse.dart';
import 'package:tabib_al_bait/utils/constants.dart';

class ReportsRepo {
  displayLabReports(int startIndex, String? search) async {
    Reportcontroller.j.updateIsLoading(true);
    var patientId = await LocalDb().getPatientId();
    var branchId = await LocalDb().getBranchId();
    var token = await LocalDb().getToken();
    var headers = {
      'Content-Type': 'application/json',
    };

    var body = {
      "start": "$startIndex",
      "length": AppConstants.maximumDataTobeFetched,
      "PatientId": "$patientId",
      "BranchId": "$branchId",
      "Token": "$token",
      "Search": "$search"
    };
    try {
      var response = await http.post(Uri.parse(AppConstants.getLabTestReports),
          body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        if (result['Status'] == 1) {
          LabTestResultsResponse response =
              LabTestResultsResponse.fromJson(result);
          Reportcontroller.j.updateIsLoading(false);
          return response;
        } else {
          Reportcontroller.j.updateIsLoading(false);

          ToastManager.showToast('${result['ErrorMessage']}');
        }
      } else {
        Reportcontroller.j.updateIsLoading(false);

        var result = jsonDecode(response.body);
        ToastManager.showToast('${result['ErrorMessage']}');
      }
    } catch (e) {
      Reportcontroller.j.updateIsLoading(false);
    }
  }

  digitalPrescriptions(int startIndex, String? search) async {
    var patientId = await LocalDb().getPatientId();
    var branchId = await LocalDb().getBranchId();
    var token = await LocalDb().getToken();
    var headers = {
      'Content-Type': 'application/json',
    };
    var body = {
      "start": "$startIndex",
      "length": AppConstants.maximumDataTobeFetched,
      "PatientId": "$patientId",
      "BranchId": "$branchId",
      "Token": "$token",
      'Search': search ?? ''
    };
    try {
      var response = await http.post(
          Uri.parse(AppConstants.getDigitalPrescriptions),
          body: jsonEncode(body),
          headers: headers);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        if (result['Status'] == 1) {
          DigitalPrescriptionsResponse response =
              DigitalPrescriptionsResponse.fromJson(result);
          Reportcontroller.j.updateIsLoading(false);
          return response;
        } else {
          Reportcontroller.j.updateIsLoading(false);
          ToastManager.showToast('${result['ErrorMessage']}');
        }
      }
    } catch (e) {
      Reportcontroller.j.updateIsLoading(false);
    }
  }

  diagnosticReports(int startIndex, String? search) async {
    var patientId = await LocalDb().getPatientId();
    var branchId = await LocalDb().getBranchId();
    var token = await LocalDb().getToken();
    var headers = {
      'Content-Type': 'application/json',
    };
    var body = {
      "start": startIndex,
      "PatientId": "$patientId",
      "Token": "$token",
      "BranchId": "$branchId",
      "Length": "${AppConstants.maximumDataTobeFetched}",
      "Search": search ?? ""
    };
    try {
      var response = await http.post(
          Uri.parse(AppConstants.getDiagnosticImagingURL),
          body: jsonEncode(body),
          headers: headers);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        if (result['Status'] == 1) {
          DiagnosticReportsResponse response =
              DiagnosticReportsResponse.fromJson(result);
          Reportcontroller.j.updateIsLoading(false);
          log(response.toString().toString());
          return response;
        } else {
          Reportcontroller.j.updateIsLoading(false);
          ToastManager.showToast('${result['ErrorMessage']}');
        }
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
