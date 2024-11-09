class Diagnosticsession {
  dynamic serviceName;
  dynamic location;
  dynamic imagePath;
  dynamic sessionId;
  dynamic startTime;
  dynamic endTime;
  dynamic interval;
  List<Slots>? slots;

  Diagnosticsession(
      {this.serviceName,
      this.location,
      this.imagePath,
      this.sessionId,
      this.startTime,
      this.endTime,
      this.interval,
      this.slots});

  Diagnosticsession.fromJson(Map<String, dynamic> json) {
    serviceName = json['ServiceName'];
    location = json['Location'];
    imagePath = json['ImagePath'];
    sessionId = json['SessionId'];
    startTime = json['StartTime'];
    endTime = json['EndTime'];
    interval = json['Interval'];
    if (json['Slots'] != null) {
      slots = <Slots>[];
      json['Slots'].forEach((v) {
        slots!.add(Slots.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ServiceName'] = serviceName;
    data['Location'] = location;
    data['ImagePath'] = imagePath;
    data['SessionId'] = sessionId;
    data['StartTime'] = startTime;
    data['EndTime'] = endTime;
    data['Interval'] = interval;
    if (slots != null) {
      data['Slots'] = slots!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Slots {
  dynamic slotTime;
  dynamic slotEndTime;
  dynamic sessionId;
  dynamic isBooked;
  dynamic consultancyFee;
  dynamic appointmentSlotDisplayType;

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
