import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tabib_al_bait/components/doctor_cards/doctor_widget.dart';
import 'package:tabib_al_bait/data/controller/favorites_controller.dart';
import 'package:tabib_al_bait/main.dart';
import 'package:tabib_al_bait/screens/family_screens/family_members.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  void initState() {
    // internetCheck();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    var contr = Get.put<FavoritesController>(FavoritesController());
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: CustomAppBar(
          title: 'favorites'.tr,
        ),
      ),
      body: GetBuilder<FavoritesController>(builder: (cnt) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FavoritesController.i.favoriteDoctors.isNotEmpty
                    ? GetBuilder<FavoritesController>(builder: (cont) {
                        return ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: cont.favoriteDoctors.length,
                            itemBuilder: ((context, index) {
                              var favorite =
                                  FavoritesController.i.favoriteDoctors[index];
                              return FavoriteDoctorsCard(
                                doctor: favorite,
                              );
                            }));
                      })
                    : Column(
                        children: [
                          SizedBox(
                            height: Get.height * 0.4,
                          ),
                          Center(
                            child: Text('noFavorites'.tr),
                          ),
                        ],
                      )
              ],
            ),
          ),
        );
      }),
    );
  }
}
