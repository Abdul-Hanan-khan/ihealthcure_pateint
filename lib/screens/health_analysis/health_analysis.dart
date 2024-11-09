// ignore_for_file: use_build_context_synchronously, use_full_hex_values_for_flutter_colors, duplicate_ignore

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tabib_al_bait/components/customnew.dart';
import 'package:tabib_al_bait/components/images.dart';
import 'package:tabib_al_bait/components/new_button.dart';
import 'package:tabib_al_bait/components/primary_button.dart';
import 'package:tabib_al_bait/data/controller/health_analysis_controller.dart';
import 'package:tabib_al_bait/data/sqflite_db/sqflite_db.dart';
import 'package:tabib_al_bait/helpers/color_manager.dart';
import 'package:tabib_al_bait/helpers/values_manager.dart';
import 'package:tabib_al_bait/models/health.dart';
import 'package:tabib_al_bait/screens/family_screens/family_members.dart';
import 'package:tabib_al_bait/utils/dialogue_boxes/dialogue.dart';

double screenWidth = MediaQuery.of(Get.context!).size.width;
TextEditingController controller = TextEditingController();

class HealthAnalysis extends StatefulWidget {
  const HealthAnalysis({super.key});

  @override
  State<HealthAnalysis> createState() => _HealthAnalysisState();
}

class _HealthAnalysisState extends State<HealthAnalysis> {
  // ignore: unused_field
  final CarouselController _carouselController = CarouselController();
  // ignore: unused_field
  final CarouselController _feetcont = CarouselController();
  // ignore: unused_field
  final CarouselController _inchcont = CarouselController();
  // ignore: unused_field
  final CarouselController _weightcont = CarouselController();

  double calculateOpacity(int index, int currentIndex) {
    final opacity = (1 - (currentIndex - index).abs() * 0.3).clamp(0.0, 1.0);
    return opacity;
  }

  int pageIndex = 0;

  @override
  void initState() {
    Healthanalysiscontroller.i.getHealthSummaryData();
    Healthanalysiscontroller.i.getLastDataBasedOnTitle();

    super.initState();
  }

  // ignore: unused_field
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    var health = Get.put<Healthanalysiscontroller>(Healthanalysiscontroller());

    List<Health> services = [
      Health(
          gradientColor: const Color(0xFF1272D3),
          title: 'LDL Cholestrol'.tr,
          firsttitle: '20%',
          secondtitle: 'High',
          widget: const Divider(),
          color: const Color(0xFF1272D3),
          onPressed: () async {}),
      Health(
          gradientColor: const Color(0xFF1272D3),
          title: 'Vitamin'.tr,
          firsttitle: '30%',
          secondtitle: 'High',
          widget: const Divider(),
          color: const Color(0xFF1272D3),
          onPressed: () async {
            // Get.to(() => LabInvestigations(
            //       imagePath: Images.microscope,
            //       title: 'labInvestigationBooking'.tr,
            //     ));
          }),
      Health(
          title: 'Acid'.tr,
          firsttitle: '10%',
          secondtitle: 'High',
          widget: const Divider(),
          gradientColor: const Color(0xFF1272D3),
          color: const Color(0xFF1272D3),
          onPressed: () async {
            // Get.to(() => ServicesHome(
            //       imagepath: Images.services,
            //       title: 'homeService'.tr,
            //       isServiceshome: true,
            //     )
            //     );
          }),
    ];
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: CustomAppBar(
          title: 'healthanalysis'.tr,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppPadding.p20),
        child: SingleChildScrollView(
          child: GetBuilder<Healthanalysiscontroller>(
            builder: (cont) {
              return cont.isLoading == false
                  ? Stack(children: [
                      Stack(children: [
                        Column(
                          children: [
                            Container(
                              color: const Color(0xFFDAE7F6),
                              height: Get.height * 0.25,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: Get.height * 0.03),
                                child: const Text.rich(
                                  textAlign: TextAlign.center,
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text:
                                            "Here are some Health facts about ",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                        ),
                                      ),
                                      TextSpan(
                                        text: "Men ",
                                        style: TextStyle(
                                          color: Colors.blue,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextSpan(
                                        text: "in \n",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                        ),
                                      ),
                                      TextSpan(
                                        text: "Dubai, UAE ",
                                        style: TextStyle(
                                          color: Colors.blue,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextSpan(
                                        text: "around the age group of \n",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                        ),
                                      ),
                                      WidgetSpan(
                                        child: Center(
                                          child: Text(
                                            "\t25-30 years",
                                            style: TextStyle(
                                              color: Colors.blue,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: Get.height * 0.19),
                              child: Container(
                                height: Get.height * 0.5,
                                width: Get.width * 1,
                                color: const Color(0xFF1272D3),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: Get.height * 0.05),
                                      child: Text(
                                        "healthanalysistools".tr,
                                        style: GoogleFonts.poppins(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: const Color(0xFFFFFFFF),
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: Get.height * 0.05,
                                              left: Get.width * 0.04),
                                          child: Newbutton(
                                            height: Get.height * 0.16,
                                            width: Get.width * 0.25,
                                            icon: Image.asset(
                                              Images.bMI,
                                            ),
                                            title: 'BMI\nCalculator'.tr,
                                            textcolor: const Color(0xFF1272D3),
                                            fontSize: 12,
                                            onPressed: () {
                                              bMIcalculator(context);
                                            },
                                            color: const Color(0xFFFFFFFF),
                                            primaryIcon: true,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: Get.height * 0.05,
                                              left: Get.width * 0.04),
                                          child: Newbutton(
                                            height: Get.height * 0.16,
                                            width: Get.width * 0.25,
                                            icon: Image.asset(
                                              Images.bP,
                                            ),
                                            title: 'Bp\nMonitor'.tr,
                                            textcolor: const Color(0xFF1272D3),
                                            fontSize: 12,
                                            onPressed: () {
                                              bPMonitor(context);
                                            },
                                            color: const Color(0xFFFFFFFF),
                                            primaryIcon: true,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: Get.height * 0.05,
                                              left: Get.width * 0.04),
                                          child: Newbutton(
                                            height: Get.height * 0.16,
                                            width: Get.width * 0.25,
                                            icon: Image.asset(
                                              Images.glocuse,
                                            ),
                                            title: 'Glocuse\nMonitor'.tr,
                                            textcolor: const Color(0xFF1272D3),
                                            fontSize: 12,
                                            onPressed: () {
                                              gLocuseMonitor(context);
                                            },
                                            color: const Color(0xFFFFFFFF),
                                            primaryIcon: true,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: Get.height * 0.22),
                          child: Center(
                            // ignore: avoid_unnecessary_containers
                            child: Container(
                              child: CarouselSlider.builder(
                                carouselController: CarouselController(),
                                itemCount: services.length,
                                itemBuilder: (context, index, realIndex) {
                                  final service = services[index];
                                  final isCurrentPage = index == pageIndex;
                                  final opacity = isCurrentPage ? 1.0 : 0.4;
                                  return index == pageIndex
                                      ? Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color:
                                                      ColorManager.kWhiteColor,
                                                  width: 10),
                                              color: ColorManager.kWhiteColor,
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: Opacity(
                                            opacity: opacity,
                                            child:
                                                ServicesWidget(health: service),
                                          ),
                                        )
                                      // ignore: avoid_unnecessary_containers
                                      : Container(
                                          child: Opacity(
                                            opacity: opacity,
                                            child:
                                                ServicesWidget(health: service),
                                          ),
                                        );
                                },
                                options: CarouselOptions(
                                  height: Get.height * 0.25,
                                  aspectRatio: 12 / 9,
                                  viewportFraction: 0.55,
                                  enlargeCenterPage: true,
                                  enableInfiniteScroll: true,
                                  onPageChanged: (index, reason) {
                                    setState(() {
                                      pageIndex = index;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                        )
                      ]),
                    ])
                  : Center(
                      child: Column(
                        children: [
                          SizedBox(
                            height: Get.height * 0.3,
                          ),
                          const CircularProgressIndicator(),
                        ],
                      ),
                    );
            },
          ),
        ),
      ),
    );
  }

  Widget dataWidget(BuildContext context,
      {String? title,
      String? unit,
      GlobalKey<FormState>? formkey,
      String? date,
      Widget? whiteContainerContent,
      String? hintText1,
      String? hintText2}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '$title',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: ColorManager.kPrimaryColor, fontWeight: FontWeight.w900),
        ),
        Container(
          width: Get.width * 0.5,
          padding: const EdgeInsets.all(AppPadding.p10)
              .copyWith(top: 30, bottom: 30),
          decoration: BoxDecoration(
              color: ColorManager.kPrimaryLightColor,
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '$date',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: ColorManager.kPrimaryColor,
                    fontWeight: FontWeight.w900,
                    fontSize: 12),
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              Container(
                  padding: const EdgeInsets.all(AppPadding.p4)
                      .copyWith(left: 15, right: 15),
                  decoration: BoxDecoration(
                      color: ColorManager.kWhiteColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: whiteContainerContent),
              SizedBox(
                height: Get.height * 0.02,
              ),
              Text(
                '$unit',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: ColorManager.kPrimaryColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600),
              )
            ],
          ),
        ),
        SizedBox(
          height: Get.height * 0.02,
        ),
        PrimaryButton(
          title: 'connect'.tr,
          onPressed: () async {
            var list = await SqfliteDB().queryAllRowsBasedOnTitle(title);
            Healthanalysiscontroller.i.updateHistoryList(list);
            AlertDialgue().dialogueBox(context,
                formKey: formkey,
                list: list,
                controller1: Healthanalysiscontroller.i.controller1,
                controller2: Healthanalysiscontroller.i.controller2,
                title: title,
                hintText1: hintText1,
                hintText2: hintText2);
          },
          color: ColorManager.kPrimaryColor,
          textcolor: ColorManager.kWhiteColor,
          fontSize: 12,
        )
      ],
    );
  }
}

class ServicesWidget extends StatelessWidget {
  const ServicesWidget({super.key, required this.health});
  final Health health;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SizedBox(
        height: Get.height * 0.17,
        width: Get.width * 0.7,
        child: InkWell(
          onTap: health.onPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        colors: [
                          health.gradientColor!,
                          health.color!,
                        ]),
                    color: health.color,
                    borderRadius: BorderRadius.circular(5)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(health.title!,
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                      color: ColorManager.kWhiteColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    // SizedBox(height: 10,),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(health.firsttitle!,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                      color: ColorManager.kWhiteColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Divider(
                            color: Colors.white,
                            thickness: 1,
                          ),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(health.secondtitle!,
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                            color: ColorManager.kWhiteColor,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
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

// ignore: non_constant_identifier_names
late List<Widget> BMIpages;

bMIcalculator(BuildContext context) {
  BMIpages = [
    // Page 1 content
    SingleChildScrollView(
      child: Column(
        children: [
          Text(
            'bmiCalculator'.tr,
            style: GoogleFonts.poppins(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1272D3)),
          ),
          SizedBox(
            height: Get.height * 0.07,
          ),
          Image.asset(
            Images.meter,
          ),
          SizedBox(
            height: Get.height * 0.04,
          ),
          Row(
            children: [
              // ignore: sized_box_for_whitespace
              Container(
                width: Get.width * 0.19,
                child: CustomText(
                    hintText: 'feet'.tr,
                    fillColor: Colors.white,
                    validator: (p0) {
                      if (p0!.isEmpty) {
                        return 'required';
                      } else {
                        return null;
                      }
                    }),
              ),
              Text(
                "ft",
                style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              // ignore: sized_box_for_whitespace
              Container(
                width: Get.width * 0.19,
                child: CustomText(
                  hintText: 'inch'.tr,
                  fillColor: Colors.white,
                ),
              ),
              Text(
                "ins",
                style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              // ignore: sized_box_for_whitespace
              Container(
                width: Get.width * 0.17,
                child: CustomText(
                  hintText: 'cm',
                  fillColor: const Color(0xFF1272D3),
                  suffixIcon: Image.asset(
                    Images.arrowleft,
                    height: 2,
                    width: 2,
                  ),
                ),
              ),
            ],
          ),
          CustomText(
              hintText: 'weightkg'.tr,
              fillColor: Colors.white,
              prefixIcon: Image.asset(
                Images.weight,
                height: 27,
                width: 27,
              )),
          PrimaryButton(
            width: Get.width * 0.65,
            title: 'calculatebmi'.tr,
            onPressed: () async {},
            color: ColorManager.kPrimaryColor,
            textcolor: ColorManager.kWhiteColor,
            fontSize: 12,
          )
        ],
      ),
    ),

    SingleChildScrollView(
      child: Column(
        children: [
          Text(
            'BMI'.tr,
            style: GoogleFonts.poppins(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1272D3)),
          ),
          SizedBox(
            height: Get.height * 0.05,
          ),
          Container(
            height: Get.height * 0.5,
            width: Get.width * 1,
            decoration: BoxDecoration(
              color: const Color(0xFFE5EBF4),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Get.width * 0.25,
                    vertical: Get.height * 0.02,
                  ),
                  child: Text(
                    'history'.tr,
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1272D3),
                    ),
                  ),
                ),
                Table(
                  border: TableBorder.all(
                      color: Colors.transparent), // Hide table borders
                  children: [
                    TableRow(
                      children: [
                        TableCell(
                          child: Center(
                            child: Text(
                              'heightcm'.tr,
                              style: const TextStyle(
                                  color: Colors.blue, fontSize: 12),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Center(
                            child: Text(
                              'weight'.tr,
                              style: const TextStyle(
                                  color: Colors.blue, fontSize: 12),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Center(
                            child: Text(
                              'datetime'.tr,
                              style: const TextStyle(
                                  color: Colors.blue, fontSize: 12),
                            ),
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        const TableCell(
                          child: Center(
                              child: Text(
                            '196',
                            style: TextStyle(color: Colors.blue, fontSize: 10),
                          )),
                        ),
                        TableCell(
                          child: Center(
                              child: Text(
                            'high'.tr,
                            style: const TextStyle(
                                color: Colors.blue, fontSize: 10),
                          )),
                        ),
                        const TableCell(
                          child: Center(
                              child: Text(
                            '16-06-2023',
                            style: TextStyle(color: Colors.blue, fontSize: 10),
                          )),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        const TableCell(
                          child: Center(
                              child: Text(
                            '165',
                            style: TextStyle(color: Colors.blue, fontSize: 10),
                          )),
                        ),
                        TableCell(
                          child: Center(
                              child: Text(
                            'normal'.tr,
                            style: const TextStyle(
                                color: Colors.blue, fontSize: 10),
                          )),
                        ),
                        const TableCell(
                          child: Center(
                              child: Text(
                            '09-06-2023',
                            style: TextStyle(color: Colors.blue, fontSize: 10),
                          )),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    ),
  ];

  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return Material(
        type: MaterialType.transparency,
        shape: const RoundedRectangleBorder(),
        color: ColorManager.kCyanBlue,
        child: DefaultTabController(
            length: 2,
            child: AlertDialog(
              content: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: Get.width * 0.05,
                      ),
                      Container(
                        width: Get.width * 0.5,
                        height: Get.height * 0.055,
                        decoration: BoxDecoration(
                          // ignore: unrelated_type_equality_checks
                          color: BMIpages == 0
                              // ignore: use_full_hex_values_for_flutter_colors
                              ? const Color(0xfff1272d3)
                              : ColorManager.kWhiteColor,
                          border: Border.all(
                              color: const Color.fromARGB(255, 17, 83, 196)),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: TabBar(
                          tabs: const [
                            Tab(
                              text: 'Calculate',
                            ),
                            Tab(text: 'History'),
                          ],
                          indicator: BoxDecoration(
                              color: ColorManager.kPrimaryColor,
                              borderRadius: BorderRadius.circular(5)),
                          labelStyle: const TextStyle(fontSize: 12),
                          indicatorColor: Colors.blue,
                          labelColor: Colors.white,
                          unselectedLabelColor: Colors.black,
                        ),
                      ),
                      SizedBox(
                        width: Get.width * 0.05,
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Image.asset(
                            Images.crossicon,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Get.height * 0.07,
                  ),
                  Expanded(
                    child: SizedBox(
                      height: Get.height * 0.7,
                      width: Get.width * 1,
                      child: TabBarView(
                        children: BMIpages,
                      ),
                    ),
                  ),
                ],
              ),
            )),
      );
    },
  );
}

late List<Widget> pages;
int index = 0;

bPMonitor(BuildContext context) {
  pages = [
    // Page 1 content
    SingleChildScrollView(
      child: Column(
        children: [
          Text(
            'bloodpressuremoniter'.tr,
            style: GoogleFonts.poppins(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1272D3)),
          ),
          SizedBox(
            height: Get.height * 0.07,
          ),
          Image.asset(
            Images.bpheart,
          ),
          SizedBox(
            height: Get.height * 0.04,
          ),
          CustomText(
            hintText: 'entersystolic'.tr,
            fillColor: Colors.white,
            prefixIcon: const Icon(
              Icons.arrow_upward,
              color: Colors.blue,
            ),
          ),
          SizedBox(
            height: Get.height * 0.01,
          ),
          CustomText(
            hintText: 'enterlowerbp'.tr,
            fillColor: Colors.white,
            prefixIcon: const Icon(
              Icons.arrow_downward,
              color: Colors.blue,
            ),
          ),
          PrimaryButton(
            width: Get.width * 0.65,
            title: 'savebp'.tr,
            onPressed: () async {},
            color: ColorManager.kPrimaryColor,
            textcolor: ColorManager.kWhiteColor,
            fontSize: 12,
          )
        ],
      ),
    ),

    SingleChildScrollView(
      child: Column(
        children: [
          Text(
            'bloodpressure'.tr,
            style: GoogleFonts.poppins(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1272D3)),
          ),
          SizedBox(
            height: Get.height * 0.05,
          ),
          Container(
            height: Get.height * 0.5,
            width: Get.width * 1,
            decoration: BoxDecoration(
              color: const Color(0xFFE5EBF4),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Get.width * 0.25,
                    vertical: Get.height * 0.02,
                  ),
                  child: Text(
                    'history'.tr,
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1272D3),
                    ),
                  ),
                ),
                Table(
                  border: TableBorder.all(
                      color: Colors.transparent), // Hide table borders
                  children: [
                    TableRow(
                      children: [
                        TableCell(
                          child: Center(
                            child: Text(
                              'values'.tr,
                              style: const TextStyle(
                                  color: Colors.blue, fontSize: 12),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Center(
                            child: Text(
                              'condition'.tr,
                              style: const TextStyle(
                                  color: Colors.blue, fontSize: 12),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Center(
                            child: Text(
                              'datetime'.tr,
                              style: const TextStyle(
                                  color: Colors.blue, fontSize: 12),
                            ),
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        const TableCell(
                          child: Center(
                              child: Text(
                            '132/90',
                            style: TextStyle(color: Colors.blue, fontSize: 10),
                          )),
                        ),
                        TableCell(
                          child: Center(
                              child: Text(
                            'high'.tr,
                            style: const TextStyle(
                                color: Colors.blue, fontSize: 10),
                          )),
                        ),
                        const TableCell(
                          child: Center(
                              child: Text(
                            '16-06-2023',
                            style: TextStyle(color: Colors.blue, fontSize: 10),
                          )),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        const TableCell(
                          child: Center(
                              child: Text(
                            '110/80',
                            style: TextStyle(color: Colors.blue, fontSize: 10),
                          )),
                        ),
                        TableCell(
                          child: Center(
                              child: Text(
                            'normal'.tr,
                            style: const TextStyle(
                                color: Colors.blue, fontSize: 10),
                          )),
                        ),
                        const TableCell(
                          child: Center(
                              child: Text(
                            '09-06-2023',
                            style: TextStyle(color: Colors.blue, fontSize: 10),
                          )),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    ),
  ];

  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return Material(
        type: MaterialType.transparency,
        shape: const RoundedRectangleBorder(),
        color: ColorManager.kCyanBlue,
        child: DefaultTabController(
            length: 2,
            child: AlertDialog(
              content: StatefulBuilder(builder: (context, newState) {
                return Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: Get.width * 0.05,
                        ),
                        Container(
                          width: Get.width * 0.45,
                          height: Get.height * 0.055,
                          decoration: BoxDecoration(
                            color: index == 1
                                ? const Color(0xfff1272d3)
                                : ColorManager.kWhiteColor,
                            border: Border.all(
                                color: const Color.fromARGB(255, 17, 83, 196)),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: TabBar(
                            onTap: (value) {
                              newState(() {
                                index = value;
                              });
                            },
                            tabs: const [
                              Tab(
                                text: 'Calculate',
                              ),
                              Tab(text: 'History'),
                            ],
                            indicator: BoxDecoration(
                                color: ColorManager.kPrimaryColor,
                                borderRadius: BorderRadius.circular(5)),
                            labelStyle: const TextStyle(fontSize: 12),
                            indicatorColor: Colors.blue,
                            labelColor: Colors.white,
                            unselectedLabelColor: Colors.black,
                          ),
                        ),
                        SizedBox(
                          width: Get.width * 0.05,
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: Image.asset(
                              Images.crossicon,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Get.height * 0.07,
                    ),
                    Expanded(
                      child: SizedBox(
                        height: Get.height * 0.7,
                        width: Get.width * 1,
                        child: TabBarView(
                          children: pages,
                        ),
                      ),
                    ),
                  ],
                );
              }),
            )),
      );
    },
  );
}

late List<Widget> glocupages;

gLocuseMonitor(BuildContext context) {
  glocupages = [
    // Page 1 content
    SingleChildScrollView(
      child: Column(
        children: [
          Text(
            'glucosemoniter'.tr,
            style: GoogleFonts.poppins(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1272D3)),
          ),
          SizedBox(
            height: Get.height * 0.06,
          ),
          Image.asset(
            Images.glocu,
          ),
          SizedBox(
            height: Get.height * 0.04,
          ),
          CustomText(
            hintText: 'fasting'.tr,
            fillColor: Colors.white,
            prefixIcon: Image.asset(
              Images.twoarrows,
              height: 5,
              width: 5,
            ),
          ),
          SizedBox(
            height: Get.height * 0.01,
          ),
          CustomText(
            hintText: 'enterValue'.tr,
            fillColor: Colors.white,
            prefixIcon: Image.asset(
              Images.blood,
              height: 5,
              width: 5,
            ),
          ),
          PrimaryButton(
            width: Get.width * 0.65,
            title: 'Save Reading'.tr,
            onPressed: () async {},
            color: ColorManager.kPrimaryColor,
            textcolor: ColorManager.kWhiteColor,
            fontSize: 12,
          )
        ],
      ),
    ),

    SingleChildScrollView(
      child: Column(
        children: [
          Text(
            'glocuselevel'.tr,
            style: GoogleFonts.poppins(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1272D3)),
          ),
          SizedBox(
            height: Get.height * 0.05,
          ),
          Container(
            height: Get.height * 0.5,
            width: Get.width * 1,
            decoration: BoxDecoration(
              color: const Color(0xFFE5EBF4),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Get.width * 0.25,
                    vertical: Get.height * 0.02,
                  ),
                  child: Text(
                    'history'.tr,
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1272D3),
                    ),
                  ),
                ),
                Table(
                  border: TableBorder.all(
                      color: Colors.transparent), // Hide table borders
                  children: [
                    TableRow(
                      children: [
                        TableCell(
                          child: Center(
                            child: Text(
                              'values'.tr,
                              style: const TextStyle(
                                  color: Colors.blue, fontSize: 12),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Center(
                            child: Text(
                              'datetime'.tr,
                              style: const TextStyle(
                                  color: Colors.blue, fontSize: 12),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const TableRow(
                      children: [
                        TableCell(
                          child: Center(
                              child: Text(
                            '90',
                            style: TextStyle(color: Colors.blue, fontSize: 10),
                          )),
                        ),
                        TableCell(
                          child: Center(
                              child: Text(
                            '16-06-2023-15:23',
                            style: TextStyle(color: Colors.blue, fontSize: 10),
                          )),
                        ),
                      ],
                    ),
                    const TableRow(
                      children: [
                        TableCell(
                          child: Center(
                              child: Text(
                            '110',
                            style: TextStyle(color: Colors.blue, fontSize: 10),
                          )),
                        ),
                        TableCell(
                          child: Center(
                              child: Text(
                            '09-06-2023-18:23',
                            style: TextStyle(color: Colors.blue, fontSize: 10),
                          )),
                        ),
                      ],
                    ),
                    const TableRow(
                      children: [
                        TableCell(
                          child: Center(
                              child: Text(
                            '70',
                            style: TextStyle(color: Colors.blue, fontSize: 10),
                          )),
                        ),
                        TableCell(
                          child: Center(
                              child: Text(
                            '09-06-2023-17:30',
                            style: TextStyle(color: Colors.blue, fontSize: 10),
                          )),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    ),
  ];

  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return Material(
        type: MaterialType.transparency,
        shape: const RoundedRectangleBorder(),
        color: ColorManager.kCyanBlue,
        child: DefaultTabController(
            length: 2,
            child: AlertDialog(
              content: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: Get.width * 0.05,
                      ),
                      Container(
                        width: Get.width * 0.5,
                        height: Get.height * 0.055,
                        decoration: BoxDecoration(
                          color: glocupages == 0
                              ? const Color(0xfff1272d3)
                              : ColorManager.kWhiteColor,
                          border: Border.all(
                              color: const Color.fromARGB(255, 17, 83, 196)),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: TabBar(
                          tabs: const [
                            Tab(
                              text: 'Calculate',
                            ),
                            Tab(text: 'History'),
                          ],
                          indicator: BoxDecoration(
                              color: ColorManager.kPrimaryColor,
                              borderRadius: BorderRadius.circular(5)),
                          labelStyle: const TextStyle(fontSize: 12),
                          indicatorColor: Colors.blue,
                          labelColor: Colors.white,
                          unselectedLabelColor: Colors.black,
                        ),
                      ),
                      SizedBox(
                        width: Get.width * 0.05,
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Image.asset(
                            Images.crossicon,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Get.height * 0.07,
                  ),
                  Expanded(
                    child: SizedBox(
                      height: Get.height * 0.7,
                      width: Get.width * 1,
                      child: TabBarView(
                        children: glocupages,
                      ),
                    ),
                  ),
                ],
              ),
            )),
      );
    },
  );
}
