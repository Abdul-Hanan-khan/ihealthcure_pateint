import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tabib_al_bait/models/genders_model.dart';
import 'package:tabib_al_bait/models/get_martial_statuses/get_martial_statuses.dart';

class EditProfileController extends GetxController implements GetxService {
  static DateTime? arrival = DateTime.now();
  RxString? formatArrival = DateFormat.yMMMd().format(arrival ?? DateTime.now()).obs;

  GendersData? _selectedGender;
  GendersData? get selectedGender => _selectedGender;

  MartialStatuses? _status;
  MartialStatuses? get status => _status;

  updateSelectedGender(GendersData data) {
    _selectedGender = data;
    update();
  }

  updateMartialStatuses(MartialStatuses data) {
    _status = data;
    update();
  }

  static EditProfileController get i => Get.put(EditProfileController());
}
