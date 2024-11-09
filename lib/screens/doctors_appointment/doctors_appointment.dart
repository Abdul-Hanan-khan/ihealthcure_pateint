import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tabib_al_bait/components/appoint_ment_card/appointment_cards.dart';
import 'package:tabib_al_bait/components/custom_textfields.dart';
import 'package:tabib_al_bait/data/controller/my_appointments_controller.dart';
import 'package:tabib_al_bait/helpers/values_manager.dart';
import 'package:tabib_al_bait/models/appointment_data.dart';
import 'package:tabib_al_bait/screens/book_your_appointment/book_your_appointment.dart';
import 'package:tabib_al_bait/screens/dashboard/home.dart';
import 'package:tabib_al_bait/screens/family_screens/family_members.dart';
import 'package:tabib_al_bait/screens/lab_screens/lab_investigations.dart';
import '../../components/images.dart';
import '../../data/controller/specialities_controller.dart';
import '../../helpers/color_manager.dart';
import '../../helpers/font_manager.dart';
import '../../models/services_model.dart';

class DoctorsAppointment extends StatelessWidget {
  const DoctorsAppointment({super.key});

  @override
  Widget build(BuildContext context) {
    List<Services> services = [
      Services(
          title: 'homeSample'.tr,
          imagePath: Images.bloodSample,
          color: ColorManager.kPrimaryColor,
          onPressed: () async {
            Get.to(() => LabInvestigations(
                  title: 'homeSample'.tr,
                  isHomeSamle: true,
                ));
          }),
      // Services(
      //     title: 'Lab Investigation Booking',
      //     imagePath: Images.microscope,
      //     color: ColorManager.kyellowContainer,
      //     onPressed: () async {
      //       Get.to(() => const LabInvestigations(
      //             title: 'Lab Investigation Booking',
      //           ));
      //     }),
      // Services(
      //     title: 'Image Booking',
      //     imagePath: Images.imaging,
      //     color: ColorManager.kCyanBlue,
      //     onPressed: () async {
      //       Get.to(() => const NoDataFound());
      //     }),
      Services(
          title: 'doctorConsultation'.tr,
          imagePath: 'assets/images/docImage.png',
          color: ColorManager.kyellowContainer,
          onPressed: () async {
            await SpecialitiesController.i.getSpecialities();
            Get.to(() => const BookyourAppointment());
          }),
    ];
    var controller =
        Get.put<MyAppointmentsController>(MyAppointmentsController());
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(40),
        child: CustomAppBar(
          title: 'My Appointments',
        ),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(AppPadding.p20),
        child: GetBuilder<MyAppointmentsController>(builder: (cont) {
          return Column(
            children: [
              SizedBox(
                height: Get.height * 0.2,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: services.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ServicesWidget(service: services[index]);
                    }),
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              const CustomTextField(
                hintText: 'Search',
                prefixIcon: Icon(
                  Icons.search,
                  color: ColorManager.kPrimaryColor,
                ),
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              TabBar(
                indicatorWeight: 3,
                labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 14, fontWeight: FontWeightManager.semiBold),
                labelColor: ColorManager.kPrimaryColor,
                indicatorColor: ColorManager.kPrimaryColor,
                controller: controller.tabController,
                tabs: const [
                  Tab(
                    text: 'Upcoming',
                  ),
                  Tab(text: 'Completed'),
                  Tab(text: 'Cancelled'),
                ],
              ),
              SizedBox(height: Get.height * 0.02),
              Expanded(
                  child: cont.selectedAppointmentData == 3
                      ? TabBarView(
                          controller: controller.tabController,
                          children: [
                            buildAppointmentsList(
                              context,
                              [
                                AppointmentData(
                                  statusText: 'Consult at Clinic',
                                  statusColor: ColorManager.kOrangeColor,
                                  name: 'Dr. Sheikh Hamid',
                                  date: 'Aug 19,2023',
                                  time: '10:00 AM',
                                  type: 'Cardiology Specialist',
                                  rating: '4.5',
                                  showButtons: false,
                                  onBookAgainPressed: () {},
                                  onLeaveReviewPressed: () {},
                                ),
                                // Add more upcoming appointments here
                              ],
                            ),
                            buildAppointmentsList(
                              context,
                              [
                                AppointmentData(
                                  statusText: 'Completed',
                                  statusColor: Colors.green,
                                  name: 'Dr Sheikh Hamid',
                                  date: 'Aug 19, 2023',
                                  time: '11:00 am',
                                  type: 'Cardiology Specialist',
                                  rating: '4.5',
                                  showButtons: true,
                                  onBookAgainPressed: () {},
                                  onLeaveReviewPressed: () {},
                                ),
                              ],
                            ),
                            buildAppointmentsList(
                              context,
                              [
                                AppointmentData(
                                  statusText: 'Cancelled',
                                  statusColor: Colors.red,
                                  name: 'Dr Sheikh Hamid',
                                  date: 'Aug 19, 2023',
                                  time: '11:00 AM',
                                  type: 'Cardiology Specialist',
                                  rating: '4.5',
                                  showButtons: false,
                                  onBookAgainPressed: () {},
                                  onLeaveReviewPressed: () {},
                                ),
                              ],
                            ),
                          ],
                        )
                      : TabBarView(
                          controller: controller.tabController,
                          children: [
                            buildAppointmentsList(
                              context,
                              [
                                AppointmentData(
                                  statusText: 'Rider Arriving Soon',
                                  statusColor: ColorManager.kOrangeColor,
                                  name: 'Dr. Sheikh Hamid',
                                  date: 'Aug 19,2023',
                                  time: '10:00 AM',
                                  type: 'Home Sampling',
                                  rating: '4.5',
                                  showButtons: false,
                                  onBookAgainPressed: () {},
                                  onLeaveReviewPressed: () {},
                                ),
                              ],
                            ),
                            buildAppointmentsList(
                              context,
                              [
                                AppointmentData(
                                  statusText: 'Completed',
                                  statusColor: Colors.green,
                                  name: 'Dr Sheikh Hamid',
                                  date: 'Aug 19, 2023',
                                  time: '11:00 am',
                                  type: 'Home Sampling',
                                  rating: '4.5',
                                  showButtons: true,
                                  onBookAgainPressed: () {},
                                  onLeaveReviewPressed: () {},
                                ),
                              ],
                            ),
                            buildAppointmentsList(
                              context,
                              [
                                AppointmentData(
                                  statusText: 'Cancelled',
                                  statusColor: Colors.red,
                                  name: 'Dr Sheikh Hamid',
                                  date: 'Aug 19, 2023',
                                  time: '11:00 AM',
                                  type: 'Home Sampling',
                                  rating: '4.5',
                                  showButtons: false,
                                  onBookAgainPressed: () {},
                                  onLeaveReviewPressed: () {},
                                ),
                              ],
                            ),
                          ],
                        )),
            ],
          );
        }),
      ),
    );
  }

  buildAppointmentsList(
      BuildContext context, List<AppointmentData> appointmentDataList) {
    return ListView.builder(
      itemCount: appointmentDataList.length,
      itemBuilder: (context, index) {
        return LabInvestigationAppointmentCards(
          statusText: appointmentDataList[index].statusText!,
          statusColor: appointmentDataList[index].statusColor!,
          name: appointmentDataList[index].name!,
          date: appointmentDataList[index].date!,
          time: appointmentDataList[index].time!,
          type: appointmentDataList[index].type!,
          rating: appointmentDataList[index].rating!,
          showButtons: appointmentDataList[index].showButtons!,
          onBookAgainPressed: appointmentDataList[index].onBookAgainPressed!,
          onLeaveReviewPressed:
              appointmentDataList[index].onLeaveReviewPressed!,
        );
      },
    );
  }
}
