// class Slots {
//   dynamic slotTime;
//   dynamic slotEndTime;
//   dynamic sessionId;
//   dynamic isBooked;
//   dynamic consultancyFee;
//   dynamic appointmentSlotDisplayType;

//   Slots(
//       {this.slotTime,
//       this.slotEndTime,
//       this.sessionId,
//       this.isBooked,
//       this.consultancyFee,
//       this.appointmentSlotDisplayType});

//   Slots.fromJson(Map<String, dynamic> json) {
//     slotTime = json['SlotTime'];
//     slotEndTime = json['SlotEndTime'];
//     sessionId = json['SessionId'];
//     isBooked = json['IsBooked'];
//     consultancyFee = json['ConsultancyFee'];
//     appointmentSlotDisplayType = json['AppointmentSlotDisplayType'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['SlotTime'] = slotTime;
//     data['SlotEndTime'] = slotEndTime;
//     data['SessionId'] = sessionId;
//     data['IsBooked'] = isBooked;
//     data['ConsultancyFee'] = consultancyFee;
//     data['AppointmentSlotDisplayType'] = appointmentSlotDisplayType;
//     return data;
//   }
// }
