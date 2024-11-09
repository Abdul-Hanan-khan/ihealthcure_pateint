import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:tabib_al_bait/data/localDB/local_db.dart';
import 'package:tabib_al_bait/helpers/show_toast.dart';
import 'package:tabib_al_bait/models/favoriteDoctorsResponse/favorite_doctors_model.dart';
import 'package:tabib_al_bait/utils/constants.dart';

class FavoritesRepo {
  static addToFavorites({
    String? doctorId,
    String? patientId,
    String? branchId,
  }) async {
    var token = await LocalDb().getToken();
    var branchId = await LocalDb().getBranchId();
    var body = {
      "DoctorId": "$doctorId",
      "PatientId": "$patientId",
      "BranchId": "$branchId",
      "Token": "$token"
    };
    var headers = {'Content-Type': 'application/json'};
    try {
      var response = await http.post(Uri.parse(AppConstants.addToFavoritesURI),
          headers: headers, body: jsonEncode(body));
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        if (result['Status'] == 1) {
          ToastManager.showToast('${result['ErrorMessage']}');
        }
      } else {
        var result = jsonDecode(response.body);
        ToastManager.showToast('${result['Status']}');
      }
    } catch (e) {
      // handleError(e);
    }
  }

  static removeFromFavorites({
    String? doctorId,
    String? patientId,
    String? branchId,
  }) async {
    var token = await LocalDb().getToken();
    var branchId = await LocalDb().getBranchId();
    var body = {
      "DoctorId": "$doctorId",
      "PatientId": "$patientId",
      "BranchId": "$branchId",
      "Token": "$token"
    };
    var headers = {'Content-Type': 'application/json'};
    try {
      var response = await http.post(
          Uri.parse(AppConstants.removedFromFavoritesURI),
          headers: headers,
          body: jsonEncode(body));
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        if (result['Status'] == 1) {
          ToastManager.showToast('${result['ErrorMessage']}');
        }
      } else {
        var result = jsonDecode(response.body);
        ToastManager.showToast('${result['ErrorMessage']}');
      }
    } catch (e) {
      // handleError(e);
    }
  }

  static getAllFavoriteDoctors() async {
    var patientId = await LocalDb().getPatientId();
    var token = await LocalDb().getToken();
    var branchID = await LocalDb().getBranchId();
    var body = {
      "PatientId": "$patientId",
      "Token": "$token",
      "BranchId": "$branchID",
      "DoctorName": "",
      "WorkLocationId": "",
      "SpecialityId": "",
      "IsOnline": "false",
      "MinConsultancyFee": "",
      "MaxConsultancyFee": "",
      "Date": "",
      "FromTime": "",
      "ToTime": "",
      "CityId": ""
    };
    var headers = {'Content-Type': 'application/json'};
    try {
      var response = await http.post(
          Uri.parse(AppConstants.getAllFavoriteDoctorsURI),
          headers: headers,
          body: jsonEncode(body));
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        if (result['Status'] == 1) {
          GetFavoriteDoctorsResponse response =
              GetFavoriteDoctorsResponse.fromJson(result);
          log(response.doctors.toString());
          return response.doctors;
        }
      } else {
        var result = jsonDecode(response.body);
        ToastManager.showToast('${result['ErrorMessage']}');
      }
    } catch (e) {
      // ToastManager.showToast('someThingWentWrong'.tr);
    }
  }
}
