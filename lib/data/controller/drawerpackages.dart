import 'package:get/get.dart';
import 'package:tabib_al_bait/models/drawerpackages/drawerpackagesresponse.dart';

class Drawerpackagescontroller extends GetxController {
  List<Packagesresponse> dt = [];
  List<Packagesresponse> data = [];
  List<bool> showallitems = [];
  updateresponsedata(List<Packagesresponse> dt) {
    data = dt;
    showallitems =
        List.generate(Drawerpackagescontroller.i.data.length, (index) => false);
    update();
  }

  updatecheckvalue(int i) {
    showallitems[i] = !showallitems[i];
    update();
  }

  bool loader = false;
  updateloader(bool val) {
    loader = val;
    update();
  }

  static Drawerpackagescontroller get i => Get.put(Drawerpackagescontroller());
}
