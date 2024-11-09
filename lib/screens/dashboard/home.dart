// ignore_for_file: use_build_context_synchronously, unused_local_variable

import 'dart:developer';
import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tabib_al_bait/components/images.dart';
import 'package:tabib_al_bait/components/primary_button.dart';
import 'package:tabib_al_bait/data/controller/auth_controller.dart';
import 'package:tabib_al_bait/data/controller/favorites_controller.dart';
import 'package:tabib_al_bait/data/controller/language_controller.dart';
import 'package:tabib_al_bait/data/controller/schedule_controller.dart';
import 'package:tabib_al_bait/data/controller/specialities_controller.dart';
import 'package:tabib_al_bait/data/localDB/local_db.dart';
import 'package:tabib_al_bait/helpers/color_manager.dart';
import 'package:tabib_al_bait/helpers/font_manager.dart';
import 'package:tabib_al_bait/helpers/show_toast.dart';
import 'package:tabib_al_bait/helpers/values_manager.dart';
import 'package:tabib_al_bait/main.dart';
import 'package:tabib_al_bait/models/doctor_consultation_fee.dart';
import 'package:tabib_al_bait/models/search_models.dart';
import 'package:tabib_al_bait/models/services_model.dart';
import 'package:tabib_al_bait/screens/auth_screens/login.dart';
import 'package:tabib_al_bait/screens/book_your_appointment/book_your_appointment.dart';
import 'package:tabib_al_bait/screens/favorites_screen/favorites_screen.dart';
import 'package:tabib_al_bait/screens/health_summary/health_summary.dart';
import 'package:tabib_al_bait/screens/imaging_screen/imaging_booking.dart';
import 'package:tabib_al_bait/screens/lab_screens/lab_investigations.dart';
import 'package:tabib_al_bait/screens/no_data_found/no_data_found.dart';
import 'package:tabib_al_bait/screens/notifications/notification.dart';
import 'package:tabib_al_bait/screens/online_appointment_confirm/online_appointment_confirm.dart';
import 'package:tabib_al_bait/screens/reports/reports_screen.dart';
import 'package:tabib_al_bait/screens/services_home/services_home.dart';
import 'package:tabib_al_bait/screens/specialists_screen/doctor_schedule.dart';
import 'package:tabib_al_bait/screens/specialists_screen/specialists_screen.dart';
import 'package:tabib_al_bait/utils/constants.dart';
import 'package:upgrader/upgrader.dart';
import '../../data/repositories/specialities_repo/specialities_repo.dart';

double screenHeight = MediaQuery.of(Get.context!).size.height;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    // internetCheck();
  }

  int pageIndex = 0;
  int doctorsIndex = 0;
  @override
  void didChangeDependencies() {
    LanguageController.i.updateSelectedIndex(0);
    // getDoctors();

    // loadUserData();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var cont = Get.put(() => FavoritesController());
    List<Services> services = [
      Services(
          title: 'homeService'.tr,
          gradientColor: const Color(0xFF294EA3),
          imagePath: Images.services,
          color: const Color(0xFF97B1EC),
          onPressed: () async {
            Get.to(() => ServicesHome(
                  imagepath: Images.services,
                  title: 'homeService'.tr,
                  isServiceshome: true,
                ));
          }),
      Services(
          gradientColor: const Color(0xFFFCB006),
          title: 'labInvestigationBooking'.tr,
          imagePath: Images.microscope,
          color: const Color(0xFFFDD504),
          onPressed: () async {
            Get.to(() => LabInvestigations(
                  isLabInvestigationBooking: true,
                  isHomeSamle: false,
                  imagePath: Images.microscope,
                  title: 'labInvestigationBooking'.tr,
                ));
          }),
      Services(
          gradientColor: const Color(0xFF006778),
          title: 'imaging'.tr,
          imagePath: Images.imaging,
          color: const Color(0xFF00DEE0),
          onPressed: () async {
            Get.to(() => ImagingBooking(
                  title: 'imaging'.tr,
                ));
          }),
    ];

    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: GetBuilder<AuthController>(builder: (cont) {
          return GetBuilder<SpecialitiesController>(builder: (spec) {
            return GetBuilder<FavoritesController>(builder: (favor) {
              return BlurryModalProgressHUD(
                inAsyncCall: favor.isLoading,
                blurEffectIntensity: 4,
                progressIndicator: const SpinKitSpinningLines(
                  color: Color(0xff1272d3),
                  size: 60,
                ),
                dismissible: false,
                opacity: 0.4,
                color: Theme.of(context).scaffoldBackgroundColor,
                child: SafeArea(
                  minimum: const EdgeInsets.all(AppPadding.p24)
                      .copyWith(top: 15, bottom: 0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: Get.height * 0.03,
                        ),
                        Row(
                          children: [
                            InkWell(
                                onTap: () {
                                  if (ZoomDrawer.of(context)!.isOpen()) {
                                    ZoomDrawer.of(context)!.close();
                                  } else {
                                    ZoomDrawer.of(context)!.open();
                                  }
                                },
                                child: Image.asset(Images.menuIcon)),
                            SizedBox(
                              width: Get.width * 0.04,
                            ),
                            CircleAvatar(
                              radius: 28,
                              backgroundColor: const Color(0xFFFEF4F7),
                              child: AuthController.i.user?.imagePath == null
                                  ? const CircleAvatar(
                                      backgroundImage:
                                          AssetImage(Images.avatar),
                                      radius: 25,
                                    )
                                  : CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          '$baseURL/${AuthController.i.user?.imagePath}'),
                                      radius: 25,
                                    ),
                            ),
                            SizedBox(
                              width: Get.width * 0.02,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AuthController.i.user?.fullName != null
                                    ? SizedBox(
                                        width: Get.width * 0.35,
                                        child: Text(
                                          AuthController.i.user?.firstName !=
                                                  null
                                              ? "${AuthController.i.user!.firstName?.trim()}"
                                              : '',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge
                                              ?.copyWith(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 18,
                                              ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      )
                                    : const SizedBox.shrink(),
                                Text(
                                  getGreetingMessage(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                          fontSize: Get.height * 0.018,
                                          color: ColorManager.kGreyColor),
                                ),
                              ],
                            ),
                            const Spacer(),
                            InkWell(
                                onTap: () async {
                                  var isLoggedIn =
                                      await LocalDb().getLoginStatus();
                                  if (isLoggedIn == false) {
                                    Get.to(() => const LoginScreen());
                                  } else {
                                    Get.to(() => const Notifications());
                                  }
                                },
                                child: Image.asset(
                                  Images.notification,
                                  height: Get.height * 0.025,
                                )),
                            SizedBox(
                              width: Get.width * 0.01,
                            ),
                            InkWell(
                                onTap: () async {
                                  var isLoggedin =
                                      await LocalDb().getLoginStatus();
                                  if (isLoggedin == true) {
                                    Get.to(() => const FavoritesScreen());
                                  } else {
                                    Get.to(() => const LoginScreen());
                                  }
                                },
                                child: const Icon(
                                  Icons.favorite_outline,
                                  color: Colors.red,
                                  size: 25,
                                ))
                          ],
                        ),
                        InkWell(
                          onTap: () async {
                            SpecialitiesController.i.getSpecialities();
                            Get.to(() => const BookyourAppointment());
                          },
                          child: Container(
                            height: Get.height * 0.2,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(imageBasedOnLocale(
                                        LanguageController
                                            .i.selected!.locale!)),
                                    fit: BoxFit.fill)),
                          ),
                        ),

                        // SizedBox(
                        //   height: Get.height * 0.01,
                        // ),
                        Text(
                          'services'.tr,
                          style: GoogleFonts.poppins(
                              color: ColorManager.kPrimaryColor,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        Row(
                          children: [
                            for (int i = 0; i < services.length; i++)
                              Expanded(
                                  child: Padding(
                                padding: EdgeInsets.only(right: i != 2 ? 7 : 0),
                                child: ServicesWidget(service: services[i]),
                              )),
                          ],
                        ),
                        // SizedBox(
                        //   height: Get.height * 0.02,
                        // ),
                        // DotsIndicatorRow(
                        //   length: 1,
                        //   pageIndex: pageIndex,
                        //   activeColor: ColorManager.kPrimaryColor,
                        //   inactiveColor: const Color(0xFFDBEAF8),
                        // ),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: PrimaryButton(
                                // padding: const EdgeInsets.only(right: 6),
                                height: Get.height * 0.06,
                                icon: Image.asset(
                                  Images.reportss,
                                  height: Get.height * 0.04,
                                ),
                                title: 'reports'.tr,
                                fontSize: Get.height * 0.012,
                                onPressed: () async {
                                  var isLoggedIn =
                                      await LocalDb().getLoginStatus();
                                  if (isLoggedIn == true) {
                                    Get.to(() => const ReportsScreen());
                                  } else {
                                    Get.to(() => const LoginScreen());
                                  }
                                },
                                radius: 5,
                                isGradient: true,
                                color: const Color(0xFF1272D3),
                                gradientColor: ColorManager.kPrimaryDark,
                                textcolor: ColorManager.kWhiteColor,
                                primaryIcon: true,
                              ),
                            ),
                            SizedBox(
                              width: Get.width * 0.02,
                            ),
                            Expanded(
                              child: PrimaryButton(
                                height: Get.height * 0.06,
                                icon: Image.asset(
                                  Images.cardiac,
                                  height: Get.height * 0.05,
                                ),
                                title: 'healthSummary'.tr,
                                fontSize: Get.height * 0.012,
                                textWidth: Get.width * 0.13,
                                onPressed: () {
                                  if (AuthController.i.loginStatus == true) {
                                    Get.to(() => const HealthSummary());
                                  } else {
                                    Get.to(() => const LoginScreen(
                                          isHealthSummary: true,
                                        ));
                                  }
                                },
                                color: const Color(0xFFFF7B7B),
                                radius: 5,
                                textcolor: ColorManager.kWhiteColor,
                                primaryIcon: true,
                                gradientColor: const Color(0xFF2B2C58),
                              ),
                            ),
                            SizedBox(
                              width: Get.width * 0.02,
                            ),
                            Expanded(
                              child: PrimaryButton(
                                isGradient: true,
                                color: const Color(0xFFF9934F),
                                // padding:
                                //     const EdgeInsets.symmetric(horizontal: 10),
                                height: Get.height * 0.06,
                                icon: Image.asset(
                                  Images.watch,
                                  height: Get.height * 0.05,
                                ),
                                title: 'healthAnalysis'.tr,
                                textWidth: Get.width * 0.1,
                                fontSize: Get.height * 0.011,
                                onPressed: () {
                                  Get.to(() => const NoDataFound());
                                },
                                radius: 5,
                                gradientColor: const Color(0xFF2B2C58),
                                textcolor: ColorManager.kWhiteColor,
                                primaryIcon: true,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        GetBuilder<SpecialitiesController>(
                            builder: (specialists) {
                          return GetBuilder<ScheduleController>(
                              builder: (cont) {
                            return SpecialitiesController
                                    .i.allDoctors.isNotEmpty
                                ? CarouselSlider.builder(
                                    carouselController: CarouselController(),
                                    itemCount: SpecialitiesController
                                        .i.allDoctors.length,
                                    itemBuilder: (context, index, realIndex) {
                                      final service = SpecialitiesController
                                          .i.allDoctors[index];
                                      return availableDoctor(context,
                                          search: service);
                                    },
                                    options: CarouselOptions(
                                      enlargeCenterPage: true,
                                      clipBehavior: Clip.none,
                                      viewportFraction: 1,
                                      initialPage: 0,
                                      height: Get.height * 0.3,
                                      aspectRatio: 18 / 9,
                                      enableInfiniteScroll: false,
                                      onPageChanged: (index, reason) {
                                        setState(() {
                                          doctorsIndex = index;
                                        });
                                      },
                                    ),
                                  )
                                : Center(
                                    child: Padding(
                                    padding: const EdgeInsets.all(10.0)
                                        .copyWith(top: 50),
                                    child: Text('noDoctorsAvailable'.tr),
                                  ));
                          });
                        }),
                        const SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  ),
                ),
              );
            });
          });
        }),
      ),
    );
  }

  availableDoctor(
    BuildContext context, {
    Search? search,
  }) {
    return InkWell(
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: Get.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: const Color(0xFFDBEAF8)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 20),
                          child: Container(
                            height: Get.height * 0.135,
                            width: Get.height * 0.135,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: ColorManager.kPrimaryColor,
                                width: 3,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: search?.picturePath != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          '${containsFile(search!.picturePath!)}/${search.picturePath}',
                                      fit: BoxFit.cover,
                                      errorWidget: (context, url, error) =>
                                          Image.asset(
                                        Images.doctorAvatar,
                                        fit: BoxFit.fitHeight,
                                      ),
                                    ),
                                  )
                                : Image.asset(Images.doctorAvatar),
                          ),
                        ),
                        Flexible(
                          flex: 5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: Get.height * 0.02,
                              ),
                              GetBuilder<FavoritesController>(builder: (cont) {
                                return Row(
                                  // mainAxisAlignment:
                                  //     MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        search?.isOnline == true
                                            ? 'online'.tr
                                            : 'offline'.tr,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                                color: search?.isOnline == true
                                                    ? Colors.green
                                                    : ColorManager.kRedColor,
                                                fontWeight: FontWeight.w900,
                                                fontSize: 12)),
                                    const Spacer(
                                      flex: 4,
                                    ),
                                    const Icon(
                                      Icons.star,
                                      color: ColorManager.kyellowContainer,
                                      size: 20,
                                    ),
                                    SizedBox(
                                      width: Get.width * 0.02,
                                    ),
                                    const Text('${4.5}'),
                                    IconButton(
                                      hoverColor: ColorManager.lightGrey,
                                      autofocus: true,
                                      visualDensity: const VisualDensity(
                                          horizontal: -4, vertical: -4),
                                      padding: EdgeInsets.zero,
                                      onPressed: () async {
                                        var isLoggedin =
                                            await LocalDb().getLoginStatus();
                                        if (isLoggedin == true) {
                                          FavoritesController.i
                                              .updateIsLoading(true);
                                          await FavoritesController.i
                                              .addOrRemoveFromFavorites(Search(
                                                  id: search?.id,
                                                  name: search?.name,
                                                  designation:
                                                      search?.designation,
                                                  subSpeciality:
                                                      search?.speciality,
                                                  speciality:
                                                      search?.speciality));

                                          // await listToLoad();
                                        } else {
                                          ToastManager.showToast(
                                              'youarenotloggedin'.tr);

                                          FavoritesController.i
                                              .updateIsLoading(false);
                                        }
                                        getDoctors();
                                      },
                                      icon: Icon(
                                        FavoritesController.i.favoriteDoctors
                                                    .any((favDoctor) =>
                                                        favDoctor.id ==
                                                        search?.id) ==
                                                true
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: ColorManager.kRedColor,
                                        size: 20,
                                      ),
                                    ),
                                    const Spacer(),
                                  ],
                                );
                              }),
                              Text(
                                '${search?.name?.trim()}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: Get.height * 0.01,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    flex: 8,
                                    child: Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: ColorManager.kPrimaryColor),
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.all(AppPadding.p8)
                                                .copyWith(left: AppPadding.p8),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'generalConsultation'.tr,
                                              textAlign: TextAlign.start,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall
                                                  ?.copyWith(
                                                      color: ColorManager
                                                          .kWhiteColor,
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w900),
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  'experience'.tr,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall
                                                      ?.copyWith(
                                                          color: ColorManager
                                                              .kWhiteColor,
                                                          fontSize: 10,
                                                          fontFamily:
                                                              GoogleFonts.mitr()
                                                                  .fontFamily),
                                                ),
                                                Text(
                                                  ': ${search?.numberofExpereinceyear} ',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall
                                                      ?.copyWith(
                                                          color: ColorManager
                                                              .kWhiteColor,
                                                          fontSize: 10,
                                                          fontFamily:
                                                              GoogleFonts.mitr()
                                                                  .fontFamily),
                                                ),
                                                Text(
                                                  'year'.tr,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall
                                                      ?.copyWith(
                                                          color: ColorManager
                                                              .kWhiteColor,
                                                          fontSize: 10,
                                                          fontFamily:
                                                              GoogleFonts.mitr()
                                                                  .fontFamily),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: Get.width * 0.03,
                                  ),
                                  Flexible(
                                    flex: 3,
                                    child: Container(
                                      alignment: Alignment.centerRight,
                                      decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              bottomLeft: Radius.circular(10)),
                                          color: ColorManager.kyellowContainer),
                                      padding:
                                          const EdgeInsets.all(AppPadding.p8),
                                      child: Text(
                                        '${'token'.tr} \n${'NA'}',
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(
                                                fontWeight:
                                                    FontWeightManager.bold,
                                                fontSize: 8),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: Get.height * 0.05,
                    ),
                  ],
                ),
              ),
              PositionedButtonWidget(
                offset: 10,
                bottom: -15,
                onTap: () async {
                  if (search.isOnline == true) {
                    var isLoggedIn = await LocalDb().getLoginStatus();
                    var branchid = await LocalDb().getBranchId();
                    ConsultancyDetail details =
                        await SpecialitiesRepo().getConsultancyFee(search.id!);
                    Get.to(() => OnlineAppointmentConfirm(
                          doctor: Search(
                            picturePath: search.picturePath,
                            isFavouriteDoctor:
                                search.isFavouriteDoctor.toString(),
                            id: search.id,
                            name: search.name,
                            designation: search.designation,
                            location: search.location,
                            isOnline: search.isOnline,
                            consultancyFee: details.consultancyFee,
                            speciality: search.speciality,
                            subSpeciality: details.displayDesignation,
                            branchId: branchid,
                            onlineVideoConsultationFee: details.consultancyFee,
                          ),
                          details: details,
                        ));
                  } else {
                    ToastManager.showToast('Doctor offline'.tr);
                  }
                },
                icon: Icons.video_call_outlined,
                alignment: Alignment.centerRight,
                iconColor: search!.isOnline == true ? Colors.green : Colors.red,
                borderColor:
                    search.isOnline == true ? Colors.green : Colors.red,
                buttonText: 'consultNow'.tr,
              ),
              PositionedButtonWidget(
                bottom: -15,
                onTap: () async {
                  await SpecialitiesController.i
                      .getDoctorWorkLocations(search.id!);
                  Get.to(() => DoctorSchedule(
                        frombookedappointment: false,
                        reschedule: false,
                        doctor: search,
                      ));
                },
                isImage: true,
                imagePath: Images.clinic,
                offset: 10,
                alignment: Alignment.centerLeft,
                iconColor: Colors.green,
                borderColor: Colors.green,
                buttonText: 'getAppointment'.tr,
              ),
            ],
          ),
        ],
      ),
    );
  }

  // upComingList(BuildContext context,
  //     {DoctorConsultationAppointmentHistoryDataList? list}) {
  //   return InkWell(
  //     onTap: () async {
  //       // await SpecialitiesController.i.getDoctorWorkLocations(list.DoctorId!);
  //     },
  //     child: GetBuilder<FavoritesController>(builder: (fav) {
  //       return Column(
  //         children: [
  //           Stack(
  //             clipBehavior: Clip.none,
  //             children: [
  //               Container(
  //                 width: Get.width,
  //                 decoration: BoxDecoration(
  //                     borderRadius: BorderRadius.circular(15),
  //                     color: const Color(0xFFDBEAF8)),
  //                 child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         Padding(
  //                           padding: const EdgeInsets.symmetric(
  //                               vertical: 20.0, horizontal: 20),
  //                           child: Container(
  //                             height: Get.height * 0.15,
  //                             width: Get.height * 0.15,
  //                             decoration: BoxDecoration(
  //                               border: Border.all(
  //                                 color: ColorManager.kPrimaryColor,
  //                                 width: 3,
  //                               ),
  //                               borderRadius: BorderRadius.circular(10),
  //                             ),
  //                             child: list?.ImagePath != null
  //                                 ? ClipRRect(
  //                                     borderRadius: BorderRadius.circular(10),
  //                                     child: CachedNetworkImage(
  //                                       imageUrl:
  //                                           '${containsFile(list!.ImagePath!)}/${list.ImagePath}',
  //                                       fit: BoxFit.cover,
  //                                       errorWidget: (context, url, error) =>
  //                                           Image.asset(
  //                                         Images.doctorAvatar,
  //                                         fit: BoxFit.fitHeight,
  //                                       ),
  //                                     ),
  //                                   )
  //                                 : Image.asset(Images.doctorAvatar),
  //                           ),
  //                         ),
  //                         Flexible(
  //                           flex: 6,
  //                           child: Column(
  //                             crossAxisAlignment: CrossAxisAlignment.start,
  //                             children: [
  //                               SizedBox(
  //                                 height: Get.height * 0.02,
  //                               ),
  //                               Row(
  //                                 // mainAxisAlignment:
  //                                 //     MainAxisAlignment.spaceBetween,
  //                                 children: [
  //                                   Text(
  //                                       isOnlineOrOffline(list!.DoctorId!) ==
  //                                               true

  //                                           ? 'online'.tr
  //                                           : 'offline'.tr,
  //                                       style: Theme.of(context)
  //                                           .textTheme
  //                                           .bodyMedium
  //                                           ?.copyWith(
  //                                               color: isOnlineOrOffline(
  //                                                           list.DoctorId!) ==
  //                                                       true
  //                                                   ? Colors.green
  //                                                   : ColorManager.kRedColor,
  //                                               fontWeight: FontWeight.bold,
  //                                               fontSize: 12)),
  //                                   const Spacer(
  //                                     flex: 3,
  //                                   ),
  //                                   const Icon(
  //                                     Icons.star,
  //                                     color: ColorManager.kyellowContainer,
  //                                     size: 20,
  //                                   ),
  //                                   SizedBox(
  //                                     width: Get.width * 0.01,
  //                                   ),
  //                                   Text('${list.SlotTokenNumber}'),
  //                                   SizedBox(
  //                                     width: Get.width * 0.01,
  //                                   ),
  //                                   InkWell(
  //                                     onTap: () async {
  //                                       var isLoggedin =
  //                                           await LocalDb().getLoginStatus();
  //                                       if (isLoggedin == true) {
  //                                         await FavoritesController.i
  //                                             .addOrRemoveFromFavorites(Search(
  //                                                 id: list.DoctorId,
  //                                                 name: list.DoctorName,
  //                                                 designation: list.Designation,
  //                                                 subSpeciality: list.Address,
  //                                                 speciality: list.Speciality));
  //                                         await listToLoad();
  //                                         await lengthOfList();
  //                                         setState(() {});
  //                                       } else {
  //                                         showSnackbar(
  //                                             context, 'youarenotloggedin'.tr);
  //                                       }
  //                                     },
  //                                     child: Icon(
  //                                       FavoritesController.i.favoriteDoctors
  //                                                   .any((favDoctor) =>
  //                                                       favDoctor.id ==
  //                                                       list.DoctorId) ==
  //                                               true
  //                                           ? Icons.favorite
  //                                           : Icons.favorite_border,
  //                                       color: ColorManager.kRedColor,
  //                                       size: 20,
  //                                     ),
  //                                   ),
  //                                   const Spacer(),
  //                                 ],
  //                               ),
  //                               Text(
  //                                 '${list.DoctorName?.trim()}',
  //                                 style: Theme.of(context)
  //                                     .textTheme
  //                                     .bodySmall
  //                                     ?.copyWith(
  //                                         fontSize: 12,
  //                                         fontWeight: FontWeight.bold),
  //                               ),
  //                               // SizedBox(
  //                               //   height: Get.height * 0.01,
  //                               // ),
  //                               Row(
  //                                 crossAxisAlignment: CrossAxisAlignment.start,
  //                                 mainAxisAlignment:
  //                                     MainAxisAlignment.spaceBetween,
  //                                 children: [
  //                                   Flexible(
  //                                     flex: 5,
  //                                     child: Container(
  //                                       decoration: BoxDecoration(
  //                                           borderRadius:
  //                                               BorderRadius.circular(15),
  //                                           color: ColorManager.kPrimaryColor),
  //                                       child: Padding(
  //                                         padding: const EdgeInsets.all(
  //                                                 AppPadding.p8)
  //                                             .copyWith(left: AppPadding.p4),
  //                                         child: Column(
  //                                           crossAxisAlignment:
  //                                               CrossAxisAlignment.start,
  //                                           children: [
  //                                             Text(
  //                                               'generalConsultation'.tr,
  //                                               style: Theme.of(context)
  //                                                   .textTheme
  //                                                   .bodySmall
  //                                                   ?.copyWith(
  //                                                       color: ColorManager
  //                                                           .kWhiteColor,
  //                                                       fontSize: 10,
  //                                                       fontWeight:
  //                                                           FontWeight.w900),
  //                                             ),
  //                                             Row(
  //                                               children: [
  //                                                 Text(
  //                                                   'experiance'.tr,
  //                                                   style: Theme.of(context)
  //                                                       .textTheme
  //                                                       .bodySmall
  //                                                       ?.copyWith(
  //                                                           color: ColorManager
  //                                                               .kWhiteColor,
  //                                                           fontSize: 10,
  //                                                           fontFamily:
  //                                                               GoogleFonts
  //                                                                       .mitr()
  //                                                                   .fontFamily),
  //                                                 ),
  //                                                 Text(
  //                                                   ' : 23 ',
  //                                                   style: Theme.of(context)
  //                                                       .textTheme
  //                                                       .bodySmall
  //                                                       ?.copyWith(
  //                                                           color: ColorManager
  //                                                               .kWhiteColor,
  //                                                           fontSize: 10,
  //                                                           fontFamily:
  //                                                               GoogleFonts
  //                                                                       .mitr()
  //                                                                   .fontFamily),
  //                                                 ),
  //                                                 Text(
  //                                                   'year'.tr,
  //                                                   style: Theme.of(context)
  //                                                       .textTheme
  //                                                       .bodySmall
  //                                                       ?.copyWith(
  //                                                           color: ColorManager
  //                                                               .kWhiteColor,
  //                                                           fontSize: 10,
  //                                                           fontFamily:
  //                                                               GoogleFonts
  //                                                                       .mitr()
  //                                                                   .fontFamily),
  //                                                 ),
  //                                               ],
  //                                             ),
  //                                           ],
  //                                         ),
  //                                       ),
  //                                     ),
  //                                   ),
  //                                   Flexible(
  //                                     flex: 2,
  //                                     child: Container(
  //                                       alignment: Alignment.centerRight,
  //                                       decoration: const BoxDecoration(
  //                                           borderRadius: BorderRadius.only(
  //                                               topLeft: Radius.circular(10),
  //                                               bottomLeft:
  //                                                   Radius.circular(10)),
  //                                           color:
  //                                               ColorManager.kyellowContainer),
  //                                       padding:
  //                                           const EdgeInsets.all(AppPadding.p8),
  //                                       child: FittedBox(
  //                                           child: Text(
  //                                         '${'token'.tr} \n ${list.SlotTokenNumber}',
  //                                         textAlign: TextAlign.center,
  //                                         style: Theme.of(context)
  //                                             .textTheme
  //                                             .bodySmall
  //                                             ?.copyWith(
  //                                                 fontWeight:
  //                                                     FontWeightManager.bold,
  //                                                 fontSize: 10),
  //                                       )),
  //                                     ),
  //                                   )
  //                                 ],
  //                               ),
  //                             ],
  //                           ),
  //                         )
  //                       ],
  //                     ),
  //                     SizedBox(
  //                       height: Get.height * 0.05,
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //               PositionedButtonWidget(
  //                 offset: 10,
  //                 bottom: -15,
  //                 onTap: () async {
  //                   if (isOnlineOrOffline(list.DoctorId!) == true) {
  //                     var isLoggedIn = await LocalDb().getLoginStatus();
  //                     var branchid = await LocalDb().getBranchId();
  //                     ConsultancyDetail details = await SpecialitiesRepo()
  //                         .getConsultancyFee(list.DoctorId!);
  //                     Get.to(() => OnlineAppointmentConfirm(
  //                           doctor: Search(
  //                             isFavouriteDoctor:
  //                                 list.IsFavouriteDoctor.toString(),
  //                             id: list.DoctorId,
  //                             name: list.DoctorName,
  //                             designation: list.Designation,
  //                             location: list.WorkLocation,
  //                             isOnline: list.IsOnlineAppointment,
  //                             consultancyFee: details.consultancyFee,
  //                             speciality: list.Speciality,
  //                             subSpeciality: details.displayDesignation,
  //                             branchId: branchid,
  //                             onlineVideoConsultationFee:
  //                                 details.consultancyFee,
  //                           ),
  //                           details: details,
  //                         ));
  //                   } else {
  //                   }
  //                 },
  //                 icon: Icons.video_call_outlined,
  //                 alignment: Alignment.centerRight,
  //                 iconColor: isOnlineOrOffline(list.DoctorId!) == true
  //                     ? Colors.green
  //                     : Colors.red,
  //                 borderColor: isOnlineOrOffline(list.DoctorId!) == true
  //                     ? Colors.green
  //                     : Colors.red,
  //                 buttonText: 'consultNow'.tr,
  //               ),
  //               PositionedButtonWidget(
  //                 bottom: -15,
  //                 onTap: () async {
  //                   var branchId = await LocalDb().getBranchId();
  //                   await SpecialitiesController.i
  //                       .getDoctorWorkLocations(list.DoctorId!);
  //                   Get.to(() => DoctorSchedule(
  //                         frombookedappointment: false,
  //                         reschedule: false,
  //                         doctor: Search(
  //                           picturePath: list.ImagePath,
  //                           isFavouriteDoctor:
  //                               list.IsFavouriteDoctor.toString(),
  //                           id: list.DoctorId,
  //                           name: list.DoctorName,
  //                           designation: list.Designation,
  //                           location: list.WorkLocation,
  //                           isOnline: list.IsOnlineAppointment,
  //                           consultancyFee: list.ConsultancyFee,
  //                           speciality: list.Speciality,
  //                           subSpeciality: list.Speciality,
  //                           branchId: branchId,
  //                           onlineVideoConsultationFee: list.ConsultancyFee,
  //                         ),
  //                       ));
  //                 },
  //                 isImage: true,
  //                 imagePath: Images.clinic,
  //                 offset: 10,
  //                 alignment: Alignment.centerLeft,
  //                 iconColor: Colors.green,
  //                 borderColor: Colors.green,
  //                 buttonText: 'getAppointment'.tr,
  //               ),
  //             ],
  //           ),
  //         ],
  //       );
  //     }),
  //   );
  // }

  bookAppointmentContainer(BuildContext context) {
    return InkWell(
      onTap: () async {
        await SpecialitiesController.i.getSpecialities();
        Get.to(() => const BookyourAppointment());
      },
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Image.asset(
                Images.container,
                width: Get.width,
                fit: BoxFit.contain,
                // height: Get.height * 0.2,
              ),
              Directionality(
                textDirection: TextDirection.rtl,
                child: Positioned(
                    bottom: 0,
                    child: Image.asset(
                      Images.docImage,
                      fit: BoxFit.cover,
                      width: screenHeight < 470
                          ? Get.width * 0.3
                          : Get.width * 0.35,
                      alignment: Alignment.bottomCenter,
                    )),
              ),
              Positioned(
                  top: 0,
                  right: 60,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                          width: Get.width * 0.28,
                          child: Text(
                            'onlineOffline'.tr,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    wordSpacing: 0.0,
                                    letterSpacing: 0.1,
                                    color: ColorManager.kWhiteColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w900),
                          )),
                      Text(
                        'consultations'.tr,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: ColorManager.kyellowContainer,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                      )
                    ],
                  )),
              Positioned(
                bottom: -10,
                right: 30,
                child: InkWell(
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: ColorManager.kWhiteColor, width: 5),
                        color: ColorManager.kWhiteColor,
                        borderRadius: BorderRadius.circular(5)),
                    child: PrimaryButton(
                      radius: 5,
                      height: Get.height * 0.06,
                      title: 'booknow'.tr,
                      onPressed: () async {
                        await SpecialitiesController.i.getSpecialities();
                        Get.to(() => const BookyourAppointment());
                      },
                      color: ColorManager.kPrimaryColor,
                      textcolor: ColorManager.kWhiteColor,
                      fontSize: 12,
                      width: Get.width * 0.35,
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class ServicesWidget extends StatelessWidget {
  const ServicesWidget({
    super.key,
    required this.service,
  });

  final Services service;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height * 0.12,
      // width: Get.width * 0.3,
      child: InkWell(
        onTap: service.onPressed,
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: [
                      service.gradientColor!,
                      service.color!,
                    ]),
                color: service.color,
                borderRadius: BorderRadius.circular(5)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  service.imagePath!,
                  height: Get.height * 0.05,
                ),
                SizedBox(
                  height: Get.height * 0.01,
                ),
                Flexible(
                  child: Text(service.title!,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: ColorManager.kWhiteColor,
                          fontSize: Get.height * 0.012,
                          fontWeight: FontWeight.w900)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

String getGreetingMessage() {
  var now = DateTime.now();
  var hour = now.hour;

  if (hour < 12) {
    return 'goodmorning'.tr;
  } else if (hour < 15) {
    return 'goodAfternoon'.tr;
  } else if (hour < 19) {
    return 'goodEvening'.tr;
  } else {
    return 'goodNight'.tr;
  }
}

getDoctors() async {
  SpecialitiesController.i.allDoctors = [];
  SpecialitiesController.i.update();

  List<Search> doctors =
      await SpecialitiesController.i.getDoctors('', query: '');
  for (int i = 0; i < doctors.length; i++) {
    SpecialitiesController.i.allDoctors.add(doctors[i]);
  }
  log('${SpecialitiesController.i.allDoctors.length.toString()} all doctors length');
  // lengthOfList();
  SpecialitiesController.i.update();
}

String imageBasedOnLocale(Locale locale) {
  if (locale == const Locale('en', 'US')) {
    return Images.booknow;
  } else if (locale == const Locale('ur', 'PK')) {
    return Images.urdu;
  } else {
    return Images.arabic;
  }
}
