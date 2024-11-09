import 'dart:convert';
import 'package:tabib_al_bait/data/localDB/local_db.dart';
import 'package:tabib_al_bait/helpers/show_toast.dart';
import 'package:tabib_al_bait/utils/constants.dart';
import 'package:http/http.dart' as http;

class PasswordRepository {
  static changepassword(String oldpass, String pass) async {
    var headers = {
      'Content-Type': 'application/json',
    };

    var body = {
      'Id': await LocalDb().getPatientId(),
      'BranchId': await LocalDb().getBranchId(),
      'Token': await LocalDb().getToken(),
      'Password': pass,
      'OldPassword': oldpass,
    };
    try {
      var response = await http.post(Uri.parse(AppConstants.changePassword),
          body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        var status = responseData['Status'];
        if (status == 1) {
          return status;
        } else {
          return 0;
        }
      }
    } catch (e) {
      ToastManager.showToast(e.toString());
      return false;
    }
    return false;
  }
}
