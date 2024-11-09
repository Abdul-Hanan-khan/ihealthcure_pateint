import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tabib_al_bait/components/custom_textfields.dart';
import 'package:tabib_al_bait/components/primary_button.dart';
import 'package:tabib_al_bait/data/controller/google_maps_controller.dart';
import 'package:tabib_al_bait/helpers/color_manager.dart';
import 'package:tabib_al_bait/helpers/values_manager.dart';
import 'package:tabib_al_bait/screens/family_screens/family_members.dart';

class GoogleMaps extends StatefulWidget {
  const GoogleMaps({super.key});

  @override
  State<GoogleMaps> createState() => _GoogleMapsState();
}

class _GoogleMapsState extends State<GoogleMaps> {
  @override
  void initState() {
    AddressController.i.getcurrentLocation().then((value) {
      AddressController.i.latitude = value.latitude;
      AddressController.i.longitude = value.longitude;
      AddressController.i.initialAddress(value.latitude, value.longitude);
      log('latitude: ${AddressController.i.latitude} , longitude ${AddressController.i.longitude}');
      AddressController.i.markers.clear();
      AddressController.i.markers.add(Marker(
          infoWindow: const InfoWindow(
              title: 'Current Location',
              snippet: 'This is my current Location'),
          position: LatLng(
              AddressController.i.latitude!, AddressController.i.longitude!),
          markerId: const MarkerId('1')));
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: CustomAppBar(
            title: 'selectAddress'.tr,
          )),
      body: Padding(
        padding: const EdgeInsets.all(AppPadding.p20),
        child: Stack(
          children: [
            SizedBox(
              height: Get.height * 0.02,
            ),
            SizedBox(
              height: Get.height * 0.8,
              child: GetBuilder<AddressController>(builder: (address) {
                return address.latitude != null && address.longitude != null
                    ? GoogleMap(
                      // myLocationEnabled: true,
                        onTap: (argument) async {
                          setState(() {
                            address.markers.clear();
                            address.markers.add(Marker(
                                infoWindow: const InfoWindow(
                                    title: 'Current Location',
                                    snippet: 'This is my current Location'),
                                position: LatLng(
                                    argument.latitude, argument.longitude),
                                markerId: const MarkerId('1')));
                            address.currentPlaceList.clear();
                          });
                          GoogleMapController controller =
                              await AddressController.i.mapController.future;

                          controller.animateCamera(
                              CameraUpdate.newCameraPosition(CameraPosition(
                                  zoom: 14,
                                  target: LatLng(
                                      argument.latitude, argument.longitude))));
                          log(AddressController.i.currentLocation.toString());

                          List<Placemark>? placemark =
                              await placemarkFromCoordinates(
                            argument.latitude,
                            argument.longitude,
                          );

                          address.updateAddress(
                              '${placemark[0].subLocality} ${placemark[0].locality} ${placemark[0].country} ${placemark[0].street}');
                          log(AddressController.address.toString());
                          address.currentLocation = await locationFromAddress(
                              AddressController.address!);
                        },
                        initialCameraPosition: CameraPosition(
                            target: LatLng(AddressController.i.latitude!,
                                AddressController.i.longitude!),
                            zoom: 14),
                        mapType: MapType.normal,
                        markers: Set.of(AddressController.i.markers),
                        onMapCreated: (controller) {
                          AddressController.i.mapController
                              .complete(controller);
                        },
                      )
                    : const Center(
                        child: CircularProgressIndicator(),
                      );
              }),
            ),
            Column(
              children: [
                GetBuilder<AddressController>(builder: (cont) {
                  return Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          controller: cont.controller,
                          onchanged: (value) {
                            log(value.toString());
                            setState(() {
                              AddressController.i.getSuggestion(value);
                            });
                          },
                          hintText: 'search'.tr,
                          prefixIcon: const Icon(
                            Icons.search,
                            color: ColorManager.kPrimaryColor,
                          ),
                        ),
                      ),
                    ],
                  );
                }),
                GetBuilder<AddressController>(builder: (address) {
                  return ListView.builder(
                      itemCount: address.currentPlaceList.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () async {
                            if (address.currentPlaceList.isNotEmpty) {
                              address.currentLocation =
                                  await locationFromAddress(address
                                      .currentPlaceList[index]['description']);
                            }

                            setState(() {
                              address.currentPlaceList.clear();
                              address.markers.clear();
                              address.markers.add(Marker(
                                  infoWindow: const InfoWindow(
                                      title: 'Current Location',
                                      snippet: 'This is my current Location'),
                                  position: LatLng(
                                      address.currentLocation!.reversed.last
                                          .latitude,
                                      address.currentLocation!.reversed.last
                                          .longitude),
                                  markerId: const MarkerId('1')));
                            });

                            GoogleMapController controller =
                                await AddressController.i.mapController.future;
                            controller.animateCamera(
                                CameraUpdate.newCameraPosition(CameraPosition(
                                    zoom: 10,
                                    target: LatLng(
                                        AddressController.i.currentLocation!
                                            .reversed.last.latitude,
                                        AddressController.i.currentLocation!
                                            .reversed.last.longitude))));
                            log(AddressController.i.currentLocation.toString());

                            List<Placemark>? placemark =
                                await placemarkFromCoordinates(
                                    address.currentLocation!.last.latitude,
                                    address.currentLocation!.last.longitude);

                            address.updateAddress(
                                '${placemark[0].subLocality} ${placemark[0].locality} ${placemark[0].country} ${placemark[0].street}');
                            log(AddressController.address.toString());
                            address.currentLocation = await locationFromAddress(
                                AddressController.address!);
                            CameraUpdate.newCameraPosition(CameraPosition(
                                zoom: 10,
                                target: LatLng(
                                    address.currentLocation!.reversed.last
                                        .latitude,
                                    address.currentLocation!.reversed.last
                                        .longitude)));
                          },
                          child: Container(
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                AddressController.i.currentPlaceList[index]
                                    ['description'],
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        );
                      });
                }),
                const Spacer(),
                PrimaryButton(
                    fontSize: 14,
                    title: 'selectLocation'.tr,
                    onPressed: () async {
                      AddressController.i.markers.clear();
                      Get.back();
                      AddressController.i.currentLocation =
                          await locationFromAddress(AddressController.address!);
                    },
                    color: ColorManager.kPrimaryColor,
                    textcolor: ColorManager.kWhiteColor)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
