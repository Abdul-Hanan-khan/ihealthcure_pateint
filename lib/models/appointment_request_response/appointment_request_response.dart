class AppointmentRequestResponse {
  int? status;
  List<AppointmentsList>? data;
  int? totalRecord;
  int? filterRecord;

  AppointmentRequestResponse(
      {this.status, this.data, this.totalRecord, this.filterRecord});

  AppointmentRequestResponse.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    if (json['Data'] != null) {
      data = <AppointmentsList>[];
      json['Data'].forEach((v) {
        data!.add(AppointmentsList.fromJson(v));
      });
    }
    totalRecord = json['TotalRecord'];
    filterRecord = json['FilterRecord'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Status'] = status;
    if (this.data != null) {
      data['Data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['TotalRecord'] = totalRecord;
    data['FilterRecord'] = filterRecord;
    return data;
  }
}

class AppointmentsList {
  String? patientServiceAppointmentId;
  String? labNo;
  String? patientId;
  String? status;
  int? statusValue;
  String? bookingDate;
  String? time;
  String? mRNo;
  String? patientName;
  String? cellNumber;
  String? labName;
  String? labTest;
  String? labTestIds;
  String? labId;
  String? prescribedBy;
  String? action;
  String? labTestChallanNo;
  String? visitNo;
  String? modifiedOn;
  String? prescribeByDoctorId;
  int? patientTypesHtmlValue;
  String? flightNo;
  String? flightDate;
  String? airlineId;
  String? airportId;
  String? flightDestinationId;
  String? passengerNameRecord;
  String? pickupAddress;
  String? latitude;
  String? statusType;
  String? appointmentNo;
  String? branchLocationId;
  String? longitude;
  String? paymentMethodId;
  String? lastProcessedBy;
  String? lastProcessedOn;
  bool? isNotCompleted;
  String? paymentStatusName;
  String? paymentStatusValue;
  String? inRouteDeliveryBranchLocationId;
  int? appointmentStatusCount;
  String? appointmentStatus;
  String? inRouteLongitude;
  String? inRouteLatitude;
  String? messageBody;
  String? providerName;
  String? appointmentCategoryName;
  double? totalAppointmentFee;
  String? startTime;
  String? picturePath;
  String? eXRURL;
  int? typeBit;
  String? providerId;
  String? packageGroupId;
  String? packageGroupName;
  double? packageGroupDiscountRate;
  int? packageGroupDiscountType;
  String? paymentOn;

  AppointmentsList(
      {this.patientServiceAppointmentId,
      this.labNo,
      this.patientId,
      this.status,
      this.statusValue,
      this.bookingDate,
      this.time,
      this.mRNo,
      this.patientName,
      this.cellNumber,
      this.labName,
      this.labTest,
      this.labTestIds,
      this.labId,
      this.prescribedBy,
      this.action,
      this.labTestChallanNo,
      this.visitNo,
      this.modifiedOn,
      this.prescribeByDoctorId,
      this.patientTypesHtmlValue,
      this.flightNo,
      this.flightDate,
      this.airlineId,
      this.airportId,
      this.flightDestinationId,
      this.passengerNameRecord,
      this.pickupAddress,
      this.latitude,
      this.statusType,
      this.appointmentNo,
      this.branchLocationId,
      this.longitude,
      this.paymentMethodId,
      this.lastProcessedBy,
      this.lastProcessedOn,
      this.isNotCompleted,
      this.paymentStatusName,
      this.paymentStatusValue,
      this.inRouteDeliveryBranchLocationId,
      this.appointmentStatusCount,
      this.appointmentStatus,
      this.inRouteLongitude,
      this.inRouteLatitude,
      this.messageBody,
      this.providerName,
      this.appointmentCategoryName,
      this.totalAppointmentFee,
      this.startTime,
      this.picturePath,
      this.eXRURL,
      this.typeBit,
      this.providerId,
      this.packageGroupId,
      this.packageGroupName,
      this.packageGroupDiscountRate,
      this.packageGroupDiscountType,
      this.paymentOn});

  AppointmentsList.fromJson(Map<String, dynamic> json) {
    patientServiceAppointmentId = json['PatientServiceAppointmentId'];
    labNo = json['LabNo'];
    patientId = json['PatientId'];
    status = json['Status'];
    statusValue = json['StatusValue'];
    bookingDate = json['BookingDate'];
    time = json['Time'];
    mRNo = json['MRNo'];
    patientName = json['PatientName'];
    cellNumber = json['CellNumber'];
    labName = json['LabName'];
    labTest = json['LabTest'];
    labTestIds = json['LabTestIds'];
    labId = json['LabId'];
    prescribedBy = json['PrescribedBy'];
    action = json['Action'];
    labTestChallanNo = json['LabTestChallanNo'];
    visitNo = json['VisitNo'];
    modifiedOn = json['ModifiedOn'];
    prescribeByDoctorId = json['PrescribeByDoctorId'];
    patientTypesHtmlValue = json['PatientTypesHtmlValue'];
    flightNo = json['FlightNo'];
    flightDate = json['FlightDate'];
    airlineId = json['AirlineId'];
    airportId = json['AirportId'];
    flightDestinationId = json['FlightDestinationId'];
    passengerNameRecord = json['PassengerNameRecord'];
    pickupAddress = json['PickupAddress'];
    latitude = json['Latitude'];
    statusType = json['StatusType'];
    appointmentNo = json['AppointmentNo'];
    branchLocationId = json['BranchLocationId'];
    longitude = json['Longitude'];
    paymentMethodId = json['PaymentMethodId'];
    lastProcessedBy = json['LastProcessedBy'];
    lastProcessedOn = json['LastProcessedOn'];
    isNotCompleted = json['IsNotCompleted'];
    paymentStatusName = json['PaymentStatusName'];
    paymentStatusValue = json['PaymentStatusValue'];
    inRouteDeliveryBranchLocationId = json['InRouteDeliveryBranchLocationId'];
    appointmentStatusCount = json['AppointmentStatusCount'];
    appointmentStatus = json['AppointmentStatus'];
    inRouteLongitude = json['InRouteLongitude'];
    inRouteLatitude = json['InRouteLatitude'];
    messageBody = json['MessageBody'];
    providerName = json['ProviderName'];
    appointmentCategoryName = json['AppointmentCategoryName'];
    totalAppointmentFee = json['TotalAppointmentFee'];
    startTime = json['StartTime'];
    picturePath = json['PicturePath'];
    eXRURL = json['EXRURL'];
    typeBit = json['TypeBit'];
    providerId = json['ProviderId'];
    packageGroupId = json['PackageGroupId'];
    packageGroupName = json['PackageGroupName'];
    packageGroupDiscountRate = json['PackageGroupDiscountRate'];
    packageGroupDiscountType = json['PackageGroupDiscountType'];
    paymentOn = json['PaymentOn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['PatientServiceAppointmentId'] = patientServiceAppointmentId;
    data['LabNo'] = labNo;
    data['PatientId'] = patientId;
    data['Status'] = status;
    data['StatusValue'] = statusValue;
    data['BookingDate'] = bookingDate;
    data['Time'] = time;
    data['MRNo'] = mRNo;
    data['PatientName'] = patientName;
    data['CellNumber'] = cellNumber;
    data['LabName'] = labName;
    data['LabTest'] = labTest;
    data['LabTestIds'] = labTestIds;
    data['LabId'] = labId;
    data['PrescribedBy'] = prescribedBy;
    data['Action'] = action;
    data['LabTestChallanNo'] = labTestChallanNo;
    data['VisitNo'] = visitNo;
    data['ModifiedOn'] = modifiedOn;
    data['PrescribeByDoctorId'] = prescribeByDoctorId;
    data['PatientTypesHtmlValue'] = patientTypesHtmlValue;
    data['FlightNo'] = flightNo;
    data['FlightDate'] = flightDate;
    data['AirlineId'] = airlineId;
    data['AirportId'] = airportId;
    data['FlightDestinationId'] = flightDestinationId;
    data['PassengerNameRecord'] = passengerNameRecord;
    data['PickupAddress'] = pickupAddress;
    data['Latitude'] = latitude;
    data['StatusType'] = statusType;
    data['AppointmentNo'] = appointmentNo;
    data['BranchLocationId'] = branchLocationId;
    data['Longitude'] = longitude;
    data['PaymentMethodId'] = paymentMethodId;
    data['LastProcessedBy'] = lastProcessedBy;
    data['LastProcessedOn'] = lastProcessedOn;
    data['IsNotCompleted'] = isNotCompleted;
    data['PaymentStatusName'] = paymentStatusName;
    data['PaymentStatusValue'] = paymentStatusValue;
    data['InRouteDeliveryBranchLocationId'] = inRouteDeliveryBranchLocationId;
    data['AppointmentStatusCount'] = appointmentStatusCount;
    data['AppointmentStatus'] = appointmentStatus;
    data['InRouteLongitude'] = inRouteLongitude;
    data['InRouteLatitude'] = inRouteLatitude;
    data['MessageBody'] = messageBody;
    data['ProviderName'] = providerName;
    data['AppointmentCategoryName'] = appointmentCategoryName;
    data['TotalAppointmentFee'] = totalAppointmentFee;
    data['StartTime'] = startTime;
    data['PicturePath'] = picturePath;
    data['EXRURL'] = eXRURL;
    data['TypeBit'] = typeBit;
    data['ProviderId'] = providerId;
    data['PackageGroupId'] = packageGroupId;
    data['PackageGroupName'] = packageGroupName;
    data['PackageGroupDiscountRate'] = packageGroupDiscountRate;
    data['PackageGroupDiscountType'] = packageGroupDiscountType;
    data['PaymentOn'] = paymentOn;
    return data;
  }
}
