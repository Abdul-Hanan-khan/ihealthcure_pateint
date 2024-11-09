// ignore_for_file: unnecessary_null_comparison, library_private_types_in_public_api

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tabib_al_bait/screens/family_screens/family_members.dart';
import 'package:tabib_al_bait/utils/constants.dart';

class PdfViewerPage extends StatefulWidget {
  final String? testName;
  final String? url;
  const PdfViewerPage({super.key, this.url, this.testName});

  @override
  _PdfViewerPageState createState() => _PdfViewerPageState();
}

class _PdfViewerPageState extends State<PdfViewerPage> {
  String urlPDFPath = "";
  bool exists = true;
  int _totalPages = 0;
  int _currentPage = 0;
  bool pdfReady = false;
  PDFViewController? _pdfViewController;
  bool loaded = false;

  Future<File> getFileFromUrl(String url, {name}) async {
    var fileName = '${widget.testName}';
    if (name != null) {
      fileName = name;
    }
    try {
      await requestPersmission();
      await requestManagement();

      var data = await http.get(Uri.parse(url));
      var bytes = data.bodyBytes;
      var dir = await getApplicationDocumentsDirectory();
      log(dir.path);
      log(dir.path.toString());
      File file = File("${dir.path}/${fileName.trim()}.pdf");
      log(file.path.toString());
      File urlFile = await file.writeAsBytes(bytes);
      return urlFile;
    } catch (e) {
      log(e.toString());
      setState(() {
        loaded = false;
        exists = false;
      });
      Fluttertoast.showToast(msg: e.toString());
      throw Exception("Error opening url file");
    }
  }

  requestPersmission() async {
    Permission permission = Permission.storage;

    if (await permission.isGranted) {
      log('test1');
    } else if (await permission.isDenied) {
      log('test2');
      await permission.request();
    } else if (await permission.isPermanentlyDenied) {
      log('test3');

      openAppSettings();
    }
    log(permission.status.toString());
  }

  requestManagement() async {
    Permission permission = Permission.storage;
    Permission management = Permission.manageExternalStorage;

    if (await management.isGranted) {
      log('test1');
    } else if (await management.isDenied) {
      log('test2');
      await management.request();
    } else if (await management.isPermanentlyDenied) {
      log('test3');

      openAppSettings();
    }
    log(permission.status.toString());
  }

  @override
  void initState() {
    log(widget.url.toString());

    getFileFromUrl(
      "$baseURL/${widget.url}",
    ).then(
      (value) => {
        log('$baseURL/${widget.url}'),
        setState(() {
          if (value != null) {
            urlPDFPath = value.path;
            loaded = true;
            exists = true;
          } else {
            exists = false;
          }
        })
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (loaded) {
      return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(40),
          child: CustomAppBar(
            title: widget.testName,
          ),
        ),
        body: Center(
          child: PDFView(
            filePath: urlPDFPath,
            autoSpacing: true,
            enableSwipe: true,
            pageSnap: true,
            swipeHorizontal: true,
            nightMode: false,
            onError: (e) {},
            onRender: (pages) {
              setState(() {
                _totalPages = pages!;
                pdfReady = true;
              });
            },
            onViewCreated: (PDFViewController vc) {
              setState(() {
                _pdfViewController = vc;
              });
            },
            onPageChanged: (int? page, int? total) {
              setState(() {
                _currentPage = page!;
              });
            },
            onPageError: (page, e) {
              Fluttertoast.showToast(msg: '$e');
            },
          ),
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.chevron_left),
              iconSize: 50,
              color: Colors.black,
              onPressed: () {
                setState(() {
                  if (_currentPage > 0) {
                    _currentPage--;
                    _pdfViewController?.setPage(_currentPage);
                  }
                });
              },
            ),
            Text(
              "${_currentPage + 1}/$_totalPages",
              style: const TextStyle(color: Colors.black, fontSize: 20),
            ),
            IconButton(
              icon: const Icon(Icons.chevron_right),
              iconSize: 50,
              color: Colors.black,
              onPressed: () {
                setState(() {
                  if (_currentPage < _totalPages - 1) {
                    _currentPage++;
                    _pdfViewController?.setPage(_currentPage);
                  }
                });
              },
            ),
          ],
        ),
      );
    } else {
      if (exists) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(40),
            child: CustomAppBar(
              title: widget.testName,
            ),
          ),
          body: const Center(
            child: CircularProgressIndicator(),
          ),
        );
      } else {
        //Replace Error UI
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(40),
            child: CustomAppBar(
              title: widget.testName,
            ),
          ),
          body: Center(
            child: Text(
              "pdfnotavail".tr,
              style: const TextStyle(fontSize: 20),
            ),
          ),
        );
      }
    }
  }
}
