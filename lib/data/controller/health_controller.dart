import 'package:get/get.dart';

class HealthController extends GetxController implements GetxService{

  int _selectedOption = 0;
  int get selectedOption => _selectedOption;

   setSelectedOption(int option) {
    _selectedOption = option;
    update();
  }

    static HealthController get i => Get.put(HealthController());


}