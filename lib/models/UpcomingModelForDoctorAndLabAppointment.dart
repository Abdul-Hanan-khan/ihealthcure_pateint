// ignore_for_file: non_constant_identifier_names

import 'package:tabib_al_bait/models/DoctorConsultationAppointmentHistory.dart';

class UpcomingModelForDoctorAndLabAppointment {
  UpcomingModelForDoctorAndLabAppointment({
    this.Status,
    this.Data,
    this.TotalRecord,
    this.FilterRecord,
  });
  int? Status;
  List<DoctorConsultationAppointmentHistoryDataList>? Data;
  int? TotalRecord;
  int? FilterRecord;

  UpcomingModelForDoctorAndLabAppointment.fromJson(Map<String, dynamic> json) {
    Status = json['Status'];
    Data = (json['Data'] as List<dynamic>?)
        ?.map((e) => DoctorConsultationAppointmentHistoryDataList.fromJson(
            e as Map<String, dynamic>))
        .toList();
    TotalRecord = json['TotalRecord'];
    FilterRecord = json['FilterRecord'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['Status'] = Status;
    data['Data'] = Data?.map((e) => e.toJson()).toList();
    data['TotalRecord'] = TotalRecord;
    data['FilterRecord'] = FilterRecord;
    return data;
  }
}

class AppointmentData {
  AppointmentData({
    this.Id,
    this.DoctorId,
    this.DoctorName,
    this.ImagePath,
    this.Designation,
    this.WorkLocation,
    this.Address,
    this.CityName,
    this.PatientName,
    this.StartTime,
    this.EndTime,
    this.Status,
    this.AppointmentDate,
    this.WorkLocationId,
    this.PatientId,
    this.PatientAppointmentId,
    this.ConsultancyFee,
    this.Speciality,
    this.FollowUp,
    this.Monday,
    this.Sunday,
    this.Tuesday,
    this.Wednesday,
    this.Thursday,
    this.Friday,
    this.Saturday,
    this.SessionId,
    this.IsOnlineConsultation,
    this.IsOnlineAppointment,
    this.BookingDate,
    this.CityId,
    this.EXRURL,
    this.IsFavouriteDoctor,
    this.StatusValue,
    this.ModifiedOn,
    this.SlotTokenNumber,
    this.AppointmentSlotDisplayType,
  });
  String? Id;
  String? DoctorId;
  String? DoctorName;
  String? ImagePath;
  String? Designation;
  String? WorkLocation;
  String? Address;
  String? CityName;
  String? PatientName;
  String? StartTime;
  String? EndTime;
  String? Status;
  String? AppointmentDate;
  String? WorkLocationId;
  String? PatientId;
  String? PatientAppointmentId;
  double? ConsultancyFee;
  String? Speciality;
  bool? FollowUp;
  int? Monday;
  int? Sunday;
  int? Tuesday;
  int? Wednesday;
  int? Thursday;
  int? Friday;
  int? Saturday;
  String? SessionId;
  bool? IsOnlineConsultation;
  bool? IsOnlineAppointment;
  String? BookingDate;
  String? CityId;
  String? EXRURL;
  bool? IsFavouriteDoctor;
  int? StatusValue;
  String? ModifiedOn;
  int? SlotTokenNumber;
  int? AppointmentSlotDisplayType;

  AppointmentData.fromJson(Map<String, dynamic> json) {
    Id = json['Id'];
    DoctorId = json['DoctorId'];
    DoctorName = json['DoctorName'];
    ImagePath = json['ImagePath'];
    Designation = json['Designation'];
    WorkLocation = json['WorkLocation'];
    Address = json['Address'];
    CityName = json['CityName'];
    PatientName = json['PatientName'];
    StartTime = json['StartTime'];
    EndTime = json['EndTime'];
    Status = json['Status'];
    AppointmentDate = json['AppointmentDate'];
    WorkLocationId = json['WorkLocationId'];
    PatientId = json['PatientId'];
    PatientAppointmentId = json['PatientAppointmentId'];
    ConsultancyFee = json['ConsultancyFee'];
    Speciality = json['Speciality'];
    FollowUp = json['FollowUp'];
    Monday = json['Monday'];
    Sunday = json['Sunday'];
    Tuesday = json['Tuesday'];
    Wednesday = json['Wednesday'];
    Thursday = json['Thursday'];
    Friday = json['Friday'];
    Saturday = json['Saturday'];
    SessionId = json['SessionId'];
    IsOnlineConsultation = json['IsOnlineConsultation'];
    IsOnlineAppointment = json['IsOnlineAppointment'];
    BookingDate = json['BookingDate'];
    CityId = json['CityId'];
    EXRURL = json['EXRURL'];
    IsFavouriteDoctor = json['IsFavouriteDoctor'];
    StatusValue = json['StatusValue'];
    ModifiedOn = json['ModifiedOn'];
    SlotTokenNumber = json['SlotTokenNumber'];
    AppointmentSlotDisplayType = json['AppointmentSlotDisplayType'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['Id'] = Id;
    data['DoctorId'] = DoctorId;
    data['DoctorName'] = DoctorName;
    data['ImagePath'] = ImagePath;
    data['Designation'] = Designation;
    data['WorkLocation'] = WorkLocation;
    data['Address'] = Address;
    data['CityName'] = CityName;
    data['PatientName'] = PatientName;
    data['StartTime'] = StartTime;
    data['EndTime'] = EndTime;
    data['Status'] = Status;
    data['AppointmentDate'] = AppointmentDate;
    data['WorkLocationId'] = WorkLocationId;
    data['PatientId'] = PatientId;
    data['PatientAppointmentId'] = PatientAppointmentId;
    data['ConsultancyFee'] = ConsultancyFee;
    data['Speciality'] = Speciality;
    data['FollowUp'] = FollowUp;
    data['Monday'] = Monday;
    data['Sunday'] = Sunday;
    data['Tuesday'] = Tuesday;
    data['Wednesday'] = Wednesday;
    data['Thursday'] = Thursday;
    data['Friday'] = Friday;
    data['Saturday'] = Saturday;
    data['SessionId'] = SessionId;
    data['IsOnlineConsultation'] = IsOnlineConsultation;
    data['IsOnlineAppointment'] = IsOnlineAppointment;
    data['BookingDate'] = BookingDate;
    data['CityId'] = CityId;
    data['EXRURL'] = EXRURL;
    data['IsFavouriteDoctor'] = IsFavouriteDoctor;
    data['StatusValue'] = StatusValue;
    data['ModifiedOn'] = ModifiedOn;
    data['SlotTokenNumber'] = SlotTokenNumber;
    data['AppointmentSlotDisplayType'] = AppointmentSlotDisplayType;
    return data;
  }
}
