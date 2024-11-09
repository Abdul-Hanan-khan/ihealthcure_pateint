// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jitsi_meet_flutter_sdk/jitsi_meet_flutter_sdk.dart';
import 'package:tabib_al_bait/models/callscreenmodel.dart';

class Callaccept extends StatefulWidget {
  Callaccept({
    super.key,
    required this.data,
  });

  Callingscreenmodel data;

  @override
  State<Callaccept> createState() => _CallacceptState();
}

class _CallacceptState extends State<Callaccept> {
  call() async {
    var options = JitsiMeetConferenceOptions(
      room: widget.data.uRL,
    );
    await jitsiMeet.join(
      options,
    );
    Get.close(2);
  }

  dynamic listener;

  @override
  void initState() {
    call();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  final meetingNameController = TextEditingController();
  final jitsiMeet = JitsiMeet();

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Scaffold(
        // body: Center(
        //     child:
        //      SizedBox(
        //       child: InAppWebView(
        //           initialUrlRequest: URLRequest(
        //               url: Uri.parse(
        //                   "${widget.data.uRL}#config.disableDeepLinking=true")),
        //           initialOptions: InAppWebViewGroupOptions(
        //             crossPlatform: InAppWebViewOptions(
        //               mediaPlaybackRequiresUserGesture: false,
        //             ),
        //           ),
        //           onWebViewCreated: (InAppWebViewController controller) async {
        //             await Permission.camera.request();
        //             await Permission.microphone.request();
        //             controller;
        //           },
        //           androidOnPermissionRequest: (InAppWebViewController controller,
        //               String origin, List<String> resources) async {
        //             PermissionRequestResponseAction.GRANT;
        //             return PermissionRequestResponse(
        //                 resources: resources,
        //                 action: PermissionRequestResponseAction.GRANT);
        //           }),
        //     ),
        //     ),
        );
  }
}
