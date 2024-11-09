// ignore_for_file: body_might_complete_normally_nullable

import 'dart:developer';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart' as intl;
import 'package:permission_handler/permission_handler.dart';
import 'package:tabib_al_bait/data/controller/auth_controller.dart';
import 'package:tabib_al_bait/data/controller/book_appointment_controller.dart';
import 'package:tabib_al_bait/data/controller/controller.dart';
import 'package:tabib_al_bait/data/controller/google_maps_controller.dart';
import 'package:tabib_al_bait/data/controller/health_summary_controller.dart';
import 'package:tabib_al_bait/data/controller/lab_investigations_controller.dart';
import 'package:tabib_al_bait/data/controller/language_controller.dart';
import 'package:tabib_al_bait/data/controller/network_connectivity_controller.dart';
import 'package:tabib_al_bait/data/controller/schedule_controller.dart';
import 'package:tabib_al_bait/data/localDB/local_db.dart';
import 'package:tabib_al_bait/data/repositories/auth_repository/auth_repo.dart';
import 'package:tabib_al_bait/data/repositories/favorites_repo/favorites_repo.dart';
import 'package:tabib_al_bait/data/repositories/notifications_repo/notifications_repo.dart';
import 'package:tabib_al_bait/data/sqflite_db/sqflite_db.dart';
import 'package:tabib_al_bait/helpers/theme_manager.dart';
import 'package:tabib_al_bait/models/languages_model/languages_model.dart';
import 'package:tabib_al_bait/models/user_model.dart';
import 'package:tabib_al_bait/screens/dashboard/home.dart';
import 'package:tabib_al_bait/screens/googe_maps/google_maps.dart';
import 'package:tabib_al_bait/screens/splash_screen/splash_screen.dart';
import 'package:tabib_al_bait/utils/constants.dart';
import 'package:tabib_al_bait/utils/init/init.dart';
import 'package:tabib_al_bait/utils/languages.dart';
import 'package:uuid/uuid.dart';

int? initScreen;
var uuid = const Uuid();

Future<ConnectivityResult> internetCheck() async {
  ConnectivityResult result =
      await NetworkController.i.connectivity.checkConnectivity();
  log(result.toString());
  if (result == ConnectivityResult.none) {
    Get.rawSnackbar(
        messageText: const Text('Network Connection Error',
            style: TextStyle(color: Colors.white, fontSize: 14)),
        isDismissible: false,
        duration: const Duration(days: 1),
        backgroundColor: Colors.red[400] ?? Colors.red,
        icon: const Icon(
          Icons.wifi_off,
          color: Colors.white,
          size: 35,
        ),
        margin: EdgeInsets.zero,
        snackStyle: SnackStyle.GROUNDED);
  } else {}
  return result;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);

  await Firebase.initializeApp();
  await NotificationsRepo().initLocalNotifications();
  await NotificationsRepo().initNotifications();
  await NotificationsRepo().firebaseInit();
  baseURL = await instance();
  initScreen = await LocalDb().getIsOnboarding();
  FamilyScreensController.i.getallcountries();
  await SqfliteDB().init();

  // FamilyScreensController.i
  //     .getprovince(FamilyScreensController.i.selectedcountry!.id!);
  // FamilyScreensController.i
  //     .getcities(FamilyScreensController.i.selectedprovince!.id!);
  getDoctors();
  isLoggedin();
  loadtheData();

  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

FirebaseMessaging? fcm = FirebaseMessaging.instance;

class _MyAppState extends State<MyApp> {
  static GlobalKey<NavigatorState> navKey = GlobalKey();

  @override
  void initState() {
    getLocale();
    // loadInitialData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: navKey,
      textDirection: TextDirection.ltr,
      translations: Localization(),
      locale: const Locale('en', 'US'),
      theme: Styles.lightTheme,
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      initialBinding: AppBindings(),
    );
  }
}

String formatTimeOfDay(TimeOfDay tod) {
  final now = DateTime.now();
  final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
  final format = intl.DateFormat.jm(); //"6:00 AM"
  return format.format(dt);
}

getLocale() async {
  LanguageModel? lang = await LocalDb().getLanguage();
  if (lang == null) {
    lang = LanguageModel(
        id: 1, name: 'English', image: null, locale: const Locale('en', 'US'));
    Get.updateLocale(lang.locale!);
    LanguageController.i.selected = AppConstants.languages[0];
  } else {
    Get.updateLocale(lang.locale!);
  }
  if (lang.id == 1) {
    LanguageController.i.selected = AppConstants.languages[0];
  } else if (lang.id == 2) {
    LanguageController.i.selected = AppConstants.languages[1];
  } else {
    LanguageController.i.selected = AppConstants.languages[2];
  }
}

loadInitialData() async {
  try {
    ConnectivityResult result = await internetCheck();
    if (result == ConnectivityResult.wifi || result == ConnectivityResult.mobile
        // result == ConnectivityResult.ethernet ||
        // result == ConnectivityResult.vpn
        ) {
      getLocale();
      isLoggedin();
      BookAppointmentController.i.getPaymentMethods();
      LabInvestigationController.i.getLabTests();
      LabInvestigationController.i.getAllPackages();
      LanguageController.i.updateSelectedIndex(0);
      AuthController.i.getGendersFromAPI();
      AuthController.i.getCountriesFromAPI();
      LabInvestigationController.i.getDoctors();
      LabInvestigationController.i.getserviceslist();
      //  call();

      getDoctors();
      FamilyScreensController.i.getallcountries();
    } else {
      Get.rawSnackbar(
          messageText: const Text('Network Connection Error',
              style: TextStyle(color: Colors.black, fontSize: 14)),
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
    }
  } catch (e) {
    if (e is SocketException) {
      Get.rawSnackbar(
          messageText: const Text('PLEASE CONNECT TO THE INTERNET',
              style: TextStyle(color: Colors.black, fontSize: 14)),
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
    }
  }
}

Future<Position?> determinePosition() async {
  LocationPermission permission;
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.deniedForever) {
      log('$permission 2');
      openAppSettings();
    }
  } else if (permission == LocationPermission.whileInUse ||
      permission == LocationPermission.always) {
    Get.to(() => const GoogleMaps());
    await AddressController.i.getcurrentLocation().then(
      (value) async {
        AddressController.i.latitude = value.latitude;
        AddressController.i.longitude = value.longitude;
        await AddressController.i
            .initialAddress(value.latitude, value.longitude);
        AddressController.i.markers.clear();
        AddressController.i.markers.add(Marker(
            infoWindow: const InfoWindow(
                title: 'Current Location', snippet: 'current Location'),
            position: LatLng(value.latitude, value.longitude),
            markerId: const MarkerId('1')));
      },
    );
  }
}

loadtheData() async {
  ScheduleController.i.updateDataisLoading(true);

  // await lengthOfList();
  await listToLoad();

  ScheduleController.i.updateDataisLoading(false);
}

isLoggedin() async {
  bool? isLoggedIn = await LocalDb().getLoginStatus();
  AuthController.i.updateLoginStatus(isLoggedIn ?? false);
  if (isLoggedIn == true) {
    await LocalDb().getDataFromSP();
    HealthSummaryController.i.getLastDataBasedOnTitle();
    FavoritesRepo.getAllFavoriteDoctors();
    ScheduleController.i.getUpcomingAppointment('', true);
    call();
    // await AuthRepo().getupdatedprofile();
  } else {}
}

call() async {
  await AuthRepo.getupdatedprofile();
}

String containsFile(String? path) {
  if (path != null && path.split('/').contains('File')) {
    return baseURL;
  } else {
    return getImageUrl;
  }
}

Future<String> instance() async {
  final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
  await remoteConfig.setConfigSettings(
    RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 120),
      minimumFetchInterval: const Duration(minutes: 2),
    ),
  );
  await remoteConfig.fetchAndActivate().then((value) {
    baseURL = remoteConfig.getString('QAUrl');
    if (baseURL == "") {
      baseURL = 'http://192.168.88.254:328/';
    }
  }).onError((error, stackTrace) {
    baseURL = 'http://192.168.88.254:328/';
  });
  // String baseURL = remoteConfig.getString('URL');

  // baseURL = 'http://192.168.88.254:324';
  String? savedBaseURL = await LocalDb().getBaseURL();
  if (savedBaseURL != baseURL) {
    LocalDb().saveLoginStatus(false);
    LocalDb.saveUserData(UserDataModel());
    LocalDb().saveDeviceToken('');
    LocalDb().savePatientId('');
    AuthController.i.updateLoginStatus(false);
    AuthController.i.updateUser(UserDataModel());
    await AuthRepo.logout();
  }
  LocalDb().setBaseURL(baseURL);
  return baseURL;
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
