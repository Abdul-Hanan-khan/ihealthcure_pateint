// ignore_for_file: unused_element
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tabib_al_bait/components/images.dart';
import 'package:tabib_al_bait/data/controller/auth_controller.dart';
import 'package:tabib_al_bait/data/controller/book_appointment_controller.dart';
import 'package:tabib_al_bait/data/controller/lab_investigations_controller.dart';
import 'package:tabib_al_bait/data/controller/language_controller.dart';
import 'package:tabib_al_bait/main.dart';
import 'package:tabib_al_bait/screens/dashboard/menu_drawer.dart';
import 'package:tabib_al_bait/screens/welcome_screen/welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    BookAppointmentController.i.getPaymentMethods();
    LabInvestigationController.i.getLabTests();
    LabInvestigationController.i.getAllPackages();
    LanguageController.i.updateSelectedIndex(0);
    AuthController.i.getGendersFromAPI();
    AuthController.i.getCountriesFromAPI();
    LabInvestigationController.i.getDoctors();
    LabInvestigationController.i.getserviceslist();
    Timer(const Duration(milliseconds: 4500), () {
      Get.offAll(() => initScreen == 0 || initScreen == null
          ? const WelcomeScreen()
          : const DrawerScreen());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Positioned(
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
        ),
        SlideTransitions(
          image: Center(child: Image.asset(Images.logo)),
        )
      ],
    ));
  }
}

class SlideTransitions extends StatefulWidget {
  final Widget? image;
  const SlideTransitions({super.key, this.image});

  @override
  State<SlideTransitions> createState() => _SlideTransitionsState();
}

class _SlideTransitionsState extends State<SlideTransitions>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 3),
    vsync: this,
  )..repeat(reverse: true);
  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(1.5, 0.0),
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.easeIn,
  ));

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: Padding(padding: const EdgeInsets.all(8.0), child: widget.image),
    );
  }
}
