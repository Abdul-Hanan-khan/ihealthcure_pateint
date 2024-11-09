import 'package:get/get.dart';
import 'package:tabib_al_bait/data/controller/auth_controller.dart';
import 'package:tabib_al_bait/data/controller/book_appointment_controller.dart';
import 'package:tabib_al_bait/data/controller/bottom_nav_bar_controller.dart';
import 'package:tabib_al_bait/data/controller/controller.dart';
import 'package:tabib_al_bait/data/controller/drawerpackages.dart';
import 'package:tabib_al_bait/data/controller/family_screens_controller.dart';
import 'package:tabib_al_bait/data/controller/forgotpasswordcontroller.dart';
import 'package:tabib_al_bait/data/controller/google_maps_controller.dart';
import 'package:tabib_al_bait/data/controller/lab_investigations_controller.dart';
import 'package:tabib_al_bait/data/controller/language_controller.dart';
import 'package:tabib_al_bait/data/controller/network_connectivity_controller.dart';
import 'package:tabib_al_bait/data/controller/notificationcontroller.dart';
import 'package:tabib_al_bait/data/controller/patienthistory.dart';
import 'package:tabib_al_bait/data/controller/specialities_controller.dart';

class AppBindings implements Bindings {
  @override
  void dependencies() {
    Get.put<BottomBarController>(BottomBarController());
    Get.put<SpecialitiesController>(SpecialitiesController());
    Get.put<Forgotpasswordcontroller>(Forgotpasswordcontroller());
    Get.put<Drawerpackagescontroller>(Drawerpackagescontroller());
    Get.put<Patienthistory>(Patienthistory());
    Get.put<AddressController>(AddressController());
    Get.put<Notificationcontroller>(Notificationcontroller());
    Get.put<AuthController>(AuthController());
    Get.put<BookAppointmentController>(BookAppointmentController());
    Get.put<LabInvestigationController>(LabInvestigationController());
    Get.put<FamilyScreensController>(FamilyScreensController());
    Get.put<LanguageController>(LanguageController());
    Get.put<MyFamilyScreensController>(MyFamilyScreensController());
    Get.put<NetworkController>(NetworkController(), permanent: true);
  }
}
