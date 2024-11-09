import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:tabib_al_bait/data/controller/forgotpasswordcontroller.dart';
import 'package:tabib_al_bait/models/forgetpassword/verifycodereturn.dart';
import 'package:tabib_al_bait/utils/constants.dart';

class Forgotpasswordrepo {
  getpatienthistory(bd) async {
    var body = {'email': bd};
    var headers = {'Content-Type': 'application/json'};
    try {
      var response = await http.post(
          Uri.parse(AppConstants.forgotpasswordemail),
          body: jsonEncode(body),
          headers: headers);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        if (result['Status'] == 1) {
          Forgotpasswordcontroller.i
              .updatereturnbody(Verifycoderesponse.fromJson(result));
          return Forgotpasswordcontroller().data;
        } else {
          return result['ErrorMessage'];
        }
      } else {
        log(response.statusCode.toString());
      }
    } catch (e) {
      log(e.toString());
    }
  }

  verifypassword(String email, String verifycode) async {
    var body = {
      "Email": email,
      "VerificationCode": verifycode,
    };
    var headers = {'Content-Type': 'application/json'};
    try {
      var response = await http.post(
          Uri.parse(AppConstants.resetcodeverification),
          body: jsonEncode(body),
          headers: headers);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        if (result['Status'] == 1) {
          Forgotpasswordcontroller.i
              .updatereturnbody(Verifycoderesponse.fromJson(result));
          return Forgotpasswordcontroller().data;
        } else {
          return result['ErrorMessage'];
        }
      } else {
        log(response.statusCode.toString());
      }
    } catch (e) {
      log(e.toString());
    }
  }

  changepassword(String pass, String confirmpass) async {
    var body = {
      "UserName": Forgotpasswordcontroller.i.data.username,
      "Email": Forgotpasswordcontroller.i.data.email,
      "Password": "123123",
      "ConfirmPassword": "123123",
      "VerificationCode": "344503",
    };
    var headers = {'Content-Type': 'application/json'};
    try {
      var response = await http.post(
          Uri.parse(AppConstants.forgotpasswordemail),
          body: jsonEncode(body),
          headers: headers);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        if (result['Status'] == 1) {
          return result['Status'].toString();
        } else {
          return result['Status'].toString();
        }
      } else {
        log(response.statusCode.toString());
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
