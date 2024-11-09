// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tabib_al_bait/data/controller/lab_investigations_controller.dart';
import 'package:tabib_al_bait/helpers/color_manager.dart';
import 'package:tabib_al_bait/models/lab_tests_model.dart';

Searchableservice(BuildContext context, List<LabTests> list
    //  TextEditingController fullNameController,
    ) async {
  TextEditingController search = TextEditingController();
  LabTests? generic;

  String title = "";
  await showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return GetBuilder<LabInvestigationController>(
          builder: (lab) {
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
                        children: [
                          TextFormField(
                            decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              hintStyle: const TextStyle(
                                  fontWeight: FontWeight.w900,
                                  color: ColorManager.kPrimaryColor),
                              hintText: 'search'.tr,
                              filled: true,
                              disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: ColorManager.kPrimaryLightColor),
                                  borderRadius: BorderRadius.circular(8)),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                    color: ColorManager.kPrimaryLightColor),
                              ),
                              fillColor: ColorManager.kPrimaryLightColor,
                              prefixIcon: const Icon(
                                Icons.search,
                                color: ColorManager.kPrimaryColor,
                              ),
                              border: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: ColorManager.kPrimaryLightColor),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(0.0),
                                ),
                              ),
                            ),
                            controller: search,
                            onChanged: (val) {
                              title = val;
                              setState(() {
                                title = val;
                              });
                            },
                          ),
                          GetBuilder<LabInvestigationController>(builder: (cont) {
                            return LabInvestigationController.i.isServicesLoading ==
                                    false
                                ? SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.7,
                                    height:
                                        MediaQuery.of(context).size.height * 0.6,
                                    child: ListView.builder(
                                      itemCount: list.length,
                                      itemBuilder: ((context, index) {
                                        if (search.text.isEmpty) {
                                          return InkWell(
                                            onTap: () {
                                              generic = list[index];
                                              Navigator.pop(context);
                                              LabInvestigationController.i
                                                  .updateservice(generic!);
                                            },
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.02,
                                                ),
                                               Text('${list[index].name.toString()}  (${list[index].price.toString()})',),
                                                const Divider()
                                              ],
                                            ),
                                          );
                                        } else if (list[index]
                                            .name
                                            .toString()
                                            .toLowerCase()
                                            .contains(title.toLowerCase())) {
                                          return InkWell(
                                            onTap: () {
                                              generic = list[index];
                                              Navigator.pop(context);
                                              LabInvestigationController.i
                                                  .updateservice(generic!);
                                            },
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.02,
                                                ),
                                                Text('${list[index].name.toString()} ${list[index].price.toString()}',),
                                                const Divider()
                                              ],
                                            ),
                                          );
                                        } else {
                                          return Container();
                                        }
                                      }),
                                    ))
                                : const Center(
                                    child: CircularProgressIndicator(),
                                  );
                          })
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        );
      });

  if (generic != null) {
    return generic;
  }

  //  search.clear();
}
