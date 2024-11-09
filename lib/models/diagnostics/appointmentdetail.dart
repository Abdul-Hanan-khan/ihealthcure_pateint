class Appointmentdetail {
  dynamic diagnosticAppointmentId;
  dynamic diagnosticId;
  dynamic patientName;
  dynamic diagnosticName;
  dynamic diagnosticCenter;
  dynamic diagnosticCenterImagePah;
  dynamic location;
  dynamic bookingTime;
  dynamic status;
  dynamic appointmentDate;
  dynamic prescribedByDoctor;
  dynamic patientId;
  dynamic patientDiagnosticAppointmentId;
  dynamic sessionId;
  dynamic branchId;
  dynamic diagnosticCenterId;
  dynamic typeBit;

  Appointmentdetail(
      {this.diagnosticAppointmentId,
      this.diagnosticId,
      this.patientName,
      this.diagnosticName,
      this.diagnosticCenter,
      this.diagnosticCenterImagePah,
      this.location,
      this.bookingTime,
      this.status,
      this.appointmentDate,
      this.prescribedByDoctor,
      this.patientId,
      this.patientDiagnosticAppointmentId,
      this.sessionId,
      this.branchId,
      this.diagnosticCenterId,
      this.typeBit});

  Appointmentdetail.fromJson(Map<String, dynamic> json) {
    diagnosticAppointmentId = json['DiagnosticAppointmentId'];
    diagnosticId = json['DiagnosticId'];
    patientName = json['PatientName'];
    diagnosticName = json['DiagnosticName'];
    diagnosticCenter = json['DiagnosticCenter'];
    diagnosticCenterImagePah = json['DiagnosticCenterImagePah'];
    location = json['Location'];
    bookingTime = json['BookingTime'];
    status = json['Status'];
    appointmentDate = json['AppointmentDate'];
    prescribedByDoctor = json['PrescribedByDoctor'];
    patientId = json['PatientId'];
    patientDiagnosticAppointmentId = json['PatientDiagnosticAppointmentId'];
    sessionId = json['SessionId'];
    branchId = json['BranchId'];
    diagnosticCenterId = json['DiagnosticCenterId'];
    typeBit = json['TypeBit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['DiagnosticAppointmentId'] = diagnosticAppointmentId;
    data['DiagnosticId'] = diagnosticId;
    data['PatientName'] = patientName;
    data['DiagnosticName'] = diagnosticName;
    data['DiagnosticCenter'] = diagnosticCenter;
    data['DiagnosticCenterImagePah'] = diagnosticCenterImagePah;
    data['Location'] = location;
    data['BookingTime'] = bookingTime;
    data['Status'] = status;
    data['AppointmentDate'] = appointmentDate;
    data['PrescribedByDoctor'] = prescribedByDoctor;
    data['PatientId'] = patientId;
    data['PatientDiagnosticAppointmentId'] = patientDiagnosticAppointmentId;
    data['SessionId'] = sessionId;
    data['BranchId'] = branchId;
    data['DiagnosticCenterId'] = diagnosticCenterId;
    data['TypeBit'] = typeBit;
    return data;
  }
}
