// ignore_for_file: avoid_unnecessary_containers, use_build_context_synchronously, unused_field

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_auth/local_auth.dart';
import 'package:tabib_al_bait/components/images.dart';
import 'package:tabib_al_bait/components/primary_button.dart';
import 'package:tabib_al_bait/data/controller/auth_controller.dart';
import 'package:tabib_al_bait/data/localDB/local_db.dart';
import 'package:tabib_al_bait/data/repositories/auth_repository/auth_repo.dart';
import 'package:tabib_al_bait/helpers/color_manager.dart';
import 'package:tabib_al_bait/helpers/font_manager.dart';
import 'package:tabib_al_bait/helpers/show_toast.dart';
import 'package:tabib_al_bait/helpers/values_manager.dart';
import 'package:tabib_al_bait/models/consult_now/consult_now_body.dart';
import 'package:tabib_al_bait/models/lab_test_model2.dart';
import 'package:tabib_al_bait/models/lab_tests_model.dart';
import 'package:tabib_al_bait/screens/auth_screens/register_screen.dart';
import 'package:tabib_al_bait/screens/family_screens/family_members.dart';
import 'package:tabib_al_bait/screens/forgot_password/forgotten_password.dart';

class LoginScreen extends StatefulWidget {
  final bool? isdoctorConsultation;
  final bool? isServicesHomeScreen;
  final bool? isHerefromSchedule;
  final bool? isHealthSummary;
  final bool? isprofile;
  final bool? ishelp;
  final bool? isHealthanalysis;
  final bool? isOnlineAppointmentConsultation;
  final ConsultNowBody? body;
  final String? endTime;
  final String? startTime;
  final String? formattedDate;
  final String? patientId;
  final String? doctorId;
  final bool? isHomeSampleScreen;
  final bool? isOnlineConsultation;
  final List<LabTestHome>? map;
  final List<LabTests>? services;
  final List<LabTests>? consultServices;
  final bool? isLabInvestigationScreen;
  final bool? isBookDoctorAppointmentScreen;
  final bool? isimagingbookingScreen;
  final String? workLocationId;
  final String? branchId;
  final String? sessionId;
  const LoginScreen({
    super.key,
    this.isOnlineAppointmentConsultation = false,
    this.body,
    this.isLabInvestigationScreen = false,
    this.isimagingbookingScreen,
    this.isBookDoctorAppointmentScreen = false,
    this.map,
    this.isHomeSampleScreen = false,
    this.doctorId,
    this.patientId,
    this.formattedDate,
    this.startTime,
    this.isprofile,
    this.ishelp,
    this.endTime,
    this.isOnlineConsultation,
    this.workLocationId,
    this.branchId,
    this.sessionId,
    this.isHealthSummary,
    this.isHerefromSchedule,
    this.isServicesHomeScreen,
    this.services,
    this.isdoctorConsultation,
    this.consultServices,
    this.isHealthanalysis,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    call();
    // internetCheck();
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    AuthController.i.emailController.clear();
    AuthController.i.passwordController.clear();
    super.dispose();
  }

  bool loginstatus = false;

  call() async {
    bool? value = await LocalDb().getfingerprintstatus();
    AuthController.i.updateFingerPrint(value);
  }

  final LocalAuthentication auth = LocalAuthentication();
  List<BiometricType>? _availableBiometrics;
  String _authorized = "Not Authorized";
  bool _isAuthenticating = false;
  bool authentication = false;
  Future<bool> _authenticate() async {
    bool authenticated = false;
    try {
      setState(() {
        _isAuthenticating = true;
        _authorized = "Authenticating";
      });
      authenticated = await auth.authenticate(
        localizedReason: "Let OS determine authentication method",
        options: const AuthenticationOptions(
          stickyAuth: true,
        ),
      );
      setState(() {
        _isAuthenticating = false;
      });
    } on PlatformException catch (e) {
      setState(() {
        _isAuthenticating = false;
        _authorized = "Error - ${e.message}";
      });
      return authenticated;
    }
    if (!mounted) {
      return authenticated;
    }
    setState(
        () => _authorized = authenticated ? "Authorized" : "Not Authorized");
    return authenticated;
  }

  fingercheck() async {
    if (AuthController.i.fingerprint &&
        AuthController.i.user?.fullName == null) {
      authentication = await _authenticate();
      if (authentication) {
        if (AuthController.i.user?.fullName == null) {
          String? username = await LocalDb().getusername();
          String? password = await LocalDb().getpassword();
          if (username != null && password != null) {
            await LocalDb().savefingerprintstatus(true);
            await AuthController.i.updateFingerPrint(true);
            await AuthRepo.login(cnic: username, password: password);
          } else {
            ToastManager.showToast("Use login for first time.");
            AuthController.i.updateFingerPrint(false);
            await LocalDb().savefingerprintstatus(false);
          }
        } else {
          ToastManager.showToast("You are already Logged in");
          AuthController.i.updateFingerPrint(true);
          await LocalDb().savefingerprintstatus(true);
        }

        setState(() {});
      } else {
        ToastManager.showToast("You declined the biometric login.");
      }

      if (AuthController.i.fingerprint) {
        if (authentication) {
          if (AuthController.i.user?.firstName != null) {
            AuthController.i.updateFingerPrint(true);
          } else {
            AuthController.i.updateFingerPrint(true);
          }
        } else {
          AuthController.i.updateFingerPrint(true);
        }
        LocalDb().savefingerprintstatus(AuthController.i.fingerprint);
      }
      // setState(() {
      //   fingerprint = value;
      // });
    } else {
      LocalDb().savefingerprintstatus(AuthController.i.fingerprint);
      AuthController.i.updateFingerPrint(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    var login = Get.put<AuthController>(AuthController());
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: CustomAppBar(
            title: '',
            isScheduleScreen: widget.isLabInvestigationScreen,
            isprofile: widget.isprofile,
            ishelp: widget.ishelp,
            isLogoPresent: true,
            widget: Image.asset(
              Images.logo,
              height: Get.height * 0.08,
            ),
          ),
        ),
        body: SafeArea(
          child: Stack(
            children: [
              const BackgroundLogoimage(),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.all(AppPadding.p20),
                height: Get.height,
                width: Get.width,
                child: Form(
                  key: _formKey,
                  child: GetBuilder<AuthController>(builder: (cont) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Spacer(
                          flex: 1,
                        ),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('welcomeTo'.tr,
                                  textAlign: TextAlign.start,
                                  style: GoogleFonts.raleway(
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold,
                                      color: ColorManager.kPrimaryColor)),
                            ],
                          ),
                        ),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('SIDRA HEALTHCARE',
                                  textAlign: TextAlign.start,
                                  style: GoogleFonts.raleway(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: ColorManager.kPrimaryColor)),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        AuthTextField(
                          function: (p0) {
                            if (p0.length > 15) {
                              return false;
                            }
                            return null;
                          },
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'enterYourNationalId'.tr;
                            }
                            if (val.length > 15) {
                              return 'National ID is invalid';
                            }
                            if (val.length < 10) {
                              return 'National ID is invalid';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.text,
                          controller: login.emailController,
                          hintText: 'username'.tr,
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        AuthTextField(
                          obscureText: cont.isLoginPasswordVisible,
                          suffixIcon: IconButton(
                              onPressed: () {
                                cont.updateisLoginPasswordVisible();
                              },
                              icon: Icon(cont.isLoginPasswordVisible == true
                                  ? Icons.visibility_off
                                  : Icons.visibility)),
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'passwordIsEmpty'.tr;
                            }
                            return null;
                          },
                          controller: login.passwordController,
                          hintText: 'password'.tr,
                        ),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () async {
                                await Get.to(() => const ForgotPassword());
                                AuthController.i.emailController.clear();
                                AuthController.i.passwordController.clear();
                              },
                              child: Text(
                                "forgotPassword".tr,
                                textAlign: TextAlign.right,
                                style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w900,
                                    color: ColorManager.kPrimaryColor),
                              ),
                            ),
                            // TextButton(
                            //     onPressed: () async {
                            //       await Get.to(() => const ForgotPassword());
                            //       AuthController.i.emailController.clear();
                            //       AuthController.i.passwordController.clear();
                            //     },
                            //     child: Text(
                            //       "forgotPassword".tr,
                            //       textAlign: TextAlign.right,
                            //       style: const TextStyle(
                            //           fontSize: 12,
                            //           fontWeight: FontWeight.w900,
                            //           color: ColorManager.kPrimaryColor),
                            //     ))
                          ],
                        ),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        PrimaryButton(
                            title: 'login'.tr,
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                await showDialog(
                                    context: Get.context!,
                                    builder: (context) {
                                      return StatefulBuilder(
                                          builder: (context, setstate) {
                                        return Scaffold(
                                          backgroundColor: Colors.transparent,
                                          body: Material(
                                            color: Colors.transparent,
                                            child: AlertDialog(
                                              scrollable: true,
                                              title: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    'disclaimer'.tr,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium!
                                                        .copyWith(
                                                            color: ColorManager
                                                                .kblackColor,
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w900),
                                                  ),
                                                  const Divider(
                                                    color: ColorManager
                                                        .kblackColor,
                                                  ),
                                                ],
                                              ),
                                              backgroundColor: Colors.white,
                                              content: SizedBox(
                                                width: Get.width,
                                                child: Column(
                                                  children: [
                                                    SizedBox(
                                                      height: Get.height * 0.5,
                                                      child:
                                                          SingleChildScrollView(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              'consentTitle'.tr,
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyMedium!
                                                                  .copyWith(
                                                                      color: ColorManager
                                                                          .kblackColor,
                                                                      fontSize:
                                                                          13,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w900),
                                                            ),
                                                            Text(
                                                              'consent'.tr,
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyMedium!
                                                                  .copyWith(
                                                                      fontSize:
                                                                          12,
                                                                      color: ColorManager
                                                                          .kblackColor),
                                                            ),
                                                            Text(
                                                              'informationWeCollect'
                                                                  .tr,
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyMedium!
                                                                  .copyWith(
                                                                      fontSize:
                                                                          13,
                                                                      color: ColorManager
                                                                          .kblackColor,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w900),
                                                            ),
                                                            SizedBox(
                                                              height:
                                                                  Get.height *
                                                                      0.01,
                                                            ),
                                                            Text(
                                                              'information1'.tr,
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyMedium!
                                                                  .copyWith(
                                                                      fontSize:
                                                                          12,
                                                                      color: ColorManager
                                                                          .kblackColor),
                                                            ),
                                                            SizedBox(
                                                              height:
                                                                  Get.height *
                                                                      0.02,
                                                            ),
                                                            Text(
                                                              'information2'.tr,
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyMedium!
                                                                  .copyWith(
                                                                      fontSize:
                                                                          12,
                                                                      color: ColorManager
                                                                          .kblackColor),
                                                            ),
                                                            SizedBox(
                                                              height:
                                                                  Get.height *
                                                                      0.02,
                                                            ),
                                                            Text(
                                                              'usageTitle'.tr,
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyMedium!
                                                                  .copyWith(
                                                                      fontSize:
                                                                          13,
                                                                      color: ColorManager
                                                                          .kblackColor,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w900),
                                                            ),
                                                            SizedBox(
                                                              height:
                                                                  Get.height *
                                                                      0.02,
                                                            ),
                                                            Text(
                                                              'usage'.tr,
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyMedium!
                                                                  .copyWith(
                                                                      fontSize:
                                                                          12,
                                                                      color: ColorManager
                                                                          .kblackColor),
                                                            ),
                                                            Text(
                                                              'disclosureTitle'
                                                                  .tr,
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyMedium!
                                                                  .copyWith(
                                                                      fontSize:
                                                                          13,
                                                                      color: ColorManager
                                                                          .kblackColor,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w900),
                                                            ),
                                                            Text(
                                                              'disclosure'.tr,
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyMedium!
                                                                  .copyWith(
                                                                      fontSize:
                                                                          12,
                                                                      color: ColorManager
                                                                          .kblackColor),
                                                            ),
                                                            SizedBox(
                                                              height:
                                                                  Get.height *
                                                                      0.02,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: Get.height * 0.03,
                                                    ),
                                                    GetBuilder<AuthController>(
                                                        builder: (cont) {
                                                      return SizedBox(
                                                        height:
                                                            Get.height * 0.06,
                                                        width: Get.width,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Checkbox(
                                                              activeColor:
                                                                  ColorManager
                                                                      .kPrimaryColor,
                                                              focusColor:
                                                                  ColorManager
                                                                      .kPrimaryColor,
                                                              checkColor:
                                                                  ColorManager
                                                                      .kWhiteColor,
                                                              // fillColor:
                                                              //     MaterialStateProperty
                                                              //         .all(Colors
                                                              //             .transparent),
                                                              // activeColor:
                                                              //     ColorManager
                                                              //         .kPrimaryColor,
                                                              // focusColor:
                                                              //     ColorManager
                                                              //         .kPrimaryColor,
                                                              // checkColor:
                                                              //     ColorManager
                                                              //         .kWhiteColor,
                                                              // // fillColor:
                                                              //     MaterialStateProperty
                                                              //         .all(Colors
                                                              //             .transparent),
                                                              value: cont
                                                                  .isChecked,
                                                              onChanged: (bool?
                                                                  newVal) {
                                                                cont.updateisChecked(
                                                                    newVal!);
                                                              },
                                                            ),
                                                            Expanded(
                                                              child: RichText(
                                                                text: TextSpan(
                                                                  children: <TextSpan>[
                                                                    TextSpan(
                                                                      text: 'iHaveRead'
                                                                          .tr,
                                                                      style: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .titleMedium
                                                                          ?.copyWith(
                                                                              color: ColorManager.kblackColor,
                                                                              fontWeight: FontWeightManager.bold,
                                                                              fontSize: 12),
                                                                      children: const <InlineSpan>[
                                                                        WidgetSpan(
                                                                          alignment:
                                                                              PlaceholderAlignment.baseline,
                                                                          baseline:
                                                                              TextBaseline.alphabetic,
                                                                          child:
                                                                              SizedBox(),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    TextSpan(
                                                                      children: <InlineSpan>[
                                                                        WidgetSpan(
                                                                          child:
                                                                              SizedBox(width: Get.width * 0.01),
                                                                        ),
                                                                      ],
                                                                      style: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .titleMedium
                                                                          ?.copyWith(
                                                                              color: ColorManager.kblackColor,
                                                                              fontWeight: FontWeightManager.bold,
                                                                              fontSize: 12),
                                                                      text: 'theTermsAndCondition'
                                                                          .tr,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    }),
                                                    SizedBox(
                                                      height: Get.height * 0.02,
                                                    ),
                                                    GetBuilder<AuthController>(
                                                        builder: (cont) {
                                                      return Row(
                                                        children: [
                                                          Expanded(
                                                              child:
                                                                  PrimaryButton(
                                                                      isLoading:
                                                                          cont
                                                                              .isLoading,
                                                                      isDisabled: !AuthController
                                                                                  .i.isChecked ==
                                                                              false
                                                                          ? false
                                                                          : true,
                                                                      fontSize:
                                                                          12,
                                                                      height: Get
                                                                              .height *
                                                                          0.06,
                                                                      title:
                                                                          'accept'
                                                                              .tr,
                                                                      onPressed:
                                                                          () async {
                                                                        await LocalDb().saveusernamepassword(
                                                                            cont.emailController.text,
                                                                            cont.passwordController.text);
                                                                        await AuthRepo.login(
                                                                            isimagingBookingScreen: widget
                                                                                .isimagingbookingScreen,
                                                                            isschedule: widget.isHerefromSchedule ??
                                                                                false,
                                                                            isprofile: widget.isprofile ??
                                                                                false,
                                                                            isDoctorConsultaion: widget
                                                                                .isdoctorConsultation,
                                                                            services: widget
                                                                                .services,
                                                                            isHealthSummary: widget
                                                                                .isHealthSummary,
                                                                            context:
                                                                                context,
                                                                            isOnlineConsultation:
                                                                                widget.isOnlineAppointmentConsultation,
                                                                            consultNowBody: widget.body,
                                                                            isHomeSampleScreen: widget.isHomeSampleScreen!,
                                                                            isBookAppointmentScreen: widget.isBookDoctorAppointmentScreen!,
                                                                            isLabInvestigationScreen: widget.isLabInvestigationScreen!,
                                                                            cnic: login.emailController.text,
                                                                            password: login.passwordController.text,
                                                                            isServicesHomeScreen: widget.isServicesHomeScreen,
                                                                            list: widget.map);

                                                                        if (AuthController.i.loginchk ??
                                                                            false) {
                                                                          Get.back();
                                                                        }
                                                                      },
                                                                      color: ColorManager
                                                                          .kPrimaryColor,
                                                                      textcolor:
                                                                          ColorManager
                                                                              .kWhiteColor)),
                                                          SizedBox(
                                                            width: Get.width *
                                                                0.03,
                                                          ),
                                                          Expanded(
                                                              child:
                                                                  PrimaryButton(
                                                                      fontSize:
                                                                          12,
                                                                      height: Get
                                                                              .height *
                                                                          0.06,
                                                                      title:
                                                                          'decline'
                                                                              .tr,
                                                                      onPressed:
                                                                          () async {
                                                                        Get.back();
                                                                        AuthController
                                                                            .i
                                                                            .updateIsloading(false);
                                                                      },
                                                                      color: ColorManager
                                                                          .kPrimaryColor,
                                                                      textcolor:
                                                                          ColorManager
                                                                              .kWhiteColor))
                                                        ],
                                                      );
                                                    })
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      });
                                    });
                              }
                              if (AuthController.i.loginchk ?? false) {
                                Get.back();
                              }
                            },
                            color: ColorManager.kPrimaryColor,
                            textcolor: ColorManager.kWhiteColor),
                        SizedBox(
                          height: Get.height * 0.1,
                        ),
                        AuthController.i.fingerprint == true
                            ? Center(
                                child: IconButton(
                                    icon: const Icon(
                                      Icons.fingerprint,
                                      size: 50,
                                    ),
                                    onPressed: () async {
                                      AuthController.i.updateFingerPrint(true);
                                      if (AuthController.i.fingerprint) {
                                        authentication = await _authenticate();
                                        if (authentication) {
                                          if (AuthController.i.user?.fullName ==
                                              null) {
                                            String? username =
                                                await LocalDb().getusername();
                                            String? password =
                                                await LocalDb().getpassword();
                                            if (username == null &&
                                                password == null) {
                                              ToastManager.showToast(
                                                  'You must login first');
                                              AuthController.i
                                                  .updateFingerPrint(false);
                                            } else {
                                              await AuthRepo.login(
                                                  isimagingBookingScreen: widget
                                                      .isimagingbookingScreen,
                                                  isschedule: widget
                                                          .isHerefromSchedule ??
                                                      false,
                                                  isprofile:
                                                      widget.isprofile ?? false,
                                                  isDoctorConsultaion: widget
                                                      .isdoctorConsultation,
                                                  services: widget.services,
                                                  isHealthSummary:
                                                      widget.isHealthSummary,
                                                  context: context,
                                                  isOnlineConsultation: widget
                                                      .isOnlineAppointmentConsultation,
                                                  consultNowBody: widget.body,
                                                  isBookAppointmentScreen: widget
                                                      .isBookDoctorAppointmentScreen!,
                                                  isLabInvestigationScreen: widget
                                                      .isLabInvestigationScreen!,
                                                  cnic: username,
                                                  password: password,
                                                  isServicesHomeScreen: widget
                                                      .isServicesHomeScreen,
                                                  list: widget.map);
                                              await LocalDb()
                                                  .savefingerprintstatus(true);
                                              // fingerprint = true;
                                              AuthController.i.fingerprint =
                                                  await LocalDb()
                                                      .getfingerprintstatus();

                                              setState(() {});
                                            }
                                            setState(() {});
                                          } else {
                                            ToastManager.showToast(
                                                'You are already Logged in');
                                            AuthController.i
                                                .updateFingerPrint(true);
                                          }

                                          setState(() {});
                                        } else {
                                          ToastManager.showToast(
                                              "You declined the biometric login.");
                                        }
                                      }
                                    }),
                              )
                            : const SizedBox.shrink(),
                        const Spacer(
                          flex: 2,
                        ),
                        SignupOrLoginText(
                          login: true,
                          pre: '${'donthaveanAccount'.tr}?',
                          suffix: 'register'.tr,
                          onTap: () {
                            Get.to(() => RegisterScreen(
                                  fromlogin: true,
                                ));
                          },
                        )
                      ],
                    );
                  }),
                ),
              ),
            ],
          ),
        ));
  }
}

class BackgroundLogoimage extends StatelessWidget {
  const BackgroundLogoimage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 100,
      right: 0,
      child: Opacity(
        opacity: 0.4,
        child: Container(
          height: Get.height * 0.8,
          width: Get.width,
          alignment: Alignment.centerLeft,
          child: Image.asset(
            Images.logoBackground,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class SignupOrLoginText extends StatelessWidget {
  final Function()? onTap;
  final String? pre;
  final String? suffix;
  final bool? login;
  const SignupOrLoginText({
    this.login,
    super.key,
    this.pre,
    this.suffix,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '$pre',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        SizedBox(
          width: login != null && login == true
              ? Get.width * 0.01
              : Get.width * 0.02,
        ),
        InkWell(
          onTap: onTap,
          child: Text(
            '$suffix',
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: ColorManager.kPrimaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 16),
          ),
        ),
      ],
    );
  }
}

class AuthTextField extends StatelessWidget {
  final Function(String)? function;
  final bool? obscureText;
  final List<TextInputFormatter>? formatters;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final String? hintText;
  final bool? readOnly;
  const AuthTextField({
    super.key,
    this.hintText,
    this.suffixIcon,
    this.controller,
    this.validator,
    this.readOnly,
    this.formatters,
    this.obscureText,
    this.keyboardType,
    this.function,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: Theme.of(context)
          .textTheme
          .bodyMedium
          ?.copyWith(color: ColorManager.kblackColor, fontSize: 12),
      onChanged: function,
      keyboardType: keyboardType,
      obscureText: obscureText ?? false,
      inputFormatters: formatters,
      readOnly: readOnly ?? false,
      validator: validator,
      controller: controller,
      decoration: InputDecoration(
          errorStyle: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: ColorManager.kRedColor, fontSize: 12),
          suffixIcon: suffixIcon,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          hintText: "$hintText",
          hintStyle: const TextStyle(
            color: ColorManager.kGreyColor,
            fontSize: 12,
          ),
          disabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey)),
          errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: ColorManager.kRedColor)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: ColorManager.kGreyColor)),
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: ColorManager.kGreyColor))),
    );
  }
}
