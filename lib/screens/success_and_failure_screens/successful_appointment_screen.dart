import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tabib_al_bait/components/images.dart';
import 'package:tabib_al_bait/components/success_or_failed.dart';
import 'package:tabib_al_bait/helpers/values_manager.dart';
import 'package:tabib_al_bait/screens/auth_screens/login.dart';

class SuccessFulAppointScreen extends StatefulWidget {
  final String? imagePath;
  final bool? isLabInvestigationBooking;
  final String? firstButtonText;
  final Function()? onPressedFirst;
  final Function()? onPressedSecond;
  final String? appoinmentFailedorSuccessSmalltext;
  final String? title;

  const SuccessFulAppointScreen(
      {super.key,
      this.appoinmentFailedorSuccessSmalltext,
      this.title,
      this.onPressedFirst,
      this.onPressedSecond,
      this.firstButtonText,
      this.isLabInvestigationBooking,
      this.imagePath});

  @override
  State<SuccessFulAppointScreen> createState() =>
      _SuccessFulAppointScreenState();
}

class _SuccessFulAppointScreenState extends State<SuccessFulAppointScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Image.asset(
          Images.logo,
          height: Get.height * 0.08,
        ),
      ),
      body: Stack(
        children: [
          const BackgroundLogoimage(),
          Padding(
            padding: const EdgeInsets.all(AppPadding.p20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppointSuccessfulOrFailedWidget(
                  imagePath: widget.imagePath,
                  isLabInvestigationBooking: widget.isLabInvestigationBooking,
                  onPressedFirst: widget.onPressedFirst,
                  onPressedSecond: widget.onPressedSecond,
                  image: Images.correct,
                  successOrFailedHeader: '${widget.title}',
                  appoinmentFailedorSuccessSmalltext:
                      '${widget.appoinmentFailedorSuccessSmalltext}',
                  firstButtonText: widget.firstButtonText ?? 'ok'.tr,
                  secondButtonText: 'cancel'.tr,
                ),
                const Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
