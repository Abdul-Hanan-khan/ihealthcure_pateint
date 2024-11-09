import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tabib_al_bait/components/images.dart';
import 'package:tabib_al_bait/data/controller/bottom_nav_bar_controller.dart';
import 'package:tabib_al_bait/data/controller/schedule_controller.dart';
import 'package:tabib_al_bait/data/controller/specialities_controller.dart';
import 'package:tabib_al_bait/data/localDB/local_db.dart';
import 'package:tabib_al_bait/helpers/show_toast.dart';
import 'package:tabib_al_bait/main.dart';
import 'package:tabib_al_bait/models/book_appointment.dart';
import 'package:tabib_al_bait/models/consult_now/consult_now_body.dart';
import 'package:tabib_al_bait/models/date_wise_doctor_slots.dart';
import 'package:tabib_al_bait/models/doctor_consultation_fee.dart';
import 'package:tabib_al_bait/models/doctor_locations_model.dart';
import 'package:tabib_al_bait/models/payment_response.dart';
import 'package:tabib_al_bait/models/search_models.dart';
import 'package:tabib_al_bait/models/specialities_model.dart';
import 'package:tabib_al_bait/screens/callringingscreen/waitingscreen.dart';
import 'package:tabib_al_bait/screens/dashboard/menu_drawer.dart';
import 'package:tabib_al_bait/screens/web_view_flutter/web_view.dart';
import 'package:tabib_al_bait/utils/constants.dart';
import '../../../components/success_or_failed.dart';
import '../../controller/book_appointment_controller.dart';

class SpecialitiesRepo {
  static getSpecialities({String? query}) async {
    var body = {
      "Search": query
    };
    var headers = {'Content-Type': 'application/json'};

    try {
      var response = await http.post(Uri.parse(AppConstants.getSpecialities),
          headers: headers, body: jsonEncode(body));
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        if (result['Status'] == 1) {
          Specialities specialities =
              Specialities.fromJson(jsonDecode(response.body));
          log('${specialities.toString()} specialities');
          log(result.toString());
          return specialities;
        }
      } else {
        log(response.statusCode.toString());
      }
    } catch (e) {
      log('$e exception caught');
    }
  }

  static getworklocaitons() async {
    var body = {};
    var headers = {'Content-Type': 'application/json'};

    try {
      var response = await http.post(
          Uri.parse(AppConstants.getDoctorWorkLocations),
          headers: headers,
          body: jsonEncode(body));
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        if (result['Status'] == 1) {
          Iterable data = result['Data'];
          SpecialitiesController.i.updateworklocations(
              data.map((e) => DoctorScheduleModel.fromJson(e)).toList());
        }
      } else {
        log(response.statusCode.toString());
      }
    } catch (e) {
      log('$e exception caught');
    }
  }

  getSearchDoctors({String? id, String? query}) async {
    var patientId = await LocalDb().getPatientId();
    var branchID = await LocalDb().getBranchId();
    var body = {
      
      "PatientId": "$patientId",
      "Token": "",
      "BranchId": "$branchID",
      "DoctorName": "$query",
      "WorkLocationId": "",
      "SpecialityId": id ?? '',
      "IsOnline": false,
      "MinConsultancyFee": "",
      "MaxConsultancyFee": "",
      "Date": "",
      "FromTime": "",
      "ToTime": "",
      "CityId": ""
    };
    var headers = {'Content-Type': 'application/json'};
    try {
      var response = await http.post(Uri.parse(AppConstants.searchDoctor),
          body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        if (result['Status'] == 1) {
          SearchDoctors search =
              SearchDoctors.fromJson(jsonDecode(response.body));

          return search;
        } else {
          log('message');
        }
      } else {
        log(response.statusCode.toString());
      }
    } catch (e) {
      // ToastManager.showToast('someerroroccured'.tr);
    }
  }

  static getDoctorWorkLocations(String doctorsId) async {
    String branchid = await LocalDb().getBranchId() ?? "";
    var body = {"DoctorId": doctorsId, "BranchId": branchid};
    var headers = {'Content-Type': 'application/json'};
    SpecialitiesController.i.updateIsLoading(true);
    try {
      var response = await http.post(
          Uri.parse(AppConstants.getDoctorLocationsAndSchedule),
          body: jsonEncode(body),
          headers: headers);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        if (result['Status'] == 1) {
          DoctorsData data = DoctorsData.fromJson(result);
          SpecialitiesController.i.updateIsLoading(false);
          return data.data;
        } else {
          SpecialitiesController.i.updateIsLoading(false);
          ToastManager.showToast('someerroroccured'.tr);
        }
      } else {
        SpecialitiesController.i.updateIsLoading(false);
        ToastManager.showToast('${response.statusCode}');
      }
    } catch (e) {
      SpecialitiesController.i.updateIsLoading(false);
      // ToastManager.showToast(e.toString());
    }
  }

  static getDateWiseDoctorSlots(String doctorsId, String? workLocationId,
      bool? isOnline, String? date) async {
    var branchID = await LocalDb().getBranchId();
    var body = {
      "DoctorId": doctorsId,
      "WorkLocationId": "$workLocationId",
      "DayDate": "$date",
      "BranchId": branchID,
      "Token": "ABB358A1-301C-4BBD-B8B7-01A1D903F770",
      "IsOnlineConfiguration": isOnline
    };
    var headers = {'Content-Type': 'application/json'};
    BookAppointmentController.i.updateIsBookAppointmentLoading(true);
    try {
      var response = await http.post(Uri.parse(AppConstants.getDoctorWiseSlots),
          body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        if (result['Status'] == 1) {
          DateWiseDoctorSlots data = DateWiseDoctorSlots.fromJson(result);
          BookAppointmentController.i.updateIsBookAppointmentLoading(false);
          log(data.toJson().toString());
          return data.sessions!;
        } else {
          BookAppointmentController.i.updateIsBookAppointmentLoading(false);
          ToastManager.showToast('someerroroccured'.tr);
        }
      } else {
        BookAppointmentController.i.updateIsBookAppointmentLoading(false);
        ToastManager.showToast('${response.statusCode}');
      }
    } catch (e) {
      BookAppointmentController.i.updateIsBookAppointmentLoading(false);
      // ToastManager.showToast('$e');
    }
  }

  static getPaymentMethods() async {
    var branchID = await LocalDb().getBranchId();
    var token = await LocalDb().getToken();
    var body = {
      "IsMobile": "true",
      "BranchId": branchID,
      "IsWeb": "true",
      "IsHIMS": "false",
      "Token": "$token"
    };
    var headers = {'Content-Type': 'application/json'};
    try {
      var response = await http.post(Uri.parse(AppConstants.getPayments),
          body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        if (result['Status'] == 1) {
          PaymentResponse payments = PaymentResponse.fromJson(result);
          return payments.data;
        } else {
          ToastManager.showToast('${result['Data']}');
        }
      } else {
        log(response.statusCode.toString());
      }
    } catch (e) {
      log(e.toString());
    }
  }

  static bookAppointment(
      String doctorId,
      String? patientId,
      String? bookdate,
      String? startTime,
      String? endTime,
      bool isOnlineConsultation,
      String? workLocationId,
      String? sessionId,
      String? branchId,
      {String? appointmentnotes,
      String? actualPrice}) async {
    BookAppointmentController.i.updateIsBookAppointmentLoading(true);

    log(BookAppointmentController.i.isBookAppointmentLoading.toString());
    log('$endTime');
    var body = {
      // "PaymentMethodId":
      //     "${BookAppointmentController.i.bookAppointmentMethod?.id}",

      "doctorId": doctorId,
      "PatientId": "$patientId",
      "BookDate": "$bookdate",
      "StartTime": "$startTime",
      "EndTime": "$endTime",
      "IsOnlineConsultation": "$isOnlineConsultation",
      "WorkLocationId": "$workLocationId",
      "SessionId": "$sessionId",
      "BranchId": "$branchId",
      "AppointmentNotes": appointmentnotes,
      // "Token":"49E2C5AD-7DAC-4485-BEB1-95B4056935EB"
    };
    log(body.toString());
    // log('$doctorId , $patientId, $bookdate , $startTime, $endTime , $isOnlineConsultation ,$workLocationId, $sessionId, $branchId');
    var headers = {'Content-Type': 'application/json'};
    var response = await http.post(Uri.parse(AppConstants.bookAppoinmentURI),
        body: jsonEncode(body), headers: headers);

    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      if (result['Data'] != null) {
        log(response.body);
        BookAppointmentResponse bookAppointment =
            BookAppointmentResponse.fromJson(result);
        log(bookAppointment.toJson().toString());

        log(BookAppointmentController.i.isBookAppointmentLoading.toString());
        await confirmDoctorPayment(
          paymentMethodId:
              BookAppointmentController.i.bookAppointmentMethod?.id,
          doctorId: doctorId,
          price: actualPrice,
        );
        showDialog(
            context: Get.context!,
            builder: (context) {
              return StatefulBuilder(builder: (context, setstate) {
                return Material(
                  type: MaterialType.transparency,
                  color: Colors.transparent,
                  child: AlertDialog(
                    backgroundColor: const Color.fromARGB(0, 178, 169, 169),
                    content: Column(
                      children: [
                        SizedBox(
                          height: Get.height * 0.08,
                        ),
                        AppointSuccessfulOrFailedWidget(
                          isLabInvestigationBooking: false,
                          titleImage: false,
                          image: Images.correct,
                          successOrFailedHeader: 'Appointment Successful',
                          appoinmentFailedorSuccessSmalltext:
                              'Your Appointment has been successfully booked',
                          firstButtonText: 'viewAppointment'.tr,
                          secondButtonText: 'cancel'.tr,
                          onPressedFirst: () async {
                            Get.offAll(() => const DrawerScreen());
                            BottomBarController.i
                                .navigateToPage(1, filterType: 1);
                            ScheduleController.i.ApplyFilterForAppointments(1);
                            ScheduleController.i.update();
                            BottomBarController.i.update();
                            ScheduleController.i.updateLatestAppointment(
                                result['Data']['AppointmentId']);
                          },
                          onPressedSecond: () {
                            Get.back();
                          },
                        )
                      ],
                    ),
                  ),
                );
              });
            });
        await loadtheData();
        BookAppointmentController.i.updatePayment(true);
        return bookAppointment.data;
      } else if (result['Status'] == 1 &&
          result['ErrorMessage'] == 'Successfully Booked' &&
          result['Data'] != null) {
        BookAppointmentController.i.updateIsBookAppointmentLoading(false);
        log(BookAppointmentController.i.isBookAppointmentLoading.toString());
        if (BookAppointmentController
                .i.bookAppointmentMethod!.paymentMethodValue ==
            5) {
          BookAppointmentController.i.updateIsBookAppointmentLoading(false);
          var url = result['Data']['transaction']['url'];
          log('$url');
          await Get.to(() => WebView(
                url: url,
              ));
        } else {
          BookAppointmentController.i.updateIsBookAppointmentLoading(false);
          ToastManager.showToast('bookingfailed'.tr);
        }
      } else {
        BookAppointmentController.i.updateIsBookAppointmentLoading(false);
        ToastManager.showToast('${result['ErrorMessage']}');

        // log('${result['ErrorMessage']}');
      }
    }
  }

  static confirmDoctorPayment(
      {String? paymentMethodId, String? doctorId, String? price}) async {
    var patientId = await LocalDb().getPatientId();
    var token = await LocalDb().getToken();
    var branchID = await LocalDb().getBranchId();
    var body = {
      "DoctorId": "$doctorId",
      "PatientId": "$patientId",
      "PaymentMethodId": "$paymentMethodId",
      "PaymentMethodValue":
          BookAppointmentController.i.bookAppointmentMethod?.paymentMethodValue,
      "BranchId": "$branchID",
      "Token": "$token",
      "Price": "$price"
    };
    log(body.toString());
    var headers = {'Content-Type': 'application/json'};
    var responses = await http.post(
        Uri.parse(AppConstants.confirmDoctorPayment),
        headers: headers,
        body: jsonEncode(body));
    if (responses.statusCode == 200) {
      var result = jsonDecode(responses.body);
      if (result['Status'] == 1 &&
          result['ErrorMessage'] == 'Successfully Booked') {
        if (BookAppointmentController
                .i.bookAppointmentMethod!.paymentMethodValue ==
            5) {
          BookAppointmentController.i.updateIsBookAppointmentLoading(false);
          var url = result['Data']['transaction']['url'];
          log('$url');
          await Get.to(() => WebView(
                url: url,
              ));
        }
      }
    }
  }

  getConsultancyFee(String doctorId) async {
    var patientId = await LocalDb().getPatientId();
    var body = {"PatientId": "$patientId", "DoctorId": doctorId};
    var headers = {'Content-Type': 'application/json'};

    try {
      var response = await http.post(Uri.parse(AppConstants.getConsultancyFee),
          headers: headers, body: jsonEncode(body));
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        DoctorConsultationData data = DoctorConsultationData.fromJson(result);
        return data.consultancyDetail;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  static consultNow(ConsultNowBody? body, Search? doctor) async {
    log(jsonEncode(body!.toJson()).toString());
    var headers = {'Content-Type': 'application/json'};
    try {
      SpecialitiesController.i.updateIsConsultNowLoading(true);
      var response = await http.post(Uri.parse(AppConstants.consultNowURI),
          body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200) {
        log(response.body.toString());
        var result = jsonDecode(response.body);
        if (result['Status'] == 1 && result['VisitNo'] != null) {
          log(result.toString());
          // var consult = result;
          SpecialitiesController.i.updateIsConsultNowLoading(false);
          showDialog(
              context: Get.context!,
              builder: (context) {
                return StatefulBuilder(builder: (context, setstate) {
                  return Material(
                    type: MaterialType.transparency,
                    color: Colors.transparent,
                    child: AlertDialog(
                      backgroundColor: Colors.transparent,
                      content: Column(
                        children: [
                          SizedBox(
                            height: Get.height * 0.08,
                          ),
                          const AppointSuccessfulOrFailedWidget(
                            titleImage: false,
                            image: Images.correct,
                            successOrFailedHeader: 'Appointment Successful',
                            appoinmentFailedorSuccessSmalltext:
                                'Your Appointment has been successfully booked',
                            firstButtonText: 'Go to Appoinment',
                          )
                        ],
                      ),
                    ),
                  );
                });
              });
          // return consult.data;
        } else if (result['Status'] != 1) {
          ToastManager.showToast('${result['ErrorMessage']}');
          SpecialitiesController.i.updateIsConsultNowLoading(false);
        } else if (result['Status'] == 1 &&
            result['ErrorMessage'] == 'Successfully Booked' &&
            result['Data'] != null) {
          if (BookAppointmentController
                  .i.consultNowPaymentMethod!.paymentMethodValue ==
              5) {
            SpecialitiesController.i.updateIsConsultNowLoading(false);
            var url = result['Data']['transaction']['url'];
            log('$url');
            await Get.to(() => WebView(
                  url: url,
                ));
            Get.to(() => Patientwaitingscreen(
                  doctor: doctor!,
                ));
            SpecialitiesController.i.updateIsConsultNowLoading(false);
          } else {
            ToastManager.showToast('bookingfailed'.tr);
          }
        } else {
          SpecialitiesController.i.updateIsConsultNowLoading(false);
          ToastManager.showToast('${result['ErrorMessage']}');
        }
      } else {
        SpecialitiesController.i.updateIsConsultNowLoading(false);
      }
    } catch (e) {
      SpecialitiesController.i.updateIsConsultNowLoading(false);
      log(e.toString());
    }
  }
}
