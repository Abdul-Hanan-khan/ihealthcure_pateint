import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyAppointmentsController extends GetxController with GetSingleTickerProviderStateMixin{

   TabController? tabController;
   bool? _isPaymentComplete = false;
   bool? get isPaymentComplete => _isPaymentComplete;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  void onClose() {
    tabController!.dispose();
    super.onClose();
  }

  int _pageIndex = 0;
  int get pageIndex => _pageIndex;

  updatePageIndex(int index){
    _pageIndex = index;
    update();
  }

  int _selectedAppointment = 0;
  int get selectedAppointmentData => _selectedAppointment;

  updateAppointmentData(int index){
    _selectedAppointment = index;
    update();
  }

  updatePayment(bool value){
    _isPaymentComplete = value;
    log(_isPaymentComplete.toString());
    update();
  }

      static MyAppointmentsController get i => Get.put(MyAppointmentsController());

 

}