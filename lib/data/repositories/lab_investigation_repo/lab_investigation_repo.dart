import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tabib_al_bait/components/images.dart';
import 'package:tabib_al_bait/components/success_or_failed.dart';
import 'package:tabib_al_bait/data/controller/bottom_nav_bar_controller.dart';
import 'package:tabib_al_bait/data/controller/lab_investigations_controller.dart';
import 'package:tabib_al_bait/data/controller/packages_controller.dart';
import 'package:tabib_al_bait/data/controller/schedule_controller.dart';
import 'package:tabib_al_bait/data/localDB/local_db.dart';
import 'package:tabib_al_bait/data/repositories/upload_file_repo/upload_file.dart';
import 'package:tabib_al_bait/helpers/color_manager.dart';
import 'package:tabib_al_bait/helpers/show_toast.dart';
import 'package:tabib_al_bait/models/diagnostics/appointmentdetail.dart';
import 'package:tabib_al_bait/models/diagnostics/bookdiagnosticbody.dart';
import 'package:tabib_al_bait/models/diagnostics/diagnosticsession.dart';
import 'package:tabib_al_bait/models/diagnostics/disgnosticscenter.dart';
import 'package:tabib_al_bait/models/doctors_data.dart';
import 'package:tabib_al_bait/models/lab_test_model2.dart';
import 'package:tabib_al_bait/models/lab_tests_model.dart';
import 'package:tabib_al_bait/models/labservices.dart';
import 'package:tabib_al_bait/models/packages_model.dart';
import 'package:tabib_al_bait/models/specialities_model.dart';
import 'package:tabib_al_bait/screens/dashboard/menu_drawer.dart';
import 'package:tabib_al_bait/screens/doctor%20consultation/doctorconsultation.dart';
import 'package:tabib_al_bait/screens/success_and_failure_screens/successful_appointment_screen.dart';
import 'package:tabib_al_bait/screens/web_view_flutter/web_view.dart';
import 'package:tabib_al_bait/utils/constants.dart';
import '../../controller/google_maps_controller.dart';

class LabInvestigationRepo {
  static getLabs() async {
    var body = {
      "TypeBit": "2",
      "Latitude": "",
      "Longitude": "",
      "BranchId": "",
      "Token": "44717866-70BA-4223-8F97-45286B2FD599"
    };
    var headers = {'Content-Type': 'application/json'};
    try {
      var response = await http.post(Uri.parse(AppConstants.getLabs),
          body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        if (result['Status'] == 1) {
          log('success');
        } else {
          log(result['Status']);
        }
      }
    } catch (e) {
      // log(e.toString());
    }
  }

  static getspeciality() async {
    var body = {
      "TypeBit": "8",
      "Latitude": "",
      "Longitude": "",
      "BranchId": "",
      "Token": await LocalDb().getToken(),
    };
    var headers = {'Content-Type': 'application/json'};
    try {
      var response = await http.post(Uri.parse(AppConstants.getLabs),
          body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        if (result['Status'] == 1) {
          log('success');
        } else {
          log(result['Status']);
        }
      }
    } catch (e) {
      // log(e.toString());
    }
  }

  static getspecialityservices() async {
    LabInvestigationController.i.updateIsServicesLoading(true);
    var body = {
      "TypeBit": "8",
      "Latitude": "",
      "Longitude": "",
      "BranchId": "",
      "Token": await LocalDb().getToken(),
    };
    var headers = {'Content-Type': 'application/json'};
    try {
      var response = await http.post(Uri.parse(AppConstants.getLabs),
          body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        Iterable data = result['Data'];
        // log(data);
        if (result['Status'] == 1) {
          List<servicesmodel> md = data
              .map(
                (e) => servicesmodel.fromJson(e),
              )
              .toList();
          LabInvestigationController.i.updateIsServicesLoading(false);
          return md;
        } else {
          LabInvestigationController.i.updateIsServicesLoading(false);
          log(result['Status']);
        }
      }
    } catch (e) {
      LabInvestigationController.i.updateIsServicesLoading(false);
      log(e.toString());
    }
  }

  static getLabservices(int value) async {
    var body = {
      "TypeBit": value,
      "Latitude": "",
      "Longitude": "",
      "BranchId": "",
      "Token": await LocalDb().getToken(),
    };
    var headers = {'Content-Type': 'application/json'};
    try {
      var response = await http.post(Uri.parse(AppConstants.getLabs),
          body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        Iterable data = result['Data'];
        // log(data);
        if (result['Status'] == 1) {
          List<servicesmodel> md = data
              .map(
                (e) => servicesmodel.fromJson(e),
              )
              .toList();
          // lst=data[0]['Id'];
          LabInvestigationController.i.updateIsServicesLoading(false);

          return md;
        } else {
          log(result['Status']);
          LabInvestigationController.i.updateIsServicesLoading(false);
        }
      }
    } catch (e) {
      LabInvestigationController.i.updateIsServicesLoading(false);
      // ToastManager.showToast('someerroroccured'.tr);
    }
  }

  static Future getservices(lst, int value) async {
    var token = await LocalDb().getToken();
    var body = {"LabId": lst, "Token": token, "TypeBit": value};

    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };

    try {
      var response = await http.post(
          Uri.parse(
            AppConstants.getLabTests,
          ),
          body: jsonEncode(body),
          headers: headers);
      if (response.statusCode == 200) {
        log('message');
        var result = jsonDecode(response.body);

        if (result['Status'] == 1) {
          LabTestsModel labTestsModel =
              LabTestsModel.fromJson(jsonDecode(response.body));
          return labTestsModel;
        } else {
          log(result['Status'].toString());
          log('failed');
        }
      } else {
        log(response.statusCode.toString());
      }
    } catch (e) {
      // log('$e ===>');
    }
  }

  static Future getconsultservices(lst) async {
    var token = await LocalDb().getToken();
    var body = {"LabId": lst, "Token": token, "TypeBit": "8"};

    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };

    try {
      var response = await http.post(
          Uri.parse(
            AppConstants.getLabTests,
          ),
          body: jsonEncode(body),
          headers: headers);
      if (response.statusCode == 200) {
        log('message');
        var result = jsonDecode(response.body);

        if (result['Status'] == 1) {
          LabTestsModel labTestsModel =
              LabTestsModel.fromJson(jsonDecode(response.body));
          return labTestsModel;
        } else {
          log(result['Status'].toString());
          log('failed');
        }
      } else {
        log(response.statusCode.toString());
      }
    } catch (e) {
      log('$e ===>');
    }
  }

  static Future getLabTests() async {
    var token = await LocalDb().getToken();
    var branchID = await LocalDb().getBranchId();
    log('token = $token');
    log('branchID =$branchID');
    var body = {"LabId": "", "Token": token};
    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };

    try {
      var response = await http.post(
          Uri.parse(
            AppConstants.getLabTests,
          ),
          body: jsonEncode(body),
          headers: headers);
      if (response.statusCode == 200) {
        log('message');
        var result = jsonDecode(response.body);

        if (result['Status'] == 1) {
          LabTestsModelHome labTestsModel =
              LabTestsModelHome.fromJson(jsonDecode(response.body));
          return labTestsModel;
        } else {
          log(result['Status'].toString());
          log('failed');
        }
      } else {
        log(response.statusCode.toString());
      }
    } catch (e) {}
  }

  static Future getDiagnostics() async {
    var token = await LocalDb().getToken();
    var branchID = await LocalDb().getBranchId();
    log('token = $token');
    log('branchID =$branchID');
    var body = {"LabId": "", "Token": token};
    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };

    try {
      var response = await http.post(
          Uri.parse(
            AppConstants.getDiagnostics,
          ),
          body: jsonEncode(body),
          headers: headers);
      if (response.statusCode == 200) {
        log('message');
        var result = jsonDecode(response.body);

        if (result['Status'] == 1) {
          LabTestsModelHome labTestsModel =
              LabTestsModelHome.fromJson(jsonDecode(response.body));
          return labTestsModel;
        } else {
          log(result['Status'].toString());
          log('failed');
        }
      } else {
        log(response.statusCode.toString());
      }
    } catch (e) {
      log('$e ===>');
    }
  }

  static getDiagnosticCenter(String id) async {
    var token = await LocalDb().getToken();
    var branchID = await LocalDb().getBranchId();
    log('token = $token');
    log('branchID =$branchID');

    var body = {
      "DiagnosticId": id,
      "TypeBit": "3",
      "Latitude": "",
      "Longitude": "",
      "BranchId": "",
      "Token": token
    };
//{"LabId": "", "Token": token};
    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };

    try {
      var response = await http.post(
          Uri.parse(
            AppConstants.getDiagnosticscenter,
          ),
          body: jsonEncode(body),
          headers: headers);
      if (response.statusCode == 200) {
        log('message');
        var result = jsonDecode(response.body);

        if (result['Status'] == 1) {
          Iterable data = result['Data'];
          LabInvestigationController.i.updatediagnosticscenter(
              data.map((e) => Diagnosticscenter.fromJson(e)).toList());
        } else {
          log(result['Status'].toString());
          log('failed');
        }
      } else {
        log(response.statusCode.toString());
      }
    } catch (e) {
      log('$e ===>');
    }
  }

  static getDiagnosticSlots(String digid, String centr, String date) async {
    var token = await LocalDb().getToken();
    var branchID = await LocalDb().getBranchId();
    // var patientId = await LocalDb().getPatientId();
    log('token = $token');
    log('branchID =$branchID');

    var body = {
      "DiagnosticId": digid,
      "DayDate": date.split(' ')[0],
      "DiagnosticCenterId": centr,
      "Token": token
    };
//{"LabId": "", "Token": token};
    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };

    try {
      var response = await http.post(
          Uri.parse(
            AppConstants.getDiagnosticslots,
          ),
          body: jsonEncode(body),
          headers: headers);
      if (response.statusCode == 200) {
        log('message');
        var result = jsonDecode(response.body);

        if (result['Status'] == 1) {
          Iterable dt = result['Sessions'];

          List<Diagnosticsession> data =
              dt.map((e) => Diagnosticsession.fromJson(e)).toList();

          LabInvestigationController.i.updatediagnosticslots(data[0].slots!);
        } else {
          log(result['Status'].toString());
          log('failed');
        }
      } else {
        log(response.statusCode.toString());
      }
    } catch (e) {
      log('$e ===>');
    }
  }

  static bookimageboking(Bookdiagnosticbody body) async {
    var token = await LocalDb().getToken();

    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };

    try {
      var response = await http.post(
          Uri.parse(
            AppConstants.BookDiagnosticAppointment,
          ),
          body: jsonEncode(body),
          headers: headers);
      if (response.statusCode == 200) {
        log('message');
        var result = jsonDecode(response.body);

        if (result['Status'] == 1) {
          Iterable data = result['AppointmentDetail'];
          List<Appointmentdetail> responsedata =
              data.map((e) => Appointmentdetail.fromJson(e)).toList();
          ToastManager.showToast(result['ErrorMessage'],
              bgColor: Colors.greenAccent);
          await confirmdiagnostic(
              responsedata.first.diagnosticAppointmentId,
              responsedata.first.patientDiagnosticAppointmentId,
              responsedata.first.diagnosticCenterId,
              body);
          await showDialog(
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
                                  .navigateToPage(1, filterType: 2);
                              ScheduleController.i
                                  .ApplyFilterForAppointments(2);
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
        } else {
          ToastManager.showToast(result['ErrorMessage']);
        }
      } else {
        log(response.statusCode.toString());
      }
    } catch (e) {
      log('$e ===>');
    }
  }

  static confirmdiagnostic(
    String diagnosticid,
    String patientappointmentid,
    String diagnosticscenterid,
    Bookdiagnosticbody bd,
  ) async {
    var token = await LocalDb().getToken();
    var patientid = await LocalDb().getPatientId();

    var body = {
      "DiagnosticId": bd.diagnosticId,
      "PatientId": "$patientid",
      "DiagnosticAppointmentId": diagnosticid,
      "PatientDiagnosticAppointmentId": patientappointmentid,
      "PaymentMethodId": "5B1C687C-24CE-E911-80CE-A0B3CCE147C0",
      "VouncherCode": "",
      "Price": "",
      "DiagnosticCenterId": bd.diagnosticCenterId,
      "Token": token,
    };
    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };
    log(body.toString());
    try {
      var response = await http.post(
          Uri.parse(
            AppConstants.ConfirmDiagnosticAppointment,
          ),
          body: jsonEncode(body),
          headers: headers);
      if (response.statusCode == 200) {
        log('message');
        var result = jsonDecode(response.body);

        if (result['Status'] == 1) {
          String url = result['Data']['ReturnURL'];
          await Get.to(() => WebView(
                url: url,
              ));
        } else {
          ToastManager.showToast(result['ErrorMessage'],
              bgColor: Colors.redAccent);
        }
      } else {
        log(response.statusCode.toString());
      }
    } catch (e) {
      log('$e ===>');
    }
  }
//   {
//     DiagnosticIdAppointmentId:"ca73374f-3b85-ea11-80ce-005056af756c",
// PatientId:"530bc9c6-5f7c-e811-80be-005056af7162",
// PatientDiagnosticAppointmentId:"ca73374f-3b85-ea11-80ce-005056af756c",
// BranchId: "5BD60354-FEFD-4BCC-A58D-B8E27D802E85",
// Token: "ABB358A1-301C-4BBD-B8B7-01A1D903F770"
// }

  getPackages() async {
    var branchId = await LocalDb().getBranchId();
    var body = {"BranchId": "$branchId", "Length": 100};
    var headers = {'Content-Type': 'application/json'};

    try {
      var response = await http.post(Uri.parse(AppConstants.getPackages),
          body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        if (result['Status'] == 1) {
          Packages package = Packages.fromJson(result);
          log('packages data length ${package.data?.length}');
          return package.data;
        }
      } else {
        log(response.statusCode.toString());
      }
    } catch (e) {
      log(e.toString());
    }
  }

  bookLabInvestigationOrHomeSampling(
      {List<LabTestHome>? list,
      bool? isHerefromHomeSample = false,
      bool? isLabInvestigationBooking = false,
      bool? isHereFromReports = false}) async {
    var patientId = await LocalDb().getPatientId();
    var cont = LabInvestigationController.i;
    var maps = AddressController.i;
    var packages = PackagesController.i;
    List jsonList = [];
    LabPackages? list;
    // if (isLabInvestigationBooking == true) {
    //   cont.selectedLabTests = list ?? [];
    // }
    for (int i = 0; i < packages.selectedLabPackages!.length; i++) {
      list = packages.selectedLabPackages?[i];
      for (int j = 0; j < list!.dTOPackageGroupDetail!.length; j++) {
        jsonList.add({
          'TypeBit': "2",
          "Id": list.dTOPackageGroupDetail![j].id,
          "LabTestId": list.dTOPackageGroupDetail![j].id,
          "Price": list.dTOPackageGroupDetail![j].total,
          "ActualPrice": 0.0,
          "IsForSampleCollectionCharges": false,
          "IsForAdditionalCharges": false,
          "IsForUrgentCharges": false,
          "IsAdditionalChargesForPassenger": false,
          "IsForCovid": false,
          "IsForAdditionalChargesForCovid": false
        });
        // tr.packages[0].dTOPackageGroupDetail![i].toJson()
      }
    }
    String? fileAttachment;
    if (cont.file != null) {
      fileAttachment =
          await UploadFileRepo().updatePicture(cont.file ?? File(''));
    }
    cont.selectedLabTests.map((e) => jsonList.add(e.toJson())).toList();
    log('The length of jsonList is = ${jsonList.length}');
    // packages.selectedLabPackages?.map((e) => jsonList.add(e.toJson())).toList();
    log('${cont.selectedDate.toString().split(' ').first} ${cont.selectedLabTests} ${cont.prescribedBy} ${cont.totalSum}  ${cont.formattedSelectedTime.toString().split(' ').first}');
    if (cont.selectedLabValue == 1) {
      AddressController.i.updateAddress('');
      maps.currentLocation = [];
    }
    log('selected payment is ${cont.selectedPaymentMethod!.paymentMethodValue.toString()} ${cont.selectedPaymentMethod!.id.toString()}');
    var loginToken = await LocalDb().getToken();
    var totalSum = packages.totalSum + await packages.sumUpGrandTotal();
    var body = {
      "AdditionalSubServices": [],
      "Address": AddressController.address ?? '',
      "AddressDetail": "",
      "AirlineId": "",
      "AirportId": "",
      "ConsentFormLink": "",
      "Date": cont.selectedDate.toString().split(' ').first,
      "Distance": "",
      "DoctorId":
          cont.prescribedBy == 'Doctor' ? cont.selectedDoctor?.id ?? '' : '',
      "FlightDate": "",
      "FlightDestinationId": "",
      "FlightNo": "",
      "FileAttachment": fileAttachment ?? '',
      //"LabId": "d8340ed5-af5d-4f68-895b-0350114aab09",
      "LabTests": jsonList,
      "Latitude": maps.currentLocation!.isNotEmpty
          ? maps.currentLocation![0].latitude
          : '',
      "Longitude": maps.currentLocation!.isNotEmpty
          ? maps.currentLocation![0].longitude
          : '',
      "OutDoorDoctor": "${cont.prescribedBy}",
      "PackageGroupDiscountRate": list?.packageGroupDiscountRate ?? '',
      "PackageGroupDiscountType": list?.packageGroupDiscountType,
      "PackageGroupId": "${list?.packageGroupId}",
      "PackageGroupName": "${list?.packageGroupName}",
      "PaidAmount": "${cont.totalSum + totalSum}",
      "PassengerNameRecord": "",
      "PassportImage": "",
      "PassportNo": "",
      "PatientId": "$patientId",
      "PaymentMethodId": cont.selectedPaymentMethod?.id ?? '',
      "PaymentMethodValue":
          cont.selectedPaymentMethod?.paymentMethodValue ?? '',
      "SampleImage": "",
      "TicketImage": "",
      "Time": cont.formattedSelectedTime.toString().split(' ').first,
      "Token": "$loginToken",
      "VouncherCode": "",
      "Price": "${cont.totalSum + totalSum}",
    };

    log(body.toString());
    log(fileAttachment.toString());
    // body['PaymentMethodValue']='5';
    var headers = {'Content-Type': 'application/json'};
    cont.updateIsLoading(true);
    try {
      var result = await http.post(
          Uri.parse(AppConstants.confirmLabTestPaymentUri),
          headers: headers,
          body: jsonEncode(body));
      if (result.statusCode == 200) {
        var response = jsonDecode(result.body);
        if (response['Status'] == 1) {
          log(response.toString());
          Get.to(() => SuccessFulAppointScreen(
              imagePath: cont.selectedLabValue == 1
                  ? 'assets/images/Frame2.png'
                  : Images.bike,
              isLabInvestigationBooking:
                  cont.selectedLabValue == 1 ? true : false,
              onPressedSecond: () {
                Get.back();
              },
              firstButtonText: 'viewAppointment'.tr,
              title: 'congratulations'.tr,
              appoinmentFailedorSuccessSmalltext: 'appointmentSuccessful'.tr,
              onPressedFirst: () {
                Get.back();
                Get.back();
                if (isHereFromReports == true) {
                  Get.back();
                }
                BottomBarController.i.navigateToPage(1, filterType: 3);
                ScheduleController.i.ApplyFilterForAppointments(3);
                ScheduleController.i.updateSelectedService(1);
                ScheduleController.i.updateIndexOfAppointmentList(1);
                ScheduleController.i.update();
                BottomBarController.i.update();
              }));

          if (response['ErrorMessage'] == 'Successfully Booked') {
            if (cont.selectedPaymentMethod?.paymentMethodValue == 5) {
              var url = response['Data']['transaction']['url'];
              log('$url');
              Get.to(() => WebView(
                    url: url,
                  ));
            }
          }
          cont.updateIsLoading(false);
        } else {
          LabInvestigationController.i.selectedLabTests = [];
          LabInvestigationController.i.prescribedBy = null;
          LabInvestigationController.i.totalSum = 0.0;
          LabInvestigationController.i.selectedDate = DateTime.now();
          cont.updateIsLoading(false);
          var response = jsonDecode(result.body);
          log(response.toString());
          ToastManager.showToast('${response['ErrorMessage']}',
              bgColor: ColorManager.kRedColor,
              textColor: ColorManager.kWhiteColor);
        }

        cont.updateIsLoading(false);
      } else {
        var response = jsonDecode(result.body);
        ToastManager.showToast('${response['ErrorMessage']}');
        cont.updateIsLoading(false);
        LabInvestigationController.i.selectedDate = DateTime.now();
      }
    } catch (e) {
      // log(e.toString());
      // handleError(e);
      // ToastManager.showToast(e.toString());
      // cont.updateIsLoading(false);
      // LabInvestigationController.i.selectedDate = DateTime.now();
    }
  }

  bookServicesHome(
      {List<LabTests>? list,
      bool? isserviceBooking = false,
      String? appointmentnotes}) async {
    var patientId = await LocalDb().getPatientId();
    var cont = LabInvestigationController.i;
    var maps = AddressController.i;

    log('the patient id is $patientId');

    log(AddressController.address.toString());

    List jsonList = [];

    if (isserviceBooking == true) {
      cont.selectedservicelist = list;
    }
    cont.selectedservicelist!.map((e) => jsonList.add(e.toJson())).toList();
    log('${cont.selectedDate.toString().split(' ').first} ${cont.selectedservicelist} ${cont.ServicesBy} ${cont.totalSum}  ${cont.formattedSelectedTime.toString().split(' ').first}');
    if (isserviceBooking == true) {
      AddressController.i.updateAddress('');
    }

    log('selected payment is ${cont.selectedPaymentMethod1!.paymentMethodValue.toString()} ${cont.selectedPaymentMethod1!.id.toString()}');
    var loginToken = await LocalDb().getToken();
    var body = {
      "AdditionalSubServices": [],
      "Address": AddressController.address ?? '',
      "AddressDetail": "",
      "AirlineId": "",
      "AirportId": "",
      "ConsentFormLink": "",
      "Date": cont.selectedDate.toString().split(' ').first,
      "Distance": "",
      "DoctorId": cont.selectedDoctor?.id ?? '',
      "FlightDate": " ",
      "FlightDestinationId": "",
      "FlightNo": "",
      //"LabId": "d8340ed5-af5d-4f68-895b-0350114aab09",
      "LabTests": jsonList,
      "Latitude": maps.currentLocation!.isNotEmpty
          ? maps.currentLocation![0].latitude
          : '',
      "Longitude": maps.currentLocation!.isNotEmpty
          ? maps.currentLocation![0].longitude
          : '',
      "OutDoorDoctor": "${cont.ServicesBy}",
      "PackageGroupDiscountRate": "",
      "PackageGroupDiscountType": "",
      "PackageGroupId": "",
      "PackageGroupName": "",
      "PaidAmount": "${cont.totalSum1}",
      "PassengerNameRecord": "",
      "PassportImage": "",
      "PassportNo": "",
      "PatientId": "$patientId",
      "PaymentMethodId": cont.selectedPaymentMethod1?.id ?? '',
      "PaymentMethodValue":
          cont.selectedPaymentMethod1?.paymentMethodValue ?? '',
      "SampleImage": "",
      "TicketImage": "",
      "Time": cont.formattedSelectedTime.toString().split(' ').first,
      "Token": "$loginToken",
      "VouncherCode": "",
      "Price": "${cont.totalSum1}",
      "AppointmentNotes": appointmentnotes,
    };

    log(body.toString());
    // body['PaymentMethodValue']='5';

    var headers = {'Content-Type': 'application/json'};
    cont.updateIsLoading(true);
    cont.updateIsServicesLoading(true);
    try {
      var result = await http.post(
          Uri.parse(AppConstants.confirmLabTestPaymentUri),
          headers: headers,
          body: jsonEncode(body));
      if (result.statusCode == 200) {
        var response = jsonDecode(result.body);
        log(response.toString());
        if (response['Status'] == 1) {
          log(response.toString());
          Get.to(() => SuccessFulAppointScreen(
                imagePath: Images.services,
                firstButtonText: 'viewAppointment'.tr,
                title: 'congratulations'.tr,
                appoinmentFailedorSuccessSmalltext: 'serviceBooked'.tr,
                onPressedFirst: () {
                  Get.back();
                  Get.back();
                  BottomBarController.i.navigateToPage(1, filterType: -1);
                  ScheduleController.i.ApplyFilterForAppointments(-1);
                },
                onPressedSecond: (() {
                  Get.back();
                }),
              ));
        } else {
          Get.to(() => SuccessFulAppointScreen(
                title: 'congratulations'.tr,
                appoinmentFailedorSuccessSmalltext: 'serviceBooked'.tr,
                firstButtonText: 'viewAppointment'.tr,
                onPressedSecond: () {
                  Get.close(2);
                },
                onPressedFirst: () {
                  Get.close(2);
                  BottomBarController.i.navigateToPage(1);
                },
              ));
        }
        LabInvestigationController.i.selectedservicelist = [];
        LabInvestigationController.i.ServicesBy = null;
        LabInvestigationController.i.totalSum1 = 0.0;
        LabInvestigationController.i.selectedDate = DateTime.now();

        if (response['ErrorMessage'] == 'Successfully Booked') {
          if (cont.selectedPaymentMethod1?.paymentMethodValue == 5) {
            var url = response['Data']['transaction']['url'];
            log('$url');
            Get.to(() => WebView(
                  url: url,
                ));
          }
        }
        cont.updateIsLoading(false);
        cont.updateIsServicesLoading(false);
      } else {
        var response = jsonDecode(result.body);
        ToastManager.showToast('${response['ErrorMessage']}');
        cont.updateIsLoading(false);
        cont.updateIsServicesLoading(false);
        LabInvestigationController.i.selectedDate = DateTime.now();
      }
    } catch (e) {
      cont.updateIsLoading(false);
      cont.updateIsServicesLoading(false);
      LabInvestigationController.i.selectedDate = DateTime.now();
    }
  }

  bookspecialitisservices(
      {List<LabTests>? list,
      bool? isserviceBooking = false,
      String? appointmentnotes}) async {
    var patientId = await LocalDb().getPatientId();
    var cont = LabInvestigationController.i;
    var maps = AddressController.i;
    List jsonList = [];
    if (isserviceBooking == true) {
      cont.selectedconsultservice = list;
    }
    cont.selectedconsultservice!.map((e) => jsonList.add(e.toJson())).toList();
    if (isserviceBooking == true) {
      AddressController.i.updateAddress('');
    }

//  List jsonList = [];
//     if (isserviceBooking == true) {
//       cont.selectedLabTests = list;
//     }
//     cont.selectedLabTests!.map((e) => jsonList.add(e.toJson())).toList();
//     log('${cont.selectedDate.toString().split(' ').first} ${cont.selectedLabTests} ${cont.prescribedBy} ${cont.totalSum}  ${cont.formattedSelectedTime.toString().split(' ').first}');
//     if (isserviceBooking == true) {
//       AddressController.i.updateAddress('');
//     }
    log('selected payment is ${cont.selectedPaymentMethod2!.paymentMethodValue.toString()} ${cont.selectedPaymentMethod2!.id.toString()}');
    var loginToken = await LocalDb().getToken();
    var body = {
      "AdditionalSubServices": [],
      "AirlineId": "",
      "AirportId": "",
      "ConsentFormLink": "",
      "Date": cont.selectedDate.toString().split(' ').first,
      "Distance": "",
      "DoctorId": cont.selectedDoctor?.id ?? '',
      "FlightDate": " ",
      "FlightDestinationId": "",
      "FlightNo": "",
      //"LabId": "d8340ed5-af5d-4f68-895b-0350114aab09",
      "LabTests": jsonList,
      "Latitude": maps.currentLocation!.isNotEmpty
          ? maps.currentLocation![0].latitude
          : '',
      "Longitude": maps.currentLocation!.isNotEmpty
          ? maps.currentLocation![0].longitude
          : '',
      "OutDoorDoctor": "${cont.ServicesBy}",
      "PackageGroupDiscountRate": "",
      "PackageGroupDiscountType": "",
      "PackageGroupId": "",
      "PackageGroupName": "",
      "PaidAmount": "${cont.totalSum2}",
      "PassengerNameRecord": "",
      "PassportImage": "",
      "PassportNo": "",
      "PatientId": "$patientId",
      "PaymentMethodId": cont.selectedPaymentMethod2?.id ?? '',
      "PaymentMethodValue":
          cont.selectedPaymentMethod2?.paymentMethodValue ?? '',
      "SampleImage": "",
      "TicketImage": "",
      "Time": cont.formattedSelectedTime.toString().split(' ').first,
      "Token": "$loginToken",
      "VouncherCode": "",
      "Price": "${cont.totalSum2}",
      "AppointmentNotes": appointmentnotes,
      "SpecialityId": cont.doctorspeciality?.id,
      "IsOnlineAppointment": cont.Status,
    };

    log(body.toString());
    // body['PaymentMethodValue']='5';

    var headers = {'Content-Type': 'application/json'};
    cont.updateIsLoading(true);
    try {
      var result = await http.post(
          Uri.parse(AppConstants.confirmLabTestPaymentUri),
          headers: headers,
          body: jsonEncode(body));
      if (result.statusCode == 200) {
        var response = jsonDecode(result.body);
        if (response['Status'] == 1) {
          log(response.toString());
          Get.to(() => SuccessFulAppointScreen(
                title: 'Congratulations',
                appoinmentFailedorSuccessSmalltext:
                    'Your Appointment Has been Booked Successfully',
                onPressedFirst: (() {
                  Get.to(() => SuccessFulAppointScreen(
                        title: 'congratulations'.tr,
                        appoinmentFailedorSuccessSmalltext: 'serviceBooked'.tr,
                        onPressedFirst: () {
                          Get.offUntil(
                            MaterialPageRoute(
                                builder: (_) => doctorconsultation(
                                      title: 'doctorconsultation'.tr,
                                    )),
                            (route) => false,
                          );
                        },
                      ));
                }),
              ));
        } else {
          ToastManager.showToast('pleasetryagain'.tr);
        }
        LabInvestigationController.i.selectedconsultservice = [];
        LabInvestigationController.i.Status = null;
        // LabInvestigationController.i.selectedPaymentMethod2 = null;
        LabInvestigationController.i.totalSum2 = 0.0;
        LabInvestigationController.i.selectedDate = DateTime.now();

        if (response['ErrorMessage'] == 'Successfully Booked') {
          if (cont.selectedPaymentMethod2?.paymentMethodValue == 5) {
            var url = response['Data']['transaction']['url'];
            log('$url');
            Get.to(() => WebView(
                  url: url,
                ));
          }
        }
        cont.updateIsLoading(false);
      } else {
        ToastManager.showToast('${result.statusCode}');

        cont.updateIsLoading(false);
        LabInvestigationController.i.selectedDate = DateTime.now();
      }
    } catch (e) {
      handleError(e);
      cont.updateIsLoading(false);
      LabInvestigationController.i.selectedDate = DateTime.now();
    }
  }

  static getspecialities() async {
    var patientId = await LocalDb().getPatientId();
    var body = {
      "PatientId": patientId,
      "BranchId": await LocalDb().getBranchId(),
      "Token": await LocalDb().getToken(),
      "Search": ""
    };
    var headers = {'Content-Type': 'application/json'};
    try {
      var response = await http.post(Uri.parse(AppConstants.getSpecialities),
          body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        if (result['Status'] == 1) {
          Specialities specialities =
              Specialities.fromJson(jsonDecode(response.body));
          log('${specialities.toString()} specialities');
          return specialities;
        } else {
          log(result['Status']);
        }
      }
    } catch (e) {
      log(e.toString());
    }
  }

  static getDoctors() async {
    var body = {"DoctorId": "", "Token": ""};
    var headers = {'Content-Type': 'application/json'};

    try {
      var response = await http.post(Uri.parse(AppConstants.doctorsListURI),
          body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        if (result['Status'] == 1) {
          DoctorsResponse response = DoctorsResponse.fromJson(result);
          return response.doctors;
        } else {
          ToastManager.showToast('${result['ErrorMessage']}');
        }
      } else {
        // ignore: unused_local_variable
        // var result = jsonDecode(response.body);
        // ToastManager.showToast('${result.statusCode}');
      }
    } catch (e) {
      ToastManager.showToast('couldNotFetchDoctors'.tr);
    }
  }
}
