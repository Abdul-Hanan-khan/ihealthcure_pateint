class AppointmentsSummeryResponse {
  int? status;
  List<AppointmentsHistory>? data;

  AppointmentsSummeryResponse({this.status, this.data});

  AppointmentsSummeryResponse.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    if (json['Data'] != null) {
      data = <AppointmentsHistory>[];
      json['Data'].forEach((v) {
        data!.add(AppointmentsHistory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Status'] = status;
    if (this.data != null) {
      data['Data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AppointmentsHistory {
  int? appointmentType;
  String? labNo;
  String? id;
  String? patientAppointmentId;
  String? name;
  String? prescribedByDoctor;
  String? patientName;
  String? imagePath;
  String? workLocation;
  String? location;
  String? cityName;
  String? status;
  String? startTime;
  String? endTime;
  String? appointmentDate;
  String? doctorId;
  String? sessionId;
  String? workLocationId;
  String? patientId;
  String? diagnosticCenterId;
  String? diagnosticId;
  String? labId;
  List<dynamic>? labTests;
  List<dynamic>? additionalSubService;
  int? monday;
  int? sunday;
  int? tuesday;
  int? wednesday;
  int? thursday;
  int? friday;
  int? saturday;
  String? branchId;
  double? consultancyFee;
  String? designation;
  String? speciality;
  bool? isOnlineConsultation;
  bool? isOnlineAppointment;
  String? cityId;
  String? bookingDate;
  String? latitude;
  String? longitude;
  String? pickupAddress;
  int? statusValue;
  int? slotTokenNumber;
  int? appointmentSlotDisplayType;
  String? packageGroupId;
  String? packageGroupName;
  String? packageGroupDiscountRate;
  String? packageGroupDiscountType;
  String? fileAttachment;

  AppointmentsHistory(
      {this.appointmentType,
      this.labNo,
      this.id,
      this.patientAppointmentId,
      this.name,
      this.prescribedByDoctor,
      this.patientName,
      this.imagePath,
      this.workLocation,
      this.location,
      this.cityName,
      this.status,
      this.startTime,
      this.endTime,
      this.appointmentDate,
      this.doctorId,
      this.sessionId,
      this.workLocationId,
      this.patientId,
      this.diagnosticCenterId,
      this.diagnosticId,
      this.labId,
      this.labTests,
      this.additionalSubService,
      this.monday,
      this.sunday,
      this.tuesday,
      this.wednesday,
      this.thursday,
      this.friday,
      this.saturday,
      this.branchId,
      this.consultancyFee,
      this.designation,
      this.speciality,
      this.isOnlineConsultation,
      this.isOnlineAppointment,
      this.cityId,
      this.bookingDate,
      this.latitude,
      this.longitude,
      this.pickupAddress,
      this.statusValue,
      this.slotTokenNumber,
      this.appointmentSlotDisplayType,
      this.packageGroupId,
      this.packageGroupName,
      this.packageGroupDiscountRate,
      this.packageGroupDiscountType,
      this.fileAttachment});

  AppointmentsHistory.fromJson(Map<String, dynamic> json) {
    appointmentType = json['AppointmentType'];
    labNo = json['LabNo'];
    id = json['Id'];
    patientAppointmentId = json['PatientAppointmentId'];
    name = json['Name'];
    prescribedByDoctor = json['PrescribedByDoctor'];
    patientName = json['PatientName'];
    imagePath = json['ImagePath'];
    workLocation = json['WorkLocation'];
    location = json['Location'];
    cityName = json['CityName'];
    status = json['Status'];
    startTime = json['StartTime'];
    endTime = json['EndTime'];
    appointmentDate = json['AppointmentDate'];
    doctorId = json['DoctorId'];
    sessionId = json['SessionId'];
    workLocationId = json['WorkLocationId'];
    patientId = json['PatientId'];
    diagnosticCenterId = json['DiagnosticCenterId'];
    diagnosticId = json['DiagnosticId'];
    labId = json['LabId'];
    labTests = json['LabTests'];
    // additionalSubService = json['AdditionalSubService'].cast<String>();
    monday = json['Monday'];
    sunday = json['Sunday'];
    tuesday = json['Tuesday'];
    wednesday = json['Wednesday'];
    thursday = json['Thursday'];
    friday = json['Friday'];
    saturday = json['Saturday'];
    branchId = json['BranchId'];
    consultancyFee = json['ConsultancyFee'];
    designation = json['Designation'];
    speciality = json['Speciality'];
    isOnlineConsultation = json['IsOnlineConsultation'];
    isOnlineAppointment = json['IsOnlineAppointment'];
    cityId = json['CityId'];
    bookingDate = json['BookingDate'];
    latitude = json['Latitude'];
    longitude = json['Longitude'];
    pickupAddress = json['PickupAddress'];
    statusValue = json['StatusValue'];
    slotTokenNumber = json['SlotTokenNumber'];
    appointmentSlotDisplayType = json['AppointmentSlotDisplayType'];
    packageGroupId = json['PackageGroupId'];
    packageGroupName = json['PackageGroupName'];
    packageGroupDiscountRate = json['PackageGroupDiscountRate'];
    packageGroupDiscountType = json['PackageGroupDiscountType'];
    fileAttachment = json['FileAttachment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['AppointmentType'] = appointmentType;
    data['LabNo'] = labNo;
    data['Id'] = id;
    data['PatientAppointmentId'] = patientAppointmentId;
    data['Name'] = name;
    data['PrescribedByDoctor'] = prescribedByDoctor;
    data['PatientName'] = patientName;
    data['ImagePath'] = imagePath;
    data['WorkLocation'] = workLocation;
    data['Location'] = location;
    data['CityName'] = cityName;
    data['Status'] = status;
    data['StartTime'] = startTime;
    data['EndTime'] = endTime;
    data['AppointmentDate'] = appointmentDate;
    data['DoctorId'] = doctorId;
    data['SessionId'] = sessionId;
    data['WorkLocationId'] = workLocationId;
    data['PatientId'] = patientId;
    data['DiagnosticCenterId'] = diagnosticCenterId;
    data['DiagnosticId'] = diagnosticId;
    data['LabId'] = labId;
    data['LabTests'] = labTests;
    data['AdditionalSubService'] = additionalSubService;
    data['Monday'] = monday;
    data['Sunday'] = sunday;
    data['Tuesday'] = tuesday;
    data['Wednesday'] = wednesday;
    data['Thursday'] = thursday;
    data['Friday'] = friday;
    data['Saturday'] = saturday;
    data['BranchId'] = branchId;
    data['ConsultancyFee'] = consultancyFee;
    data['Designation'] = designation;
    data['Speciality'] = speciality;
    data['IsOnlineConsultation'] = isOnlineConsultation;
    data['IsOnlineAppointment'] = isOnlineAppointment;
    data['CityId'] = cityId;
    data['BookingDate'] = bookingDate;
    data['Latitude'] = latitude;
    data['Longitude'] = longitude;
    data['PickupAddress'] = pickupAddress;
    data['StatusValue'] = statusValue;
    data['SlotTokenNumber'] = slotTokenNumber;
    data['AppointmentSlotDisplayType'] = appointmentSlotDisplayType;
    data['PackageGroupId'] = packageGroupId;
    data['PackageGroupName'] = packageGroupName;
    data['PackageGroupDiscountRate'] = packageGroupDiscountRate;
    data['PackageGroupDiscountType'] = packageGroupDiscountType;
    data['FileAttachment'] = fileAttachment;
    return data;
  }
}
