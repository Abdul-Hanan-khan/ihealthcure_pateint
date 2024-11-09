class ConsultNowBody {
  String? doctorId;
  String? patientId;
  double? consultancyFee;
  String? paymentMethodId;
  String? vouncherCode;
  String? discount;
  String? discountType;
  String? token;
  String? branchId;
  String? deviceToken;

  ConsultNowBody(
      {this.doctorId,
      this.patientId,
      this.consultancyFee,
      this.paymentMethodId,
      this.vouncherCode,
      this.discount,
      this.discountType,
      this.token,
      this.branchId,
      this.deviceToken});

  ConsultNowBody.fromJson(Map<String, dynamic> json) {
    doctorId = json['DoctorId'];
    patientId = json['PatientId'];
    consultancyFee = json['ConsultancyFee'];
    paymentMethodId = json['PaymentMethodId'];
    vouncherCode = json['VouncherCode'];
    discount = json['Discount'];
    discountType = json['DiscountType'];
    token = json['Token'];
    branchId = json['BranchId'];
    deviceToken = json['DeviceToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['DoctorId'] = doctorId;
    data['PatientId'] = patientId;
    data['ConsultancyFee'] = consultancyFee;
    data['PaymentMethodId'] = paymentMethodId;
    data['VouncherCode'] = vouncherCode;
    data['Discount'] = discount;
    data['DiscountType'] = discountType;
    data['Token'] = token;
    data['BranchId'] = branchId;
    data['DeviceToken'] = deviceToken;
    return data;
  }
}
