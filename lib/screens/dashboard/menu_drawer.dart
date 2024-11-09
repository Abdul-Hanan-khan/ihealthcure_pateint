import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:tabib_al_bait/data/controller/bottom_nav_bar_controller.dart';
import 'package:tabib_al_bait/helpers/color_manager.dart';
import 'package:tabib_al_bait/screens/dashboard/dashboard.dart';
import 'package:tabib_al_bait/screens/dashboard/menu_screen.dart';

class DrawerScreen extends StatefulWidget {
  final int? index;
  const DrawerScreen({super.key, this.index});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
        controller: BottomBarController.i.drawerController,
        menuScreenTapClose: true,
        dragOffset: 40,
        showShadow: true,
        shadowLayer2Color: const Color(0xFF2157B2),
        menuBackgroundColor: ColorManager.kPrimaryColor,
        angle: 0,
        slideWidth: 300,
        drawerShadowsBackgroundColor: ColorManager.kPrimaryColor,
        menuScreen: const MenuScreen(),
        mainScreen: const DashBoard());
  }
}
