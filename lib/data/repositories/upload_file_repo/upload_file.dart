import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:tabib_al_bait/utils/constants.dart';
import 'package:http/http.dart' as http;

class UploadFileRepo {
  Future<String> updatePicture(File file) async {
    String r = '';
    var url = AppConstants.uploadFile;
    // String patientId = await LocalDb().getPatientId() ?? "";
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers.addAll({'Content-Type': 'application/json'});

    request.files
        .add(await http.MultipartFile.fromPath('FileUpload', file.path));
    // request.fields['OldImagePath'] = oldimagepath;
    // request.fields['DoctorId'] = patientId;
    final res = await request.send();
    final response = await http.Response.fromStream(res);
    if (res.statusCode == 200) {
      Map<String, dynamic> responseData = json.decode(response.body);
      log(responseData.toString());

      int status = responseData['Status'];
      r = responseData['FilePath'];
      if (status == 1) {
        // int status = responseData['Status'];
        r = responseData['FilePath'];
        // ToastManager.showToast("Updated");
      } else {
        // ToastManager.showToast("Updated");
      }
    } else {
      // ToastManager.showToast("Updated");
    }
    return r;
  }
}
