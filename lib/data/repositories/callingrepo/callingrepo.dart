import 'dart:convert';
import 'dart:developer';
import 'package:tabib_al_bait/data/controller/reportcontroller.dart';
import 'package:tabib_al_bait/helpers/show_toast.dart';
import 'package:tabib_al_bait/models/callscreenmodel.dart';
import 'package:tabib_al_bait/utils/constants.dart';
import 'package:http/http.dart' as http;

class CallRepo {
  acceptcall(Callingscreenmodel data) async {
    var headers = {
      'Content-Type': 'application/json',
    };
    var body = {
      "PatientId": data.patientId,
      "DoctorId": data.doctorId,
      "VisitNo": data.visitNo,
      "BranchId": data.branchId,
      "DeviceToken": data.deviceToken,
      "PrescribedInValue": data.prescribedInValue.toString(),
      "IsFirstTimeVisit": data.isFirstTimeVisit.toString(),
      "IsOnline": "true"
    };
    log("data:${jsonEncode(body)}");
    try {
      var response = await http.post(Uri.parse(AppConstants.acceptConsulation),
          body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        if (result['Status'] == 1) {
          return result['Status'];
        } else {
          Reportcontroller.j.updateIsLoading(false);
          ToastManager.showToast('${result['ErrorMessage']}');
        }
      }
    } catch (e) {
      e;
    }
  }

  rejectcall(Callingscreenmodel data) async {
    var headers = {
      'Content-Type': 'application/json',
    };
    var body = {
      "DoctorId": data.doctorId,
      "BranchId": data.branchId,
      "PatientId": data.patientId,
      "VisitNo": data.visitNo
    };
    try {
      var response = await http.post(Uri.parse(AppConstants.dropCall),
          body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        if (result['Status'] == 1) {
          return result['Status'];
        } else {
          Reportcontroller.j.updateIsLoading(false);
          ToastManager.showToast('${result['ErrorMessage']}');
        }
      }
    } catch (e) {
      e;
    }
  }

  cancelconsultation(Callingscreenmodel data) async {
    var headers = {
      'Content-Type': 'application/json',
    };
    var body = {
      "DoctorId": data.doctorId,
      "BranchId": data.branchId,
      "PatientId": data.patientId,
      "VisitNo": data.visitNo
    };
    try {
      var response = await http.post(Uri.parse(AppConstants.cancelconsultation),
          body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        if (result['Status'] == 1) {
          return result['Status'];
        } else {
          Reportcontroller.j.updateIsLoading(false);
          ToastManager.showToast('${result['ErrorMessage']}');
        }
      }
    } catch (e) {
      e;
    }
  }
}
