import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:tabib_al_bait/components/custom_textfields.dart';
import 'package:tabib_al_bait/components/image_container.dart';
import 'package:tabib_al_bait/components/primary_button.dart';
import 'package:tabib_al_bait/data/controller/lab_investigations_controller.dart';
import 'package:tabib_al_bait/data/controller/packages_controller.dart';
import 'package:tabib_al_bait/helpers/color_manager.dart';
import 'package:tabib_al_bait/helpers/values_manager.dart';
import 'package:tabib_al_bait/screens/family_screens/family_members.dart';

class PackagesList extends StatefulWidget {
  const PackagesList({super.key});

  @override
  State<PackagesList> createState() => _PackagesListState();
}

class _PackagesListState extends State<PackagesList> {
  @override
  void initState() {
    LabInvestigationController.i.getAllPackages();
    packages();
    super.initState();
  }

  packages() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      LabInvestigationController.i.labPackages =
          await LabInvestigationController.i.getAllPackages();
    });
  }

  @override
  Widget build(BuildContext context) {
    var cont = Get.put<PackagesController>(PackagesController());
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: CustomAppBar(
          title: 'Packages',
        ),
      ),
      body: GetBuilder<LabInvestigationController>(builder: (cont) {
        return BlurryModalProgressHUD(
          inAsyncCall: cont.isPackagesLoading,
          blurEffectIntensity: 4,
          progressIndicator: const SpinKitSpinningLines(
            color: Color(0xff1272d3),
            size: 60,
          ),
          dismissible: false,
          opacity: 0.4,
          color: Theme.of(context).scaffoldBackgroundColor,
          child: SafeArea(
              minimum: const EdgeInsets.all(AppPadding.p20),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          isSizedBoxAvailable: false,
                          prefixIcon: const Icon(
                            Icons.search,
                            color: ColorManager.kPrimaryColor,
                          ),
                          hintText: 'search'.tr,
                        ),
                      ),
                      SizedBox(
                        width: Get.width * 0.02,
                      ),
                      ImageContainer(
                        onpressed: () {
                          LabInvestigationController.i.getAllPackages();
                        },
                        backgroundColor: ColorManager.kPrimaryColor,
                        color: ColorManager.kWhiteColor,
                        imagePath: 'assets/images/reload.png',
                        isSvg: false,
                      )
                    ],
                  ),
                  GetBuilder<LabInvestigationController>(builder: (packages) {
                    return GetBuilder<PackagesController>(builder: (cont) {
                      return Flexible(
                        child: ListView.builder(
                            // physics: const NeverScrollableScrollPhysics(),
                            itemCount: packages.labPackages!.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              var package = packages.labPackages?[index];
                              return Padding(
                                padding: EdgeInsets.only(
                                    bottom: 10, top: index == 0 ? 10 : 0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      border:
                                          Border.all(color: Colors.grey[200]!),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.all(AppPadding.p14)
                                                .copyWith(bottom: 0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  '${package?.packageGroupName}',
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w900),
                                                ),
                                                PrimaryButton(
                                                    radius: 20,
                                                    height: Get.height * 0.03,
                                                    width: Get.width * 0.2,
                                                    fontSize: 12,
                                                    title: 'Book'.tr,
                                                    onPressed: () async {
                                                      PackagesController.i
                                                          .updateselectednewpackage(
                                                              package!);
                                                      await PackagesController.i
                                                          .updatediscount(
                                                              PackagesController
                                                                  .i
                                                                  .selectedLabPackage!
                                                                  .packageGroupDiscountRate!,
                                                              PackagesController
                                                                  .i
                                                                  .selectedLabPackage!
                                                                  .total!);
                                                      // await PackagesController.i.totalVatPercentOfPackages();
                                                      //  PackagesController.i.totalPriceOfPackages();
                                                      await cont
                                                          .addlabpackage();
                                                      Get.back();
                                                      LabInvestigationController
                                                          .i
                                                          .update();
                                                    },
                                                    color: ColorManager
                                                        .kPrimaryColor,
                                                    textcolor: ColorManager
                                                        .kWhiteColor)
                                              ],
                                            ),
                                            SizedBox(
                                              height: Get.height * 0.02,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  '${package?.total}/-',
                                                  style: TextStyle(
                                                      decoration:
                                                          package?.packageGroupDiscountRate ==
                                                                  0.0
                                                              ? TextDecoration
                                                                  .lineThrough
                                                              : TextDecoration
                                                                  .none,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  width: Get.width * 0.02,
                                                ),
                                                package?.packageGroupDiscountRate ==
                                                        0.0
                                                    ? Text(
                                                        '${(package?.total ?? 0 - package!.packageGroupDiscountRate!)}/-',
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 12),
                                                      )
                                                    : const SizedBox.shrink()
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Divider(
                                        color: ColorManager.kblackColor,
                                      ),
                                      ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: package!
                                              .dTOPackageGroupDetail?.length,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemBuilder: ((context, index) {
                                            var detail = package
                                                .dTOPackageGroupDetail?[index];
                                            return Padding(
                                              padding: const EdgeInsets.all(
                                                      AppPadding.p14)
                                                  .copyWith(
                                                      bottom: index ==
                                                              package.dTOPackageGroupDetail!
                                                                      .length -
                                                                  1
                                                          ? 15
                                                          : 0,
                                                      top: index == 0 ? 10 : 0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  SizedBox(
                                                    width: Get.width * 0.6,
                                                    child: Text(
                                                      '${detail?.name?.split('--').last.split(';').first}',
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodySmall,
                                                    ),
                                                  ),
                                                  Text('${detail?.total} /-'),
                                                ],
                                              ),
                                            );
                                          }))
                                    ],
                                  ),
                                ),
                              );
                            }),
                      );
                    });
                  })
                ],
              )),
        );
      }),
    );
  }
}
