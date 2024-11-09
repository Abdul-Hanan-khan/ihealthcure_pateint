// ignore_for_file: unused_import

import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:tabib_al_bait/models/preference.dart';

class PreferenceController extends GetxController implements GetxService {
  static PreferenceController get i => Get.put(PreferenceController());
  var idformatter = MaskTextInputFormatter();
  PreferenceData preferenceObject = PreferenceData();
  updatePreference(PreferenceData p) {
    preferenceObject = p;
    // idformatter = MaskTextInputFormatter(
    //     mask: PreferenceController
    //         .i.preferenceObject.dynamicMaskingForIdentityNumber);
    update();
  }
}
