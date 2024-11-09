import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tabib_al_bait/data/controller/packages_controller.dart';
import 'package:tabib_al_bait/helpers/color_manager.dart';
import 'package:tabib_al_bait/models/packages_model.dart';

searchablepackage(BuildContext context, List<LabPackages> list
    //  TextEditingController fullNameController,
    ) async {
  TextEditingController search = TextEditingController();
  LabPackages? generic;
  String title = "";
  await showDialog(
      barrierDismissible: true,
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
                      list.isNotEmpty
                          ? SizedBox(
                              width: MediaQuery.of(context).size.width * 0.7,
                              height: MediaQuery.of(context).size.height * 0.6,
                              child: ListView.builder(
                                itemCount: list.length,
                                itemBuilder: ((context, index) {
                                  if (search.text.isEmpty) {
                                    return InkWell(
                                      onTap: () {
                                        generic = list[index];

                                        PackagesController.i
                                            .updateselectednewpackage(generic!);
                                        Navigator.pop(context);
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
                                          Text(list[index]
                                              .packageGroupName
                                              .toString()),
                                          const Divider()
                                        ],
                                      ),
                                    );
                                  } else if (list[index]
                                      .packageGroupName
                                      .toString()
                                      .toLowerCase()
                                      .contains(title.toLowerCase())) {
                                    return InkWell(
                                      onTap: () {
                                        generic = list[index];
                                        Navigator.pop(context);
                                        PackagesController.i
                                            .updateselectednewpackage(generic!);
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
                                          Text(list[index]
                                              .packageGroupName
                                              .toString()),
                                          const Divider()
                                        ],
                                      ),
                                    );
                                  } else {
                                    return Container();
                                  }
                                  //   Column(
                                  //     crossAxisAlignment: CrossAxisAlignment.start,
                                  //     children: [
                                  //       SizedBox(
                                  //         height:  MediaQuery.of(context).size.height*0.02,
                                  //       ),
                                  //
                                  //       Text(
                                  //         'No Result Found',
                                  //         style: GoogleFonts.poppins(fontSize: 12,fontWeight: FontWeight.normal,color: Colors.black),
                                  //       )
                                  //     ],
                                  //   ),);
                                  // }
                                }),
                              ))
                          : Padding(
                              padding:
                                  const EdgeInsets.all(10.0).copyWith(top: 20),
                              child: Text('noDataFound'.tr),
                            )
                    ],
                  ),
                ),
              ),
            );
          },
        );
      });

  if (generic != null) {
    return generic;
  }
  return [];

  //  search.clear();
}
