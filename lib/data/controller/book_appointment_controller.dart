import 'dart:async';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tabib_al_bait/data/controller/lab_investigations_controller.dart';
import 'package:tabib_al_bait/data/repositories/specialities_repo/specialities_repo.dart';
import 'package:tabib_al_bait/models/appointment_booking_mode/appointment_booking_model.dart';
import 'package:tabib_al_bait/models/payment_response.dart';

class BookAppointmentController extends GetxController {
  List<String> availableDays = [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday'
  ];

  List<PaymentMethod> paymentMethods = [];
  PaymentMethod? selectedPaymentMethod;
  PaymentMethod? consultNowPaymentMethod;
  PaymentMethod? bookAppointmentMethod;
  int _index = 0;
  int get selectedIndex => _index;
  static DateTime? _date = DateTime.now();
  static DateTime? get date => _date;
  String? formattedDate = DateFormat('yyyy-MM-dd').format(_date!);
  bool? _payButtonDisabled = true;
  bool? get payButtonDisabled => _payButtonDisabled;
  bool? _consultNowpayButtonDisabled = true;
  bool? get consultNowpayButtonDisabled => _consultNowpayButtonDisabled;

  bool? _isBookAppointmentLoading = false;
  bool? get isBookAppointmentLoading => _isBookAppointmentLoading;

  updateIsBookAppointmentLoading(bool? value) {
    _isBookAppointmentLoading = value;
    update();
  }

  AppointmentDataModel? model;

  updatePayment(bool value) {
    _payButtonDisabled = value;
    update();
  }

  updateConsultPayment(bool value) {
    _consultNowpayButtonDisabled = value;
    update();
  }

  DateTime? newDate;

  Future<String> addDateBasedOnIndex(int index) async {
    DateTime currentDate = DateTime.now();
    int deltaDays = index - 1;
    newDate = currentDate.add(Duration(days: deltaDays));
    return DateFormat('yyyy-MM-dd').format(newDate!);
  }

  DateTime findClosestFutureDate(String selectedDay) {
    final now = DateTime.now();
    final selectedDayIndex = availableDays.indexOf(selectedDay);
    if (selectedDayIndex == -1) {
      return now;
    }
    final currentDayIndex = now.weekday % 7;
    final daysUntilSelectedDay = (selectedDayIndex - currentDayIndex + 7) % 7;

    newDate = now.add(Duration(days: daysUntilSelectedDay));
    return newDate!;
  }

  static BookAppointmentController get i =>
      Get.put(BookAppointmentController());

  @override
  void onInit() {
    log('${paymentMethods.toString()} this is the list');

    super.onInit();
  }

  getPaymentMethods() async {
    try {
      paymentMethods = await SpecialitiesRepo.getPaymentMethods();
      log('The payment Method id is${paymentMethods[0].id.toString()}');
      LabInvestigationController.i.selectedPaymentMethod = paymentMethods[0];
      consultNowPaymentMethod = paymentMethods[0];
      bookAppointmentMethod = paymentMethods[0];

      update();
    } catch (e) {
      // if (e is SocketException) {
      //   ToastManager.showToast('No Internet Connection',
      //       bgColor: ColorManager.kRedColor);
      // } else if (e is TimeoutException) {
      //   ToastManager.showToast('Request Time Out',
      //       bgColor: ColorManager.kRedColor);
      // } else {
      //   ToastManager.showToast('An Unknown Error Occured');
      // }
    }
  }

  updateDate(DateTime changedDate) {
    _date = changedDate;
    formattedDate = DateFormat('yyyy-MM-dd').format(_date!);
    update();
    log('the formatted Date is $formattedDate');
  }

  updateSelectedIndex(int index) {
    _index = index;
    update();
  }

  updatePaymentMethod(PaymentMethod method) {
    selectedPaymentMethod = method;
    update();
  }

  updateConsultNowPaymentMethod(PaymentMethod method) {
    consultNowPaymentMethod = method;
    log('here is it $consultNowPaymentMethod');
    update();
  }

  updateBookAppointmentPayment(PaymentMethod method) {
    bookAppointmentMethod = method;
    if (bookAppointmentMethod?.paymentMethodValue == 5) {
      log(true.toString());
    }
    log('here is it $consultNowPaymentMethod');
    update();
  }
}
