import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:tabib_al_bait/helpers/show_toast.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebView extends StatefulWidget {
  final String? url;
  const WebView({super.key, this.url});

  @override
  State<WebView> createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  bool isLoading = false;
  WebViewController? controller;
  double? _progress;
  @override
  void initState() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // ignore: unnecessary_this
            if (this.mounted) {
              setState(() {
                isLoading = true;
                _progress = progress / 100;
              });
            }
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {
            setState(() {
              isLoading = false;
            });
          },
          onWebResourceError: (WebResourceError error) {
            ToastManager.showToast(error.description);
          },
          onNavigationRequest: (NavigationRequest request) async {
            log("This is it${request.url}");
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            } else if (request.url
                .startsWith('https://www.youtube.com/@thetechbrotherss')) {
              log(widget.url.toString());
              setState(() {
                log(isLoading.toString());
              });

              return NavigationDecision.prevent;
            } else if (request.url.contains("https://meet.greenhost.net/")) {
              Get.back();
              return NavigationDecision.prevent;
            } else if (request.url.contains("/Account/LogIn?ReturnUrl")) {
              await Future.delayed(const Duration(seconds: 10));
              Get.back();
              return NavigationDecision.prevent;
            } else {
              log('over here');
              log("This is it${request.url}");
              setState(() {
                log(isLoading.toString());
              });
              return NavigationDecision.navigate;
            }
          },
        ),
      )
      ..loadRequest(Uri.parse('${widget.url}'));
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
      ),
      body: isLoading == true && _progress != 100
          ? Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: LinearPercentIndicator(
                    percent: _progress!,
                    lineHeight: 10,
                  ),
                ),
                const Text('Loading....')
              ],
            ))
          : WebViewWidget(controller: controller!),
    );
  }
}
