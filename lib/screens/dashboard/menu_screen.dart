// ignore_for_file: use_build_context_synchronously, unrelated_type_equality_checks, unused_local_variable, unused_field, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tabib_al_bait/data/controller/auth_controller.dart';
import 'package:tabib_al_bait/data/controller/lab_investigations_controller.dart';
import 'package:tabib_al_bait/data/controller/language_controller.dart';
import 'package:tabib_al_bait/data/localDB/local_db.dart';
import 'package:tabib_al_bait/data/repositories/auth_repository/auth_repo.dart';
import 'package:tabib_al_bait/helpers/color_manager.dart';
import 'package:tabib_al_bait/helpers/show_toast.dart';
import 'package:tabib_al_bait/helpers/values_manager.dart';
import 'package:tabib_al_bait/models/languages_model/languages_model.dart';
import 'package:tabib_al_bait/models/user_model.dart';
import 'package:tabib_al_bait/screens/auth_screens/login.dart';
import 'package:tabib_al_bait/screens/change_password/change_password.dart';
import 'package:tabib_al_bait/screens/family_screens/family_members.dart';
import 'package:tabib_al_bait/screens/history/history.dart';
import 'package:tabib_al_bait/screens/no_data_found/no_data_found.dart';
import 'package:tabib_al_bait/screens/packages/packages.dart';
import 'package:tabib_al_bait/screens/profile/profile.dart';
import 'package:tabib_al_bait/utils/constants.dart';
import 'package:tabib_al_bait/utils/dialogue_boxes/lanuage_dialogue.dart';
import '../../components/images.dart';
import 'package:local_auth/local_auth.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  call() async {
    loginstatus = await LocalDb().getLoginStatus() ?? false;
    bool? value = await LocalDb().getfingerprintstatus();
    AuthController.i.updateFingerPrint(value);

    setState(() {});
    if (AuthController.i.fingerprint &&
        AuthController.i.user?.fullName == null) {
      fingercheck();
    }
  }

  bool loginstatus = false;
  @override
  void initState() {
    call();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cont = Get.put<AuthController>(AuthController());
    return Scaffold(
      backgroundColor: ColorManager.kPrimaryColor,
      body: SafeArea(
        minimum: const EdgeInsets.all(AppPadding.p20),
        child: GetBuilder<AuthController>(builder: (cont) {
          return ListView(
            children: [
              SizedBox(
                height: Get.height * 0.08,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: CircleAvatar(
                  radius: 28,
                  backgroundColor: const Color(0xFFFEF4F7),
                  child: AuthController.i.user?.imagePath == null
                      ? const CircleAvatar(
                          backgroundImage: AssetImage(Images.avatar),
                          radius: 25,
                        )
                      : CircleAvatar(
                          backgroundImage: NetworkImage(
                              '$baseURL/${AuthController.i.user?.imagePath}'),
                          radius: 25,
                        ),
                ),
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      AuthController.i.user?.fullName != null
                          ? '${AuthController.i.user?.firstName?.trim()}'
                          : 'patientname'.tr,
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    width: Get.width * 0.15,
                  ),
                  AuthController.i.user?.id != null
                      ? InkWell(
                          child: Image.asset(
                            Images.edit,
                            height: Get.height * 0.03,
                          ),
                          onTap: () async {
                            var isLoggedIn = await LocalDb().getLoginStatus();
                            if (isLoggedIn == true) {
                              Get.to(() => EditProfile(
                                    firstName:
                                        AuthController.i.user?.fullName ?? "",
                                    dob: AuthController.i.user?.dateofbirth ??
                                        "",
                                    cellNumber:
                                        AuthController.i.user?.cellNumber ?? "",
                                    email: AuthController.i.user?.email ?? "",
                                    country:
                                        AuthController.i.user?.country ?? "",
                                    province: AuthController
                                            .i.user?.stateOrProvince ??
                                        "",
                                    city: AuthController.i.user?.city ?? "",
                                    patientAddress:
                                        AuthController.i.user?.address ?? "",
                                  ));
                            } else {
                              Get.to(() => const LoginScreen());
                            }
                          },
                        )
                      : const SizedBox.shrink(),
                ],
              ),

              // SizedBox(
              //   width: Get.width * 0.5,
              //   child: TextFormField(
              //     decoration: InputDecoration(
              //       enabled: false,
              //       hintText: AuthController.i.user?.fullName != null
              //           ? '${AuthController.i.user?.fullName}'
              //           : '',
              //       hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
              //           fontSize: 20, color: ColorManager.kWhiteColor),
              //     ),
              //   ),
              // ),
              const Divider(
                color: Colors.white,
                thickness: 1,
              ),
              Text(
                "MR No. ${AuthController.i.user?.mRNo ?? "-"}",
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
              ),
              SizedBox(
                height: Get.height * 0.035,
              ),

              customListTile(context, onTap: () async {
                var isLoggedIn = await LocalDb().getLoginStatus();
                if (isLoggedIn == true) {
                  Get.to(() => const History());
                } else {
                  Get.to(() => const LoginScreen());
                }
              },
                  isIcon: true,
                  icon: const Icon(
                    Icons.history,
                    fill: 0.9,
                    size: 35,
                    color: Colors.white,
                  ),
                  title: 'history'.tr),
              customListTile(
                context,
                onTap: () async {
                  var isLoggedIn = await LocalDb().getLoginStatus();
                  if (isLoggedIn == true) {
                    Get.to(() => const FamilyMembers());
                  } else {
                    Get.to(() => const LoginScreen());
                  }
                },
                imagePath: Images.family,
                title: 'familyMembers'.tr,
              ),
              // customListTile(
              //   context,
              //   onTap: () {
              //     Get.to(() => const NoDataFound());
              //   },
              //   imagePath: Images.location,
              //   title: 'location'.tr,
              // ),
              customListTile(
                context,
                imagePath: Images.wallet,
                title: 'wallet'.tr,
                onTap: () async {
                  var isLoggedIn = await LocalDb().getLoginStatus();
                  if (isLoggedIn == true) {
                    Get.to(() => const NoDataFound());
                  } else {
                    Get.to(() => const LoginScreen());
                  }
                },
              ),
              customListTile(
                context,
                onTap: () async {
                  var isLoggedIn = await LocalDb().getLoginStatus();
                  if (isLoggedIn == true) {
                    Get.to(() => const Drawerpackages());
                  } else {
                    Get.to(() => const LoginScreen());
                  }
                },
                imagePath: Images.package,
                title: 'packages'.tr,
              ),
              AuthController.i.loginStatus == true
                  ? customListTile(context, onTap: () async {
                      String? id = await LocalDb().getPatientId();
                      String? token = await LocalDb().getToken();
                      // bool? loginStatus = await LocalDb().getLoginStatus();
                      // AuthController.i.updateLoginStatus(false);

                      Get.to(() => const ChangePassword());
                    },
                      isIcon: false,
                      imagePath: Images.lock,
                      // imagePath: Images.delete,
                      title: 'changePassword'.tr,
                      textColor: ColorManager.kWhiteColor)
                  : const SizedBox.shrink(),

              // customListTile(context, onTap: () {
              //   Get.to(() => const NoDataFound());
              // }, imagePath: Images.lock, title: 'changePassword'.tr,imageHeight: Get.height*0.038),
              customListTile(context,
                  onTap: () async {},
                  imagePath: Images.fingerprint,
                  title: 'biometric'.tr,
                  togglebutton: true,
                  isToggled: AuthController.i.fingerprint),
              customListTile(
                context,
                isIcon: true,
                icon: Image.asset(
                  'assets/images/languagespng.png',
                  color: Colors.white,
                  height: 30,
                ),
                // imagePath: Images.language,
                title: 'languages'.tr,

                onTap: () async {
                  // LabInvestigationController.i.updateSelectedIndex(0);
                  // LanguageController.i.updateSelected(LanguageModel(
                  //     id: 0, name: 'English', locale: Locale('en', 'US')));
                  // LabInvestigationController.i.update();
                  // LanguageController.i.update();
                  await languageSelector(context, AppConstants.languages);
                },
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              const Divider(
                color: Colors.white,
                thickness: 1,
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              InkWell(
                onTap: () {
                  showDialog(
                      context: Get.context!,
                      builder: (context) {
                        return StatefulBuilder(builder: (context, setstate) {
                          return Scaffold(
                            backgroundColor: Colors.transparent,
                            body: Material(
                              color: Colors.transparent,
                              child: AlertDialog(
                                scrollable: true,
                                title: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Text(
                                        'privacyPolicy'.tr,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                                color: ColorManager.kblackColor,
                                                fontSize: 13,
                                                fontWeight: FontWeight.w900),
                                      ),
                                      const Divider(
                                        color: ColorManager.kblackColor,
                                      ),
                                    ],
                                  ),
                                ),
                                backgroundColor: Colors.white,
                                content: SizedBox(
                                  width: Get.width,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: Get.height * 0.6,
                                        child: SingleChildScrollView(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'consentTitle'.tr,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                        color: ColorManager
                                                            .kblackColor,
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.w900),
                                              ),
                                              Text(
                                                'consent'.tr,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                        fontSize: 12,
                                                        color: ColorManager
                                                            .kblackColor),
                                              ),
                                              Text(
                                                'informationWeCollect'.tr,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                        fontSize: 13,
                                                        color: ColorManager
                                                            .kblackColor,
                                                        fontWeight:
                                                            FontWeight.w900),
                                              ),
                                              SizedBox(
                                                height: Get.height * 0.01,
                                              ),
                                              Text(
                                                'information1'.tr,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                        fontSize: 12,
                                                        color: ColorManager
                                                            .kblackColor),
                                              ),
                                              SizedBox(
                                                height: Get.height * 0.02,
                                              ),
                                              Text(
                                                'information2'.tr,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                        fontSize: 12,
                                                        color: ColorManager
                                                            .kblackColor),
                                              ),
                                              SizedBox(
                                                height: Get.height * 0.02,
                                              ),
                                              Text(
                                                'usageTitle'.tr,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                        fontSize: 13,
                                                        color: ColorManager
                                                            .kblackColor,
                                                        fontWeight:
                                                            FontWeight.w900),
                                              ),
                                              SizedBox(
                                                height: Get.height * 0.02,
                                              ),
                                              Text(
                                                'usage'.tr,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                        fontSize: 12,
                                                        color: ColorManager
                                                            .kblackColor),
                                              ),
                                              Text(
                                                'disclosureTitle'.tr,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                        fontSize: 13,
                                                        color: ColorManager
                                                            .kblackColor,
                                                        fontWeight:
                                                            FontWeight.w900),
                                              ),
                                              Text(
                                                'disclosure'.tr,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                        fontSize: 12,
                                                        color: ColorManager
                                                            .kblackColor),
                                              ),
                                              SizedBox(
                                                height: Get.height * 0.02,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: RichText(
                                              text: TextSpan(
                                                children: <TextSpan>[
                                                  TextSpan(
                                                    children: <InlineSpan>[
                                                      WidgetSpan(
                                                        child: SizedBox(
                                                            width: Get.width *
                                                                0.01),
                                                      ),
                                                    ],
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleMedium
                                                        ?.copyWith(
                                                            color: ColorManager
                                                                .kblackColor,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 12),
                                                    // text: 'theTermsAndCondition'
                                                    //     .tr,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.blue,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10))),
                                                onPressed: () {
                                                  Get.back();
                                                },
                                                child: const Text("Ok")),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        });
                      });
                },
                child: Text(
                  'privacyPolicy'.tr,
                  style: const TextStyle(
                      color: ColorManager.kWhiteColor, fontSize: 14),
                ),
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              InkWell(
                onTap: () {
                  showDialog(
                      context: Get.context!,
                      builder: (context) {
                        return StatefulBuilder(builder: (context, setstate) {
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
                                      'termsAndConditions'.tr,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                              color: ColorManager.kblackColor,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w900),
                                    ),
                                    const Divider(
                                      color: ColorManager.kblackColor,
                                    ),
                                  ],
                                ),
                                backgroundColor: Colors.white,
                                content: SizedBox(
                                  width: Get.width,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: Get.height * 0.6,
                                        child: SingleChildScrollView(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'termsofuse'.tr,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                        color: ColorManager
                                                            .kblackColor,
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.w900),
                                              ),
                                              SizedBox(
                                                height: Get.height * 0.02,
                                              ),
                                              Text(
                                                'link'.tr,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                        fontSize: 12,
                                                        color: ColorManager
                                                            .kblackColor),
                                              ),
                                              SizedBox(
                                                height: Get.height * 0.02,
                                              ),
                                              Text(
                                                'access'.tr,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                        fontSize: 13,
                                                        color: ColorManager
                                                            .kblackColor,
                                                        fontWeight:
                                                            FontWeight.w900),
                                              ),
                                              SizedBox(
                                                height: Get.height * 0.01,
                                              ),
                                              Text(
                                                'accessinformation'.tr,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                        fontSize: 12,
                                                        color: ColorManager
                                                            .kblackColor),
                                              ),
                                              SizedBox(
                                                height: Get.height * 0.02,
                                              ),
                                              // Text(
                                              //   'disclaimer1'.tr,
                                              //   style: Theme.of(context)
                                              //       .textTheme
                                              //       .bodyMedium!
                                              //       .copyWith(
                                              //           fontSize: 12,
                                              //           color: ColorManager
                                              //               .kblackColor),
                                              // ),
                                              // SizedBox(
                                              //   height: Get.height * 0.02,
                                              // ),
                                              Text(
                                                'disclaimertitle'.tr,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                        fontSize: 13,
                                                        color: ColorManager
                                                            .kblackColor,
                                                        fontWeight:
                                                            FontWeight.w900),
                                              ),
                                              SizedBox(
                                                height: Get.height * 0.02,
                                              ),
                                              Text(
                                                'disclaimer1'.tr,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                        fontSize: 12,
                                                        color: ColorManager
                                                            .kblackColor),
                                              ),
                                              SizedBox(
                                                height: Get.height * 0.02,
                                              ),
                                              Text(
                                                'contactinfo'.tr,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                        fontSize: 13,
                                                        color: ColorManager
                                                            .kblackColor,
                                                        fontWeight:
                                                            FontWeight.w900),
                                              ),
                                              SizedBox(
                                                height: Get.height * 0.02,
                                              ),
                                              Text(
                                                'contactinfodetail'.tr,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                        fontSize: 12,
                                                        color: ColorManager
                                                            .kblackColor),
                                              ),
                                              SizedBox(
                                                height: Get.height * 0.02,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: RichText(
                                              text: TextSpan(
                                                children: <TextSpan>[
                                                  TextSpan(
                                                    children: <InlineSpan>[
                                                      WidgetSpan(
                                                        child: SizedBox(
                                                            width: Get.width *
                                                                0.01),
                                                      ),
                                                    ],
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleMedium
                                                        ?.copyWith(
                                                            color: ColorManager
                                                                .kblackColor,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 12),
                                                    // text: 'theTermsAndCondition'
                                                    //     .tr,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.blue,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10))),
                                                onPressed: () {
                                                  Get.back();
                                                },
                                                child: const Text("Ok")),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        });
                      });
                },
                child: Text(
                  'termsAndConditions'.tr,
                  style: const TextStyle(
                      color: ColorManager.kWhiteColor, fontSize: 14),
                ),
              ),
              SizedBox(height: Get.height * 0.06),

              // customListTile(context, onTap: () {
              //   Get.to(() => const RegisterScreen());
              // }, imagePath: Images.wifi, title: 'signup'.tr,imageHeight: Get.height*0.038),

              // AuthController.i.loginStatus == false
              //     ? customListTile(
              //         context,
              //         imagePath: Images.logout,
              //         title: 'Login'.tr,imageHeight: Get.height*0.038,
              //         onTap: () async {
              //           Get.to(() => const LoginScreen());
              //         },
              //       )
              //     : const SizedBox.shrink(),

              SizedBox(
                height: Get.height * 0.04,
              ),
              AuthController.i.loginStatus == true
                  ? customListTile(context, onTap: () async {
                      deleteAccountDialogue(context);
                    },
                      isIcon: true,
                      icon: const Icon(
                        Icons.delete_sharp,
                        size: 35,
                        color: Colors.white,
                      ),
                      // imagePath: Images.delete,
                      title: 'deleteAccount'.tr,
                      // imageHeight: Get.height*0.03,

                      textColor: ColorManager.kWhiteColor)
                  : const SizedBox.shrink(),
              AuthController.i.loginStatus == true
                  ? customListTile(
                      context,
                      imagePath: Images.logout,
                      imageHeight: Get.height * 0.035,
                      title: 'logout'.tr,
                      onTap: () async {
                        var isLoggedin = await LocalDb().getLoginStatus();
                        if (isLoggedin == true) {
                          LocalDb().saveLoginStatus(false);
                          LocalDb.saveUserData(UserDataModel());
                          LocalDb().savePatientId(null);
                          LocalDb().saveToken(null);
                          AuthController.i.updateLoginStatus(false);
                          AuthController.i.updateUser(UserDataModel());
                          await AuthRepo.logout();
                          await lengthOfList();
                          await listToLoad();
                        } else {
                          ToastManager.showToast('You Are already Logged out');
                        }
                      },
                    )
                  : customListTile(
                      context,
                      imagePath: Images.logout,
                      imageHeight: Get.height * 0.035,
                      title: 'login'.tr,
                      onTap: () async {
                        var isLoggedin = await LocalDb().getLoginStatus();
                        if (isLoggedin == false) {
                          Get.to(() => const LoginScreen());
                        } else {
                          ToastManager.showToast('You are already Logged in');
                        }
                      },
                    ),
            ],
          );
        }),
      ),
    );
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

  customListTile(BuildContext context,
      {String? title,
      Function()? onTap,
      Widget? icon,
      Color? textColor = ColorManager.kWhiteColor,
      String? imagePath,
      double? imageHeight = 20,
      bool? togglebutton = false,
      bool? isIcon = false,
      bool? isToggled,
      bool isImageThere = false}) {
    return ListTile(
      visualDensity: const VisualDensity(vertical: -2, horizontal: 0.5),
      onTap: onTap,
      dense: true,
      contentPadding: EdgeInsets.zero,
      leading: isIcon == false
          ? (imagePath != null && imagePath.isNotEmpty)
              ? SizedBox(
                  height: 30,
                  width: 30,
                  child: Image.asset(
                    imagePath,
                  ),
                )
              : const SizedBox.shrink()
          : icon ??
              const Icon(
                Icons.delete,
                color: ColorManager.kRedColor,
                size: 30,
              ),
      title: Text(
        '$title',
        style: Theme.of(context)
            .textTheme
            .bodySmall
            ?.copyWith(color: textColor, fontWeight: FontWeight.bold),
      ),
      trailing: togglebutton == true
          ? GetBuilder<AuthController>(builder: (cont) {
              return Switch(
                value: AuthController.i.fingerprint,
                onChanged: (value) async {
                  if (value == true) {
                    AuthController.i.updateFingerPrint(true);
                    if (AuthController.i.fingerprint) {
                      authentication = await _authenticate();
                      if (authentication) {
                        if (AuthController.i.user?.fullName == null) {
                          String? username = await LocalDb().getusername();
                          String? password = await LocalDb().getpassword();
                          if (username == null && password == null) {
                            ToastManager.showToast('You must login first');
                            AuthController.i.updateFingerPrint(false);
                          } else {
                            await AuthRepo.login(
                                cnic: username, password: password);
                            await LocalDb().savefingerprintstatus(true);
                            // fingerprint = true;
                            AuthController.i.fingerprint =
                                await LocalDb().getfingerprintstatus();

                            setState(() {});
                          }
                          setState(() {});
                        } else {
                          ToastManager.showToast('You are already Logged in');

                          AuthController.i.updateFingerPrint(true);
                        }

                        setState(() {});
                      } else {
                        ToastManager.showToast(
                            "You declined the biometric login.");
                      }

                      if (AuthController.i.fingerprint) {
                        if (authentication) {
                          if (AuthController.i.user?.id != null) {
                            AuthController.i.updateFingerPrint(true);
                          } else {
                            AuthController.i.updateFingerPrint(false);

                            ToastManager.showToast("Use login for first time.");
                          }
                        } else {
                          AuthController.i.updateFingerPrint(false);
                        }
                        LocalDb().savefingerprintstatus(
                            AuthController.i.fingerprint);
                      }
                      // setState(() {
                      //   fingerprint = value;
                      // });
                    } else {
                      AuthController.i.updateFingerPrint(false);

                      LocalDb()
                          .savefingerprintstatus(AuthController.i.fingerprint);
                    }
                  } else {
                    AuthController.i.updateFingerPrint(false);

                    LocalDb()
                        .savefingerprintstatus(AuthController.i.fingerprint);
                  }
                },
                activeTrackColor: ColorManager.kPrimaryLightColor,
                activeColor: ColorManager.kPrimaryColor,
              );
            })
          : const SizedBox.shrink(),
    );
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
}
