import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tabib_al_bait/main.dart';

class NetworkController extends GetxController {
  final Connectivity connectivity = Connectivity();

  @override
  void onInit() {
    super.onInit();
    connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  
  }

  void _updateConnectionStatus(ConnectivityResult connectivityResult) {
    // Get.rawSnackbar(
    //       messageText:  Text(connectivityResult.name.toString(),
    //           style: const TextStyle(color: Colors.black, fontSize: 14)),
    //       isDismissible: false,
    //       duration: const Duration(days: 1),
    //       backgroundColor: Colors.red[400]!,
    //       icon: const Icon(
    //         Icons.wifi_off,
    //         color: Colors.white,
    //         size: 35,
    //       ),
    //       margin: EdgeInsets.zero,
    //       snackStyle: SnackStyle.GROUNDED);
    if (connectivityResult == ConnectivityResult.none) {
      // log('no internet connection error');
      Get.rawSnackbar(
          messageText: const Text('PLEASE CONNECT TO THE INTERNET',
              style: TextStyle(color: Colors.white, fontSize: 14)),
          isDismissible: false,
          duration: const Duration(days: 1),
          backgroundColor: Colors.red[400]!,
          icon: const Icon(
            Icons.wifi_off,
            color: Colors.white,
            size: 35,
          ),
          margin: EdgeInsets.zero,
          snackStyle: SnackStyle.GROUNDED);
    } else {
      if (Get.isSnackbarOpen) {
        loadInitialData();
        Get.closeCurrentSnackbar();

      }
    }
  }
    static NetworkController get i => Get.put(NetworkController());
}
