
class AppointmentDataModel {
  String? doctorId;
  String? patientId;
  String? bookDate;
  String? startTime;
  String? endTime;
  bool? isOnlineConsultation;
  String? workLocationId;
  String? sessionId;
  String? branchId;
  String? token;
  String? appointmentNotes;
  String? price;

  AppointmentDataModel(
      {this.doctorId,
      this.price,
      this.patientId,
      this.bookDate,
      this.startTime,
      this.endTime,
      this.isOnlineConsultation,
      this.workLocationId,
      this.sessionId,
      this.branchId,
      this.token, this.appointmentNotes});

  AppointmentDataModel.fromJson(Map<String, dynamic> json) {
    doctorId = json['DoctorId'];
    patientId = json['PatientId'];
    bookDate = json['BookDate'];
    startTime = json['StartTime'];
    endTime = json['EndTime'];
    isOnlineConsultation = json['IsOnlineConsultation'];
    workLocationId = json['WorkLocationId'];
    sessionId = json['SessionId'];
    branchId = json['BranchId'];
    token = json['Token'];
    appointmentNotes = json['AppointmentNotes'];
    price = json['Price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['DoctorId'] = doctorId;
    data['PatientId'] = patientId;
    data['BookDate'] = bookDate;
    data['StartTime'] = startTime;
    data['EndTime'] = endTime;
    data['IsOnlineConsultation'] = isOnlineConsultation;
    data['WorkLocationId'] = workLocationId;
    data['SessionId'] = sessionId;
    data['BranchId'] = branchId;
    data['Token'] = token;
    data['Price'] = price;
    return data;
  }
}
