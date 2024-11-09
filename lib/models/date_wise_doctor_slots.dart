class DateWiseDoctorSlots {
  int? status;
  List<Sessions>? sessions;
  int? appointmentSlotDisplayType;

  DateWiseDoctorSlots(
      {this.status, this.sessions, this.appointmentSlotDisplayType});

  DateWiseDoctorSlots.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    if (json['Sessions'] != null) {
      sessions = <Sessions>[];
      json['Sessions'].forEach((v) {
        sessions!.add( Sessions.fromJson(v));
      });
    }
    appointmentSlotDisplayType = json['AppointmentSlotDisplayType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Status'] = status;
    if (sessions != null) {
      data['Sessions'] = sessions!.map((v) => v.toJson()).toList();
    }
    data['AppointmentSlotDisplayType'] = appointmentSlotDisplayType;
    return data;
  }
}

class Sessions {
  String? sessionId;
  String? startTime;
  String? endTime;
  int? interval;
  String? doctorName;
  String? location;
  String? imagePath;
  List<Slots>? slots;
  double? consultancyFee;

  Sessions(
      {this.sessionId,
      this.startTime,
      this.endTime,
      this.interval,
      this.doctorName,
      this.location,
      this.imagePath,
      this.slots,
      this.consultancyFee});

  Sessions.fromJson(Map<String, dynamic> json) {
    sessionId = json['SessionId'];
    startTime = json['StartTime'];
    endTime = json['EndTime'];
    interval = json['Interval'];
    doctorName = json['DoctorName'];
    location = json['Location'];
    imagePath = json['ImagePath'];
    if (json['Slots'] != null) {
      slots = <Slots>[];
      json['Slots'].forEach((v) {
        slots!.add( Slots.fromJson(v));
      });
    }
    consultancyFee = json['ConsultancyFee'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['SessionId'] = sessionId;
    data['StartTime'] = startTime;
    data['EndTime'] = endTime;
    data['Interval'] = interval;
    data['DoctorName'] = doctorName;
    data['Location'] = location;
    data['ImagePath'] = imagePath;
    if (slots != null) {
      data['Slots'] = slots!.map((v) => v.toJson()).toList();
    }
    data['ConsultancyFee'] = consultancyFee;
    return data;
  }
}

class Slots {
  String? slotTime;
  String? slotEndTime;
  String? sessionId;
  bool? isBooked;
  double? consultancyFee;
  int? appointmentSlotDisplayType;

  Slots(
      {this.slotTime,
      this.slotEndTime,
      this.sessionId,
      this.isBooked,
      this.consultancyFee,
      this.appointmentSlotDisplayType});

  Slots.fromJson(Map<String, dynamic> json) {
    slotTime = json['SlotTime'];
    slotEndTime = json['SlotEndTime'];
    sessionId = json['SessionId'];
    isBooked = json['IsBooked'];
    consultancyFee = json['ConsultancyFee'];
    appointmentSlotDisplayType = json['AppointmentSlotDisplayType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['SlotTime'] = slotTime;
    data['SlotEndTime'] = slotEndTime;
    data['SessionId'] = sessionId;
    data['IsBooked'] = isBooked;
    data['ConsultancyFee'] = consultancyFee;
    data['AppointmentSlotDisplayType'] = appointmentSlotDisplayType;
    return data;
  }
}
