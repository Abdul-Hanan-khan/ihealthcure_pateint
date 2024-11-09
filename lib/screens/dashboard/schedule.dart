// ignore_for_file: non_constant_identifier_names, prefer_final_fields, unused_local_variable, camel_case_types, body_might_complete_normally_nullable
import 'dart:developer';
import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tabib_al_bait/components/appoint_ment_card/appointment_cards.dart';
import 'package:tabib_al_bait/components/custom_textfields.dart';
import 'package:tabib_al_bait/components/images.dart';
import 'package:tabib_al_bait/helpers/values_manager.dart';
import 'package:tabib_al_bait/models/DoctorConsultationAppointmentHistory.dart';
import 'package:tabib_al_bait/models/UpComingLabInvestigation.dart';
import 'package:tabib_al_bait/models/UpcomingDiagnosticAppointment.dart';
import 'package:tabib_al_bait/models/appointments_history/appointments_history.dart';
import 'package:tabib_al_bait/screens/family_screens/family_members.dart';
import '../../data/controller/schedule_controller.dart';
import '../../helpers/color_manager.dart';
import '../../models/services_model.dart';

int? selected;

class ScheduledAppointments extends StatefulWidget {
  final bool? isSchedule;
  const ScheduledAppointments({super.key, this.isSchedule = false});

  @override
  State<ScheduledAppointments> createState() => _ScheduledAppointmentsState();
}

class _ScheduledAppointmentsState extends State<ScheduledAppointments> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScheduleController.i.updateSelectedService(1);
    });

    super.initState();
  }

  @override
  void dispose() {
    ScheduleController.i.updateSelectedService(-1);
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var contr = Get.put<ScheduleController>(ScheduleController());
    contr.appointmentList = [
      Services(
          title: 'homeServices'.tr,
          imagePath: Images.services,
          color: ColorManager.kPrimaryColor,
          onPressed: () {
            ScheduleController.i.ApplyFilterForAppointments(
              -1,
            );
            ScheduleController.i.getAppointmentsList("");
            ScheduleController.i.updateSelectedService(0);
          }),
      Services(
          title: 'labInvestions'.tr,
          imagePath: Images.microscope,
          color: ColorManager.kyellowContainer,
          onPressed: () {
            ScheduleController.i.ApplyFilterForAppointments(3);
            ScheduleController.i.updateSelectedService(1);
          }),
      Services(
          title: 'imaging'.tr,
          imagePath: Images.imaging,
          color: const Color.fromARGB(255, 9, 210, 190),
          onPressed: () {
            ScheduleController.i.ApplyFilterForAppointments(2);
            ScheduleController.i.updateSelectedService(2);
          }),
      Services(
          title: 'doctorConsultation'.tr,
          imagePath: 'assets/images/docImage.png',
          color: ColorManager.kPrimaryColor,
          onPressed: () {
            ScheduleController.i.ApplyFilterForAppointments(1);
            ScheduleController.i.updateSelectedService(3);
          }),
    ];
    return DefaultTabController(
        length: 4,
        child: GetBuilder<ScheduleController>(builder: (cont) {
          return Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(50),
                child: CustomAppBar(
                  title: 'myAppointments'.tr,
                  isScheduleScreen: true,
                ),
              ),
              body: BlurryModalProgressHUD(
                  inAsyncCall: ScheduleController.i.isLoading,
                  blurEffectIntensity: 4,
                  progressIndicator: const SpinKitSpinningLines(
                    color: Color(0xff1272d3),
                    size: 60,
                  ),
                  dismissible: false,
                  opacity: 0.4,
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: AppPadding.p10,
                        left: AppPadding.p20,
                        right: AppPadding.p20),
                    child: Column(
                      children: [
                        SizedBox(
                          height: Get.height * 0.12,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                              // physics: const NeverScrollableScrollPhysics(),
                              itemCount: contr.appointmentList.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    // log('hiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii');
                                    // // cont.updateSelectedService(index);
                                    // log("the selected tab is : ${cont.selectedService.toString()}");
                                  },
                                  child: ServiceWidget(
                                      index: index,
                                      service: contr.appointmentList[index]),
                                );
                              }),
                        ),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        ScheduleController.i.appointmentTypeFilter != 0
                            ? CustomTextField(
                                prefixIcon: const Icon(
                                  Icons.search,
                                  color: ColorManager.kPrimaryColor,
                                ),
                                controller: controller,
                                hintText: hintText(),
                                onchanged: (p0) {
                                  Future.delayed(
                                      const Duration(
                                        milliseconds: 2000,
                                      ), () async {
                                    if (ScheduleController
                                            .i.appointmentTypeFilter ==
                                        -1) {
                                      ScheduleController.i
                                          .getAppointmentsList(p0);
                                    } else if (ScheduleController
                                            .i.appointmentTypeFilter ==
                                        1) {
                                      ScheduleController.i.clearData();
                                      ScheduleController.i
                                          .getUpcomingAppointment(p0, true);
                                    } else if (ScheduleController
                                            .i.appointmentTypeFilter ==
                                        2) {
                                      ScheduleController.i.clearData();
                                      ScheduleController.i
                                          .getUpcomingAppointment(p0, true);
                                    } else if (ScheduleController
                                            .i.appointmentTypeFilter ==
                                        3) {
                                      ScheduleController.i.clearData();
                                      ScheduleController.i
                                          .getUpcomingAppointment(p0, true);
                                    }
                                  });
                                },
                              )
                            : const SizedBox.shrink(),
                        if (ScheduleController.i.appointmentTypeFilter == 0)
                          Flexible(
                            child: SizedBox(
                                child: buildAppointmentsList(
                                    context, cont.appointmentsSummery)),
                          ),
                        if (ScheduleController.i.appointmentTypeFilter !=
                            0) ...[
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.08,
                            child: Column(children: [
                              TabBar(
                                physics: const NeverScrollableScrollPhysics(),
                                isScrollable: false,
                                unselectedLabelColor: ColorManager.kGreyColor,
                                labelColor: ColorManager.kPrimaryColor,
                                unselectedLabelStyle: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                        color: ColorManager.kGreyColor,
                                        fontWeight: FontWeight.w900,
                                        fontSize: 10),
                                labelStyle: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                        color: ColorManager.kPrimaryColor,
                                        fontWeight: FontWeight.w900,
                                        fontSize: 12),
                                indicator: const UnderlineTabIndicator(
                                    borderSide: BorderSide(
                                      width: 2,
                                      color: Colors.blue,
                                    ),
                                    insets: EdgeInsets.only(left: 0, right: 0)),
                                indicatorSize: TabBarIndicatorSize.tab,
                                onTap: (index) {
                                  if (index == 0) {
                                    ScheduleController.i
                                        .updateSelectedTab("Upcoming");
                                  } else if (index == 1) {
                                    ScheduleController.i
                                        .updateSelectedTab("Completed");
                                  } else if (index == 2) {
                                    ScheduleController.i
                                        .updateSelectedTab("OverDue");
                                  } else if (index == 3) {
                                    ScheduleController.i
                                        .updateSelectedTab("Cancelled");
                                  }
                                  FocusScope.of(context).unfocus();
                                  log(index.toString());
                                  if (ScheduleController
                                          .i.appointmentTypeFilter ==
                                      -1) {
                                    ScheduleController.i
                                        .getAppointmentsList("");
                                  }
                                },
                                tabs: [
                                  FittedBox(
                                    child: Tab(
                                      iconMargin: EdgeInsets.zero,
                                      child: Text(
                                        'upcoming'.tr,
                                      ),
                                    ),
                                  ),
                                  FittedBox(
                                    child: Tab(
                                      iconMargin: EdgeInsets.zero,
                                      child: Text(
                                        'completed'.tr,
                                      ),
                                    ),
                                  ),
                                  FittedBox(
                                    child: Tab(
                                      iconMargin: EdgeInsets.zero,
                                      child: Text(
                                        'pending'.tr,
                                      ),
                                    ),
                                  ),
                                  FittedBox(
                                    child: Tab(
                                      iconMargin: EdgeInsets.zero,
                                      child: Text(
                                        'cancelled'.tr,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(
                                height: 1.5,
                                color: ColorManager.kGreyColor,
                              ),
                            ]),
                          ),
                          const Expanded(
                            child: TabBarView(
                                physics: NeverScrollableScrollPhysics(),
                                children: [
                                  UpcomingAppointments(
                                    status: "Upcomming",
                                  ),
                                  CancelledAppointments(
                                    appointmentType: 'Completed',
                                  ), //pass here a veriable Compelted
                                  pendingappointments(
                                    status: "Overdue",
                                  ),
                                  CancelledAppointments(
                                    appointmentType: 'Cancelled',
                                  ) //pass here a veriable Cancel
                                ]),
                          ),
                        ],
                      ],
                    ),
                    // const CustomTextField(
                    //   hintText: 'Search',
                    //   prefixIcon: Icon(
                    //     Icons.search,
                    //     color: ColorManager.kPrimaryColor,
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: Get.height * 0.02,
                    // ),
                    // buildAppointmentsList(
                    //     context, ScheduleController.i.appointmentsHistory),
                  )));
        }));
  }
}

class ServiceWidget extends StatefulWidget {
  final int? index;
  final double? width;
  final double? height;
  const ServiceWidget({
    this.index,
    super.key,
    required this.service,
    this.width,
    this.height,
  });

  final Services service;

  @override
  State<ServiceWidget> createState() => _ServiceWidgetState();
}

class _ServiceWidgetState extends State<ServiceWidget> {
  int? selectedIndex;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: ScheduleController.i.selectedService == widget.index ||
              ScheduleController.i.selectedService == selected
          ? 1.0
          : 0.4,
      child: SizedBox(
        height: widget.height ?? Get.height * 0.12,
        width: widget.width ?? Get.width * 0.25,
        child: InkWell(
          onTap: widget.service.onPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: widget.service.color,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      widget.service.imagePath!,
                      height: Get.height * 0.04,
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    Text(widget.service.title!,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: ColorManager.kWhiteColor,
                            fontSize: 10,
                            fontWeight: FontWeight.w900)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CancelledAppointments extends StatefulWidget {
  final String? appointmentType;
  final String? serviceAppointmentType;
  const CancelledAppointments(
      {super.key, this.appointmentType, this.serviceAppointmentType});

  @override
  State<CancelledAppointments> createState() => _CancelledAppointmentsState();
}

class _CancelledAppointmentsState extends State<CancelledAppointments> {
  ScrollController _scrollControllerhistory = ScrollController();
  bool? value = false;

  @override
  void didUpdateWidget(covariant CancelledAppointments oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    ScheduleController.i.changeStatusofOpenedTab(false);
    ScheduleController.i.clearData();
    ScheduleController.i
        .getHistoryAppointment("", appointmentType: widget.appointmentType);
    // ScheduleController.i.getAppointmentsList('');

    //when scroll page
    _scrollControllerhistory.addListener(() {
      // var nextPageTrigger = 0.8 * _scrollController.position.maxScrollExtent;
      if (_scrollControllerhistory.position.pixels ==
          _scrollControllerhistory.position.maxScrollExtent) {
        var isCallToFetchData = ScheduleController.i
            .SetStartToFetchNextDataForHistoryAppoiontments();
        if (isCallToFetchData) {
          ScheduleController.i.getHistoryAppointment("",
              appointmentType: widget.appointmentType);
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var contr = Get.put<ScheduleController>(ScheduleController());
    return Scaffold(body: GetBuilder<ScheduleController>(builder: (cont) {
      return RefreshIndicator(
        onRefresh: () {
          return ScheduleController.i.getHistoryAppointment("",
              appointmentType: widget.appointmentType);
        },
        child: BlurryModalProgressHUD(
            inAsyncCall: ScheduleController.i.isLoadingHistory,
            blurEffectIntensity: 4,
            progressIndicator: const SpinKitSpinningLines(
              color: Color(0xff1272d3),
              size: 60,
            ),
            dismissible: false,
            opacity: 0.4,
            color: Theme.of(context).scaffoldBackgroundColor,
            child: ((ScheduleController.i.list.isNotEmpty &&
                    ScheduleController.i.appointmentTypeFilter == -1 &&
                    ScheduleController.i.list
                        .where((element) =>
                            element.status == widget.appointmentType &&
                            element.appointmentCategoryName !=
                                'Lab Investigations')
                        .toList()
                        .isNotEmpty))
                ? ListView.builder(
                    controller: _scrollControllerhistory,
                    physics: const AlwaysScrollableScrollPhysics(),
                    //physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: ScheduleController.i.list.length,
                    itemBuilder: (context, index) {
                      var list = ScheduleController.i.list[index];
                      return list.status == widget.appointmentType &&
                              list.appointmentCategoryName !=
                                  'Lab Investigations'
                          ? ServicesAppointmentsCards(
                              listData: list,
                              showButtons: false,
                              onBookAgainPressed: () {},
                              onLeaveReviewPressed: () {},
                            )
                          : const SizedBox.shrink();
                    })
                : ((ScheduleController.i.doctorConsultationAppointmentHistoryDataList.isNotEmpty) &&
                        ScheduleController.i.appointmentTypeFilter == 1 &&
                        ScheduleController
                            .i.doctorConsultationAppointmentHistoryDataList
                            .where((element) =>
                                element.Status! == widget.appointmentType)
                            .toList()
                            .isNotEmpty)
                    ? ListView.builder(
                        controller: _scrollControllerhistory,
                        physics: const AlwaysScrollableScrollPhysics(),
                        //physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: ScheduleController
                            .i
                            .doctorConsultationAppointmentHistoryDataList
                            .length,
                        itemBuilder: (context, index) {
                          var list = ScheduleController.i
                                  .doctorConsultationAppointmentHistoryDataList[
                              index];
                          return DoctorsAppointmentCards(
                            list: list,
                            statusText: cont
                                .doctorConsultationAppointmentHistoryDataList[
                                    index]
                                .Status
                                .toString(),
                            statusColor: Colors.green,
                            name: cont
                                .doctorConsultationAppointmentHistoryDataList[
                                    index]
                                .DoctorName
                                .toString(),
                            date: cont
                                .doctorConsultationAppointmentHistoryDataList[
                                    index]
                                .BookingDate!
                                .split('T')
                                .first,
                            time: cont
                                .doctorConsultationAppointmentHistoryDataList[
                                    index]
                                .BookingDate!
                                .split('T')[1]
                                .toString(),
                            type: '',
                            rating: cont
                                .doctorConsultationAppointmentHistoryDataList[
                                    index]
                                .Monday
                                .toString(),
                            showButtons: false,
                            onBookAgainPressed: () {},
                            onLeaveReviewPressed: () {},
                            Address: cont
                                .doctorConsultationAppointmentHistoryDataList[
                                    index]
                                .Address,
                            Designation: cont
                                .doctorConsultationAppointmentHistoryDataList[
                                    index]
                                .Designation,
                          );
                        })
                    : ((ScheduleController.i.doctorConsultationAppointmentHistoryDataList.isEmpty) &&
                            ScheduleController.i.appointmentTypeFilter == 1)
                        ? Center(
                            child: Text(
                              'noDataFound'.tr,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                      color: ColorManager.kblackColor,
                                      // fontWeight: FontWeight.w900,
                                      fontSize: 13),
                            ),
                          )
                        : ((ScheduleController.i.diagnosticAppointmentHistoryDataList.isNotEmpty) &&
                                ScheduleController.i.appointmentTypeFilter == 2)
                            ? ListView.builder(
                                controller: _scrollControllerhistory,
                                physics: const AlwaysScrollableScrollPhysics(),
                                //physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: ScheduleController
                                    .i
                                    .diagnosticAppointmentHistoryDataList
                                    .length,
                                itemBuilder: (context, index) {
                                  var DiagnosticName = ScheduleController.i
                                          .diagnosticAppointmentHistoryDataList[
                                      index];

                                  if (DiagnosticName.Status ==
                                      widget.appointmentType) {
                                    return ImaginBookingCard(
                                        listData: DiagnositicAppointmentListData(
                                            Id: DiagnosticName.Id,
                                            DiagnosticId:
                                                DiagnosticName.DiagnosticId,
                                            Status: DiagnosticName.Status,
                                            DiagnosticCenter:
                                                DiagnosticName.DiagnosticCenter,
                                            BookingTime:
                                                DiagnosticName.BookingTime,
                                            AppointmentDate:
                                                DiagnosticName.AppointmentDate,
                                            DiagnosticName:
                                                DiagnosticName.DiagnosticName),
                                        isCountingShown: false,
                                        statusText:
                                            (ScheduleController.i.diagnosticAppointmentHistoryDataList[index].Status) ??
                                                '',
                                        statusColor: Colors.red,
                                        name: (ScheduleController
                                                .i
                                                .diagnosticAppointmentHistoryDataList[
                                                    index]
                                                .PrescribedByDoctor) ??
                                            '',
                                        date: (ScheduleController
                                                .i
                                                .diagnosticAppointmentHistoryDataList[
                                                    index]
                                                .AppointmentDate) ??
                                            '',
                                        time: (ScheduleController.i.diagnosticAppointmentHistoryDataList[index].BookingTime) ??
                                            '',
                                        type: '',
                                        rating: '',
                                        ReportStatus: (ScheduleController
                                            .i
                                            .diagnosticAppointmentHistoryDataList[index]
                                            .Status),
                                        showReportStatusAtEnd: true,
                                        showButtons: false,
                                        address: (ScheduleController.i.diagnosticAppointmentHistoryDataList[index].DiagnosticCenter),
                                        firstButtonName: 'Reschedule',
                                        secondButtonName: 'Cancel',
                                        onBookAgainPressed: () {},
                                        onLeaveReviewPressed: () {});
                                  }
                                })
                            : ((ScheduleController.i.diagnosticAppointmentHistoryDataList.isEmpty) &&
                                    ScheduleController.i.appointmentTypeFilter == 2)
                                ? Center(
                                    child: Text(
                                      'noDataFound'.tr,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                              color: ColorManager.kblackColor,
                                              // fontWeight: FontWeight.w900,
                                              fontSize: 13),
                                    ),
                                  )
                                : ((ScheduleController.i.labInvestigationAppointmentHistoryDataList.isNotEmpty) && ScheduleController.i.appointmentTypeFilter == 3)
                                    ? ListView.builder(
                                        controller: _scrollControllerhistory,
                                        physics: const AlwaysScrollableScrollPhysics(),
                                        //physics: const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: ScheduleController.i.labInvestigationAppointmentHistoryDataList.length,
                                        itemBuilder: (context, index) {
                                          return LabInvestigationAppointmentCards(
                                              listData: UpComingLabIvestigationDataList(
                                                  Status: ScheduleController
                                                      .i
                                                      .labInvestigationAppointmentHistoryDataList[
                                                          index]
                                                      .Status,
                                                  StatusValue: ScheduleController
                                                      .i
                                                      .labInvestigationAppointmentHistoryDataList[
                                                          index]
                                                      .StatusValue,
                                                  PrescribedBy: ScheduleController
                                                      .i
                                                      .labInvestigationAppointmentHistoryDataList[
                                                          index]
                                                      .PrescribedBy,
                                                  Date: ScheduleController
                                                      .i
                                                      .labInvestigationAppointmentHistoryDataList[
                                                          index]
                                                      .Date
                                                      .toString(),
                                                  Time:
                                                      ScheduleController.i.labInvestigationAppointmentHistoryDataList[index].Time
                                                          .toString(),
                                                  LabId: ScheduleController
                                                      .i
                                                      .labInvestigationAppointmentHistoryDataList[
                                                          index]
                                                      .LabId,
                                                  LabNO: ScheduleController
                                                      .i
                                                      .labInvestigationAppointmentHistoryDataList[
                                                          index]
                                                      .LabNO,
                                                  Longitude: ScheduleController
                                                      .i
                                                      .labInvestigationAppointmentHistoryDataList[
                                                          index]
                                                      .Longitude,
                                                  Latitude: ScheduleController
                                                      .i
                                                      .labInvestigationAppointmentHistoryDataList[index]
                                                      .Latitude,
                                                  PickupAddress: ScheduleController.i.labInvestigationAppointmentHistoryDataList[index].PickupAddress,
                                                  LabLocation: ScheduleController.i.labInvestigationAppointmentHistoryDataList[index].LabLocation,
                                                  LabTests: ScheduleController.i.labInvestigationAppointmentHistoryDataList[index].LabTestList),
                                              list: ScheduleController.i.labInvestigationAppointmentHistoryDataList[index].LabTestList,
                                              isTestsListisInstanceofList: true,
                                              statusText: ScheduleController.i.labInvestigationAppointmentHistoryDataList[index].AppointmentStatus ?? '',
                                              statusColor: Colors.red,
                                              name: ScheduleController.i.labInvestigationAppointmentHistoryDataList[index].LabName!,
                                              date: ScheduleController.i.labInvestigationAppointmentHistoryDataList[index].Date.toString(),
                                              time: ScheduleController.i.labInvestigationAppointmentHistoryDataList[index].Time.toString(),
                                              type: '',
                                              rating: '',
                                              showButtons: false,
                                              address: ScheduleController.i.labInvestigationAppointmentHistoryDataList[index].LabName,
                                              firstButtonName: 'Reschedule',
                                              secondButtonName: 'Cancel',
                                              onBookAgainPressed: () {},
                                              onLeaveReviewPressed: () {});
                                        })
                                    : ((ScheduleController.i.labInvestigationAppointmentHistoryDataList.isEmpty) && ScheduleController.i.appointmentTypeFilter == 3)
                                        ? Center(
                                            child: Text(
                                              'noDataFound'.tr,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium
                                                  ?.copyWith(
                                                      color: ColorManager
                                                          .kblackColor,
                                                      // fontWeight: FontWeight.w900,
                                                      fontSize: 13),
                                            ),
                                          )
                                        : Center(
                                            child: Text(
                                              'noDataFound'.tr,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium
                                                  ?.copyWith(
                                                      color: ColorManager
                                                          .kblackColor,
                                                      // fontWeight: FontWeight.w900,
                                                      fontSize: 13),
                                            ),
                                          )),
      );
    }));
  }
}

buildAppointmentsList(
    BuildContext context, List<AppointmentsHistory> appointmentDataList) {
  return (appointmentDataList.isNotEmpty)
      ? RefreshIndicator(
          onRefresh: () {
            return ScheduleController.i.getAppointmentsSummery();
          },
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            //physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: appointmentDataList.length,
            itemBuilder: (context, index) {
              if (appointmentDataList[index].appointmentType == 1) {
                var list = appointmentDataList[index];
                return DoctorsAppointmentCards(
                    list: DoctorConsultationAppointmentHistoryDataList(
                        WorkLocation: list.workLocation,
                        Address: list.cityName,
                        PatientName: list.patientName,
                        DoctorName: list.name,
                        Status: list.status,
                        Id: list.id,
                        PatientAppointmentId: list.patientAppointmentId,
                        DoctorId: list.doctorId,
                        WorkLocationId: list.workLocationId,
                        SessionId: list.sessionId,
                        StartTime: list.startTime,
                        EndTime: list.endTime,
                        AppointmentDate: list.appointmentDate,
                        IsOnlineAppointment: list.isOnlineAppointment,
                        IsOnlineConsultation: list.isOnlineConsultation,
                        SlotTokenNumber: list.slotTokenNumber,
                        AppointmentSlotDisplayType:
                            list.appointmentSlotDisplayType,
                        BookingDate: list.bookingDate),
                    statusText: appointmentDataList[index].status.toString(),
                    statusColor: Colors.green,
                    name: appointmentDataList[index].name!,
                    date: (appointmentDataList[index].appointmentDate) ?? '',
                    // date:
                    //     appointmentDataList[index].bookingDate!.split('T').first,
                    time: appointmentDataList[index].startTime!,
                    type: appointmentDataList[index].endTime!,
                    rating: appointmentDataList[index].monday.toString(),
                    showButtons: false,
                    onBookAgainPressed: () {},
                    onLeaveReviewPressed: () {});
              } else if (appointmentDataList[index].appointmentType == 2) {
                var diagnosticsname = appointmentDataList[index].name;
                var list = appointmentDataList[index];

                return ImaginBookingCard(
                    listData: DiagnositicAppointmentListData(
                        Id: list.id,
                        DiagnosticCenterId: list.diagnosticCenterId,
                        PatientDiagnosticAppointmentId:
                            list.patientAppointmentId,
                        DiagnosticId: list.id,
                        DiagnosticName: list.name,
                        AppointmentDate: list.appointmentDate,
                        PatientName: list.patientName,
                        DiagnosticCenter: list.workLocation,
                        Status: list.status,
                        BookingTime: list.startTime,
                        Location: list.location),
                    // list: ['$diagnosticsname'],
                    isCountingShown: false,
                    statusText: (appointmentDataList[index].status) ?? '',
                    statusColor: Colors.red,
                    name: (appointmentDataList[index].prescribedByDoctor) ?? '',
                    date: (appointmentDataList[index].appointmentDate) ?? '',
                    time: (appointmentDataList[index].startTime) ?? '',
                    type: '',
                    rating: '',
                    ReportStatus: (appointmentDataList[index].status),
                    showReportStatusAtEnd: false,
                    showButtons: false,
                    address: (appointmentDataList[index].workLocation),
                    firstButtonName: 'reschedule'.tr,
                    secondButtonName: 'cancel'.tr,
                    onBookAgainPressed: () {},
                    onLeaveReviewPressed: () {});
              } else if (appointmentDataList[index].appointmentType == 3) {
                var list = appointmentDataList[index];
                return LabInvestigationAppointmentCards(
                    listData: UpComingLabIvestigationDataList(
                        Longitude: list.longitude,
                        Latitude: list.latitude,
                        PickupAddress: list.pickupAddress,
                        CityName: list.cityName,
                        Status: list.status,
                        PackageGroupId: list.packageGroupId,
                        PackageGroupDiscountRate: list.packageGroupDiscountRate,
                        PackageGroupDiscountType: list.packageGroupDiscountType,
                        Time: list.startTime,
                        LabId: list.labId,
                        LabNO: list.labNo,
                        Date: list.bookingDate,
                        PatientId: list.patientId,
                        LabTests: list.labTests,
                        LabTestList: list.labTests),
                    list: appointmentDataList[index].labTests,
                    statusText: appointmentDataList[index].status ?? '',
                    statusColor: Colors.red,
                    name: appointmentDataList[index].prescribedByDoctor!,
                    date: (appointmentDataList[index].appointmentDate) ?? '',
                    // date:
                    //     appointmentDataList[index].bookingDate!.split('T').first,
                    time: (appointmentDataList[index].startTime) ?? '',
                    type: '',
                    rating: '',
                    showButtons: true,
                    address: appointmentDataList[index].workLocation,
                    firstButtonName: 'reschedule'.tr,
                    secondButtonName: 'cancel'.tr,
                    onBookAgainPressed: () {},
                    onLeaveReviewPressed: () {});
              } else {
                return Container();
              }
            },
          ),
        )
      : Center(
          child: Text(
            'norecordfound'.tr,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: ColorManager.kblackColor,
                // fontWeight: FontWeight.w900,
                fontSize: 13),
          ),
        );
}

class pendingappointments extends StatefulWidget {
  final String? status;
  const pendingappointments({super.key, this.status});

  @override
  State<pendingappointments> createState() => _pendingappointmentsState();
}

class _pendingappointmentsState extends State<pendingappointments> {
  ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    ScheduleController.i.changeStatusofOpenedTab(true);
    ScheduleController.i.clearData();
    ScheduleController.i
        .getHistoryAppointment("", appointmentType: widget.status);
    ScheduleController.i.getUpcomingAppointment("", true);

    //when scroll page
    _scrollController.addListener(() {
      // var nextPageTrigger = 0.8 * _scrollController.position.maxScrollExtent;
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        var isCallToFetchData = ScheduleController.i
            .SetStartToFetchNextDataForComingAppoiontments();
        if (isCallToFetchData) {
          ScheduleController.i
              .getHistoryAppointment("", appointmentType: widget.status);
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var contr = Get.put<ScheduleController>(ScheduleController());
    return Scaffold(body: GetBuilder<ScheduleController>(builder: (cont) {
      return RefreshIndicator(
        onRefresh: () {
          ScheduleController.i.changeStatusofOpenedTab(false);
          ScheduleController.i.clearData();
          return ScheduleController.i
              .getHistoryAppointment("", appointmentType: widget.status);
          ;
        },
        child: BlurryModalProgressHUD(
            inAsyncCall: ScheduleController.i.isLoadingUpcoming,
            blurEffectIntensity: 4,
            progressIndicator: const SpinKitSpinningLines(
              color: Color(0xff1272d3),
              size: 60,
            ),
            dismissible: false,
            opacity: 0.4,
            color: Theme.of(context).scaffoldBackgroundColor,
            child: ((ScheduleController.i.list.isNotEmpty &&
                    ScheduleController.i.appointmentTypeFilter == -1 &&
                    ScheduleController.i.list
                        .where((element) =>
                            element.appointmentStatus! == widget.status)
                        .toList()
                        .isNotEmpty))
                ? ListView.builder(
                    controller: _scrollController,
                    physics: const AlwaysScrollableScrollPhysics(),
                    //physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: ScheduleController.i.list.length,
                    itemBuilder: (context, index) {
                      var list = ScheduleController.i.list[index];
                      return list.appointmentStatus == widget.status
                          ? ServicesAppointmentsCards(
                              listData: list,
                              showButtons: false,
                              onBookAgainPressed: () {},
                              onLeaveReviewPressed: () {},
                            )
                          : const SizedBox.shrink();
                    })
                : ((ScheduleController.i.doctorConsultationAppointmentHistoryDataList.isNotEmpty) &&
                        ScheduleController.i.appointmentTypeFilter == 1 &&
                        ScheduleController.i.doctorConsultationAppointmentHistoryDataList
                            .where((element) => element.Status! == "Pending")
                            .toList()
                            .isNotEmpty)
                    ? ListView.builder(
                        controller: _scrollController,
                        physics: const AlwaysScrollableScrollPhysics(),
                        //physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: ScheduleController
                            .i.doctorConsultationUpcomingAppointments.length,
                        itemBuilder: (context, index) {
                          var list = ScheduleController
                              .i.doctorConsultationUpcomingAppointments[index];
                          DateTime t1 = DateTime.parse(
                              "${list.BookingDate.toString().split('T')[0]} ${list.BookingDate.toString().split('T')[1]}");
                          if (t1.isBefore(DateTime.now())) {
                            return DoctorsAppointmentCards(
                              list: list,
                              statusText: cont
                                  .doctorConsultationUpcomingAppointments[index]
                                  .Status
                                  .toString(),
                              statusColor: Colors.green,
                              name: cont
                                  .doctorConsultationUpcomingAppointments[index]
                                  .DoctorName
                                  .toString(),
                              date: cont
                                  .doctorConsultationUpcomingAppointments[index]
                                  .BookingDate!
                                  .split('T')
                                  .first,
                              time: cont
                                  .doctorConsultationUpcomingAppointments[index]
                                  .BookingDate!
                                  .split('T')[1]
                                  .toString(),
                              type: '',
                              rating: cont
                                  .doctorConsultationUpcomingAppointments[index]
                                  .Monday
                                  .toString(),
                              showButtons: false,
                              onBookAgainPressed: () {},
                              onLeaveReviewPressed: () {},
                              Address: cont
                                  .doctorConsultationUpcomingAppointments[index]
                                  .Address,
                              Designation: cont
                                  .doctorConsultationUpcomingAppointments[index]
                                  .Designation,
                            );
                          } else {
                            return SizedBox.shrink(
                                child: Text(
                              'noDataFound'.tr,
                            ));
                          }
                        })
                    : ((ScheduleController.i.doctorConsultationUpcomingAppointments.isEmpty) &&
                            ScheduleController.i.appointmentTypeFilter == 1)
                        ? Center(
                            child: Text(
                              'noDataFound'.tr,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                      color: ColorManager.kblackColor,
                                      // fontWeight: FontWeight.w900,
                                      fontSize: 13),
                            ),
                          )
                        : ((ScheduleController.i.diagnosticAppointmentHistoryDataList.isNotEmpty) &&
                                ScheduleController.i.appointmentTypeFilter == 2)
                            ? ListView.builder(
                                controller: _scrollController,
                                physics: const AlwaysScrollableScrollPhysics(),
                                //physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: ScheduleController
                                    .i
                                    .diagnosticAppointmentHistoryDataList
                                    .length,
                                itemBuilder: (context, index) {
                                  var DiagnosticName = ScheduleController.i
                                          .diagnosticAppointmentHistoryDataList[
                                      index];

                                  return ImaginBookingCard(
                                      listData: DiagnositicAppointmentListData(
                                          Id: DiagnosticName.Id,
                                          DiagnosticId:
                                              DiagnosticName.DiagnosticId,
                                          Status: DiagnosticName.Status,
                                          DiagnosticCenter:
                                              DiagnosticName.DiagnosticCenter,
                                          BookingTime:
                                              DiagnosticName.BookingTime,
                                          AppointmentDate:
                                              DiagnosticName.AppointmentDate,
                                          DiagnosticName:
                                              DiagnosticName.DiagnosticName),
                                      // list: ['${DiagnosticName.DiagnosticName}'],
                                      isCountingShown: false,
                                      // listData: DiagnosticName,
                                      statusText:
                                          (ScheduleController.i.diagnositicAppointmentListData[index].Status) ??
                                              '',
                                      statusColor: Colors.red,
                                      name: (ScheduleController
                                              .i
                                              .diagnositicAppointmentListData[
                                                  index]
                                              .PrescribedByDoctor) ??
                                          '',
                                      date:
                                          (ScheduleController.i.diagnositicAppointmentListData[index].AppointmentDate) ??
                                              '',
                                      time:
                                          (ScheduleController.i.diagnositicAppointmentListData[index].BookingTime) ??
                                              '',
                                      type: '',
                                      rating: '',
                                      ReportStatus: (ScheduleController
                                          .i
                                          .diagnositicAppointmentListData[index]
                                          .Status),
                                      showReportStatusAtEnd: true,
                                      showButtons: false,
                                      address: (ScheduleController
                                          .i
                                          .diagnositicAppointmentListData[index]
                                          .DiagnosticCenter),
                                      firstButtonName: 'reschedule'.tr,
                                      secondButtonName: 'cancel'.tr,
                                      onBookAgainPressed: () {},
                                      onLeaveReviewPressed: () {});
                                  // return DoctorsAppointmentCards(
                                  //     statusText: cont
                                  //         .diagnositicAppointmentListData[index]
                                  //         .Status
                                  //         .toString(),
                                  //     statusColor: Colors.green,
                                  //     name: cont.diagnositicAppointmentListData[index]
                                  //         .PatientName
                                  //         .toString(),
                                  //     date: cont.diagnositicAppointmentListData[index]
                                  //         .AppointmentDate!,
                                  //     time: cont.diagnositicAppointmentListData[index]
                                  //         .BookingTime!,
                                  //     type: '',
                                  //     // type: cont
                                  //     //     .diagnositicAppointmentListData[index].T!,
                                  //     rating: cont
                                  //         .diagnositicAppointmentListData[index]
                                  //         .Monday
                                  //         .toString(),
                                  //     showButtons: false,
                                  //     onBookAgainPressed: () {},
                                  //     onLeaveReviewPressed: () {});
                                })
                            : ((ScheduleController.i.diagnositicAppointmentListData.isEmpty) &&
                                    ScheduleController.i.appointmentTypeFilter ==
                                        2 &&
                                    ScheduleController.i.diagnositicAppointmentListData
                                        .where((element) =>
                                            element.Status == widget.status)
                                        .toList()
                                        .isNotEmpty)
                                ? Center(
                                    child: Text(
                                      'norecordfound'.tr,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                              color: ColorManager.kblackColor,
                                              // fontWeight: FontWeight.w900,
                                              fontSize: 13),
                                    ),
                                  )
                                : ((ScheduleController.i.labInvestigationListData.isNotEmpty) &&
                                        ScheduleController.i.appointmentTypeFilter ==
                                            3 &&
                                        ScheduleController.i.labInvestigationListData
                                            .where((element) => element.StatusValue != 1)
                                            .toList()
                                            .isNotEmpty)
                                    ? ListView.builder(
                                        controller: _scrollController,
                                        physics: const AlwaysScrollableScrollPhysics(),
                                        //physics: const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: ScheduleController.i.labInvestigationListData.length,
                                        itemBuilder: (context, index) {
                                          var list = ScheduleController.i
                                              .labInvestigationListData[index];
                                          // DateTime tt= DateFormat.yMMMEd().format( "${list.Date} ${list.Time}");
                                          DateTime dateTime =
                                              DateFormat('MMM d, y')
                                                  .parse(list.Date ?? "");

                                          String formattedDate =
                                              DateFormat('y-MM-dd')
                                                  .format(dateTime);
                                          // DateTime t1 = DateTime.parse(
                                          //     "${string.split(' ')[0]} ${list.Time}");

                                          if (DateTime.parse(
                                                  "$formattedDate ${list.Time}")
                                              .isBefore(DateTime.now())) {
                                            return LabInvestigationAppointmentCards(
                                                listData: list,
                                                list: ScheduleController
                                                    .i
                                                    .labInvestigationListData[
                                                        index]
                                                    .LabTests,
                                                statusText: ScheduleController
                                                        .i
                                                        .labInvestigationListData[
                                                            index]
                                                        .Status ??
                                                    '',
                                                statusColor: Colors.red,
                                                name: ScheduleController
                                                    .i
                                                    .labInvestigationListData[
                                                        index]
                                                    .PrescribedBy!,
                                                date: ScheduleController
                                                    .i
                                                    .labInvestigationListData[
                                                        index]
                                                    .Date
                                                    .toString(),
                                                time: ScheduleController
                                                    .i
                                                    .labInvestigationListData[
                                                        index]
                                                    .Time
                                                    .toString(),
                                                type: '',
                                                rating: '',
                                                showButtons: true,
                                                address: ScheduleController
                                                    .i
                                                    .labInvestigationListData[
                                                        index]
                                                    .LabName,
                                                firstButtonName: 'Reschedule',
                                                secondButtonName: 'Cancel',
                                                onBookAgainPressed: () {},
                                                onLeaveReviewPressed: () {});
                                          } else {
                                            return const SizedBox.shrink();
                                          }
                                        })
                                    : ((ScheduleController.i.labInvestigationListData.isEmpty) && ScheduleController.i.appointmentTypeFilter == 3)
                                        ? Center(
                                            child: Text(
                                              'noDataFound'.tr,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium
                                                  ?.copyWith(
                                                      color: ColorManager
                                                          .kblackColor,
                                                      // fontWeight: FontWeight.w900,
                                                      fontSize: 13),
                                            ),
                                          )
                                        : Center(
                                            child: Text(
                                              'noDataFound'.tr,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium
                                                  ?.copyWith(
                                                      color: ColorManager
                                                          .kblackColor,
                                                      // fontWeight: FontWeight.w900,
                                                      fontSize: 13),
                                            ),
                                          )),
      );
    }));
  }
}

class UpcomingAppointments extends StatefulWidget {
  final String? status;
  const UpcomingAppointments({super.key, this.status});

  @override
  State<UpcomingAppointments> createState() => _UpcomingAppointmentsState();
}

class _UpcomingAppointmentsState extends State<UpcomingAppointments> {
  ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    ScheduleController.i.changeStatusofOpenedTab(true);
    ScheduleController.i.clearData();
    ScheduleController.i.getUpcomingAppointment("", true);
    //when scroll page
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        var isCallToFetchData = ScheduleController.i
            .SetStartToFetchNextDataForComingAppoiontments();
        if (isCallToFetchData) {
          ScheduleController.i.getUpcomingAppointment("", true);
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var contr = Get.put<ScheduleController>(ScheduleController());
    return Scaffold(body: GetBuilder<ScheduleController>(builder: (cont) {
      return RefreshIndicator(
        onRefresh: () {
          // ScheduleController.i.changeStatusofOpenedTab(true);
          // ScheduleController.i.clearData();
          return ScheduleController.i.getUpcomingAppointment(
            "",
            true,
          );
        },
        child: BlurryModalProgressHUD(
            inAsyncCall: ScheduleController.i.isLoadingUpcoming,
            blurEffectIntensity: 4,
            progressIndicator: const SpinKitSpinningLines(
              color: Color(0xff1272d3),
              size: 60,
            ),
            dismissible: false,
            opacity: 0.4,
            color: Theme.of(context).scaffoldBackgroundColor,
            child: ((ScheduleController.i.list.isNotEmpty &&
                    ScheduleController.i.appointmentTypeFilter == -1 &&
                    ScheduleController.i.list
                        .where((element) =>
                            element.status != 'Cancelled' &&
                            element.appointmentStatus == 'Upcomming' &&
                            element.appointmentCategoryName !=
                                'Lab Investigations')
                        .toList()
                        .isNotEmpty))
                ? ListView.builder(
                    controller: _scrollController,
                    physics: const AlwaysScrollableScrollPhysics(),
                    //physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: ScheduleController.i.list.length,
                    itemBuilder: (context, index) {
                      var list = ScheduleController.i.list[index];
                      return list.status != 'Cancelled' &&
                              list.appointmentCategoryName !=
                                  'Lab Investigations' &&
                              list.appointmentStatus != 'Overdue'
                          ? ServicesAppointmentsCards(
                              listData: list,
                              showButtons: false,
                              onBookAgainPressed: () {},
                              onLeaveReviewPressed: () {},
                            )
                          : const SizedBox.shrink();
                    })
                : ((ScheduleController.i.doctorConsultationUpcomingAppointments.isNotEmpty) &&
                        ScheduleController.i.appointmentTypeFilter == 1 &&
                        ScheduleController.i.doctorConsultationUpcomingAppointments
                            .where((element) => element.Status == 'Requested')
                            .toList()
                            .isNotEmpty)
                    ? ListView.builder(
                        controller: _scrollController,
                        physics: const AlwaysScrollableScrollPhysics(),
                        //physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: ScheduleController
                            .i.doctorConsultationUpcomingAppointments.length,
                        itemBuilder: (context, index) {
                          var list = ScheduleController
                              .i.doctorConsultationUpcomingAppointments[index];
                          DateTime t1 = DateTime.parse(
                              "${list.BookingDate.toString().split('T')[0]} ${list.BookingDate.toString().split('T')[1]}");
                          if (t1.isAfter(DateTime.now())) {
                            return DoctorsAppointmentCards(
                              list: list,
                              statusText: cont
                                  .doctorConsultationUpcomingAppointments[index]
                                  .Status
                                  .toString(),
                              statusColor: Colors.green,
                              name: cont
                                  .doctorConsultationUpcomingAppointments[index]
                                  .DoctorName
                                  .toString(),
                              date: cont
                                  .doctorConsultationUpcomingAppointments[index]
                                  .BookingDate!
                                  .split('T')
                                  .first,
                              time: cont
                                  .doctorConsultationUpcomingAppointments[index]
                                  .BookingDate!
                                  .split('T')[1]
                                  .toString(),
                              type: '',
                              rating: cont
                                  .doctorConsultationUpcomingAppointments[index]
                                  .Monday
                                  .toString(),
                              showButtons: false,
                              onBookAgainPressed: () {},
                              onLeaveReviewPressed: () {},
                              Address: cont
                                  .doctorConsultationUpcomingAppointments[index]
                                  .Address,
                              Designation: cont
                                  .doctorConsultationUpcomingAppointments[index]
                                  .Designation,
                            );
                          } else {
                            return const SizedBox.shrink();
                          }
                        })
                    : ((ScheduleController.i.doctorConsultationUpcomingAppointments.isEmpty) &&
                            ScheduleController.i.appointmentTypeFilter == 1)
                        ? Center(
                            child: Text(
                              'noDataFound'.tr,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                      color: ColorManager.kblackColor,
                                      // fontWeight: FontWeight.w900,
                                      fontSize: 13),
                            ),
                          )
                        : ((ScheduleController.i.diagnositicAppointmentListData.isNotEmpty) &&
                                ScheduleController.i.appointmentTypeFilter == 2)
                            ? ListView.builder(
                                controller: _scrollController,
                                physics: const AlwaysScrollableScrollPhysics(),
                                //physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: ScheduleController
                                    .i.diagnositicAppointmentListData.length,
                                itemBuilder: (context, index) {
                                  var DiagnosticName = ScheduleController
                                      .i.diagnositicAppointmentListData[index];

                                  return ImaginBookingCard(
                                      listData: DiagnosticName,
                                      // list: ['${DiagnosticName.DiagnosticName}'],
                                      isCountingShown: false,
                                      // listData: DiagnosticName,
                                      statusText: (ScheduleController
                                              .i
                                              .diagnositicAppointmentListData[
                                                  index]
                                              .Status) ??
                                          '',
                                      statusColor: Colors.red,
                                      name: (ScheduleController
                                              .i
                                              .diagnositicAppointmentListData[
                                                  index]
                                              .PrescribedByDoctor) ??
                                          '',
                                      date: (ScheduleController
                                              .i
                                              .diagnositicAppointmentListData[
                                                  index]
                                              .AppointmentDate) ??
                                          '',
                                      time: (ScheduleController
                                              .i
                                              .diagnositicAppointmentListData[
                                                  index]
                                              .BookingTime) ??
                                          '',
                                      type: '',
                                      rating: '',
                                      ReportStatus: (ScheduleController
                                          .i
                                          .diagnositicAppointmentListData[index]
                                          .Status),
                                      showReportStatusAtEnd: true,
                                      showButtons: false,
                                      address: (ScheduleController
                                          .i
                                          .diagnositicAppointmentListData[index]
                                          .DiagnosticCenter),
                                      firstButtonName: 'reschedule'.tr,
                                      secondButtonName: 'cancel'.tr,
                                      onBookAgainPressed: () {},
                                      onLeaveReviewPressed: () {});
                                  // return DoctorsAppointmentCards(
                                  //     statusText: cont
                                  //         .diagnositicAppointmentListData[index]
                                  //         .Status
                                  //         .toString(),
                                  //     statusColor: Colors.green,
                                  //     name: cont.diagnositicAppointmentListData[index]
                                  //         .PatientName
                                  //         .toString(),
                                  //     date: cont.diagnositicAppointmentListData[index]
                                  //         .AppointmentDate!,
                                  //     time: cont.diagnositicAppointmentListData[index]
                                  //         .BookingTime!,
                                  //     type: '',
                                  //     // type: cont
                                  //     //     .diagnositicAppointmentListData[index].T!,
                                  //     rating: cont
                                  //         .diagnositicAppointmentListData[index]
                                  //         .Monday
                                  //         .toString(),
                                  //     showButtons: false,
                                  //     onBookAgainPressed: () {},
                                  //     onLeaveReviewPressed: () {});
                                })
                            : ((ScheduleController
                                        .i
                                        .diagnositicAppointmentListData
                                        .isEmpty) &&
                                    ScheduleController.i.appointmentTypeFilter ==
                                        2)
                                ? Center(
                                    child: Text(
                                      'norecordfound'.tr,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                              color: ColorManager.kblackColor,
                                              // fontWeight: FontWeight.w900,
                                              fontSize: 13),
                                    ),
                                  )
                                : ((ScheduleController
                                            .i
                                            .labInvestigationListData
                                            .isNotEmpty) &&
                                        ScheduleController.i.appointmentTypeFilter ==
                                            3 &&
                                        ScheduleController.i.labInvestigationListData
                                            .where((element) => element.StatusValue == 1)
                                            .toList()
                                            .isNotEmpty)
                                    ? ListView.builder(
                                        controller: _scrollController,
                                        physics: const AlwaysScrollableScrollPhysics(),
                                        //physics: const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: ScheduleController.i.labInvestigationListData.length,
                                        itemBuilder: (context, index) {
                                          var list = ScheduleController.i
                                              .labInvestigationListData[index];
                                          DateTime dateTime =
                                              DateFormat('MMM d, y')
                                                  .parse(list.Date ?? "");

                                          String formattedDate =
                                              DateFormat('y-MM-dd')
                                                  .format(dateTime);
                                          // DateTime t1 = DateTime.parse(
                                          //     "${string.split(' ')[0]} ${list.Time}");

                                          if (DateTime.parse(
                                                  "$formattedDate ${list.Time}")
                                              .isAfter(DateTime.now())) {
                                            return LabInvestigationAppointmentCards(
                                                listData: list,
                                                list: ScheduleController
                                                    .i
                                                    .labInvestigationListData[
                                                        index]
                                                    .LabTests,
                                                statusText: ScheduleController
                                                        .i
                                                        .labInvestigationListData[
                                                            index]
                                                        .Status ??
                                                    '',
                                                statusColor: Colors.red,
                                                name: ScheduleController
                                                    .i
                                                    .labInvestigationListData[
                                                        index]
                                                    .PrescribedBy!,
                                                date: ScheduleController
                                                    .i
                                                    .labInvestigationListData[
                                                        index]
                                                    .Date
                                                    .toString(),
                                                time: ScheduleController
                                                    .i
                                                    .labInvestigationListData[
                                                        index]
                                                    .Time
                                                    .toString(),
                                                type: '',
                                                rating: '',
                                                showButtons: true,
                                                address: ScheduleController
                                                    .i
                                                    .labInvestigationListData[
                                                        index]
                                                    .LabName,
                                                firstButtonName: 'Reschedule',
                                                secondButtonName: 'Cancel',
                                                onBookAgainPressed: () {},
                                                onLeaveReviewPressed: () {});
                                          } else {
                                            return const SizedBox.shrink();
                                          }
                                        })
                                    : ((ScheduleController.i.labInvestigationListData.isEmpty) && ScheduleController.i.appointmentTypeFilter == 3)
                                        ? Center(
                                            child: Text(
                                              'noDataFound'.tr,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium
                                                  ?.copyWith(
                                                      color: ColorManager
                                                          .kblackColor,
                                                      // fontWeight: FontWeight.w900,
                                                      fontSize: 13),
                                            ),
                                          )
                                        : Center(
                                            child: Text(
                                              'noDataFound'.tr,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium
                                                  ?.copyWith(
                                                      color: ColorManager
                                                          .kblackColor,
                                                      // fontWeight: FontWeight.w900,
                                                      fontSize: 13),
                                            ),
                                          )),
      );
    }));
  }
}

class CompletedAppointments extends StatefulWidget {
  const CompletedAppointments({super.key});

  @override
  State<CompletedAppointments> createState() => _CompletedAppointmentsState();
}

class _CompletedAppointmentsState extends State<CompletedAppointments> {
  ScrollController _scrollControllerCompleted = ScrollController();
  @override
  void initState() {
    ScheduleController.i.changeStatusofOpenedTab(false);
    ScheduleController.i.clearData();
    ScheduleController.i.getHistoryAppointment(
      "",
    );

    //when scroll page
    _scrollControllerCompleted.addListener(() {
      // var nextPageTrigger = 0.8 * _scrollController.position.maxScrollExtent;
      if (_scrollControllerCompleted.position.pixels ==
          _scrollControllerCompleted.position.maxScrollExtent) {
        var isCallToFetchData = ScheduleController.i
            .SetStartToFetchNextDataForCompletedAppoiontments();
        if (isCallToFetchData) {
          ScheduleController.i.GetCompletedAppointments("");
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var contr = Get.put<ScheduleController>(ScheduleController());
    return Scaffold(body: GetBuilder<ScheduleController>(builder: (cont) {
      return BlurryModalProgressHUD(
          inAsyncCall: ScheduleController.i.isLoadingCompleted,
          blurEffectIntensity: 4,
          progressIndicator: const SpinKitSpinningLines(
            color: Color(0xff1272d3),
            size: 60,
          ),
          dismissible: false,
          opacity: 0.4,
          color: Theme.of(context).scaffoldBackgroundColor,
          child: ((ScheduleController.i.doctorConsultationCompletedAppointments.isNotEmpty) &&
                  ScheduleController.i.appointmentTypeFilter == 1 &&
                  ScheduleController.i.doctorConsultationCompletedAppointments
                      .where((element) => element.Status! == 'Completed')
                      .toList()
                      .isNotEmpty)
              ? ListView.builder(
                  controller: _scrollControllerCompleted,
                  physics: const BouncingScrollPhysics(),
                  //physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: ScheduleController
                      .i.doctorConsultationCompletedAppointments.length,
                  itemBuilder: (context, index) {
                    var list = ScheduleController
                        .i.doctorConsultationCompletedAppointments[index];

                    return DoctorsAppointmentCards(
                      list: list,
                      statusText: cont
                          .doctorConsultationCompletedAppointments[index].Status
                          .toString(),
                      statusColor: Colors.green,
                      name: cont.doctorConsultationCompletedAppointments[index]
                          .DoctorName
                          .toString(),
                      date: cont.doctorConsultationCompletedAppointments[index]
                          .BookingDate!
                          .split('T')
                          .first,
                      time: cont.doctorConsultationCompletedAppointments[index]
                          .BookingDate!
                          .split('T')[1]
                          .toString(),
                      type: '',
                      rating: cont
                          .doctorConsultationCompletedAppointments[index].Monday
                          .toString(),
                      showButtons: false,
                      onBookAgainPressed: () {},
                      onLeaveReviewPressed: () {},
                      Address: cont
                          .doctorConsultationCompletedAppointments[index]
                          .Address,
                      Designation: cont
                          .doctorConsultationCompletedAppointments[index]
                          .Designation,
                    );
                  })
              : ((ScheduleController.i.doctorConsultationCompletedAppointments.isEmpty) &&
                      ScheduleController.i.appointmentTypeFilter == 1)
                  ? Center(
                      child: Text(
                        '${'noDataFound'.tr}!',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: ColorManager.kblackColor,
                                // fontWeight: FontWeight.w900,
                                fontSize: 13),
                      ),
                    )
                  : ((ScheduleController.i.diagnosticAppointmentCompletedDataList.isNotEmpty) &&
                          ScheduleController.i.appointmentTypeFilter == 2)
                      ? ListView.builder(
                          controller: _scrollControllerCompleted,
                          physics: const BouncingScrollPhysics(),
                          //physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: ScheduleController
                              .i.diagnosticAppointmentCompletedDataList.length,
                          itemBuilder: (context, index) {
                            var DiagnosticName = ScheduleController.i
                                .diagnosticAppointmentCompletedDataList[index];

                            return ImaginBookingCard(
                                listData: DiagnositicAppointmentListData(),
                                // listData: UpComingLabIvestigationDataList(
                                //     Longitude: DiagnosticName.,
                                //     Latitude: list.latitude,
                                //     PickupAddress: list.pickupAddress,
                                //     CityName: list.cityName,
                                //     Status: list.status,
                                //     PackageGroupId: list.packageGroupId,
                                //     PackageGroupDiscountRate:
                                //         list.packageGroupDiscountRate,
                                //     PackageGroupDiscountType:
                                //         list.packageGroupDiscountType,
                                //     Time: list.startTime,
                                //     LabId: list.labId,
                                //     LabNO: list.labNo,
                                //     Date: list.bookingDate,
                                //     PatientId: list.patientId,
                                //     LabTests: list.labTests),
                                isCountingShown: false,
                                statusText: (ScheduleController
                                        .i
                                        .diagnosticAppointmentCompletedDataList[
                                            index]
                                        .Status) ??
                                    '',
                                statusColor: Colors.red,
                                name: (ScheduleController
                                        .i
                                        .diagnosticAppointmentCompletedDataList[
                                            index]
                                        .PrescribedByDoctor) ??
                                    '',
                                date: (ScheduleController
                                        .i
                                        .diagnosticAppointmentCompletedDataList[
                                            index]
                                        .AppointmentDate) ??
                                    '',
                                time: (ScheduleController
                                        .i
                                        .diagnosticAppointmentCompletedDataList[
                                            index]
                                        .BookingTime) ??
                                    '',
                                type: '',
                                rating: '',
                                ReportStatus: (ScheduleController
                                    .i
                                    .diagnosticAppointmentCompletedDataList[
                                        index]
                                    .Status),
                                showReportStatusAtEnd: true,
                                showButtons: false,
                                address: (ScheduleController
                                    .i
                                    .diagnosticAppointmentCompletedDataList[
                                        index]
                                    .DiagnosticCenter),
                                firstButtonName: 'Reschedule',
                                secondButtonName: 'Cancel',
                                onBookAgainPressed: () {},
                                onLeaveReviewPressed: () {});
                          })
                      : ((ScheduleController.i.diagnosticAppointmentHistoryDataList.isEmpty) &&
                              ScheduleController.i.appointmentTypeFilter == 2)
                          ? Center(
                              child: Text(
                                'norecordfound'.tr,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                        color: ColorManager.kblackColor,
                                        // fontWeight: FontWeight.w900,
                                        fontSize: 13),
                              ),
                            )
                          : ((ScheduleController
                                      .i
                                      .labInvestigationAppointmentCompletedDataList
                                      .isNotEmpty) &&
                                  ScheduleController.i.appointmentTypeFilter ==
                                      3)
                              ? ListView.builder(
                                  controller: _scrollControllerCompleted,
                                  physics: const BouncingScrollPhysics(),
                                  //physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: ScheduleController
                                      .i
                                      .labInvestigationAppointmentCompletedDataList
                                      .length,
                                  itemBuilder: (context, index) {
                                    var lists = ScheduleController.i
                                            .labInvestigationAppointmentCompletedDataList[
                                        index];
                                    return LabInvestigationAppointmentCards(
                                        listData: UpComingLabIvestigationDataList(
                                            Longitude: lists.Longitude,
                                            Latitude: lists.Latitude,
                                            PickupAddress: lists.PickupAddress,
                                            CityName: lists.CityName,
                                            Status: lists.Status,
                                            PackageGroupId:
                                                lists.PackageGroupId,
                                            PackageGroupDiscountRate:
                                                lists.PackageGroupDiscountRate,
                                            PackageGroupDiscountType:
                                                lists.PackageGroupDiscountType,
                                            Time: lists.Time,
                                            LabId: lists.LabId,
                                            LabNO: lists.LabNO,
                                            Date: lists.Date,
                                            PatientId: lists.PatientId,
                                            LabTests: lists.LabTestList),
                                        isTestsListisInstanceofList: true,
                                        statusText: ScheduleController
                                                .i
                                                .labInvestigationAppointmentCompletedDataList[
                                                    index]
                                                .AppointmentStatus ??
                                            '',
                                        statusColor: Colors.red,
                                        name: ScheduleController
                                            .i
                                            .labInvestigationAppointmentCompletedDataList[
                                                index]
                                            .PrescribedBy!,
                                        date: ScheduleController
                                            .i
                                            .labInvestigationAppointmentCompletedDataList[
                                                index]
                                            .Date
                                            .toString(),
                                        time: ScheduleController
                                            .i
                                            .labInvestigationAppointmentCompletedDataList[
                                                index]
                                            .Time
                                            .toString(),
                                        type: '',
                                        rating: '',
                                        showButtons: false,
                                        address: ScheduleController
                                            .i
                                            .labInvestigationAppointmentCompletedDataList[
                                                index]
                                            .LabName,
                                        firstButtonName: 'Reschedule',
                                        secondButtonName: 'Cancel',
                                        onBookAgainPressed: () {},
                                        onLeaveReviewPressed: () {});
                                  })
                              : ((ScheduleController
                                          .i
                                          .labInvestigationAppointmentCompletedDataList
                                          .isEmpty) &&
                                      ScheduleController.i.appointmentTypeFilter == 3)
                                  ? Center(
                                      child: Text(
                                        'norecordfound'.tr,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.copyWith(
                                                color: ColorManager.kblackColor,
                                                // fontWeight: FontWeight.w900,
                                                fontSize: 13),
                                      ),
                                    )
                                  : Center(
                                      child: Text(
                                        'norecordfound'.tr,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.copyWith(
                                                color: ColorManager.kblackColor,
                                                // fontWeight: FontWeight.w900,
                                                fontSize: 13),
                                      ),
                                    ));
    }));
  }
}

String? hintText() {
  if (ScheduleController.i.appointmentTypeFilter == -1) {
    return "Search Service";
  } else if (ScheduleController.i.appointmentTypeFilter == 1) {
    return "Search Appointment";
  } else if (ScheduleController.i.appointmentTypeFilter == 3) {
    return "Search Lab Investigation";
  } else if (ScheduleController.i.appointmentTypeFilter == 2) {
    return "Search Diagnostic Appointment";
  }
}
