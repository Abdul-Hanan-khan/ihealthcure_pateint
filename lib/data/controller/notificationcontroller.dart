// ignore_for_file: non_constant_identifier_names

import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tabib_al_bait/data/repositories/notification_repo/notifications_repo.dart';
import 'package:tabib_al_bait/helpers/show_toast.dart';
import 'package:tabib_al_bait/models/notifications/notificationmodel.dart';
import 'package:tabib_al_bait/utils/constants.dart';

class Notificationcontroller extends GetxController {
  List<Notificationmodel> data = [];

  bool? _isLoading = false;
  bool? get isLoading => _isLoading;

  updateIsLoading(bool value) {
    _isLoading = value;
    update();
  }

  updatedata(List<Notificationmodel> d) {
    data = d;
    update();
  }

  int length = 10;
  static Notificationcontroller get i => Get.put(Notificationcontroller());

  int startIndexToFetchData = 0;
  int TotalRecordsData = 0;

  SetStartToFetchNextData() {
    if ((startIndexToFetchData + AppConstants.maximumDataTobeFetched) <
        TotalRecordsData) {
      startIndexToFetchData =
          startIndexToFetchData + AppConstants.maximumDataTobeFetched;
      return true;
    } else {
      ToastManager.showToast("allrecordsfetched".tr,
          bgColor: const Color(0xff1272d3));

      return false;
    }
  }

  callback() {
    _isLoading = true;
    log(_isLoading.toString());
    update();
    NotificationRepo.getpackages(
      length,
    );
    Timer(const Duration(seconds: 1), () {
      _isLoading = false;
      update();
    });

    log(_isLoading.toString());
  }
}
