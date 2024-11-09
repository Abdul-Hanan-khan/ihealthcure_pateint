class BookAppointmentResponse {
  BookAppointmentResponse? data;

  BookAppointmentResponse({this.data});

  BookAppointmentResponse.fromJson(Map<String, dynamic> json) {
    data = json['Data'] != null ?  BookAppointmentResponse.fromJson(json['Data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    if (this.data != null) {
      data['Data'] = this.data!.toJson();
    }
    return data;
  }
}

class BookAppointment {
  int? status;
  String? message;
  String? appointmentId;
  String? doctorId;
  String? doctorName;
  String? imagePath;
  String? designation;
  String? workLocation;
  String? patientName;
  String? startTime;
  String? endTime;
  String? appointmentDate;
  String? workLocationId;
  String? patientId;
  String? patientAppointmentId;
  double? consultancyFee;
  String? speciality;
  String? sessionId;
  int? slotTokenNumber;
  int? appointmentSlotDisplayType;

  BookAppointment(
      {this.status,
      this.message,
      this.appointmentId,
      this.doctorId,
      this.doctorName,
      this.imagePath,
      this.designation,
      this.workLocation,
      this.patientName,
      this.startTime,
      this.endTime,
      this.appointmentDate,
      this.workLocationId,
      this.patientId,
      this.patientAppointmentId,
      this.consultancyFee,
      this.speciality,
      this.sessionId,
      this.slotTokenNumber,
      this.appointmentSlotDisplayType});

  BookAppointment.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    message = json['Message'];
    appointmentId = json['AppointmentId'];
    doctorId = json['DoctorId'];
    doctorName = json['DoctorName'];
    imagePath = json['ImagePath'];
    designation = json['Designation'];
    workLocation = json['WorkLocation'];
    patientName = json['PatientName'];
    startTime = json['StartTime'];
    endTime = json['EndTime'];
    appointmentDate = json['AppointmentDate'];
    workLocationId = json['WorkLocationId'];
    patientId = json['PatientId'];
    patientAppointmentId = json['PatientAppointmentId'];
    consultancyFee = json['ConsultancyFee'];
    speciality = json['Speciality'];
    sessionId = json['SessionId'];
    slotTokenNumber = json['SlotTokenNumber'];
    appointmentSlotDisplayType = json['AppointmentSlotDisplayType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Status'] = status;
    data['Message'] = message;
    data['AppointmentId'] = appointmentId;
    data['DoctorId'] = doctorId;
    data['DoctorName'] = doctorName;
    data['ImagePath'] = imagePath;
    data['Designation'] = designation;
    data['WorkLocation'] = workLocation;
    data['PatientName'] = patientName;
    data['StartTime'] = startTime;
    data['EndTime'] = endTime;
    data['AppointmentDate'] = appointmentDate;
    data['WorkLocationId'] = workLocationId;
    data['PatientId'] = patientId;
    data['PatientAppointmentId'] = patientAppointmentId;
    data['ConsultancyFee'] = consultancyFee;
    data['Speciality'] = speciality;
    data['SessionId'] = sessionId;
    data['SlotTokenNumber'] = slotTokenNumber;
    data['AppointmentSlotDisplayType'] = appointmentSlotDisplayType;
    return data;
  }
}
