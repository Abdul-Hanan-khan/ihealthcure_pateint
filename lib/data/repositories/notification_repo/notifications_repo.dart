import 'dart:convert';
import 'dart:developer';

import 'package:tabib_al_bait/data/controller/notificationcontroller.dart';
import 'package:tabib_al_bait/data/localDB/local_db.dart';
import 'package:tabib_al_bait/models/notifications/notificationmodel.dart';
import 'package:tabib_al_bait/utils/constants.dart';
import 'package:http/http.dart' as http;

class NotificationRepo {
  static getpackages(int length) async {
    String? patientid = await LocalDb().getPatientId();
    String? branchID = await LocalDb().getBranchId();
    DateTime now = DateTime.now();
    String dw =
        "${"${now.toString().split('-')[0]}-${int.parse(now.toString().split('-')[1].toString()) - 1}"}-${now.toString().split('-')[2].split(' ')[0]}";
    log(dw.toString());

    var body = {
      "PatientId": patientid,
      "BranchId": branchID,
      "Start": 0,
      "Length": length,
      "FromDate": dw,
      "ToDate": now.toString().split(' ')[0],
      "Search": "",
      "OrderDir": "desc",
      "OrderColumn": 0,
      "Token": "",
    };
    var headers = {'Content-Type': 'application/json'};
    log(jsonEncode(body).toString());
    try {
      var response = await http.post(
          Uri.parse(AppConstants.GetPatientNotifications),
          headers: headers,
          body: jsonEncode(body));
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        if (result['Status'] == 1) {
          Iterable data = result['data'];

          Notificationcontroller.i.updatedata(
              data.map((e) => Notificationmodel.fromJson(e)).toList());
        }
      } else {
        log(response.statusCode.toString());
      }
    } catch (e) {
      log('$e exception caught');
    }
  }
}
