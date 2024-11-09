// ignore_for_file: non_constant_identifier_names, unused_local_variable

import 'dart:convert';
import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tabib_al_bait/data/controller/auth_controller.dart';
import 'package:tabib_al_bait/models/appointment_booking_mode/appointment_booking_model.dart';
import 'package:tabib_al_bait/models/doctor_consultation_fee.dart';
import 'package:tabib_al_bait/models/languages_model/languages_model.dart';
import 'package:tabib_al_bait/models/search_models.dart';
import 'package:tabib_al_bait/models/user_model.dart';

class LocalDb {
  savePatientId(String? patientId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var result = prefs.setString('patientId', '$patientId');
    log('patientId $result');
  }

  Future<String?>? getPatientId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? result = prefs.getString('patientId');
    log('The patient Id is $result');
    return result;
  }

  savefingerprintstatus(bool val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var result = prefs.setBool('fingerprint', val);
    AuthController.i.updateFingerPrint(val);
    // getfingerprintstatus();
    log('patientId $result');
  }

  Future<bool> getfingerprintstatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var result = prefs.getBool('fingerprint') ?? false;
    return result;
  }

  saveusernamepassword(String? username, String? password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var result = prefs.setString('username', username ?? "");
    var pass = prefs.setString('password', password ?? "");
    log('patientId $result $pass');
  }

  getusername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? result = prefs.getString('username');
    log('the token is $result');
    return result;
  }

  getpassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? result = prefs.getString('password');
    log('the token is $result');
    return result;
  }

  saveToken(String? token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var result = prefs.setString('token', '$token');
    log('patientId $result');
  }

  Future<String?>? getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? result = prefs.getString('token');
    log('the token is $result');
    return result;
  }

  saveLoginStatus(bool status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var result = prefs.setBool('status', status);
    log('patientId $result');
  }

  Future<bool?>? getLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? result = prefs.getBool('status') ?? false;
    return result;
  }

  static Future saveUserData(UserDataModel user) async {
    SharedPreferences s = await SharedPreferences.getInstance();
    s.setString('user_model', jsonEncode(user));
  }

  Future getDataFromSP() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    String data = s.getString("user_model") ?? '';
    UserDataModel user = UserDataModel.fromJson(jsonDecode(data));
    AuthController.i.updateUser(user);
    log(user.toJson().toString());
  }

  static saveAppointmentData(AppointmentDataModel model) async {
    SharedPreferences s = await SharedPreferences.getInstance();
    s.setString('appointment', jsonEncode(model));
  }

  Future<AppointmentDataModel> getAppoinryMentData() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    String data = s.getString("appointment") ?? '';
    AppointmentDataModel model =
        AppointmentDataModel.fromJson(jsonDecode(data));
    return model;
  }

  static saveSearchDoctor(Search model) async {
    SharedPreferences s = await SharedPreferences.getInstance();
    s.setString('search', jsonEncode(model));
  }

  Future<Search> getSearchDoctor() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    String data = s.getString("search") ?? '';
    Search model = Search.fromJson(jsonDecode(data));
    return model;
  }

  static saveConsultNowBody(ConsultancyDetail model) async {
    SharedPreferences s = await SharedPreferences.getInstance();
    s.setString('consultancy', jsonEncode(model));
  }

  Future<ConsultancyDetail> getConsultNow() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    String data = s.getString("consultancy") ?? '';
    ConsultancyDetail? model = ConsultancyDetail.fromJson(jsonDecode(data));
    return model;
  }

  saveDeviceToken(String? token) async {
    SharedPreferences s = await SharedPreferences.getInstance();
    s.setString('deviceToken', token!);
    log('saved in pref $token');
  }

  Future<String> getDeviceToken() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    String? token = s.getString('deviceToken') ?? '';
    log('received token $token');
    String receivedToken = token;
    return receivedToken;
  }

  disclosureDialogvalue() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    s.setBool('dialogue', true);
    log('true');
  }

  Future<bool?> getDisclosureDialogueValue() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    bool? value = s.getBool('dialogue');
    log('value got from dialogue $value');
    return value;
  }

  setisOnboarding() async {
    int isviewed = 1;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setInt("initScreen", isviewed);
  }

  Future<int?> getIsOnboarding() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getInt('initScreen');
  }

  saveBranchId(String? BranchId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var result = prefs.setString('BranchId', '$BranchId');
    log('BranchId $result');
  }

  Future<String?>? getBranchId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? result = prefs.getString('BranchId');

    return result;
  }

  setLanguage(LanguageModel? language) async {
    SharedPreferences s = await SharedPreferences.getInstance();
    s.setString('language', jsonEncode(language));
  }

  Future<LanguageModel?> getLanguage() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    String? data = s.getString("language");
    LanguageModel? lang;
    if (data != null) {
      lang = LanguageModel.fromJson(jsonDecode(data));
    } else {
      lang = null;
    }
    return lang;
  }

  setBaseURL(String baseURL) async {
    SharedPreferences s = await SharedPreferences.getInstance();
    s.setString('baseURL', baseURL);
  }

  Future<String?> getBaseURL() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    String? data = s.getString("baseURL") ?? '';
    return data;
  }

  setUpdateProfile(String id) async {
    SharedPreferences s = await SharedPreferences.getInstance();
  }

  static Future saveProfileData(UserDataModel user) async {
    SharedPreferences s = await SharedPreferences.getInstance();
    s.setString('profile', jsonEncode(user));

    log(user.toJson().toString());
  }

  Future<UserDataModel> getProfileData() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    String data = s.getString("profile") ?? '';
    UserDataModel user = UserDataModel.fromJson(jsonDecode(data));
    return user;
  }
}
