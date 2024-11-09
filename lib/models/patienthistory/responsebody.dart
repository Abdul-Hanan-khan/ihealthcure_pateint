class HistoryResponseBody {
  dynamic patientServiceAppointmentId;
  dynamic labNo;
  dynamic patientId;
  dynamic status;
  dynamic statusValue;
  dynamic bookingDate;
  dynamic time;
  dynamic mRNo;
  dynamic invoiceURL;
  dynamic patientName;
  dynamic cellNumber;
  dynamic labName;
  dynamic labTest;
  dynamic labTestIds;
  dynamic labId;
  dynamic prescribedBy;
  dynamic action;
  dynamic labTestChallanNo;
  dynamic visitNo;
  dynamic modifiedOn;
  dynamic prescribeByDoctorId;
  dynamic patientTypesHtmlValue;
  dynamic flightNo;
  dynamic flightDate;
  dynamic airlineId;
  dynamic airportId;
  dynamic flightDestinationId;
  dynamic passengerNameRecord;
  dynamic pickupAddress;
  dynamic latitude;
  dynamic statusType;
  dynamic appointmentNo;
  dynamic branchLocationId;
  dynamic longitude;
  dynamic paymentMethodId;
  dynamic lastProcessedBy;
  dynamic lastProcessedOn;
  dynamic isNotCompleted;
  dynamic paymentStatusName;
  dynamic paymentStatusValue;
  dynamic inRouteDeliveryBranchLocationId;
  dynamic appointmentStatusCount;
  dynamic appointmentStatus;
  dynamic inRouteLongitude;
  dynamic inRouteLatitude;
  dynamic messageBody;
  dynamic providerName;
  dynamic appointmentCategoryName;
  dynamic totalAppointmentFee;
  dynamic startTime;
  dynamic picturePath;
  dynamic eXRURL;
  dynamic typeBit;
  dynamic providerId;
  dynamic packageGroupId;
  dynamic packageGroupName;
  dynamic packageGroupDiscountRate;
  dynamic packageGroupDiscountType;
  dynamic paymentOn;
  dynamic isRefunded;

  HistoryResponseBody(
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
      this.invoiceURL,
      this.picturePath,
      this.eXRURL,
      this.typeBit,
      this.providerId,
      this.packageGroupId,
      this.packageGroupName,
      this.packageGroupDiscountRate,
      this.packageGroupDiscountType,
      this.paymentOn,
      this.isRefunded});

  HistoryResponseBody.fromJson(Map<String, dynamic> json) {
    patientServiceAppointmentId = json['PatientServiceAppointmentId'];
    labNo = json['LabNo'];
    patientId = json['PatientId'];
    status = json['Status'];
    invoiceURL = json['InvoiceURL'];
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
    isRefunded = json['IsRefunded'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['PatientServiceAppointmentId'] = patientServiceAppointmentId;
    data['LabNo'] = labNo;
    data['InvoiceURL'] = invoiceURL;
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
    data['IsRefunded'] = isRefunded;
    return data;
  }
}
