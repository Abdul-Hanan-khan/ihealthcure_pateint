// ignore_for_file: unused_local_variable, use_full_hex_values_for_flutter_colors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tabib_al_bait/components/images.dart';
import 'package:tabib_al_bait/data/controller/auth_controller.dart';
import 'package:tabib_al_bait/data/controller/wallet_controller.dart';
import 'package:tabib_al_bait/helpers/color_manager.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  void dispose() {
    WalletController.i.disposeamount();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(Icons.arrow_back_ios,
                      size: 20, color: ColorManager.kPrimaryColor)),
              Center(
                child: ClipOval(
                  child: Container(
                    width: Get.width * 0.24,
                    height: Get.height * 0.13,
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      image: DecorationImage(
                        image: AssetImage(Images.avatar),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: Get.height * 0.02),
              Center(
                child: AuthController.i.user?.firstName != null
                    ? Text(
                        AuthController.i.user?.firstName != null
                            ? '${AuthController.i.user!.firstName}'
                            : '',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w600, fontSize: 16),
                      )
                    : const SizedBox.shrink(),
              ),
              SizedBox(height: Get.height * 0.002),
              Center(
                child: AuthController.i.user?.address != null
                    ? Text(
                        AuthController.i.user?.address != null
                            ? '${AuthController.i.user!.address}'
                            : '',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w400, fontSize: 12),
                      )
                    : const SizedBox.shrink(),
              ),
              SizedBox(height: Get.height * 0.08),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: ColorManager.kPrimaryLightColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: Get.height * 0.1),
                        Text(
                          'recenttrans'.tr,
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            color: ColorManager.kPrimaryColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: Get.height * 0.01),
                        Padding(
                          padding: EdgeInsets.only(
                              left: Get.width * 0.05, right: Get.width * 0.05),
                          child: const Divider(
                            color: ColorManager.kPrimaryColor,
                            thickness: 1,
                          ),
                        ),
                        SizedBox(height: Get.height * 0.02),
                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: 2,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: EdgeInsets.only(
                                    left: Get.width * 0.03,
                                    right: Get.width * 0.03),
                                child: Column(
                                  children: [
                                    Container(
                                      width: Get.width * 0.9,
                                      decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.2),
                                              spreadRadius: 2,
                                              blurRadius: 3,
                                              offset: const Offset(0, 2),
                                            ),
                                          ],
                                          color: ColorManager.kWhiteColor,
                                          borderRadius:
                                              BorderRadius.circular(13)),
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            top: Get.height * 0.02,
                                            bottom: Get.height * 0.02,
                                            left: Get.width * 0.03,
                                            right: Get.width * 0.03),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'onlineconsultancy'.tr,
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 10,
                                                    color:
                                                        ColorManager.kGreyColor,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                Text(
                                                  '19-08-2023 | 10:24am',
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 10,
                                                    color:
                                                        ColorManager.kGreyColor,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'Dr. Shaikh Hamid',
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 12,
                                                    color: ColorManager
                                                        .kPrimaryColor,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                                Text(
                                                  '${"amount".tr} 1,100/-',
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 12,
                                                    color: ColorManager
                                                        .kblackColor,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: Get.height * 0.015,
                                    ),
                                  ],
                                ),
                              );
                            }),
                        SizedBox(
                          height: Get.height * 0.1,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                creditAlert(context);
                              },
                              child: Container(
                                height: Get.height * 0.07,
                                width: Get.width * 0.25,
                                decoration: BoxDecoration(
                                    color: ColorManager.kPrimaryColor,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                  child: Text(
                                    'add'.tr,
                                    style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      color: ColorManager.kWhiteColor,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: Get.width * 0.04,
                            ),
                            Container(
                              height: Get.height * 0.07,
                              width: Get.width * 0.25,
                              decoration: BoxDecoration(
                                  color: ColorManager.kPrimaryColor,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                child: Text(
                                  'loading'.tr,
                                  style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    color: ColorManager.kWhiteColor,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: Get.width * 0.04,
                            ),
                            Container(
                              height: Get.height * 0.07,
                              width: Get.width * 0.25,
                              decoration: BoxDecoration(
                                  color: ColorManager.kPrimaryColor,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                child: Text(
                                  'Req',
                                  style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    color: ColorManager.kWhiteColor,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: Get.height * 0.03),
                      ],
                    ),
                  ),
                  Positioned(
                    top: -45,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                            color: ColorManager.kPrimaryColor,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                                color: ColorManager.kWhiteColor, width: 5)),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 60, right: 60, top: 20, bottom: 20),
                          child: Column(
                            children: [
                              Text(
                                'Available Balance',
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: ColorManager.kWhiteColor,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                ' 2,645.00',
                                style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  color: ColorManager.kWhiteColor,
                                  fontWeight: FontWeight.w700,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<dynamic> creditAlert(
  BuildContext context,
) async {
  await showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      var contr = Get.put<WalletController>(WalletController());
      return GetBuilder<WalletController>(
        builder: (cont) {
          return SizedBox(
            width: Get.width,
            height: MediaQuery.of(context).size.height * 0.7,
            child: AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(width: Get.width * 0.05),
                        InkWell(
                          onTap: () async {
                            await WalletController.i.disposeamount();
                            Get.back();
                          },
                          child: Image.asset(Images.crossicon),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Get.height * 0.03,
                    ),
                    Center(
                      child: Text(
                        'Add Top up Credit',
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          color: ColorManager.kPrimaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.025,
                    ),
                    Text(
                      'Choose your top up amount',
                      style: GoogleFonts.poppins(
                        fontSize: 10,
                        color: ColorManager.kPrimaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    for (int index = 0;
                        index < WalletController.i.containerValues.length;
                        index++)
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              WalletController.i.updateindex(index);
                            },
                            child: Container(
                              height: Get.height * 0.06,
                              width: Get.width * 1,
                              decoration: BoxDecoration(
                                color: WalletController
                                            .i.selectedContainerIndex ==
                                        index
                                    ? ColorManager
                                        .kPrimaryColor // Set the selected container color to blue
                                    : ColorManager.kSecondaryColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(
                                  top: Get.height * 0.015,
                                  left: Get.width * 0.03,
                                ),
                                child: Text(
                                  WalletController.i.containerValues[index],
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: WalletController
                                                .i.selectedContainerIndex ==
                                            index
                                        ? Colors.white
                                        : ColorManager.kblackColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: Get.height * 0.01,
                          ),
                        ],
                      ),
                    Visibility(
                      visible: WalletController.i.otheramount == true,
                      child: Column(
                        children: [
                          TextFormField(
                            keyboardType: TextInputType.number,
                            controller:
                                WalletController.i.otheramountController,
                            style: const TextStyle(
                                fontSize: 12,
                                color: ColorManager.kblackColor,
                                fontWeight: FontWeight.bold),
                            decoration: InputDecoration(
                              hintStyle: const TextStyle(
                                  fontSize: 12,
                                  color: ColorManager.kblackColor,
                                  fontWeight: FontWeight.bold),
                              hintText: "Enter other amount",
                              filled: true,
                              disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: ColorManager.kSecondaryColor),
                                  borderRadius: BorderRadius.circular(8)),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                    color: ColorManager.kSecondaryColor),
                              ),
                              fillColor: ColorManager.kSecondaryColor,
                              border: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: ColorManager.kSecondaryColor),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(0.0),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: Get.height * 0.015,
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        WalletController.i.updateotheramount();
                      },
                      child: Container(
                        height: Get.height * 0.06,
                        width: Get.width * 1,
                        decoration: BoxDecoration(
                            color: ColorManager.kPrimaryColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: Get.height * 0.015, left: Get.width * 0.03),
                          child: Text(
                            'Other Amount',
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: ColorManager.kWhiteColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    Text(
                      'Choose your top up amount',
                      style: GoogleFonts.poppins(
                        fontSize: 10,
                        color: ColorManager.kPrimaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    InkWell(
                      onTap: () {
                        paymentMethod(context);
                      },
                      child: Container(
                        height: Get.height * 0.06,
                        width: Get.width * 1,
                        decoration: BoxDecoration(
                            color: ColorManager.kSecondaryColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: Get.width * 0.03, right: Get.width * 0.03),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '+Add Card',
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: ColorManager.kblackColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Icon(
                                Icons.keyboard_arrow_down,
                                color: ColorManager.kblackColor,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.05,
                    ),
                    Center(
                      child: Container(
                        height: Get.height * 0.07,
                        width: Get.width * 0.6,
                        decoration: BoxDecoration(
                            color: ColorManager.kPrimaryColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: Text(
                            'Top Up Your Wallet',
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              color: ColorManager.kWhiteColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    },
  );
}

Future<dynamic> paymentMethod(
  BuildContext context,
) async {
  await showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return SizedBox(
            width: Get.width,
            height: MediaQuery.of(context).size.height * 0.7,
            child: AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(width: Get.width * 0.05),
                        InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Image.asset(Images.crossicon),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Get.height * 0.03,
                    ),
                    Center(
                      child: Text(
                        'Payment Method',
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          color: ColorManager.kPrimaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.06,
                    ),
                    Card(
                      elevation: 4,
                      surfaceTintColor: ColorManager.kWhiteColor,
                      child: SizedBox(
                        height: Get.height * 0.06,
                        width: Get.width * 1,
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: Get.width * 0.03, right: Get.width * 0.03),
                          child: Row(
                            children: [
                              Image.asset(Images.paypal),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.015,
                    ),
                    InkWell(
                      onTap: () {
                        masterCard(context);
                      },
                      child: Card(
                        elevation: 4,
                        color: ColorManager.kPrimaryColor,
                        child: SizedBox(
                          height: Get.height * 0.06,
                          width: Get.width * 1,
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: Get.width * 0.03,
                                right: Get.width * 0.03),
                            child: Row(
                              children: [
                                Text(
                                  'Card',
                                  style: GoogleFonts.poppins(
                                    fontSize: 10,
                                    color: ColorManager.kWhiteColor,
                                  ),
                                ),
                                const Spacer(),
                                Image.asset(
                                  Images.visa,
                                  height: 15,
                                  width: 30,
                                  color: ColorManager.kWhiteColor,
                                ),
                                SizedBox(
                                  width: Get.width * 0.02,
                                ),
                                Image.asset(
                                  Images.masterCard,
                                  scale: 0.9,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.015,
                    ),
                    Card(
                      elevation: 4,
                      surfaceTintColor: ColorManager.kWhiteColor,
                      child: SizedBox(
                        height: Get.height * 0.06,
                        width: Get.width * 1,
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: Get.width * 0.03, right: Get.width * 0.03),
                          child: Row(
                            children: [
                              Image.asset(Images.payoneer),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.09,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    },
  );
}

Future<dynamic> masterCard(
  BuildContext context,
) async {
  var cont = Get.put<WalletController>(WalletController());
  await showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return SizedBox(
            width: Get.width,
            height: MediaQuery.of(context).size.height * 0.7,
            child: AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(width: Get.width * 0.05),
                        InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Image.asset(Images.crossicon),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Get.height * 0.03,
                    ),
                    Center(
                      child: Text(
                        'Add Top up Credit',
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          color: ColorManager.kPrimaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.03,
                    ),
                    Row(
                      children: [
                        Text(
                          ' Choose your top up amount',
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            color: ColorManager.kPrimaryColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const Spacer(),
                        Image.asset(
                          Images.visa,
                          height: 15,
                          width: 30,
                          color: const Color(0xff222357),
                        ),
                        SizedBox(
                          width: Get.width * 0.02,
                        ),
                        Image.asset(
                          Images.masterCard,
                          scale: 0.9,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    TextFormField(
                      controller: cont.cardNo,
                      style: const TextStyle(
                          color: ColorManager.kblackColor, fontSize: 10),
                      decoration: InputDecoration(
                        hintStyle: const TextStyle(
                            fontSize: 10, color: ColorManager.kblackColor),
                        hintText: "Enter Card Number",
                        filled: true,
                        disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: ColorManager.kSecondaryColor),
                            borderRadius: BorderRadius.circular(8)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                              color: ColorManager.kSecondaryColor),
                        ),
                        fillColor: ColorManager.kSecondaryColor,
                        border: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: ColorManager.kSecondaryColor),
                          borderRadius: BorderRadius.all(
                            Radius.circular(0.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: Get.width * 0.4,
                          child: TextFormField(
                            controller: cont.expiry,
                            style: const TextStyle(
                                color: ColorManager.kblackColor, fontSize: 10),
                            decoration: InputDecoration(
                              hintStyle: const TextStyle(
                                  fontSize: 10,
                                  color: ColorManager.kblackColor),
                              hintText: "Expiry Date ( mm/yy )",
                              filled: true,
                              disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: ColorManager.kSecondaryColor),
                                  borderRadius: BorderRadius.circular(8)),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                    color: ColorManager.kSecondaryColor),
                              ),
                              fillColor: ColorManager.kSecondaryColor,
                              border: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: ColorManager.kSecondaryColor),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(0.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: Get.width * 0.2,
                          child: TextFormField(
                            controller: cont.cvv,
                            style: const TextStyle(
                                color: ColorManager.kblackColor, fontSize: 10),
                            decoration: InputDecoration(
                              hintStyle: const TextStyle(
                                  fontSize: 10,
                                  color: ColorManager.kblackColor),
                              hintText: "CVV",
                              filled: true,
                              disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: ColorManager.kSecondaryColor),
                                  borderRadius: BorderRadius.circular(8)),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                    color: ColorManager.kSecondaryColor),
                              ),
                              fillColor: ColorManager.kSecondaryColor,
                              border: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: ColorManager.kSecondaryColor),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(0.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    TextFormField(
                      controller: cont.cardHolderName,
                      style: const TextStyle(
                          color: ColorManager.kblackColor, fontSize: 10),
                      decoration: InputDecoration(
                        hintStyle: const TextStyle(
                            fontSize: 10, color: ColorManager.kblackColor),
                        hintText: "Card holder name",
                        filled: true,
                        disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: ColorManager.kSecondaryColor),
                            borderRadius: BorderRadius.circular(8)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                              color: ColorManager.kSecondaryColor),
                        ),
                        fillColor: ColorManager.kSecondaryColor,
                        border: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: ColorManager.kSecondaryColor),
                          borderRadius: BorderRadius.all(
                            Radius.circular(0.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    Text(
                      'To verify your credit/debit card, a small amount will be charged from you, after verification amount will be added to your wallet',
                      style: GoogleFonts.poppins(
                        fontSize: 10,
                        color: const Color(0xfff898f95),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.06,
                    ),
                    Center(
                      child: Container(
                        height: Get.height * 0.06,
                        width: Get.width * 0.5,
                        decoration: BoxDecoration(
                            color: ColorManager.kPrimaryColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: Text(
                            'Add Amount',
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              color: ColorManager.kWhiteColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    },
  );
}
