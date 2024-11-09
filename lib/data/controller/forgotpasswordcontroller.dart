import 'package:get/get.dart';
import 'package:tabib_al_bait/models/forgetpassword/verifycodereturn.dart';

class Forgotpasswordcontroller extends GetxController {
  Verifycoderesponse data = Verifycoderesponse();
  updatereturnbody(Verifycoderesponse dt) {
    data = dt;
    update();
  }

  static Forgotpasswordcontroller get i => Get.put(Forgotpasswordcontroller());
}
