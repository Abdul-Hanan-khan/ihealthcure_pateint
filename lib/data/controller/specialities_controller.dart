import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tabib_al_bait/data/controller/favorites_controller.dart';
import 'package:tabib_al_bait/data/repositories/specialities_repo/specialities_repo.dart';
import 'package:tabib_al_bait/models/date_wise_doctor_slots.dart';
import 'package:tabib_al_bait/models/doctor_locations_model.dart';
import 'package:tabib_al_bait/models/search_models.dart';
import '../../models/specialities_model.dart';

class SpecialitiesController extends GetxController implements GetxService {
  List<DoctorScheduleModel> worklocations = [];
  List<Data> doctors = [];
  List<Search> searchDoctors = [];
  bool? isLoading = false;
  List<DoctorScheduleModel> scheduleList = [];
  List<Sessions> sessions = [];
  List<Slots>? slots = [];
  int selectedIndex = 0;
  String? _startTime;
  String? get startTime => _startTime;
  String? _endTime;
  String? get endTime => _endTime;
  static DateTime todaysDate = DateTime.now();
  String formateDate = DateFormat('yyyy-MM-dd').format(todaysDate);
  bool? _bookAppointmentLoader = false;
  bool? get bookAppointmentLoader => _bookAppointmentLoader;
  List<Search> allDoctors = [];
  List<Search> filterDoctors = [];
  bool _isFavoriteListLoaded = false;
  bool _isAllDoctorsListLoaded = false;
  bool _isUpcomingAppointmentsLoaded = false;
  bool? get isFavoriteListLoaded => _isFavoriteListLoaded;
  bool? get isAllDoctorsListLoaded => _isAllDoctorsListLoaded;
  bool? get isUpcomingAppointmentsLoaded => _isUpcomingAppointmentsLoaded;
  String? appointmentslotdisplaytype;

  bool? _isConsultNowLoading = false;
  bool? get isConsultNowLoading => _isConsultNowLoading;

  updateIsConsultNowLoading(bool value) {
    _isConsultNowLoading = value;
    update();
  }

  updateworklocations(List<DoctorScheduleModel> dt) {
    worklocations = dt;
    update();
  }

  updateslotdisplaytype(String dt) {
    appointmentslotdisplaytype = dt;
    update();
  }

  updateIsFavoriteLoaded(bool value) {
    _isFavoriteListLoaded = value;
    update();
  }

  updateIsAllDoctorsLoaded(bool value) {
    _isAllDoctorsListLoaded = value;
    update();
  }

  updateisUpcomingAppointmentLoaded(bool value) {
    _isUpcomingAppointmentsLoaded = value;
    update();
  }

  updateStartTime(String time) {
    _startTime = time;
    update();
  }

  updateEndTime(
    String time,
  ) {
    _endTime = time;
    update();
  }

  // ======================>
  late TextEditingController searchDoctor;
  late TextEditingController searchSpecialities;

  updateIsLoading(bool value) {
    isLoading = value;
    update();
  }

  updatebookAppointmentLoader(bool value) {
    _bookAppointmentLoader = value;
    update();
  }

  getlocations() async {
    await SpecialitiesRepo.getworklocaitons();
  }

  getSpecialities({String? query}) async {
    isLoading = true;
    log(isLoading.toString());
    Specialities specialities =
        await SpecialitiesRepo.getSpecialities(query: query ?? '');
    doctors = specialities.data!;
    Timer(const Duration(milliseconds: 500), () {
      isLoading = false;
      update();
    });

    log(isLoading.toString());
    update();
  }

  List<Search> sortedDoctors = [];
  Future<List<Search>> getDoctors(String? id, {String? query = ''}) async {
    SpecialitiesController.i.updateIsLoading(true);
    SearchDoctors doctors =
        await SpecialitiesRepo().getSearchDoctors(id: id, query: query);
    searchDoctors = doctors.data!;
    sortedDoctors = sortDoctors(searchDoctors);
    _bookAppointmentLoader = false;
    SpecialitiesController.i.updateIsLoading(false);
    return sortedDoctors;
  }

  getDoctorWorkLocations(String doctorId) async {
    scheduleList = await SpecialitiesRepo.getDoctorWorkLocations(doctorId);
    update();
  }

  getDateWiseDoctorSlots(String doctorId, String workLocationId, String date,
      bool isOnline) async {
    sessions = await SpecialitiesRepo.getDateWiseDoctorSlots(
        doctorId, workLocationId, isOnline, date);
    for (int i = 0; i < sessions.length; i++) {
      slots = sessions[i].slots;
      updateSlots(slots!);
      update();
    }
    update();
  }

  updateSlots(List<Slots> myslots) {
    slots = myslots;
    update();
  }

  updateIsSelected(int index) {
    selectedIndex = index;
    update();
  }

  int customSort(Search a, Search b) {
    var fav = FavoritesController.i;
    var isAFavorite = fav.favoriteDoctors.any((element) => element.id == a.id);
    var isBFavorite = fav.favoriteDoctors.any((element) => element.id == b.id);

    if (isAFavorite && !isBFavorite) {
      return -1;
    } else if (!isAFavorite && isBFavorite) {
      return 1;
    } else {
      if (a.isOnline == true && b.isOnline == false) {
        return -1;
      } else if (a.isOnline == false && b.isOnline == true) {
        return 1;
      } else {
        return 0;
      }
    }
  }

  List<Search> sortDoctors(List<Search> doctors) {
    List<Search> sortedDoctors = List.from(doctors);
    sortedDoctors.sort(customSort);
    update();
    return sortedDoctors;
  }

  static SpecialitiesController get i => Get.put(SpecialitiesController());

  @override
  void onInit() {
    searchDoctor = TextEditingController();
    searchSpecialities = TextEditingController();
    super.onInit();
  }
}
