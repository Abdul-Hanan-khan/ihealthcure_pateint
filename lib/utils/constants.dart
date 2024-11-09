// ignore_for_file: non_constant_identifier_names, unused_local_variable

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tabib_al_bait/data/controller/book_appointment_controller.dart';
import 'package:tabib_al_bait/data/controller/favorites_controller.dart';
import 'package:tabib_al_bait/data/controller/lab_investigations_controller.dart';
import 'package:tabib_al_bait/data/controller/schedule_controller.dart';
import 'package:tabib_al_bait/data/controller/specialities_controller.dart';
import 'package:tabib_al_bait/data/localDB/local_db.dart';
import 'package:tabib_al_bait/helpers/show_toast.dart';
import 'package:tabib_al_bait/models/languages_model/languages_model.dart';
import 'package:tabib_al_bait/screens/success_and_failure_screens/appointment_failed.dart';

String baseURL = "http://192.168.88.254:328/";
String getImageUrl = '$baseURL/File/Download';

class AppConstants {
  // Base Url
  // static const String baseURL = 'http://192.168.88.254:324'; // for testing QA

  static const String testing =
      'https://qa.patient.ihealthcure.com'; // Live URL tabib albait patient
  // Branch ID
  // static const String baseURL='https://patient.helpful.ihealthcure.com';
  static const String test = 'https://patient.helpful.ihealthcure.com';
  // static const String branchID = "00000000-0000-0000-0000-000000000000";
  // API Endpoints
  static String getLabs = '$baseURL/api/labs/GetLabs';

  static String getLabTests = '$baseURL/api/labs/GetLabTests';
//BookDiagnosticAppointment
  static String getDiagnostics =
      '$baseURL/api/diagnosticappointment/GetDiagnostics';
  static String getDiagnosticscenter =
      '$baseURL/api/diagnosticappointment/GetDiagnosticCenters';
  static String getDiagnosticslots =
      '$baseURL/api/diagnosticappointment/GetDateWiseDiagnosticSlots';
  static String BookDiagnosticAppointment =
      '$baseURL/api/diagnosticappointment/BookDiagnosticAppointment';
  static String ConfirmDiagnosticAppointment =
      '$baseURL/api/diagnosticappointment/ConfirmDiagnosticAppointmentPayment';
  //api/account/GetPatientNotifications
  static String GetPatientNotifications =
      '$baseURL/api/account/GetPatientNotifications';
  static String getpatienthistory =
      '$baseURL/api/account/GetPatientNotifications';
  static String getPackages =
      '$baseURL/api/Appointment/GetPackageGroupServicesDetail';
  static String changePassword = '$baseURL/api/ChangePassword';
  static String getSpecialities = '$baseURL/api/appointment/GetSpecialities';
  static String getDoctorWorkLocations =
      '$baseURL/api/appointment/GetDoctorWorkLocations';
  //GetDoctorWorkLocations
  static String searchDoctor = '$baseURL/api/appointment/searchdoctor';
  static String signup = '$baseURL/api/SignUp';
  static String verifySignUp = '$baseURL/api/VerifySignUp';
  static String login = '$baseURL/api/account';
  static String getGenders = '$baseURL/api/ddl/GetGenders';
  static String getCountries = '$baseURL/api/ddl/GetCountries';
  static String getStatesOrProvince = '$baseURL/api/ddl/GetStateOrProvinces';
  static String getCities = '$baseURL/api/ddl/GetCities';
  static String deleteAccountURI = '$baseURL/api/account/DeletePatientAccount';
  static String updateprofile = '$baseURL/api/account/UpdateProfile';
  static String getupdateprofile =
      '$baseURL/api/account/GetUpdateProfileDetail';
  //  static String getProfileUpdate =
  //     '$baseURL/api/account/patientprofile?';
  static String getDoctorLocationsAndSchedule =
      '$baseURL/api/appointment/GetDoctorWorkLocations';
  static String getDoctorWiseSlots =
      '$baseURL/api/appointment/GetDateWiseDoctorSlot';
  static String getPayments = '$baseURL/api/account/GetPaymentMethods';
  static String bookAppoinmentURI = '$baseURL/api/appointment/BookAppointment';
  static String confirmLabTestPaymentUri =
      '$baseURL/api/labs/ConfirmLabTestPayment';
  static String doctorsListURI = '$baseURL/api/ddl/GetDoctor';
  static String getConsultancyFee =
      '$baseURL/api/appointment/GetDoctorConsultancyFee';
  static String consultNowURI = '$baseURL/api/appointment/ConsultNow';
  static String getAppointmentsSummery =
      '$baseURL/api/appointment/GetAppointmentSummary';
  static String getDoctorUpcoming =
      '$baseURL/api/appointment/GetUpcomingAppointment';
  static String getDignosticUpcoming =
      '$baseURL/api/diagnosticappointment/GetUpcomingDiagnosticAppointment';
  static String getLabInvestigationUpcoming =
      '$baseURL/api/labs/GetUpComingLabTest';
  static String getDoctorAppointmentHistory =
      '$baseURL/api/appointment/GetHistory';
  static String getDiagnosticsAppointmentHistory =
      '$baseURL/api/diagnosticappointment/GetDiagnosticAppointmentHistory';
  static String getLabInvestigationHistory =
      '$baseURL/api/labs/GetHistoryLabTest';
  static String logoutURI = '$baseURL/api/account/Logoff';
  static String prescriptionSummary =
      '$baseURL/api/account/PrescriptionSummary';
  static String rescheduleDoctorAppointmentURI =
      '$baseURL/api/appointment/Rescheduleappointment';

  static String reschedulediagnosticappoitment =
      '$baseURL/api/diagnosticappointment/RescheduleDiagnosticAppointment';
  static String cancelDoctorAppointmentURI = '$baseURL/api/appointment/Cancel';
  static String cancelLabAppointment = '$baseURL/api/lab/CancelLabAppointment';
  static String cancelDiagnosticAppointment =
      '$baseURL/api/diagnosticappointment/CancelDiagnosticAppointment';
  static String rescheduleLabTest = '$baseURL/api/labs/RescheduleLabTest';
  static String addToFavoritesURI = '$baseURL/api/account/AddFavouriteDoctor';
  static String removedFromFavoritesURI =
      '$baseURL/api/account/RemovedFavouriteDoctor';
  static String getAllFavoriteDoctorsURI =
      '$baseURL/api/account/GetFavouriteDoctors';

  ///api/Appointment/GetPackageGroupServicesDetail
  static String drawerpackages =
      '$baseURL/api/account/GetAppointmentRequestList';
  //RefundRequest
  static String refundapi = '$baseURL/api/appointment/RefundRequest';
  static String getAppointmentRequestList =
      '$baseURL/api/account/GetAppointmentRequestList';
  static String forgotpasswordemail = '$baseURL/api/ForgetPassword';
  static String resetcodeverification = '$baseURL/api/VerifyCode';
  static String getLabTestReports =
      '$baseURL/api/account/PatientInvestigations';
  static String getDigitalPrescriptions =
      '$baseURL/api/account/PatientOPDVisits';
  static String getDiagnosticImagingURL =
      '$baseURL/api/account/PatientDiagnostics';
  static String acceptConsulation =
      '$baseURL/api/appointment/AcceptConsulation';
  static String dropCall = '$baseURL/api/appointment/DropCall';
  static String cancelconsultation =
      '$baseURL/api/appointment/CancelConsulation';
  static String getFamilyMembers = '$baseURL/api/account/FamilyMembers';
  static String searchFamilyMember = '$baseURL/api/Search';
  static String getRelationShipTypes =
      '$baseURL/api/ddl/GetFamilyMemberRelations';
  static String addExistingfamilyMember =
      '$baseURL/api/AddExistingFamilyMember';
  static String addNewFamilyMember = '$baseURL/api/AddFamilyMember';
  static String getMartialStatuses = '$baseURL/api/ddl/GetMaritalStatuses';
  static String getBloodGroups = '$baseURL/api/ddl/GetBloodGroups';
  static String confirmDoctorPayment =
      "$baseURL/Api/Account/ConfirmDoctorPayment";
  static String uploadFile = '$baseURL/api/UploadFile';
  static String getBranchPreference =
      '$baseURL/api/account/GetBranchPreference';

  // ======================>
  static String appName = 'Sidra Patient Care';
  static const String requestText =
      'Muhammad Yousaf has requested to add you as Family Member, if you accept, He/She will be able to see your complete medical history, medical appointments and will be able to reserve appointments on your behalf.';
  static const String appointmentSuccessful =
      'Appointment Successfully Booked. You Will receive a notification and the Rider will Collect the sample from you.';
  static const String appointMentFailed =
      'Appointment failed please check your internet connection then try again.';
  static const String description =
      'Dr. Shaikh Hamid is a highly skilled Cardiology specialist. With extensive expertise in the field, he possesses a deep understanding of cardiovascular diseases and their treatment. Dr. Hamid is committed to providing exceptional patient care and employing the latest advancements in cardiology to improve the lives of his patients. His dedication to research and continuous learning ensures that he stays up-to-date with the most current medical practices.';
  static const String consent =
      'By using our website, services & products, you hereby consent to our Privacy Policy and agree to its terms. If you are a doctor or medical professional registering on this App, by enrolling in or using this service, you hereby confirm that usage is at your own risk and you release and agree to hold harmless the providers, developers, deployers from liability for adverse consequences, including but limited to claims, actions or legal proceedings by third parties, loss or breach of any private data and/or damages suffered as a result thereof.';
  static const String information1 =
      'Our system and apps are mainly targeting Health Care and medical. We are collecting some other information and permissions in our apps to improve user experience and app functionality. The information we collect is ephemerally processed i.e. it is only used to start some service or functionality involved inside the application and not used after it is stopped. Some important one are mentioned below with prominent disclosure/reasons for collection:';
  static const String information2 =
      'Location: In order to show nearby doctors, app needs to get this permission from user. By enabling Location-Based services on your device, you agree and acknowledge  that (a) device data that is collected from you is directly relevant to your use of the App, (b) We may provide Location-Based services related to and based on your then-current location, and (c) We may use any information collected in connection with its provision of the App.For video calling between doctor and patient.For audio calling  between doctor and patient (a)User/Patient can upload profile picture (b) User/Patient can upload health records and files for doctor to examine (c)User/Patient can download and view reports etc.';
  static const String usage =
      'We use the informative we collect in various ways, including to: (a)Provide, operate, and maintain our services and products (c)Understand and analyze how you use our services and products (d)Develop new product, services features, and functionality (e) Communicate with you, either directly or through one of our partners, including for customer service, to provide you with updates and other information relating to the website, and for marketing and promotional purposes (f) Send your emails (g) Find and prevent fraud.';
  static const String disclosure =
      'We may disclose personal information to any person performing audit, legal, operational or other services for us. We will use information which does not identify the individual for these activities whenever reasonably possible. Under the CCPA, among other rights, California consumers have the  right to Request that a business that collects personal data disclose the categories and specific pieces of personal data that a business has collected about consumers, Request that a business delete any personal data, not sell the consumers personal data. If you make a request, we have one month to respond to you. If you would like to exercise any of these rights, please contact us via customer supportUnder the GDPR Data Protection Rights, every user is entitled to the right to request copies of your personal data. We may charge you a small fell for the service, right to request that we correct any information you believe in inaccurate, right to request that we erase your personal data, restrict its processing, object to our processing of your personal, transfer the data that we have collected to another organization or directly to you data under certain conditions. If you make a request, we have one month to respond to you. If you would like to exercise any of these rights, please contact us via customer support ';
  static int maximumDataTobeFetched = 25;

  static List<LanguageModel> languages = [
    LanguageModel(name: 'English', id: 1, locale: const Locale('en', 'US')),
    LanguageModel(name: 'عربي'.tr, id: 2, locale: const Locale('ar', 'SA')),
    LanguageModel(name: 'اردو'.tr, id: 3, locale: const Locale('ur', 'PK')),
  ];
}

TimeOfDay stringToTimeOfDay(String tod) {
  final format = DateFormat.jm(); //"6:00 AM"
  return TimeOfDay.fromDateTime(format.parse(tod));
}

DateTime? toDateTime(dynamic dateValue) {
  if (dateValue is DateTime) {
    return dateValue;
  } else if (dateValue is String) {
    DateTime date = DateTime.parse(dateValue);
    String dateFormat = DateFormat('yyyy-MM-dd').format(date);
    return DateTime.parse(dateFormat);
  } else {
    return null;
  }
}

handleError(dynamic e) {
  if (e.toString().startsWith('Failed host lookup:')) {
    Get.to(() => const AppointmentFailed());
    LabInvestigationController.i.selectedDate = DateTime.now();
  } else {
    log('====>');
    ToastManager.showToast("$e");
    LabInvestigationController.i.selectedDate = DateTime.now();
  }
}

Future listToLoad() async {
  var spec = SpecialitiesController.i;
  var fav = FavoritesController.i;
  var book = BookAppointmentController.i;
  var isLoggedin = await LocalDb().getLoginStatus();
  if (isLoggedin == true) {
    await FavoritesController.i.getAllFavoriteDoctors();
    await ScheduleController.i.changeStatusofOpenedTab(true);
    await ScheduleController.i.clearData();
    await ScheduleController.i.getUpcomingAppointment("", true);
    await ScheduleController.i.ApplyFilterForAppointments(1);
    if (FavoritesController.i.favoriteDoctors.isNotEmpty) {
      log('loaded favorites');
      spec.updateIsFavoriteLoaded(true);
      spec.updateisUpcomingAppointmentLoaded(false);
      spec.updateIsAllDoctorsLoaded(false);
      return FavoritesController.i.favoriteDoctors;
    }
    // else if (ScheduleController
    //     .i.doctorConsultationUpcomingAppointments.isNotEmpty) {
    //   log('loaded upcoming Doctor Appointments');
    //   spec.updateisUpcomingAppointmentLoaded(true);
    //   spec.updateIsFavoriteLoaded(false);
    //   spec.updateIsAllDoctorsLoaded(false);
    //   return ScheduleController.i.doctorConsultationUpcomingAppointments;

    // }
    else if (FavoritesController.i.favoriteDoctors.isEmpty &&
        ScheduleController.i.doctorConsultationUpcomingAppointments.isEmpty) {
      spec.updateIsAllDoctorsLoaded(true);
      spec.updateIsFavoriteLoaded(false);
      spec.updateisUpcomingAppointmentLoaded(false);

      return SpecialitiesController.i.allDoctors;
    }
  } else {
    spec.updateIsAllDoctorsLoaded(true);
    spec.updateIsFavoriteLoaded(false);
    spec.updateisUpcomingAppointmentLoaded(false);
    return SpecialitiesController.i.allDoctors;
  }
}

Future<int> lengthOfList() async {
  var isLoggedin = await LocalDb().getLoginStatus();
  return SpecialitiesController.i.allDoctors.length;
}

Future<int> ret0() async {
  log('here');
  return SpecialitiesController.i.allDoctors.length;
}
