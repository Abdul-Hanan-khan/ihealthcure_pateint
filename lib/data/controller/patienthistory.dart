import 'package:get/get.dart';
import 'package:tabib_al_bait/models/patienthistory/responsebody.dart';

class Patienthistory extends GetxController {
  List<HistoryResponseBody>? dt = [];
  List<HistoryResponseBody> data = [];
  updatepatienthistory(List<HistoryResponseBody> dt) {
    data = dt;
    update();
  }

  bool isloading = false;
  updateloading(bool val) {
    isloading = val;

    update();
  }

  static Patienthistory get i => Get.put(Patienthistory());
}
