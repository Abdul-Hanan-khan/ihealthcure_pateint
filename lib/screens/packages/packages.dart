import 'dart:async';
import 'dart:developer';

import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:tabib_al_bait/components/custom_textfields.dart';
import 'package:tabib_al_bait/components/image_container.dart';
import 'package:tabib_al_bait/components/images.dart';
import 'package:tabib_al_bait/data/controller/drawerpackages.dart';
import 'package:tabib_al_bait/data/localDB/local_db.dart';
import 'package:tabib_al_bait/data/repositories/drawerpackages/drawerpackgesrepo.dart';
import 'package:tabib_al_bait/helpers/color_manager.dart';
import 'package:tabib_al_bait/helpers/show_toast.dart';
import 'package:tabib_al_bait/helpers/values_manager.dart';
import 'package:tabib_al_bait/models/drawerpackages/drawerpackagesbody.dart';
import 'package:tabib_al_bait/screens/family_screens/family_members.dart';
import 'package:tabib_al_bait/screens/pdf_viewer/pdf_viewer.dart';
import 'package:tabib_al_bait/utils/constants.dart';

class Drawerpackages extends StatefulWidget {
  const Drawerpackages({super.key});

  @override
  State<Drawerpackages> createState() => _DrawerpackagesState();
}

class _DrawerpackagesState extends State<Drawerpackages> {
  int startIndex = 0;
  String patientid = "";
  int totalRecords = 0;
  int recordsFetched = 0;
  call() async {
    patientid = (await LocalDb().getPatientId()) ?? "";
    drawerpackaesrepo().getpatienthistory(
      drawerpackagesrequestbody(
          start: startIndex,
          length: AppConstants.maximumDataTobeFetched,
          isDoNotApplyDateRangeFilter: "1",
          isAllServicesAppointments: "1",
          patientId: patientid,
          isAPI: "false",
          isOnlyPackageAppointmentBookings: "1",
          search: ""),
    );
    setState(() {
      recordsFetched = recordsFetched + AppConstants.maximumDataTobeFetched;
    });
  }

  setStartToFetchNextDataForComingAppoiontments() {
    if ((startIndex + AppConstants.maximumDataTobeFetched) <= recordsFetched) {
      startIndex = startIndex + AppConstants.maximumDataTobeFetched;
      return true;
    } else {
      ToastManager.showToast("allrecordsfetched".tr,
          bgColor: const Color(0xff1272D3));

      return false;
    }
  }

  formatdate(String dateString) {
    return DateFormat.yMMMMd().format(DateTime.parse(dateString));
  }

  String filter = "";

  @override
  void initState() {
    Drawerpackagescontroller.i.updateloader(true);
    value =
        List.generate(Drawerpackagescontroller.i.data.length, (index) => false);
    log(value.toString());
    call();

    _scrollControllerhistory.addListener(() async {
      // var nextPageTrigger = 0.8 * _scrollController.position.maxScrollExtent;
      if (_scrollControllerhistory.position.pixels ==
          _scrollControllerhistory.position.maxScrollExtent) {
        var isCallToFetchData =
            await setStartToFetchNextDataForComingAppoiontments();
        if (isCallToFetchData == true) {
          call();
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    startIndex = 0;
    recordsFetched = 0;
    Drawerpackagescontroller.i.data = [];
    Drawerpackagescontroller.i.dt = [];
    // TODO: implement dispose
    super.dispose();
  }

  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollControllerhistory = ScrollController();

  List<bool>? value;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: CustomAppBar(
          title: 'Package Record',
        ),
      ),
      body: GetBuilder<Drawerpackagescontroller>(builder: (cnt) {
        return BlurryModalProgressHUD(
          inAsyncCall: Drawerpackagescontroller.i.loader,
          blurEffectIntensity: 4,
          progressIndicator: const SpinKitSpinningLines(
            color: Color(0xff1272d3),
            size: 60,
          ),
          dismissible: false,
          opacity: 0.4,
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Padding(
            padding: const EdgeInsets.all(AppPadding.p14),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Get.width * 0.02,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: CustomTextField(
                          isSizedBoxAvailable: false,
                          onchanged: (p0) {
                            Future.delayed(const Duration(milliseconds: 600),
                                () async {
                              drawerpackaesrepo().getpatienthistory(
                                  drawerpackagesrequestbody(
                                      start: startIndex,
                                      length:
                                          AppConstants.maximumDataTobeFetched,
                                      isDoNotApplyDateRangeFilter: "1",
                                      isAllServicesAppointments: "1",
                                      patientId: patientid,
                                      isAPI: "false",
                                      isOnlyPackageAppointmentBookings: "1",
                                      search: p0),
                                  isSearch: true);
                            });
                          },
                          controller: _controller,
                          // controller: asearch,
                          hintText: 'Search Packages',
                          prefixIcon: const Icon(
                            Icons.search,
                            color: ColorManager.kPrimaryColor,
                          ),
                        ),
                      ),
                      SizedBox(width: Get.width * 0.02),
                      PopupMenuButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: const ImageContainer(
                          imagePath: Images.historyImage,
                          backgroundColor: ColorManager.kPrimaryColor,
                          isSvg: false,
                        ),
                        onSelected: (value) {
                          if (value == 2) {
                            filter = "pending";
                            setState(() {});
                          } else if (value == 3) {
                            // add desired output
                            filter = "Requested";
                            setState(() {});
                          } else if (value == 4) {
                            filter = "Completed";
                            setState(() {});
                            // add desired output
                          } else if (value == 5) {
                            filter = "Cancelled";
                            setState(() {});
                            // add desired output
                          } else if (value == 6) {
                            filter = "Refunded";
                            setState(() {});
                            // add desired output
                          } else if (value == 7) {
                            filter = "Pending Provider Approved";
                            setState(() {});
                            // add desired output
                          } else if (value == 8) {
                            filter = "In Progress";
                            setState(() {});
                            // add desired output
                          } else {
                            filter = "";
                            setState(() {});
                          }
                        },
                        itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                          PopupMenuItem(
                            value: 1,
                            child: Row(
                              children: [
                                Text(
                                  'all'.tr,
                                  style: const TextStyle(
                                      fontSize: 15, color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                          PopupMenuItem(
                            value: 2,
                            child: Row(
                              children: [
                                Text(
                                  'pending'.tr,
                                  style: const TextStyle(
                                      fontSize: 15, color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                          PopupMenuItem(
                            value: 3,
                            child: Row(
                              children: [
                                Text(
                                  "requested".tr,
                                  style: const TextStyle(
                                      fontSize: 15, color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                          PopupMenuItem(
                            value: 4,
                            child: Row(
                              children: [
                                Text(
                                  "completed".tr,
                                  style: const TextStyle(
                                      fontSize: 15, color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                          PopupMenuItem(
                            value: 5,
                            child: Row(
                              children: [
                                Text(
                                  "Cancelled".tr,
                                  style: const TextStyle(
                                      fontSize: 15, color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                          PopupMenuItem(
                            value: 6,
                            child: Row(
                              children: [
                                Text(
                                  "Refunded".tr,
                                  style: const TextStyle(
                                      fontSize: 15, color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                          PopupMenuItem(
                            value: 7,
                            child: Row(
                              children: [
                                Text(
                                  "Pending Provider Approved".tr,
                                  style: const TextStyle(
                                      fontSize: 15, color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                          PopupMenuItem(
                            value: 8,
                            child: Row(
                              children: [
                                Text(
                                  "In Progress".tr,
                                  style: const TextStyle(
                                      fontSize: 15, color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.01,
                ),
                Drawerpackagescontroller.i.data.isEmpty
                    ? Center(
                        child: Text("norecordfound".tr),
                      )
                    : Flexible(
                        child: ListView.builder(
                          controller: _scrollControllerhistory,
                          physics: const AlwaysScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: Drawerpackagescontroller.i.data.length,
                          itemBuilder: (context, index) {
                            final hstry =
                                Drawerpackagescontroller.i.data[index];
                            labtestlength =
                                hstry.labTest.toString().split(',').length;
                            List<String> labtestname =
                                hstry.labTest.toString().split(',');
                            if (hstry.status
                                    .toString()
                                    .replaceAll(' ', '')
                                    .toLowerCase() ==
                                filter.replaceAll(' ', '').toLowerCase()) {
                              return Card(
                                color: const Color(0xffE5EEF9),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0)
                                      .copyWith(top: 20),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: Get.width * 0.04),
                                        child: Row(
                                          children: [
                                            Container(
                                              height: Get.height * 0.13,
                                              width: Get.height * 0.13,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: ColorManager
                                                      .kPrimaryColor,
                                                  width: 3,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: hstry.pickupAddress !=
                                                          "" &&
                                                      hstry.labTestChallanNo !=
                                                          null
                                                  ? Image.asset(
                                                      Images.microscope)
                                                  : hstry.pickupAddress != ""
                                                      ? Image.asset(Images.home)
                                                      : Image.asset(
                                                          Images.microscope),
                                            ),
                                            SizedBox(
                                              width: Get.width * 0.02,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  padding: const EdgeInsets.all(
                                                          AppPadding.p10)
                                                      .copyWith(
                                                          left: 30, right: 30),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      border: Border.all(
                                                          width: 2,
                                                          color: hstry.status
                                                                      .toString()
                                                                      .toLowerCase() ==
                                                                  "completed"
                                                              ? const Color(
                                                                  0xff00AD40)
                                                              : const Color(
                                                                  0xffFFB800))),
                                                  child: Center(
                                                    child: Text(
                                                      hstry.status
                                                          .toString()
                                                          .split(' ')
                                                          .last,
                                                      style: GoogleFonts.poppins(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w900,
                                                          color: hstry.status
                                                                      .toString()
                                                                      .toLowerCase() ==
                                                                  "completed"
                                                              ? const Color(
                                                                  0xff00AD40)
                                                              : const Color(
                                                                  0xffFFB800)),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: Get.height * 0.02,
                                                ),
                                                Text(
                                                  hstry.packageGroupName ??
                                                      "packagename".tr,
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                const Divider(
                                                  color: Colors.black,
                                                  height: 1,
                                                ),
                                                // SizedBox(
                                                //   width: Get.width * 0.4,
                                                //   child: Text(
                                                //     hstry
                                                //         .appointmentCategoryName,
                                                //     style: GoogleFonts.poppins(
                                                //         fontSize: 10,
                                                //         fontWeight:
                                                //             FontWeight.w400),
                                                //     maxLines: 1,
                                                //     overflow:
                                                //         TextOverflow.ellipsis,
                                                //   ),
                                                // ),
                                                SizedBox(
                                                  width: Get.width * 0.4,
                                                  child: Text(
                                                    "${formatdate("${hstry.bookingDate.toString().split('T')[0]} ${hstry.bookingDate.toString().split('T')[1]}")} ${hstry.time.toString().split(':')[0]}:${hstry.time.toString().split(':')[1]}:${int.parse(hstry.time.toString().split(':')[0].toString()) > 11 ? "AM" : "PM"}",
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: Get.width * 0.04,
                                            vertical: Get.height * 0.01),
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: Get.width * 0.6,
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "${'apptno'.tr} ${hstry.labNo} | ",
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  Text(
                                                    "amount".tr,
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 10,
                                                        color: const Color(
                                                            0xff1272D3),
                                                        fontWeight:
                                                            FontWeight.w400),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  Text(
                                                    " ${hstry.totalAppointmentFee.toString().split('.')[0]}",
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  )
                                                ],
                                              ),
                                            ),
                                            Container(
                                              height: Get.height * 0.04,
                                              width: Get.width * 0.15,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: hstry.paymentStatusName
                                                              .toString()
                                                              .toLowerCase() ==
                                                          "pending"
                                                      ? const Color(0xffFF3333)
                                                      : const Color(
                                                          0xff00AD40)),
                                              child: Center(
                                                child: Text(
                                                  hstry.paymentStatusName,
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: const Color(
                                                          0xffFFFFFF)),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          hstry.status
                                                          .toString()
                                                          .toLowerCase()
                                                          .split(' ')
                                                          .first ==
                                                      "completed" &&
                                                  hstry.invoiceURL != null
                                              ? InkWell(
                                                  onTap: () {
                                                    Get.to(() => PdfViewerPage(
                                                          url: hstry.invoiceURL,
                                                          testName:
                                                              hstry.patientName,
                                                        ));
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color: const Color(
                                                            0xff1272D3)),
                                                    height: Get.height * 0.06,
                                                    child: Center(
                                                        child: Text(
                                                      "invoice".tr,
                                                      style:
                                                          GoogleFonts.poppins(
                                                        color: Colors.white,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    )),
                                                  ),
                                                )
                                              : Container(
                                                  width: Get.width * 0.75,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color:
                                                          const Color.fromARGB(
                                                              255,
                                                              162,
                                                              174,
                                                              186)),
                                                  height: Get.height * 0.06,
                                                  child: Center(
                                                      child: Text(
                                                    "invoice".tr,
                                                    style: GoogleFonts.poppins(
                                                      color: Colors.white,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  )),
                                                ),
                                        ],
                                      ),
                                      const Divider(),
                                      SizedBox(
                                        width: Get.width * 0.9,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: Get.width * 0.04),
                                          child: ListView.builder(
                                              shrinkWrap: true,
                                              // physics:
                                              //     const NeverScrollableScrollPhysics(),
                                              itemCount:
                                                  Drawerpackagescontroller
                                                          .i.showallitems[index]
                                                      ? labtestname.length
                                                      : labtestname.length > 1
                                                          ? 1
                                                          : labtestname.length,
                                              itemBuilder: (context, i) {
                                                return Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      labtestname[i]
                                                          .replaceAll(' ', ''),
                                                      style:
                                                          GoogleFonts.poppins(
                                                        color: Colors.black,
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              }),
                                        ),
                                      ),
                                      InkWell(
                                          onTap: () {
                                            Drawerpackagescontroller.i
                                                .updatecheckvalue(index);
                                          },
                                          child: Image.asset(
                                            Drawerpackagescontroller.i
                                                        .showallitems[index] ==
                                                    true
                                                ? Images.dropdownIcon
                                                : Images.dropdownIconDown,
                                            height: 15,
                                          ))
                                    ],
                                  ),
                                ),
                              );
                            } else if (filter == "") {
                              return Card(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                color: const Color(0xffE5EEF9),
                                child: Padding(
                                  padding: const EdgeInsets.all(AppPadding.p20),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            height: Get.height * 0.13,
                                            width: Get.height * 0.13,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color:
                                                    ColorManager.kPrimaryColor,
                                                width: 3,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: hstry.pickupAddress != "" &&
                                                    hstry.labTestChallanNo !=
                                                        null
                                                ? Image.asset(
                                                    Images.microscope,
                                                  )
                                                : hstry.pickupAddress != ""
                                                    ? Image.asset(Images.home)
                                                    : Image.asset(
                                                        Images.microscope),
                                          ),
                                          SizedBox(
                                            width: Get.width * 0.02,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(10)
                                                        .copyWith(
                                                            left: 15,
                                                            right: 15),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    border: Border.all(
                                                        width: 2,
                                                        color: hstry.status
                                                                    .toString()
                                                                    .toLowerCase() ==
                                                                "completed"
                                                            ? const Color(
                                                                0xff00AD40)
                                                            : const Color(
                                                                0xffFFB800))),
                                                child: Center(
                                                  child: Text(
                                                    hstry.status
                                                        .toString()
                                                        .split(' ')
                                                        .last,
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w900,
                                                        color: hstry.status
                                                                    .toString()
                                                                    .toLowerCase() ==
                                                                "completed"
                                                            ? const Color(
                                                                0xff00AD40)
                                                            : const Color(
                                                                0xffFFB800)),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: Get.height * 0.01,
                                              ),
                                              SizedBox(
                                                width: Get.width * 0.4,
                                                child: Text(
                                                  hstry.packageGroupName ??
                                                      "packagename",
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              const Divider(
                                                color: Colors.black,
                                                height: 1,
                                              ),
                                              // SizedBox(
                                              //   width: Get.width * 0.4,
                                              //   child: Text(
                                              //     hstry
                                              //         .appointmentCategoryName,
                                              //     style: GoogleFonts.poppins(
                                              //         fontSize: 10,
                                              //         fontWeight:
                                              //             FontWeight.w400),
                                              //     maxLines: 1,
                                              //     overflow:
                                              //         TextOverflow.ellipsis,
                                              //   ),
                                              // ),
                                              SizedBox(
                                                width: Get.width * 0.4,
                                                child: Text(
                                                  "${formatdate("${hstry.bookingDate.toString().split('T')[0]} ${hstry.bookingDate.toString().split('T')[1]}")} ${hstry.time.toString().split(':')[0]}:${hstry.time.toString().split(':')[1]}:${int.parse(hstry.time.toString().split(':')[0].toString()) > 11 ? "AM" : "PM"}",
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "${'apptno'.tr} ${hstry.labNo} | ",
                                            style: GoogleFonts.poppins(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Text(
                                            "amount".tr,
                                            style: GoogleFonts.poppins(
                                                color: const Color(0xff1272D3),
                                                fontSize: 10,
                                                fontWeight: FontWeight.w400),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Text(
                                            " ${hstry.totalAppointmentFee.toString().split('.')[0]}",
                                            style: GoogleFonts.poppins(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w400),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Container(
                                            height: Get.height * 0.04,
                                            width: Get.width * 0.15,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: hstry.paymentStatusName
                                                            .toString()
                                                            .toLowerCase() ==
                                                        "pending"
                                                    ? const Color(0xffFF3333)
                                                    : const Color(0xff00AD40)),
                                            child: Center(
                                              child: Text(
                                                hstry.paymentStatusName,
                                                style: GoogleFonts.poppins(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w500,
                                                    color: const Color(
                                                        0xffFFFFFF)),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: Get.height * 0.02,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          hstry.status
                                                          .toString()
                                                          .toLowerCase()
                                                          .split(' ')
                                                          .first ==
                                                      "completed" &&
                                                  hstry.invoiceURL != null
                                              ? InkWell(
                                                  onTap: () {
                                                    Get.to(() => PdfViewerPage(
                                                          url: hstry.invoiceURL,
                                                          testName:
                                                              hstry.patientName,
                                                        ));
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color: const Color(
                                                            0xff1272D3)),
                                                    height: Get.height * 0.06,
                                                    child: Center(
                                                        child: Text(
                                                      "invoice".tr,
                                                      style:
                                                          GoogleFonts.poppins(
                                                        color: Colors.white,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    )),
                                                  ),
                                                )
                                              : Container(
                                                  width: Get.width * 0.75,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color:
                                                          const Color.fromARGB(
                                                              255,
                                                              70,
                                                              154,
                                                              239)),
                                                  height: Get.height * 0.06,
                                                  child: Center(
                                                      child: Text(
                                                    "invoice".tr,
                                                    style: GoogleFonts.poppins(
                                                      color: Colors.white,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  )),
                                                ),
                                        ],
                                      ),
                                      const Divider(),
                                      SizedBox(
                                        width: Get.width * 0.9,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: Get.width * 0.04),
                                          child: ListView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              // shrinkWrap: true,
                                              itemCount:
                                                  Drawerpackagescontroller
                                                          .i.showallitems[index]
                                                      ? labtestname.length
                                                      : labtestname.length > 1
                                                          ? 1
                                                          : labtestname.length,
                                              itemBuilder: (context, i) {
                                                return Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      labtestname[i]
                                                          .replaceAll(' ', ''),
                                                      style:
                                                          GoogleFonts.poppins(
                                                        color: Colors.black,
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              }),
                                        ),
                                      ),
                                      InkWell(
                                          onTap: () {
                                            Drawerpackagescontroller.i
                                                .updatecheckvalue(index);
                                          },
                                          child: Image.asset(
                                            Drawerpackagescontroller.i
                                                        .showallitems[index] ==
                                                    true
                                                ? Images.dropdownIcon
                                                : Images.dropdownIconDown,
                                            height: 15,
                                          ))
                                    ],
                                  ),
                                ),
                              );
                            } else {
                              return const SizedBox.shrink();
                            }
                          },
                        ),
                      )
              ],
            ),
          ),
        );
      }),
    );
  }

  int labtestlength = 0;
}
