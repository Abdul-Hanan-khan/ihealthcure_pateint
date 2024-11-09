class Bookdiagnosticbody {
  dynamic patientId;
  dynamic diagnosticId;
  dynamic sessionId;
  dynamic prescribedByDoctorId;
  dynamic bookingDate;
  dynamic bookingTime;
  dynamic discountStatus;
  dynamic clinicalHistory;
  dynamic isReserve;
  dynamic workLocationId;
  dynamic diagnosticCenterId;
  dynamic token;
  dynamic fileAttachment;

  Bookdiagnosticbody(
      {this.patientId,
      this.diagnosticId,
      this.fileAttachment,
      this.sessionId,
      this.prescribedByDoctorId,
      this.bookingDate,
      this.bookingTime,
      this.discountStatus,
      this.clinicalHistory,
      this.isReserve,
      this.workLocationId,
      this.diagnosticCenterId,
      this.token});

  Bookdiagnosticbody.fromJson(Map<String, dynamic> json) {
    patientId = json['PatientId'];
    fileAttachment = json['FileAttachment'];
    diagnosticId = json['DiagnosticId'];
    sessionId = json['SessionId'];
    prescribedByDoctorId = json['PrescribedByDoctorId'];
    bookingDate = json['BookingDate'];
    bookingTime = json['BookingTime'];
    discountStatus = json['DiscountStatus'];
    clinicalHistory = json['ClinicalHistory'];
    isReserve = json['IsReserve'];
    workLocationId = json['WorkLocationId'];
    diagnosticCenterId = json['DiagnosticCenterId'];
    token = json['Token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['PatientId'] = patientId;
    data['DiagnosticId'] = diagnosticId;
    data['FileAttachment'] = fileAttachment;
    data['SessionId'] = sessionId;
    data['PrescribedByDoctorId'] = prescribedByDoctorId;
    data['BookingDate'] = bookingDate;
    data['BookingTime'] = bookingTime;
    data['DiscountStatus'] = discountStatus;
    data['ClinicalHistory'] = clinicalHistory;
    data['IsReserve'] = isReserve;
    data['WorkLocationId'] = workLocationId;
    data['DiagnosticCenterId'] = diagnosticCenterId;
    data['Token'] = token;
    return data;
  }
}
