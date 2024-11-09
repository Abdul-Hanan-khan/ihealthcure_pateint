import 'dart:convert';
import 'dart:developer';
import 'package:tabib_al_bait/data/controller/health_summary_controller.dart';
import 'package:tabib_al_bait/data/localDB/local_db.dart';
import 'package:http/http.dart' as http;
import 'package:tabib_al_bait/models/prescription_summary_response/prescription_summary_response.dart';
import 'package:tabib_al_bait/utils/constants.dart';

class HealthSummaryRepo {
  static Future<PrescriptionSummaryResponse?> prescriptionSummary() async {
    HealthSummaryController.i.updateIsLoading(true);

    try {
      var patientId = await LocalDb().getPatientId();
      var token = await LocalDb().getToken();
      var body = {"PatientId": "$patientId", "Token": "$token"};
      var headers = {'Content-Type': 'application/json'};

      var response = await http.post(
        Uri.parse(AppConstants.prescriptionSummary),
        headers: headers,
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);

        if (result['Status'] == 1) {
          PrescriptionSummaryResponse response =
          PrescriptionSummaryResponse.fromJson(result);
          HealthSummaryController.i.updateIsLoading(false);
          return response;
        } else {
          HealthSummaryController.i.updateIsLoading(false);
          log(result['Status'].toString());
          return null;
        }
      } else {
        HealthSummaryController.i.updateIsLoading(false);
        log('HTTP Status Code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      HealthSummaryController.i.updateIsLoading(false);
      log('Error: $e');
      return null; 
    }
  }
}
