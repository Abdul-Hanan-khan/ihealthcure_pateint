// ignore_for_file: non_constant_identifier_names, unused_local_variable, use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:tabib_al_bait/data/controller/schedule_controller.dart';
import 'package:tabib_al_bait/data/localDB/local_db.dart';
import 'package:tabib_al_bait/helpers/color_manager.dart';
import 'package:tabib_al_bait/helpers/show_toast.dart';
import 'package:tabib_al_bait/models/appointment_request_response/appointment_request_response.dart';
import 'package:tabib_al_bait/models/appointments_history/appointments_history.dart';
import '../../../models/DoctorConsultationAppointmentHistory.dart';
import '../../../models/LabInvestigationAppointmentHistory.dart';
import '../../../models/UpComingLabInvestigation.dart';
import '../../../models/UpcomingDiagnosticAppointment.dart';
import '../../../models/UpcomingModelForDoctorAndLabAppointment.dart';
import '../../../utils/constants.dart';

class ScheduleRepo {
  static getAppointmentsSummery() async {
    ScheduleController.i.updateIsLoading(true);
    var patientId = await LocalDb().getPatientId();
    var token = await LocalDb().getToken();
    log(patientId.toString());
    var body = {
      "PatientId": "$patientId",
      "Token": "$token",
    };
    var headers = {'Content-Type': 'application/json'};
    try {
      var response = await http.post(
          Uri.parse(AppConstants.getAppointmentsSummery),
          body: jsonEncode(body),
          headers: headers);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        if (result['Status'] == 1) {
          AppointmentsSummeryResponse summeryResponse =
              AppointmentsSummeryResponse.fromJson(result);
          log(summeryResponse.toString());
          ScheduleController.i.updateIsLoading(false);
          return summeryResponse.data ?? [];
        }
        return [];
      } else {
        log(response.body.toString());
        ScheduleController.i.updateIsLoading(false);

        return [];
      }
    } catch (e) {
      if (e is SocketException) {
        ToastManager.showToast('No Internet Connection',
            bgColor: ColorManager.kRedColor);
      }
      log(e.toString());
      ScheduleController.i.updateIsLoading(false);
      return [];
    }
  }

  static getDoctorUpcomingAppointment(String? Search, int length) async {
    var patientId = await LocalDb().getPatientId();
    var token = await LocalDb().getToken();
    var branchId = await LocalDb().getBranchId();
    log(patientId.toString());
    var body = {
      "PatientId": "$patientId",
      "BranchId": "$branchId",
      "Token": "$token",
      "Start": "$length",
      "Length": AppConstants.maximumDataTobeFetched.toString(),
      "Search": "$Search"
    };
    log(body.toString());
    var headers = {'Content-Type': 'application/json'};

    UpcomingModelForDoctorAndLabAppointment Response =
        UpcomingModelForDoctorAndLabAppointment();
    try {
      var response = await http.post(Uri.parse(AppConstants.getDoctorUpcoming),
          body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        if (result['Status'] == 1) {
          Response = UpcomingModelForDoctorAndLabAppointment.fromJson(result);
          log('${Response.Data!.length.toString()} upcoming length');
          return Response;
        }
        return Response;
      } else {
        log(response.body.toString());
        log('Data not fechted! ');
        return Response;
      }
    } catch (e) {
      log('some thing went wrong');
      log(e.toString());
      return [];
    }
  }

  static getDiagnosticUpcomingAppointment(String? Search, int length) async {
    UpcomingDiagnosticAppointment upcomingDiagnosticAppointment =
        UpcomingDiagnosticAppointment();
    var patientId = await LocalDb().getPatientId();
    var token = await LocalDb().getToken();
    var branchId = await LocalDb().getBranchId();
    log(patientId.toString());
    var body = {
      "PatientId": "$patientId",
      "BranchId": "$branchId",
      "Token": "$token",
      "Start": "$length",
      "Length": AppConstants.maximumDataTobeFetched.toString(),
      "Search": "$Search"
    };
    var headers = {'Content-Type': 'application/json'};
    try {
      var response = await http.post(
          Uri.parse(AppConstants.getDignosticUpcoming),
          headers: headers,
          body: jsonEncode(body));
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        if (result['Status'] == 1) {
          upcomingDiagnosticAppointment =
              UpcomingDiagnosticAppointment.fromJson(jsonDecode(response.body));
          log('${upcomingDiagnosticAppointment.toString()} upcomingDiagnosticAppointment');
          return upcomingDiagnosticAppointment;
        }
        return upcomingDiagnosticAppointment;
      } else {
        log(response.statusCode.toString());
        return upcomingDiagnosticAppointment;
      }
    } catch (e) {
      log('$e exception caught');
      return upcomingDiagnosticAppointment;
    }
  }

  static getLabInvestigationUpcomingAppointment(
      String? Search, int length) async {
    UpcomingLabInvestigation upcomingLabInvestigation =
        UpcomingLabInvestigation();
    var patientId = await LocalDb().getPatientId();
    var token = await LocalDb().getToken();
    var branchId = await LocalDb().getBranchId();
    log(patientId.toString());
    var body = {
      "PatientId": "$patientId",
      "BranchId": "$branchId",
      "Token": "$token",
      "Start": "$length",
      "Length": AppConstants.maximumDataTobeFetched.toString(),
      "Search": "$Search"
    };
    var headers = {'Content-Type': 'application/json'};
    try {
      var response = await http.post(
          Uri.parse(AppConstants.getLabInvestigationUpcoming),
          headers: headers,
          body: jsonEncode(body));
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        if (result['Status'] == 1) {
          upcomingLabInvestigation =
              UpcomingLabInvestigation.fromJson(jsonDecode(response.body));
          log('${upcomingLabInvestigation.toString()} upcomingDiagnosticAppointment');
          return upcomingLabInvestigation;
        }
        return upcomingLabInvestigation;
      } else {
        log(response.statusCode.toString());
        return upcomingLabInvestigation;
      }
    } catch (e) {
      log('$e exception caught');
      return upcomingLabInvestigation;
    }
  }

  // History
  static getDoctorHistoryAppointment(String? Search, int length) async {
    var patientId = await LocalDb().getPatientId();
    var token = await LocalDb().getToken();
    var branchId = await LocalDb().getBranchId();
    log(patientId.toString());
    var body = {
      "PatientId": "$patientId",
      "BranchId": "$branchId",
      "Token": "$token",
      "Start": "$length",
      "Length": AppConstants.maximumDataTobeFetched.toString(),
      "Search": "$Search"
    };
    var headers = {'Content-Type': 'application/json'};

    DoctorConsultationAppointmentHistory Response =
        DoctorConsultationAppointmentHistory();
    try {
      var response = await http.post(
          Uri.parse(AppConstants.getDoctorAppointmentHistory),
          body: jsonEncode(body),
          headers: headers);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        if (result['Status'] == 1) {
          Response = DoctorConsultationAppointmentHistory.fromJson(result);
          log(Response.toString());
          return Response;
        }
        return Response;
      } else {
        // log(response.body.toString());
        // log('Data not fechted! ');
        return Response;
      }
    } catch (e) {
      // log('some thing wents wrong');
      // log(e.toString());
      return [];
    }
  }

  static getDiagnosticHistoryAppointment(String? Search, int length) async {
    UpcomingDiagnosticAppointment diagnosticAppointmentHistory =
        UpcomingDiagnosticAppointment();
    var patientId = await LocalDb().getPatientId();
    var token = await LocalDb().getToken();
    var branchId = await LocalDb().getBranchId();
    log(patientId.toString());
    var body = {
      "PatientId": "$patientId",
      "BranchId": "$branchId",
      "Token": "$token",
      "Start": "$length",
      "Length": AppConstants.maximumDataTobeFetched.toString(),
      "Search": "$Search"
    };
    var headers = {'Content-Type': 'application/json'};
    try {
      var response = await http.post(
          Uri.parse(AppConstants.getDiagnosticsAppointmentHistory),
          headers: headers,
          body: jsonEncode(body));
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        if (result['Status'] == 1) {
          diagnosticAppointmentHistory =
              UpcomingDiagnosticAppointment.fromJson(jsonDecode(response.body));
          log('${diagnosticAppointmentHistory.toString()} upcomingDiagnosticAppointment');
          return diagnosticAppointmentHistory;
        }
        return diagnosticAppointmentHistory;
      } else {
        log(response.statusCode.toString());
        return diagnosticAppointmentHistory;
      }
    } catch (e) {
      log('$e exception caught');
      return diagnosticAppointmentHistory;
    }
  }

  static getLabInvestigationHistoryAppointment(
      String? Search, int length) async {
    LabInvestigationAppointmentHistory LabInvestigationhistory =
        LabInvestigationAppointmentHistory();
    var patientId = await LocalDb().getPatientId();
    var token = await LocalDb().getToken();
    var branchId = await LocalDb().getBranchId();
    log(patientId.toString());
    var body = {
      "PatientId": "$patientId",
      "BranchId": "$branchId",
      "Token": "$token",
      "Start": "$length",
      "Length": AppConstants.maximumDataTobeFetched.toString(),
      "Search": "$Search"
    };
    var headers = {'Content-Type': 'application/json'};
    try {
      var response = await http.post(
          Uri.parse(AppConstants.getLabInvestigationHistory),
          headers: headers,
          body: jsonEncode(body));
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        if (result['Status'] == 1) {
          LabInvestigationhistory = LabInvestigationAppointmentHistory.fromJson(
              jsonDecode(response.body));

          return LabInvestigationhistory;
        }
        return LabInvestigationhistory;
      } else {
        // log(response.statusCode.toString());
        return LabInvestigationhistory;
      }
    } catch (e) {
      log('$e exception caught');
      return LabInvestigationhistory;
    }
  }

  static rescheduleDoctorAppointment(
      {String? appointmentId,
      String? doctorId,
      String? patientAppointmentId,
      String? bookDate,
      bool? isOnlineConsultation,
      String? startTime,
      String? endTime,
      String? workLocationId,
      String? sessionId,
      bool? isOnlineAppointment,
      String? slotTokenNumber,
      String? appointmentDisplayType}) async {
    var patientId = await LocalDb().getPatientId();
    var token = await LocalDb().getToken();
    var branchId = await LocalDb().getBranchId();
    var body = {
      "AppointmentId": appointmentId,
      "DoctorId": doctorId,
      "PatientId": patientId,
      "PatientAppointmentId": patientAppointmentId,
      "BookDate": bookDate,
      "IsOnlineConsultation": isOnlineAppointment,
      "StartTime": startTime,
      "EndTime": endTime,
      "WorkLocationId": workLocationId,
      "SessionId": sessionId,
      "BranchId": branchId,
      'Token': token
    };
    log(body.toString());
    // log(body.toString());
    var headers = {'Content-Type': 'application/json'};
    try {
      var response = await http.post(
          Uri.parse(AppConstants.rescheduleDoctorAppointmentURI),
          headers: headers,
          body: jsonEncode(body));
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        if (result['Status'] == 1) {
          ToastManager.showToast('${result['ErrorMessage']}',
              bgColor: Colors.green, textColor: ColorManager.kWhiteColor);
          ScheduleController.i.clearData();
          ScheduleController.i.getUpcomingAppointment('', true);
          ScheduleController.i.getAppointmentsSummery();
          log(result.toString());
        } else {
          ToastManager.showToast('${result['ErrorMessage']}',
              bgColor: Colors.red, textColor: ColorManager.kWhiteColor);
        }
      } else {
        var result = jsonDecode(response.body);
        ToastManager.showToast('${result['ErrorMessage']}',
            bgColor: Colors.red, textColor: ColorManager.kWhiteColor);
      }
    } catch (e) {
      // ToastManager.showToast(e.toString());
    }
  }

  static cancelDoctorAppointment(
    String? patientAppointmentId,
    String appointmentId,
  ) async {
    var branchID = await LocalDb().getBranchId();
    var token = await LocalDb().getToken();
    var patientId = await LocalDb().getPatientId();
    var body = {
      "PatientId": "$patientId",
      "AppointmentId": patientAppointmentId,
      "BranchId": branchID,
      "Token": "$token",
      "PatientAppointmentId": appointmentId
    };
    log(body.toString());
    var headers = {'Content-Type': 'application/json'};
    try {
      var response = await http.post(
          Uri.parse(AppConstants.cancelDoctorAppointmentURI),
          headers: headers,
          body: jsonEncode(body));
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        if (result['Status'] == 1) {
          ToastManager.showToast('${result['ErrorMessage']}');
          await ScheduleController.i.clearData();
          await ScheduleController.i.getUpcomingAppointment('', true);
          await ScheduleController.i.getAppointmentsSummery();
        } else {
          log(result.toString());
        }
      }
    } catch (e) {
      log(e.toString());
    }
  }

  static cancelLabAppointment({
    BuildContext? context,
    String? labChallanNumber,
    String? labId,
  }) async {
    var patientId = await LocalDb().getPatientId();
    var token = await LocalDb().getToken();
    var body = {
      "LabTestChallanNo": "$labChallanNumber",
      "PatientId": "$patientId",
      "LabId": "$labId",
      "Token": "$token",
    };
    var headers = {'Content-Type': 'application/json'};

    try {
      var response = await http.post(
          Uri.parse(AppConstants.cancelLabAppointment),
          headers: headers,
          body: jsonEncode(body));

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        if (result['Status'] == 1) {
          ScheduleController.i.clearData();
          ScheduleController.i.getUpcomingAppointment('', true);
          ScheduleController.i.getAppointmentsList("");
          ToastManager.showToast('${result['ErrorMessage']}');

          return result['Status'];
        } else {
          ToastManager.showToast('${result['ErrorMessage']}');
        }
      }
    } catch (e) {
      // ToastManager.showToast(e.toString());
    }
  }

  rescheduleLabAppointment(
      {String? labNO,
      BuildContext? context,
      String? formatteddt,
      DateTime? date,
      String? time,
      String? labID,
      String? packageGroupId,
      String? packageGroupName,
      String? packageGroupDiscountRate,
      String? packageGroupDiscountType}) async {
    var branchId = await LocalDb().getBranchId();
    var token = await LocalDb().getToken();
    var patientId = await LocalDb().getPatientId();
    ScheduleController.i.updateIsLoading(true);
    String? formatteddate =
        DateFormat('yyyy-MM-dd').format(date ?? DateTime.now());
    var body = {
      "LabTestChallanNo": "$labNO",
      "PatientId": "$patientId",
      "Date": formatteddt ?? formatteddate,
      "Time": "$time",
      "LabId": "$labID",
      "Token": "$token",
      "BranchId": branchId,
      "PackageGroupId": "$packageGroupId",
      "PackageGroupName": "$packageGroupName",
      "PackageGroupDiscountRate": "$packageGroupDiscountRate",
      "PackageGroupDiscountType": "$packageGroupDiscountType"
    };
    var headers = {'Content-Type': 'application/json'};
    try {
      var response = await http.post(Uri.parse(AppConstants.rescheduleLabTest),
          headers: headers, body: jsonEncode(body));
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        if (result['Status'] == 1) {
          ToastManager.showToast('${result['ErrorMessage']}',
              bgColor: Colors.green);
          await ScheduleController.i.clearData();
          // ScheduleController.i.getAppointmentsSummery();
          await ScheduleController.i.getUpcomingAppointment('', true);
          await ScheduleController.i.getAppointmentsList("");
          ScheduleController.i.updateIsLoading(false);
        } else {
          ToastManager.showToast('${result['ErrorMessage']}',
              bgColor: ColorManager.kRedColor);
          ScheduleController.i.updateIsLoading(false);
        }
      }
    } catch (e) {
      // ToastManager.showToast(e.toString(),
      //     bgColor: ColorManager.kRedColor, textColor: ColorManager.kWhiteColor);
      ScheduleController.i.updateIsLoading(false);
    }
  }

  static CancelDiagnosticAppointment({
    BuildContext? context,
    String? DiagnosticAppointmentId,
    String? PatientDiagnosticAppointmentId,
    String? DiagnosticCenterId,
  }) async {
    var patientId = await LocalDb().getPatientId();
    var token = await LocalDb().getToken();
    var body = {
      "DiagnosticAppointmentId": "$DiagnosticAppointmentId",
      "PatientId": "$patientId",
      "PatientDiagnosticAppointmentId": "$PatientDiagnosticAppointmentId",
      "DiagnosticCenterId": "$DiagnosticCenterId",
      "Token": "$token"
    };
    log(body.toString());
    var headers = {'Content-Type': 'application/json'};

    try {
      var response = await http.post(
          Uri.parse(AppConstants.cancelDiagnosticAppointment),
          headers: headers,
          body: jsonEncode(body));

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        if (result['Status'] == 1) {
          ScheduleController.i.clearData();
          ScheduleController.i.getUpcomingAppointment('', true);
          ScheduleController.i.getAppointmentsSummery();
          ToastManager.showToast('${result['ErrorMessage']}');
          return result['Status'];
        } else {
          ToastManager.showToast('${result['ErrorMessage']}');
        }
      }
    } catch (e) {
      log(e.toString());
    }
  }

  getAppointmentRequestList(
      {int? HistoryFilterStatus, String? query, int? startIndex}) async {
    log('hi');
    var branchId = await LocalDb().getBranchId();
    var token = await LocalDb().getToken();
    var patientId = await LocalDb().getPatientId();
    var body = {
      "start": "${startIndex ?? 0}",
      "length": AppConstants.maximumDataTobeFetched.toString(),
      "IsDoNotApplyDateRangeFilter": "1",
      "IsAllServicesAppointments": "1",
      "PatientId": "$patientId",
      "IsAPI": "false",
      "HistoryFilterStatus": "$HistoryFilterStatus",
      "Search": "$query"
    };
    var headers = {'Content-Type': 'application/json'};
    try {
      var response = await http.post(
          Uri.parse(AppConstants.getAppointmentRequestList),
          headers: headers,
          body: jsonEncode(body));
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        if (result['Status'] == 1) {
          AppointmentRequestResponse response =
              AppointmentRequestResponse.fromJson(result);
          ScheduleController.i.clearData();
          ScheduleController.i.getAppointmentsSummery();
          ScheduleController.i.getUpcomingAppointment('', true);
          // ScheduleController.i.updateAppointmentsList(
          //   ScheduleController.i.
          // );
          //  List<AppointmentsList>?  dt=[];
          //  response.data?.forEach((element) {
          //   if(element.appointmentStatus=="Upcomming")
          //   {
          //     dt.add(element);
          //   }

          //  });
          //  ScheduleController.i.updateAppointmentsList(dt);
          log(response.toString());
          log("${response.data!.length.toString()} here");
          return response.data;
          // ScheduleController.i.clearData();
          // ScheduleController.i.getAppointmentsSummery();
          // ScheduleController.i.getUpcomingAppointment('', true);
        } else {
          ToastManager.showToast('${result['ErrorMessage']}');
          log('${result['ErrorMessage']}');
        }
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
  }

  static rescheduleDiagnosticAppointment({
    String? diagnosticAppointmentId,
    String? patientDiagnosticAppointmentId,
    String? diagnosticId,
    String? sessionID,
    String? prescribedByDoctorId,
    String? bookingDate,
    String? bookingTime,
    String? diagnosticCenterId,
    String? workLocationId,
  }) async {
    var patientId = await LocalDb().getPatientId();
    var token = await LocalDb().getToken();
    var branchId = await LocalDb().getBranchId();
    var body = {
      "DiagnosticAppointmentId": diagnosticAppointmentId,
      "PatientDiagnosticAppointmentId": patientDiagnosticAppointmentId,
      "PatientId": patientId,
      "DiagnosticId": diagnosticId,
      "SessionId": sessionID,
      "PrescribedByDoctorId": prescribedByDoctorId,
      "BookingDate": bookingDate,
      "BookingTime": bookingTime,
      "DiscountStatus": "",
      "ClinicalHistory": "",
      "IsReserve": "0",
      "WorkLocationId": "",
      "DiagnosticCenterId": diagnosticCenterId,
      "Token": token
    };
    log(body.toString());
    // log(body.toString());
    var headers = {'Content-Type': 'application/json'};
    try {
      var response = await http.post(
          Uri.parse(AppConstants.reschedulediagnosticappoitment),
          headers: headers,
          body: jsonEncode(body));
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        if (result['Status'] == 1) {
          ToastManager.showToast('${result['ErrorMessage']}',
              bgColor: Colors.green, textColor: ColorManager.kWhiteColor);
          log(result.toString());
        } else {
          ToastManager.showToast('${result['ErrorMessage']}',
              bgColor: Colors.red, textColor: ColorManager.kWhiteColor);
        }
      } else {
        var result = jsonDecode(response.body);
        ToastManager.showToast('${result['ErrorMessage']}',
            bgColor: Colors.red, textColor: ColorManager.kWhiteColor);
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
  }
}
