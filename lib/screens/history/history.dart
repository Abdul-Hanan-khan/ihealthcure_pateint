// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:developer';

import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:tabib_al_bait/components/custom_textfields.dart';
import 'package:tabib_al_bait/components/image_container.dart';
import 'package:tabib_al_bait/components/images.dart';
import 'package:tabib_al_bait/data/controller/patienthistory.dart';
import 'package:tabib_al_bait/data/localDB/local_db.dart';
import 'package:tabib_al_bait/data/repositories/patienthistory/patienthistoryrepo.dart';
import 'package:tabib_al_bait/helpers/color_manager.dart';
import 'package:tabib_al_bait/helpers/show_toast.dart';
import 'package:tabib_al_bait/helpers/values_manager.dart';
import 'package:tabib_al_bait/main.dart';
import 'package:tabib_al_bait/models/patienthistory/requestbody.dart';
import 'package:tabib_al_bait/models/patienthistory/responsebody.dart';
import 'package:tabib_al_bait/screens/family_screens/family_members.dart';
import 'package:tabib_al_bait/screens/pdf_viewer/pdf_viewer.dart';
import 'package:tabib_al_bait/utils/constants.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  int startIndex = 0;
  int recordsFetched = 0;
  String? patientid;
  call() async {
    Patienthistory.i.updateloading(true);
    patientid = await LocalDb().getPatientId();
    patientrepo().getpatienthistory(historyrequestbody(
        start: startIndex,
        length: AppConstants.maximumDataTobeFetched,
        isDoNotApplyDateRangeFilter: "1",
        isAllServicesAppointments: "1",
        patientId: patientid,
        isAPI: "false"));

    setState(() {
      recordsFetched = recordsFetched + AppConstants.maximumDataTobeFetched;
    });
    // Patienthistory.i.updateloading(false);
  }

  @override
  void dispose() {
    recordsFetched = 0;
    startIndex = 0;
    Patienthistory.i.data.clear();
    Patienthistory.i.dt?.clear();
    // TODO: implement dispose
    super.dispose();
  }

  String filter = "";

  formatdate(String dateString) {
    return DateFormat.yMMMMd().format(DateTime.parse(dateString));
  }

  TextEditingController controller = TextEditingController();

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

  final ScrollController _scrollControllerhistory = ScrollController();

  @override
  void initState() {
    call();
    value = List.generate(Patienthistory.i.data.length, (index) => false);
    log(value.toString());
    _scrollControllerhistory.addListener(() {
      if (_scrollControllerhistory.position.pixels ==
          _scrollControllerhistory.position.maxScrollExtent) {
        var isCallToFetchData = setStartToFetchNextDataForComingAppoiontments();
        if (isCallToFetchData) {
          call();
        }
      }
    });
    super.initState();
  }

  List<bool>? value;

  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: CustomAppBar(
          title: 'history'.tr,
        ),
      ),
      body: GetBuilder<Patienthistory>(builder: (cnt) {
        return BlurryModalProgressHUD(
          inAsyncCall: Patienthistory.i.isloading,
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
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: CustomTextField(
                        isSizedBoxAvailable: false,
                        onchanged: (p0) {
                          Future.delayed(const Duration(milliseconds: 600),
                              () async {
                            // do something here
                            patientrepo().getpatienthistory(
                                historyrequestbody(
                                    start: 0,
                                    length: recordsFetched,
                                    isDoNotApplyDateRangeFilter: "1",
                                    isAllServicesAppointments: "1",
                                    patientId: patientid,
                                    isAPI: "false",
                                    search: p0.toString() != ""
                                        ? p0.toString()
                                        : ""),
                                isSearch: true);
                            // await Future.delayed(Duration(seconds: 1));
                            // do stuff
                          });
                        },
                        controller: _controller,
                        // controller: asearch,
                        hintText: 'Search History',
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
                SizedBox(
                  height: Get.height * 0.01,
                ),
                Patienthistory.i.data.isEmpty
                    ? Center(
                        child: Text("norecordfound".tr),
                      )
                    : Flexible(
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const AlwaysScrollableScrollPhysics(),
                          controller: _scrollControllerhistory,
                          itemCount: Patienthistory.i.data.length,
                          itemBuilder: (context, index) {
                            final hstry = Patienthistory.i.data[index];
                            if (hstry.status
                                    .toString()
                                    .replaceAll(' ', '')
                                    .toLowerCase() ==
                                filter.replaceAll(' ', '').toLowerCase()) {
                              return Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                elevation: 0,
                                color: const Color(0xffE5EEF9),
                                child: Padding(
                                  padding: const EdgeInsets.all(AppPadding.p20),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            height: Get.height * 0.15,
                                            width: Get.height * 0.15,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color:
                                                    ColorManager.kPrimaryColor,
                                                width: 3,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: hstry.picturePath != null
                                                ? ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    child: CachedNetworkImage(
                                                      imageUrl:
                                                          '${containsFile(hstry.picturePath!)}/${hstry.picturePath}',
                                                      fit: BoxFit.cover,
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          Image.asset(
                                                        Images.bike,
                                                        fit: BoxFit.fitHeight,
                                                      ),
                                                    ),
                                                  )
                                                : Image.asset(
                                                    Images.doctorAvatar),
                                          ),
                                          SizedBox(
                                            width: Get.width * 0.03,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.all(
                                                        AppPadding.p8)
                                                    .copyWith(
                                                        left: 15, right: 15),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    border: Border.all(
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
                                                    hstry.status,
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w500,
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
                                              Text(
                                                hstry.prescribedBy
                                                    .toString()
                                                    .trim(),
                                                style: GoogleFonts.poppins(
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w700),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              const Divider(
                                                color: Colors.black,
                                                height: 1,
                                              ),
                                              SizedBox(
                                                width: Get.width * 0.4,
                                                child: Text(
                                                  hstry.appointmentCategoryName,
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              SizedBox(
                                                width: Get.width * 0.4,
                                                child: Text(
                                                  " ${formatdate("${hstry.bookingDate.toString().split('T')[0]} ${hstry.bookingDate.toString().split('T')[1]}")} ${hstry.time.toString().split(':')[0]}:${hstry.time.toString().split(':')[1]}:${int.parse(hstry.time.toString().split(':')[0].toString()) > 11 ? "AM" : "PM"}",
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
                                            "${"Appt No.".tr} ${hstry.labNo}",
                                            style: GoogleFonts.poppins(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w500),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const Spacer(),
                                          Text(
                                            "|",
                                            style: GoogleFonts.poppins(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w900),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const Spacer(),
                                          Text(
                                            "amount".tr,
                                            style: GoogleFonts.poppins(
                                                fontSize: 10,
                                                color: const Color(0xff1272D3),
                                                fontWeight: FontWeight.w500),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Text(
                                            " ${hstry.totalAppointmentFee.toString().split('.')[0]}",
                                            style: GoogleFonts.poppins(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w500),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const Spacer(),
                                          Text(
                                            "|",
                                            style: GoogleFonts.poppins(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w900),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const Spacer(),
                                          Container(
                                            padding: const EdgeInsets.all(6)
                                                .copyWith(left: 25, right: 25),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
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
                                        height: Get.height * 0.01,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          hstry.eXRURL != null
                                              ? InkWell(
                                                  onTap: () {
                                                    Get.to(
                                                      () => PdfViewerPage(
                                                        url: hstry.eXRURL,
                                                        testName:
                                                            hstry.patientName,
                                                      ),
                                                    );
                                                  },
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            AppPadding.p10),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color: const Color(
                                                            0xff1272D3)),
                                                    child: Center(
                                                        child: Text(
                                                      "report/desc".tr,
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
                                              : InkWell(
                                                  child: Container(
                                                    width: Get.width * 0.33,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color: const Color
                                                            .fromARGB(
                                                            255, 86, 165, 245)),
                                                    height: Get.height * 0.06,
                                                    child: Center(
                                                        child: Text(
                                                      "report/desc".tr,
                                                      style:
                                                          GoogleFonts.poppins(
                                                        color: Colors.white,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    )),
                                                  ),
                                                ),
                                          hstry.status
                                                          .toString()
                                                          .toLowerCase()
                                                          .trim() ==
                                                      "completed" &&
                                                  hstry.invoiceURL != null
                                              ? InkWell(
                                                  onTap: () {
                                                    Get.to(() => PdfViewerPage(
                                                          testName:
                                                              hstry.patientName,
                                                          url: hstry.invoiceURL,
                                                        ));
                                                  },
                                                  child: Container(
                                                    width: Get.width * 0.2,
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
                                                  width: Get.width * 0.2,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color:
                                                          const Color.fromARGB(
                                                              255,
                                                              100,
                                                              166,
                                                              233)),
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
                                          int.parse(hstry.paymentStatusValue) !=
                                                      0 &&
                                                  int.parse(hstry
                                                          .paymentStatusValue) !=
                                                      3
                                              ? InkWell(
                                                  onTap: () async {
                                                    await redundingdialogue(
                                                        hstry);
                                                  },
                                                  child: Container(
                                                    width: Get.width * 0.2,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color: const Color(
                                                            0xffFFB800)),
                                                    height: Get.height * 0.06,
                                                    child: Center(
                                                        child: Text(
                                                      "refund".tr,
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
                                              : InkWell(
                                                  onTap: () {},
                                                  child: Container(
                                                    width: Get.width * 0.2,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color: const Color
                                                            .fromARGB(
                                                            255, 246, 204, 96)),
                                                    height: Get.height * 0.06,
                                                    child: Center(
                                                        child: Text(
                                                      "refund".tr,
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
                                        ],
                                      )
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
                                            height: Get.height * 0.15,
                                            width: Get.height * 0.15,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color:
                                                    ColorManager.kPrimaryColor,
                                                width: 3,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: hstry.picturePath != null
                                                ? ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    child: CachedNetworkImage(
                                                      imageUrl:
                                                          '${containsFile(hstry.picturePath!)}/${hstry.picturePath}',
                                                      fit: BoxFit.cover,
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          Image.asset(
                                                        hstry.pickupAddress ==
                                                                null
                                                            ? Images
                                                                .doctorAvatar
                                                            : Images.bike,
                                                        fit: BoxFit.fitHeight,
                                                      ),
                                                    ),
                                                  )
                                                : Image.asset(
                                                    hstry.pickupAddress == null
                                                        ? Images.doctorAvatar
                                                        : Images.bike),
                                          ),
                                          SizedBox(
                                            width: Get.width * 0.03,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.all(5)
                                                    .copyWith(
                                                        left: 10, right: 10),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
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
                                                    hstry.status,
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
                                                height: Get.height * 0.01,
                                              ),
                                              Text(
                                                hstry.prescribedBy
                                                    .toString()
                                                    .trim(),
                                                style: GoogleFonts.poppins(
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w700),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              const Divider(
                                                color: Colors.black,
                                                height: 1,
                                              ),
                                              Text(
                                                hstry.appointmentCategoryName,
                                                style: GoogleFonts.poppins(
                                                    fontSize: 10,
                                                    fontWeight:
                                                        FontWeight.w400),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Text(
                                                "${formatdate("${hstry.bookingDate.toString().split('T')[0]} ${hstry.bookingDate.toString().split('T')[1]}")} ${hstry.time.toString().split(':')[0]}:${hstry.time.toString().split(':')[1]}:${int.parse(hstry.time.toString().split(':')[0].toString()) > 11 ? "AM" : "PM"}",
                                                style: GoogleFonts.poppins(
                                                    fontSize: 10,
                                                    fontWeight:
                                                        FontWeight.w400),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
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
                                            "${'apptno'.tr} ${hstry.labNo} ",
                                            style: GoogleFonts.poppins(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w400),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(
                                            height: 15,
                                            child: VerticalDivider(
                                              color: ColorManager.kblackColor,
                                              indent: 2,
                                              endIndent: 2,
                                              width: 10,
                                            ),
                                          ),
                                          Text(
                                            "amount".tr,
                                            style: GoogleFonts.poppins(
                                                fontSize: 10,
                                                color: const Color(0xff1272D3),
                                                fontWeight: FontWeight.w400),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Text(
                                            " ${hstry.totalAppointmentFee.toString().split('.')[0]}",
                                            style: GoogleFonts.poppins(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w500),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(
                                            height: 15,
                                            child: VerticalDivider(
                                              color: ColorManager.kblackColor,
                                              indent: 2,
                                              endIndent: 2,
                                              width: 10,
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.all(
                                                    AppPadding.p8)
                                                .copyWith(
                                              left: 20,
                                              right: 20,
                                            ),
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
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
                                                    color: const Color(
                                                        0xffFFFFFF)),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: Get.height * 0.01,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          hstry.eXRURL != null &&
                                                  hstry.status
                                                          .toString()
                                                          .toLowerCase()
                                                          .trim() ==
                                                      "completed"
                                              ? InkWell(
                                                  onTap: () {
                                                    Get.to(
                                                      () => PdfViewerPage(
                                                        url: hstry.eXRURL,
                                                        testName:
                                                            hstry.patientName,
                                                      ),
                                                    );
                                                  },
                                                  child: Container(
                                                    width: Get.width * 0.33,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color: const Color(
                                                            0xff1272D3)),
                                                    height: Get.height * 0.06,
                                                    child: Center(
                                                        child: Text(
                                                      "report/desc".tr,
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
                                              : InkWell(
                                                  child: Container(
                                                    width: Get.width * 0.33,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color: const Color
                                                            .fromARGB(
                                                            255, 86, 165, 245)),
                                                    height: Get.height * 0.06,
                                                    child: Center(
                                                        child: Text(
                                                      "report/desc".tr,
                                                      style:
                                                          GoogleFonts.poppins(
                                                        color: Colors.white,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    )),
                                                  ),
                                                ),
                                          hstry.status
                                                          .toString()
                                                          .toLowerCase()
                                                          .trim() ==
                                                      "completed" &&
                                                  hstry.invoiceURL != null
                                              ? InkWell(
                                                  onTap: () {
                                                    Get.to(() => PdfViewerPage(
                                                          testName:
                                                              hstry.patientName,
                                                          url: hstry.invoiceURL,
                                                        ));
                                                  },
                                                  child: Container(
                                                    width: Get.width * 0.2,
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
                                                  width: Get.width * 0.2,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color:
                                                          const Color.fromARGB(
                                                              255,
                                                              88,
                                                              164,
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
                                          int.parse(hstry.paymentStatusValue) !=
                                                      0 &&
                                                  int.parse(hstry
                                                          .paymentStatusValue) !=
                                                      3
                                              ? InkWell(
                                                  onTap: () async {
                                                    await redundingdialogue(
                                                        hstry);
                                                  },
                                                  child: Container(
                                                    width: Get.width * 0.2,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color: const Color(
                                                            0xffFFB800)),
                                                    height: Get.height * 0.06,
                                                    child: Center(
                                                        child: Text(
                                                      "refund".tr,
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
                                              : InkWell(
                                                  onTap: () {},
                                                  child: Container(
                                                    width: Get.width * 0.2,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color: const Color
                                                            .fromARGB(
                                                            255, 246, 204, 96)),
                                                    height: Get.height * 0.06,
                                                    child: Center(
                                                        child: Text(
                                                      "refund".tr,
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
                                        ],
                                      )
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

  redundingdialogue(HistoryResponseBody hstry) async {
    String? patientid = await LocalDb().getPatientId();
    String? branchid = await LocalDb().getBranchId();
    await showDialog(
        useSafeArea: true,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
            contentPadding: const EdgeInsets.only(top: 10.0),
            content: SizedBox(
              width: 300.0,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Center(
                      child: Text("Apply Refunding"),
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    const Divider(
                      color: Colors.grey,
                      height: 4.0,
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                      child: TextFormField(
                        controller: controller,
                        decoration: const InputDecoration(
                          focusedBorder: InputBorder.none,
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1, color: Colors.black)),
                          disabledBorder: InputBorder.none,
                          hintText: "Remarks",
                          border: InputBorder.none,
                        ),
                        maxLines: 4,
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    const Divider(
                      color: Colors.grey,
                      height: 4.0,
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    InkWell(
                      onTap: () async {
                        await patientrepo()
                            .refundapi(
                              Refundbody(
                                patientId: patientid.toString(),
                                branchId: branchid.toString(),
                                typeBit: hstry.typeBit.toString(),
                                remarks: controller.text.toString(),
                                bookingNo: hstry.labTestChallanNo.toString(),
                                appointmentNo: hstry.labNo.toString(),
                              ),
                            )
                            .then(
                              (value) => Get.back(),
                            )
                            .onError((error, stackTrace) {
                          ToastManager.showToast(error.toString());
                          controller = TextEditingController();
                          Get.back();
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                        decoration: const BoxDecoration(
                          color: ColorManager.kPrimaryColor,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(32.0),
                              bottomRight: Radius.circular(32.0)),
                        ),
                        child: const Text(
                          "Apply Refund",
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
