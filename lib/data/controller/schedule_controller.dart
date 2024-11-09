// ignore_for_file: non_constant_identifier_names, prefer_final_fields

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tabib_al_bait/data/repositories/schedule_repo/schedule_repo.dart';
import 'package:tabib_al_bait/helpers/show_toast.dart';
import 'package:tabib_al_bait/models/appointment_request_response/appointment_request_response.dart';
import 'package:tabib_al_bait/models/appointments_history/appointments_history.dart';
import 'package:tabib_al_bait/models/services_model.dart';
import 'package:tabib_al_bait/utils/constants.dart';
import '../../models/DoctorConsultationAppointmentHistory.dart';
import '../../models/LabInvestigationAppointmentHistory.dart';
import '../../models/UpComingLabInvestigation.dart';
import '../../models/UpcomingDiagnosticAppointment.dart';
import '../../models/UpcomingModelForDoctorAndLabAppointment.dart';

class ScheduleController extends GetxController implements GetxService {
  List<Services> appointmentList = [];

  updateIndexOfAppointmentList(int index) {
    update();
  }

  List<AppointmentsHistory> _appointmentsSummery = [];
  List<AppointmentsHistory> get appointmentsSummery => _appointmentsSummery;
  // Upcoming Doctor Appointments
  List<DoctorConsultationAppointmentHistoryDataList>
      _doctorConsultationUpcomingAppointments = [];
  List<DoctorConsultationAppointmentHistoryDataList>
      get doctorConsultationUpcomingAppointments =>
          _doctorConsultationUpcomingAppointments;
  // Diagnostic history Appointments
  List<DiagnositicAppointmentListData> _diagnosticAppointmentHistoryDataList =
      [];
  List<DiagnositicAppointmentListData>
      get diagnosticAppointmentHistoryDataList =>
          _diagnosticAppointmentHistoryDataList;
  String? formattedtime;
  TimeOfDay crnttime = TimeOfDay.now();

  // Doctor Consultation History List

  List<DoctorConsultationAppointmentHistoryDataList>
      _doctorConsultationAppointmentHistoryDataList = [];
  List<DoctorConsultationAppointmentHistoryDataList>
      get doctorConsultationAppointmentHistoryDataList =>
          _doctorConsultationAppointmentHistoryDataList;

  int? _selectedService = 0;
  int? get selectedService => _selectedService;

  updateSelectedService(int index) {
    _selectedService = index;
    log('The selected Service is$selectedService');
    update();
  }

  updateUpcomingDoctorAppointments(
      List<DoctorConsultationAppointmentHistoryDataList> list) {
    _doctorConsultationUpcomingAppointments = list;
    log('${_doctorConsultationUpcomingAppointments.toString()} length of upcoming');
    update();
  }

  removehomeservices(AppointmentsList data) {
    ScheduleController.i.list.removeWhere((element) => data == element);
    update();
  }

  removeDiagnosticAppointment(DiagnositicAppointmentListData data) {
    ScheduleController.i._diagnositicAppointmentListData
        .removeWhere((element) => data == element);
    update();
  }

  updateIsLoading(bool value) {
    _isLoading = value;
    update();
  }

  // Upcoming Diagnostics List
  List<DiagnositicAppointmentListData> _diagnositicAppointmentListData = [];
  List<DiagnositicAppointmentListData> get diagnositicAppointmentListData =>
      _diagnositicAppointmentListData;
  // Upcoming Lab Investigations List
  List<UpComingLabIvestigationDataList> _labInvestigationListData = [];
  List<UpComingLabIvestigationDataList> get labInvestigationListData =>
      _labInvestigationListData;
  // Lab Investigation History List
  List<LabInvestigationAppointmentHistoryDataList>
      _labInvestigationAppointmentHistoryDataList = [];
  List<LabInvestigationAppointmentHistoryDataList>
      get labInvestigationAppointmentHistoryDataList =>
          _labInvestigationAppointmentHistoryDataList;
  // LabInvestigation Completed List
  List<LabInvestigationAppointmentHistoryDataList>
      _labInvestigationAppointmentCompletedDataList = [];
  List<LabInvestigationAppointmentHistoryDataList>
      get labInvestigationAppointmentCompletedDataList =>
          _labInvestigationAppointmentCompletedDataList;
  // DoctorConsultationCompleted Appointments
  List<DoctorConsultationAppointmentHistoryDataList>
      _doctorConsultationCompletedAppointments = [];

  List<DoctorConsultationAppointmentHistoryDataList>
      get doctorConsultationCompletedAppointments =>
          _doctorConsultationCompletedAppointments;

  // Diagnostic Appointments Completed Appointments

  List<DiagnositicAppointmentListData> _diagnosticAppointmentCompletedDataList =
      [];
  List<DiagnositicAppointmentListData>
      get diagnosticAppointmentCompletedDataList =>
          _diagnosticAppointmentHistoryDataList;

  bool _isBlockNextProcessing = false;
  bool get isBlockNextProcessing => _isBlockNextProcessing;

  resetappointmentfilter() {
    _appointmentTypeFilter = 0;
  }

  int _appointmentTypeFilter = 0;
  int get appointmentTypeFilter => _appointmentTypeFilter;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isLoadingUpcoming = false;
  bool get isLoadingUpcoming => _isLoadingUpcoming;

  int _doctorUpcomingstartIndex = 0;
  int get doctorUpcomingstartIndex => _doctorUpcomingstartIndex;
  int _doctorUpcomingTotalRecords = 0;
  int get doctorUpcomingTotalRecords => _doctorUpcomingTotalRecords;

  int _diagnosticUpcomingstartIndex = 0;
  int get diagnosticUpcomingstartIndex => _diagnosticUpcomingstartIndex;
  int _diagnosticUpcomingTotalRecords = 0;
  int get diagnosticUpcomingTotalRecords => _diagnosticUpcomingTotalRecords;

  int _LabInvestigationUpcomingstartIndex = 0;
  int get LabInvestigationUpcomingstartIndex =>
      _LabInvestigationUpcomingstartIndex;
  int _labInvestigationUpcomingTotalRecords = 0;
  int get labInvestigationUpcomingTotalRecords =>
      _labInvestigationUpcomingTotalRecords;

  bool _isLoadingHistory = false;
  bool get isLoadingHistory => _isLoadingHistory;
  bool _isOpenedTabIsUpcomingAppointment = false;
  bool get isOpenedTabIsUpcomingAppointment =>
      _isOpenedTabIsUpcomingAppointment;
  int _doctorHistorystartIndex = 0;
  int get doctorHistorystartIndex => _doctorHistorystartIndex;
  int _doctorHistoryTotalRecords = 0;
  int get doctorHistoryTotalRecords => _doctorHistoryTotalRecords;

  int _diagnosticHistorystartIndex = 0;
  int get diagnosticHistorystartIndex => _diagnosticHistorystartIndex;
  int _diagnosticHistoryTotalRecords = 0;
  int get diagnosticHistoryTotalRecords => _diagnosticHistoryTotalRecords;

  int _LabInvestigationHistorystartIndex = 0;
  int get LabInvestigationHistorystartIndex =>
      _LabInvestigationHistorystartIndex;
  int _labInvestigationHistoryTotalRecords = 0;
  int get labInvestigationHistoryTotalRecords =>
      _labInvestigationHistoryTotalRecords;
  // Completed Appointments
  bool _isLoadingCompleted = false;
  bool get isLoadingCompleted => _isLoadingCompleted;

  bool _isOpenedTabisCompletedAppointments = false;
  bool get isOpenedTabisCompletedAppointments =>
      _isOpenedTabisCompletedAppointments;

  int _doctorCompletedstartIndex = 0;
  int get doctorCompletedstartIndex => _doctorCompletedstartIndex;
  int _doctorCompletedTotalRecords = 0;
  int get doctorCompletedTotalRecords => _doctorCompletedTotalRecords;

  int _diagnosticCompletedstartIndex = 0;
  int get diagnosticCompletedstartIndex => _diagnosticCompletedstartIndex;
  int _diagnosticCompletedTotalRecords = 0;
  int get diagnosticCompletedTotalRecords => _diagnosticCompletedTotalRecords;

  int _LabInvestigationCompletedstartIndex = 0;
  int get LabInvestigationCompletedstartIndex =>
      _LabInvestigationCompletedstartIndex;
  int _labInvestigationCompletedTotalRecords = 0;
  int get labInvestigationCompletedTotalRecords =>
      _labInvestigationCompletedTotalRecords;
////////////////////////
  bool _isInitState = false;
  bool get isInitState => _isInitState;

  bool? _dataIsLoading = false;
  bool? get dataIsLoading => _dataIsLoading;

  bool? _isShown = false;
  bool? get isShown => _isShown;

  List<AppointmentsList> _list = [];
  List<AppointmentsList> get list => _list;

  String? _latestAppointmentId;
  String? get latestAppointmentId => _latestAppointmentId;

  String? _latestLabAppointment;
  String? get latestLabAppointment => _latestLabAppointment;

  updateLatestLabAppointment(String? id) {
    _latestLabAppointment = id;
    log('latest lab id is ${id.toString()}');
    update();
  }

  updateLatestAppointment(String id) {
    _latestAppointmentId = id;
    log('latest appointment id is $id');
    update();
  }

  addDoctorAppointmentToTheTop(
      String? id, DoctorConsultationAppointmentHistoryDataList list) {
    _doctorConsultationUpcomingAppointments
        .removeWhere((element) => element.Id == id);
    _doctorConsultationUpcomingAppointments.add(list);
    update();
  }

  updateAppointmentsList(List<AppointmentsList>? dt) {
    _list = dt ?? [];
  }

  List<AppointmentsList>? cancelled = [];
  getAppointmentsList(String query) async {
    _isLoading = true;
    update();
    _list = [];
    _isBlockNextProcessing = true;
    // _appointmentTypeFilter = -1;
    clearData();
    try {
      _list = await ScheduleRepo().getAppointmentRequestList(query: query);
    } catch (e) {
      _isLoading = false;
      update();
    }

    for (var element in _list) {
      log(element.toJson().toString());
      if (element.status == 'Cancelled') {
        cancelled?.add(element);
      }
    }
    log(cancelled!.length.toString());
    log('The length of List is? ${cancelled?.length.toString()}');
    _isLoading = false;
    update();
  }

  updateIsShown(bool listIsShown) {
    listIsShown = !listIsShown;
    log(listIsShown.toString());
    update();
  }

  updateDataisLoading(bool value) {
    _dataIsLoading = value;
    log('data is Loading $_dataIsLoading');
    update();
  }

  SetStartToFetchNextDataForComingAppoiontments() {
    if (_appointmentTypeFilter == 3) {
      if ((_LabInvestigationUpcomingstartIndex +
              AppConstants.maximumDataTobeFetched) <
          _labInvestigationUpcomingTotalRecords) {
        _LabInvestigationUpcomingstartIndex =
            _LabInvestigationUpcomingstartIndex +
                AppConstants.maximumDataTobeFetched;
        return true;
      } else {
        ToastManager.showToast("allrecordsfetched".tr,
            bgColor: const Color(0xff1272D3));

        return false;
      }
    } else if (_appointmentTypeFilter == 2) {
      if ((_diagnosticUpcomingstartIndex +
              AppConstants.maximumDataTobeFetched) <
          _diagnosticUpcomingTotalRecords) {
        _diagnosticUpcomingstartIndex =
            _diagnosticUpcomingstartIndex + AppConstants.maximumDataTobeFetched;
        return true;
      } else {
        ToastManager.showToast("allrecordsfetched".tr,
            bgColor: const Color(0xff1272D3));
        return false;
      }
    } else if (_appointmentTypeFilter == 1) {
      if ((_doctorUpcomingstartIndex + AppConstants.maximumDataTobeFetched) <
          _doctorUpcomingTotalRecords) {
        _doctorUpcomingstartIndex =
            _doctorUpcomingstartIndex + AppConstants.maximumDataTobeFetched;
        return true;
      } else {
        ToastManager.showToast("allrecordsfetched".tr,
            bgColor: const Color(0xff1272D3));
        return false;
      }
    } else if (_appointmentTypeFilter == -1) {
      if ((_doctorUpcomingstartIndex + AppConstants.maximumDataTobeFetched) <
          _doctorUpcomingTotalRecords) {
        _doctorUpcomingstartIndex =
            _doctorUpcomingstartIndex + AppConstants.maximumDataTobeFetched;
        return true;
      } else {
        ToastManager.showToast("allrecordsfetched".tr,
            bgColor: const Color(0xff1272D3));
        return false;
      }
    }
  }

  SetStartToFetchNextDataForHistoryAppoiontments() {
    if (_appointmentTypeFilter == 3) {
      if ((_LabInvestigationHistorystartIndex +
              AppConstants.maximumDataTobeFetched) <
          _labInvestigationHistoryTotalRecords) {
        _LabInvestigationHistorystartIndex =
            _LabInvestigationHistorystartIndex +
                AppConstants.maximumDataTobeFetched;
        return true;
      } else {
        ToastManager.showToast("allrecordsfetched".tr,
            bgColor: const Color(0xff1272D3));
        return false;
      }
    } else if (_appointmentTypeFilter == 2) {
      if ((_diagnosticHistorystartIndex + AppConstants.maximumDataTobeFetched) <
          _diagnosticHistoryTotalRecords) {
        _diagnosticHistorystartIndex =
            _diagnosticHistorystartIndex + AppConstants.maximumDataTobeFetched;
        return true;
      } else {
        ToastManager.showToast("allrecordsfetched".tr,
            bgColor: const Color(0xff1272D3));
        return false;
      }
    } else if (_appointmentTypeFilter == 1) {
      if ((_doctorHistorystartIndex + AppConstants.maximumDataTobeFetched) <
          _doctorHistoryTotalRecords) {
        _doctorHistorystartIndex =
            _doctorHistorystartIndex + AppConstants.maximumDataTobeFetched;
        return true;
      } else {
        ToastManager.showToast("allrecordsfetched".tr,
            bgColor: const Color(0xff1272D3));
        return false;
      }
    } else if (_appointmentTypeFilter == -1) {
      if ((_doctorHistorystartIndex + AppConstants.maximumDataTobeFetched) <
          _doctorHistoryTotalRecords) {
        _doctorHistorystartIndex =
            _doctorHistorystartIndex + AppConstants.maximumDataTobeFetched;
        return true;
      } else {
        ToastManager.showToast("allrecordsfetched".tr,
            bgColor: const Color(0xff1272D3));
        return false;
      }
    }
  }

  SetStartToFetchNextDataForCompletedAppoiontments() {
    if (_appointmentTypeFilter == 3) {
      if ((_LabInvestigationCompletedstartIndex +
              AppConstants.maximumDataTobeFetched) <
          _labInvestigationCompletedTotalRecords) {
        _LabInvestigationCompletedstartIndex =
            _LabInvestigationCompletedstartIndex +
                AppConstants.maximumDataTobeFetched;
        return true;
      } else {
        ToastManager.showToast("allrecordsfetched".tr,
            bgColor: const Color(0xff1272D3));
        return false;
      }
    } else if (_appointmentTypeFilter == 2) {
      if ((_diagnosticCompletedstartIndex +
              AppConstants.maximumDataTobeFetched) <
          _diagnosticCompletedTotalRecords) {
        _diagnosticCompletedstartIndex = _diagnosticCompletedstartIndex +
            AppConstants.maximumDataTobeFetched;
        return true;
      } else {
        ToastManager.showToast("allrecordsfetched".tr,
            bgColor: const Color(0xff1272D3));
        return false;
      }
    } else if (_appointmentTypeFilter == 1) {
      if ((_doctorCompletedstartIndex + AppConstants.maximumDataTobeFetched) <
          _doctorCompletedTotalRecords) {
        _doctorCompletedstartIndex =
            _doctorCompletedstartIndex + AppConstants.maximumDataTobeFetched;
        return true;
      } else {
        ToastManager.showToast("allrecordsfetched".tr,
            bgColor: const Color(0xff1272D3));
        return false;
      }
    }
  }

  clearData() {
    _isBlockNextProcessing = false;
    _doctorUpcomingstartIndex = 0;
    _diagnosticUpcomingstartIndex = 0;
    _LabInvestigationUpcomingstartIndex = 0;
    _doctorUpcomingTotalRecords = 0;
    // completed
    _doctorCompletedstartIndex = 0;
    _diagnosticUpcomingstartIndex = 0;
    _LabInvestigationCompletedstartIndex = 0;
    _doctorCompletedTotalRecords = 0;
    _labInvestigationCompletedTotalRecords = 0;
    _diagnosticCompletedTotalRecords = 0;
    // _diagnosticUpcomingTotalRecords = 0;
    // _labInvestigationUpcomingTotalRecords = 0;

    _doctorHistorystartIndex = 0;
    _diagnosticHistorystartIndex = 0;
    _LabInvestigationHistorystartIndex = 0;
    // _doctorHistoryTotalRecords = 0;
    // _diagnosticHistoryTotalRecords = 0;
    // _labInvestigationHistoryTotalRecords = 0;
    _appointmentsSummery.clear();
    _doctorConsultationUpcomingAppointments = [];
    _doctorConsultationCompletedAppointments = [];
    _labInvestigationAppointmentCompletedDataList = [];
    _diagnosticAppointmentCompletedDataList = [];
    // _diagnositicAppointmentListData.clear();
    // _labInvestigationListData.clear();
    // _diagnosticAppointmentHistoryDataList.clear();
    // _doctorConsultationAppointmentHistoryDataList.clear();
    // _labInvestigationAppointmentHistoryDataList.clear();
  }

  changeStatusofOpenedTab(bool sta) {
    _isOpenedTabIsUpcomingAppointment = sta;
    // update();
  }

  Future ApplyFilterForAppointments(int i) async {
    log(i.toString());
    log('filter type is $i ');
    try {
      if (_isBlockNextProcessing == false) {
        _isBlockNextProcessing = true;
        _appointmentTypeFilter = i;
        _isLoadingUpcoming = true;
        _isLoadingHistory = true;
        log('${ScheduleController.i.doctorConsultationUpcomingAppointments.length.toString()} listtttt');
        clearData();
        update();
        if (i != 0) {
          if (_isOpenedTabIsUpcomingAppointment == true) {
            await getUpcomingAppointment("", true);
            _isLoadingUpcoming = false;
            update();
          } else {
            log('History Appointment');

            await getHistoryAppointment("", appointmentType: selectedTab);
            _isLoadingHistory = false;
            update();
          }
        }
      } else {
        log('already in process');
        _isLoadingUpcoming = false;
        update();
      }
    } catch (e) {
      _isLoadingUpcoming = false;
      _isLoadingHistory = false;
    }
  }

  getAppointmentsSummery() async {
    try {
      // _isLoading = true;
      _appointmentsSummery = [];
      update();
      _appointmentsSummery = await ScheduleRepo.getAppointmentsSummery();
      // _isLoading = false;
      _isBlockNextProcessing = false;
      update();
    } catch (e) {
      log('error: Exception is there');
      _isBlockNextProcessing = false;
      _isLoading = false;
      update();
    }
  }

  getUpcomingAppointment(String? Search, bool? myisInitState,
      {int? HistoryFilterStatus}) async {
    Search ??= "";
    try {
      //For Doctor Consultation
      if (_appointmentTypeFilter == 1) {
        if (_doctorUpcomingstartIndex == 0) {
          _isInitState = myisInitState!;
          _isLoadingUpcoming = true;
          _doctorConsultationUpcomingAppointments = [];
          _doctorUpcomingTotalRecords = 0;
          // update();
        }

        UpcomingModelForDoctorAndLabAppointment response =
            await ScheduleRepo.getDoctorUpcomingAppointment(
                Search, _doctorUpcomingstartIndex);

        if (response.Data != null && _isInitState == true) {
          for (var element in response.Data!) {
            _doctorConsultationUpcomingAppointments.add(element);
            update();
          }

          // _doctorConsultationUpcomingAppointments = response.Data ?? [];

          _doctorUpcomingTotalRecords =
              response.TotalRecord ?? _doctorUpcomingTotalRecords;
        }
        _isLoadingUpcoming = false;
        _isBlockNextProcessing = false;
        _isInitState = false;
        update();
      }
      //For Diagnostics
      else if (_appointmentTypeFilter == 2) {
        if (_diagnosticUpcomingstartIndex == 0) {
          _isInitState = myisInitState!;
          _isLoadingUpcoming = true;
          _diagnositicAppointmentListData = [];
          _diagnosticUpcomingTotalRecords = 0;
          // update();
        }

        UpcomingDiagnosticAppointment response =
            UpcomingDiagnosticAppointment();

        response = await ScheduleRepo.getDiagnosticUpcomingAppointment(
            Search, _diagnosticUpcomingstartIndex);

        if (response.Data != null && isInitState == true) {
          //response.Data ??= [];
          response.Data?.forEach((element) {
            log(element.toJson().toString());
            _diagnositicAppointmentListData.add(element);
            log("${response.Data![0].toString()} imaging Booking");
          });

          //_diagnositicAppointmentListData = response.Data ?? [];
          _diagnosticUpcomingTotalRecords =
              response.TotalRecord ?? _diagnosticUpcomingTotalRecords;
        }
        _isLoadingUpcoming = false;
        _isBlockNextProcessing = false;
        _isInitState = false;
        update();
      }
      //For Lab Investigation
      else if (_appointmentTypeFilter == 3) {
        if (_LabInvestigationUpcomingstartIndex == 0) {
          _isInitState = myisInitState!;
          _isLoadingUpcoming = true;
          _labInvestigationListData = [];
          _labInvestigationUpcomingTotalRecords = 0;
          // update();
        }

        UpcomingLabInvestigation response = UpcomingLabInvestigation();

        response = await ScheduleRepo.getLabInvestigationUpcomingAppointment(
            Search, _diagnosticUpcomingstartIndex);

        if (response.Data != null && _isInitState == true) {
          for (var element in response.Data!) {
            _labInvestigationListData.add(element);
          }

          //_labInvestigationListData = response.Data ?? [];
          _labInvestigationUpcomingTotalRecords =
              response.TotalRecord ?? _labInvestigationUpcomingTotalRecords;
        }
        _isLoadingUpcoming = false;
        _isBlockNextProcessing = false;
        _isInitState = false;

        update();
      }

      _isLoadingUpcoming = false;
      _isBlockNextProcessing = false;
      update();
    } catch (e) {
      log('error: Exception is there');
      _isLoadingUpcoming = false;
      _isBlockNextProcessing = false;
      update();
    }
  }

  getHistoryAppointment(String? Search, {String? appointmentType}) async {
    Search ??= "";
    try {
      log('test1');
      //For Doctor Consultation history
      if (_appointmentTypeFilter == 1) {
        if (_doctorHistorystartIndex == 0) {
          _isLoadingHistory = true;
          _doctorConsultationAppointmentHistoryDataList = [];
          _doctorHistoryTotalRecords = 0;
          // update();
        }

        DoctorConsultationAppointmentHistory response =
            DoctorConsultationAppointmentHistory();

        response = await ScheduleRepo.getDoctorHistoryAppointment(
            Search, _doctorHistorystartIndex);

        if (response.Data != null) {
          for (var element in response.Data!) {
            if (appointmentType != null) {
              _doctorConsultationAppointmentHistoryDataList.addIf(
                  element.Status == appointmentType, element);
            }
          }
          //_doctorConsultationAppointmentHistoryDataList = response.Data ?? [];
          _doctorHistoryTotalRecords =
              response.TotalRecord ?? _doctorHistoryTotalRecords;
        }
        _isLoadingHistory = false;
        _isBlockNextProcessing = false;
        update();
      }
      //For Diagnostics history
      else if (_appointmentTypeFilter == 2) {
        if (_diagnosticHistorystartIndex == 0) {
          _isLoadingHistory = true;
          _diagnosticAppointmentHistoryDataList = [];
          _diagnosticHistoryTotalRecords = 0;
          // update();
        }

        UpcomingDiagnosticAppointment response =
            UpcomingDiagnosticAppointment();

        response = await ScheduleRepo.getDiagnosticHistoryAppointment(
            Search, _diagnosticHistorystartIndex);

        if (response.Data != null) {
          for (var element in response.Data!) {
            _diagnosticAppointmentHistoryDataList.addIf(
                element.Status == '$appointmentType', element);

            log(element.Status.toString());
          }

          //  _diagnosticAppointmentHistoryDataList = response.Data ?? [];
          _diagnosticHistoryTotalRecords =
              response.TotalRecord ?? _diagnosticHistoryTotalRecords;
        }
        _isLoadingHistory = false;
        _isBlockNextProcessing = false;
        update();
      }
      //For Lab Investigation history
      else if (_appointmentTypeFilter == 3) {
        if (_LabInvestigationHistorystartIndex == 0) {
          _isLoadingHistory = true;
          _labInvestigationAppointmentHistoryDataList = [];
          _labInvestigationUpcomingTotalRecords = 0;
          // update();
        }

        LabInvestigationAppointmentHistory response =
            LabInvestigationAppointmentHistory();

        response = await ScheduleRepo.getLabInvestigationHistoryAppointment(
            Search, _diagnosticHistorystartIndex);

        if (response.Data != null) {
          for (var element in response.Data!) {
            _labInvestigationAppointmentHistoryDataList.addIf(
                element.AppointmentStatus == appointmentType, element);
          }

          log('Cancelled Lists are ${_labInvestigationAppointmentHistoryDataList.length}');
          //_labInvestigationAppointmentHistoryDataList = response.Data ?? [];
          _labInvestigationUpcomingTotalRecords =
              response.TotalRecord ?? _labInvestigationUpcomingTotalRecords;

          _isLoadingHistory = false;
          update();
        }
        _isLoadingHistory = false;
        _isBlockNextProcessing = false;
        update();
      }

      _isLoadingHistory = false;
      _isBlockNextProcessing = false;
      _isLoadingUpcoming = false;
      update();
    } catch (e) {
      log(e.toString());
      log('error: Exception is there');
      _isLoadingHistory = false;
      _isBlockNextProcessing = false;
      _isLoadingUpcoming = false;
      update();
    }
  }

  GetCompletedAppointments(String? Search) async {
    Search ??= "";
    try {
      //For Doctor Consultation history
      if (_appointmentTypeFilter == 1) {
        if (_doctorCompletedstartIndex == 0) {
          _isLoadingCompleted = true;
          _doctorConsultationCompletedAppointments = [];
          _doctorCompletedTotalRecords = 0;
          // update();
        }

        DoctorConsultationAppointmentHistory response =
            DoctorConsultationAppointmentHistory();

        response = await ScheduleRepo.getDoctorHistoryAppointment(
            Search, _doctorCompletedstartIndex);

        if (response.Data != null) {
          for (var element in response.Data!) {
            _doctorConsultationCompletedAppointments.addIf(
                element.Status == 'Consulted', element);
          }
          //_doctorConsultationAppointmentHistoryDataList = response.Data ?? [];
          _doctorCompletedTotalRecords =
              response.TotalRecord ?? _doctorCompletedTotalRecords;
        }
        _isLoadingCompleted = false;
        _isBlockNextProcessing = false;
        update();
      }
      //For Diagnostics history
      else if (_appointmentTypeFilter == 2) {
        if (_diagnosticCompletedstartIndex == 0) {
          _isLoadingCompleted = true;
          _diagnosticAppointmentCompletedDataList = [];
          _diagnosticCompletedTotalRecords = 0;
          // update();
        }

        UpcomingDiagnosticAppointment response =
            UpcomingDiagnosticAppointment();

        response = await ScheduleRepo.getDiagnosticHistoryAppointment(
            Search, _diagnosticCompletedstartIndex);

        if (response.Data != null) {
          for (var element in response.Data!) {
            _diagnosticAppointmentCompletedDataList.addIf(
                element.Status == 'Ride Started', element);
          }

          //  _diagnosticAppointmentHistoryDataList = response.Data ?? [];
          _diagnosticCompletedTotalRecords =
              response.TotalRecord ?? _diagnosticCompletedTotalRecords;
        }
        _isLoadingCompleted = false;
        _isBlockNextProcessing = false;
        update();
      }
      //For Lab Investigation history
      else if (_appointmentTypeFilter == 3) {
        if (_LabInvestigationCompletedstartIndex == 0) {
          _isLoadingCompleted = true;
          _labInvestigationAppointmentCompletedDataList = [];
          _labInvestigationCompletedTotalRecords = 0;
          // update();
        }

        LabInvestigationAppointmentHistory response =
            LabInvestigationAppointmentHistory();

        response = await ScheduleRepo.getLabInvestigationHistoryAppointment(
            Search, _diagnosticCompletedstartIndex);

        if (response.Data != null) {
          for (var element in response.Data!) {
            _labInvestigationAppointmentCompletedDataList.addIf(
                element.AppointmentStatus == 'Completed', element);
          }

          // log('Cancelled Lists are ${_cancelled.length}');
          //_labInvestigationAppointmentHistoryDataList = response.Data ?? [];
          _labInvestigationCompletedTotalRecords =
              response.TotalRecord ?? _labInvestigationCompletedTotalRecords;
        }
        _isLoadingCompleted = false;
        _isBlockNextProcessing = false;
        update();
      }

      _isLoadingCompleted = false;
      _isBlockNextProcessing = false;
      update();
    } catch (e) {
      log('error: Exception is there');
      _isLoadingCompleted = false;
      _isBlockNextProcessing = false;
      update();
    }
  }

  String convertTimeFormat(String inputTime) {
    try {
      List<String> timeParts = inputTime.split(':');

      if (timeParts.length != 3) {
        return inputTime; // Invalid input format, return as is d
      }

      int hours = int.tryParse(timeParts[0]) ?? 0;
      int minutes = int.tryParse(timeParts[1]) ?? 0;

      String period = hours >= 12 ? 'PM' : 'AM';

      if (hours > 12) {
        hours -= 12;
      } else if (hours == 0) {
        hours = 12;
      }

      String formattedTime =
          '$hours:${minutes.toString().padLeft(2, '0')} $period';

      return formattedTime;
    } catch (e) {
      return inputTime;
    }
  }

  String? _selectedTab;
  String? get selectedTab => _selectedTab;

  updateSelectedTab(String tab) {
    _selectedTab = tab;
    _isLoading = false;
    update();
  }

  static ScheduleController get i => Get.put(ScheduleController());
}
