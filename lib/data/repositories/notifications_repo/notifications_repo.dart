// ignore_for_file: unused_local_variable

import 'dart:developer';
import 'dart:math' as dm;

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:get/get.dart';
import 'package:tabib_al_bait/data/localDB/local_db.dart';
import 'package:tabib_al_bait/models/callscreenmodel.dart';
import 'package:tabib_al_bait/screens/callringingscreen/ringerscreen.dart';

class NotificationsRepo {
  final _fcm = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

// final _messageStreamController = BehaviorSubject<RemoteMessage>();

  Future<void> initNotifications() async {
    _fcm.requestPermission();
    final fcm = await _fcm.getToken().then((value) {
      // _fcm.subscribeToTopic('all');
      // log('saved token is $value');
      LocalDb().saveDeviceToken(value);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      await handleBackgroundMessage(message);
    });
  }

  Future<void> showNotifications(RemoteMessage message) async {
    AndroidNotificationChannel channel = AndroidNotificationChannel(
        dm.Random.secure().nextInt(100000).toString(),
        'High Importance Notification');
    AndroidNotificationDetails details = AndroidNotificationDetails(
      channel.id.toString(),
      channel.name.toString(),
      channelDescription: 'Channel Description',
      importance: Importance.high,
      priority: Priority.high,
      ticker: 'Ticker',
      // ignore: prefer_const_constructors
    );

    DarwinNotificationDetails darwin = const DarwinNotificationDetails(
        presentAlert: true, presentBadge: true, presentSound: true);

    NotificationDetails notifs =
        NotificationDetails(android: details, iOS: darwin);

    Future.delayed(Duration.zero, () {
      _plugin.show(0, message.notification?.title.toString(),
          message.notification?.body.toString(), notifs);
      // log(message.data.toString());
    });
  }

  Future<void> showBackgroundNotifications(RemoteMessage message) async {
    AndroidNotificationChannel channel = AndroidNotificationChannel(
        dm.Random.secure().nextInt(100000).toString(),
        'High Importance Notification');
    AndroidNotificationDetails details = AndroidNotificationDetails(
      channel.id.toString(),
      channel.name.toString(),
      channelDescription: 'Channel Description',
      importance: Importance.high,
      priority: Priority.high,
      ticker: 'Ticker',
      // ignore: prefer_const_constructors
    );

    DarwinNotificationDetails darwin = const DarwinNotificationDetails(
        presentAlert: true, presentBadge: true, presentSound: true);

    NotificationDetails notifs =
        NotificationDetails(android: details, iOS: darwin);

    Future.delayed(Duration.zero, () {
      _plugin.show(0, message.notification?.title.toString(),
          message.notification?.body.toString(), notifs);
      // log(message.data.toString());
    });
  }

  firebaseInit() {
    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
        alert: true, badge: true, sound: true);

    FirebaseMessaging.onMessage.listen((message) async {
      // log(message.notification!.body.toString());
      // log(message.data.toString());
      await showNotifications(message);

      if (message.notification?.title.toString().toLowerCase() == "calling") {
        FlutterRingtonePlayer.play(
          android: AndroidSounds.ringtone,
          ios: IosSounds.glass,
          looping: true, // Android only - API >= 28
          volume: 1, // Android only - API >= 28
          asAlarm: false, // Android only - all APIs
        );
        final Iterable<Duration> pauses = [
          const Duration(milliseconds: 500),
          const Duration(milliseconds: 1000),
          const Duration(milliseconds: 500),
        ];
        Vibrate.vibrateWithPauses(pauses);

        Callingscreenmodel model = Callingscreenmodel();

        model.visitNo = message.data['VisitNo'];
        model.branchId = message.data['BranchId'];
        model.uRL = message.data['URL'];
        model.isFirstTimeVisit = message.data['IsFirstTimeVisit'];
        model.doctorId = message.data['DoctorId'];
        model.doctorImagePath = message.data['DoctorImagePath'];
        model.deviceToken = message.data['DeviceToken'];
        model.patientId = message.data['PatientId'];
        model.prescribedInValue = message.data['PrescribedInValue'];
        model.callername = message.data['Body'];
        log(model.toJson().toString());
        Get.to(() => Ringerscreen(
              data: model,
            ));
      }
    });
  }

  initLocalNotifications() async {
    var androidInitializationSettings =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosInitializationSettings = const DarwinInitializationSettings();

    var init = InitializationSettings(
        android: androidInitializationSettings, iOS: iosInitializationSettings);
    await _plugin.initialize(
      init,
      onDidReceiveNotificationResponse: (details) {},
    );
  }

  Future<void> handleBackgroundMessage(RemoteMessage message) async {
    await showBackgroundNotifications(message);
    if (message.notification?.title.toString().toLowerCase() == "calling") {
      FlutterRingtonePlayer.play(
        android: AndroidSounds.ringtone,
        ios: IosSounds.glass,
        looping: true, // Android only - API >= 28
        volume: 1, // Android only - API >= 28
        asAlarm: false, // Android only - all APIs
      );
      final Iterable<Duration> pauses = [
        const Duration(milliseconds: 500),
        const Duration(milliseconds: 500),
        const Duration(milliseconds: 500),
        const Duration(milliseconds: 500),
        const Duration(milliseconds: 500),
        const Duration(milliseconds: 500),
        const Duration(milliseconds: 500),
        const Duration(milliseconds: 500),
        const Duration(milliseconds: 500),
        const Duration(milliseconds: 500),
        const Duration(milliseconds: 500),
        const Duration(milliseconds: 500),
        const Duration(milliseconds: 500),
      ];
      Vibrate.vibrateWithPauses(pauses);

      Callingscreenmodel model = Callingscreenmodel();

      model.visitNo = message.data['VisitNo'];
      model.branchId = message.data['BranchId'];
      model.uRL = message.data['URL'];
      model.isFirstTimeVisit = message.data['IsFirstTimeVisit'];
      model.doctorId = message.data['DoctorId'];
      model.doctorImagePath = message.data['DoctorImagePath'];
      model.deviceToken = message.data['DeviceToken'];
      model.patientId = message.data['PatientId'];
      model.prescribedInValue = message.data['PrescribedInValue'];
      model.callername = message.data['Body'];
      log("calling notification occurs");
      log(model.toJson().toString());
      Get.to(() => Ringerscreen(
            data: model,
          ));
    }
  }
}
