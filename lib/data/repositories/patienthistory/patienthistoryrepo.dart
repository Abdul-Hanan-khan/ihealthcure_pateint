// ignore_for_file: camel_case_types, dead_code

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:tabib_al_bait/helpers/show_toast.dart';
import 'package:tabib_al_bait/models/patienthistory/requestbody.dart';
import 'package:tabib_al_bait/models/patienthistory/responsebody.dart';
import 'package:tabib_al_bait/utils/constants.dart';
import '../../controller/patienthistory.dart';

class Refundbody {
  dynamic appointmentNo;
  dynamic patientId;
  dynamic bookingNo;
  dynamic branchId;
  dynamic typeBit;
  dynamic remarks;

  Refundbody(
      {this.appointmentNo,
      this.patientId,
      this.bookingNo,
      this.branchId,
      this.typeBit,
      this.remarks});

  Refundbody.fromJson(Map<String, dynamic> json) {
    appointmentNo = json['AppointmentNo'];
    patientId = json['PatientId'];
    bookingNo = json['BookingNo'];
    branchId = json['BranchId'];
    typeBit = json['TypeBit'];
    remarks = json['Remarks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['AppointmentNo'] = appointmentNo;
    data['PatientId'] = patientId;
    data['BookingNo'] = bookingNo;
    data['BranchId'] = branchId;
    data['TypeBit'] = typeBit;
    data['Remarks'] = remarks;
    return data;
  }
}

class patientrepo {
  getpatienthistory(historyrequestbody body, {bool? isSearch}) async {
    var headers = {'Content-Type': 'application/json'};
    try {
      var response = await http.post(
          Uri.parse(AppConstants.getAppointmentRequestList),
          body: jsonEncode(body),
          headers: headers);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        if (result['Status'] == 1) {
          if (isSearch == true) {
            Patienthistory.i.data = [];
            Patienthistory.i.dt = [];
          }
          List<HistoryResponseBody>? newList = [];
          Iterable lst = result['Data'];
          newList = lst.map((e) => HistoryResponseBody.fromJson(e)).toList();
          for (var element in newList) {
            Patienthistory.i.dt!.add(element);
          }
          Patienthistory.i.updatepatienthistory(Patienthistory.i.dt ?? []);
          Patienthistory.i.updateloading(false);
          log('${Patienthistory.i.dt?.length ?? 0}');
        } else {
          Patienthistory.i.updateloading(false);
          log('message');
        }
      } else {
        Patienthistory.i.updateloading(false);
        log(response.statusCode.toString());
      }
    } catch (e) {
      Patienthistory.i.updateloading(false);
      throw Exception();
    }
  }

  Future<void> refundapi(Refundbody body) async {
    log(jsonEncode(body).toString());
    var headers = {'Content-Type': 'application/json'};
    try {
      var response = await http.post(
        Uri.parse(AppConstants.refundapi),
        body: jsonEncode(body),
        headers: headers,
      );
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        if (result['Status'] == 1) {
          ToastManager.showToast("Refunding Successfull");
          log(response.body);
        } else {
          ToastManager.showToast(result['ErrorMessage']);
          log('message');
        }
      } else {
        log(response.statusCode.toString());
      }
    } catch (e) {
      // log(e.toString());
    }
  }
}
