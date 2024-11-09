import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:tabib_al_bait/data/localDB/local_db.dart';
import 'package:tabib_al_bait/models/packages_model.dart';
import 'package:tabib_al_bait/utils/constants.dart';

class PackagesRepo {
  static getpackages() async {
    var body = {
      "PatientId": await LocalDb().getPatientId(),
      "Token": await LocalDb().getToken(),
      "BranchId": await LocalDb().getBranchId(),
      "Search": "",
      "Length": 500,
      "Start": 0
    };
    var headers = {'Content-Type': 'application/json'};

    try {
      var response = await http.post(Uri.parse(AppConstants.getPackages),
          headers: headers, body: jsonEncode(body));
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        if (result['Status'] == 1) {
          Packages packages = Packages.fromJson(jsonDecode(response.body));
          log('${packages.toString()} specialities');
          return packages;
        }
      } else {
        log(response.statusCode.toString());
      }
    } catch (e) {
      log('$e exception caught');
    }
  }

  getsearchpackages() async {
    var body = {
      "PatientId": await LocalDb().getPatientId(),
      "Token": await LocalDb().getToken(),
      "BranchId": await LocalDb().getBranchId(),
      "Search": "",
      "Length": 500,
      "Start": 0
    };
    var headers = {'Content-Type': 'application/json'};
    try {
      var response = await http.post(Uri.parse(AppConstants.getPackages),
          body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        if (result['Status'] == 1) {
          Packages search = Packages.fromJson(jsonDecode(response.body));
          return search;
        } else {
          log('message');
        }
      } else {
        log(response.statusCode.toString());
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
