// ignore_for_file: non_constant_identifier_names

class LabInvestigationAppointmentHistory {
  LabInvestigationAppointmentHistory({
    this.Status,
    this.Data,
    this.TotalRecord,
    this.FilterRecord,
  });

  int? Status;
  List<LabInvestigationAppointmentHistoryDataList>? Data;
  int? TotalRecord;
  int? FilterRecord;

  LabInvestigationAppointmentHistory.fromJson(Map<String, dynamic>? json)
      : Status = json?['Status'],
        Data = (json?['Data'] as List<dynamic>?)
            ?.map((e) => LabInvestigationAppointmentHistoryDataList.fromJson(
                e as Map<String, dynamic>))
            .toList(),
        TotalRecord = json?['TotalRecord'],
        FilterRecord = json?['FilterRecord'];

  Map<String, dynamic>? toJson() {
    final data = <String, dynamic>{};
    data['Status'] = Status;
    data['Data'] = Data?.map((e) => e.toJson()).toList();
    data['TotalRecord'] = TotalRecord;
    data['FilterRecord'] = FilterRecord;
    return data;
  }
}

class LabInvestigationAppointmentHistoryDataList {
  LabInvestigationAppointmentHistoryDataList({
    this.LabTests,
    this.AdditionalSubServices,
    this.LabTestList,
    this.AdditionalSubServiceList,
    this.LabNO,
    this.PatientId,
    this.PrescribedBy,
    this.Date,
    this.Time,
    this.Longitude,
    this.Latitude,
    this.PickupAddress,
    this.LabName,
    this.LabPicture,
    this.LabLocation,
    this.CityName,
    this.Status,
    this.AppointmentStatus,
    this.LabId,
    this.StatusValue,
    this.PackageGroupId,
    this.PackageGroupName,
    this.PackageGroupDiscountRate,
    this.PackageGroupDiscountType,
    this.FileAttachment,
  });

  String? LabTests;
  String? AdditionalSubServices;
  List<LabTestLists>? LabTestList; // Updated class name
  List<AdditionalSubServiceLists>?
      AdditionalSubServiceList; // Updated class name
  String? LabNO;
  String? PatientId;
  String? PrescribedBy;
  String? Date;
  String? Time;
  String? Longitude;
  String? Latitude;
  String? PickupAddress;
  String? LabName;
  String? LabPicture;
  String? LabLocation;
  String? CityName;
  String? Status;
  String? AppointmentStatus;
  String? LabId;
  int? StatusValue;
  String? PackageGroupId;
  String? PackageGroupName;
  String? PackageGroupDiscountRate;
  String? PackageGroupDiscountType;
  String? FileAttachment;

  LabInvestigationAppointmentHistoryDataList.fromJson(
      Map<String, dynamic>? json)
      : LabTests = json?['LabTests'],
        AdditionalSubServices = json?['AdditionalSubServices'],
        LabTestList = (json?['LabTestList'] as List<dynamic>?)
            ?.map((e) => LabTestLists.fromJson(
                e as Map<String, dynamic>)) // Updated class name
            .toList(),
        AdditionalSubServiceList =
            (json?['AdditionalSubServiceList'] as List<dynamic>?)
                ?.map((e) => AdditionalSubServiceLists.fromJson(
                    e as Map<String, dynamic>)) // Updated class name
                .toList(),
        LabNO = json?['LabNO'],
        PatientId = json?['PatientId'],
        PrescribedBy = json?['PrescribedBy'],
        Date = json?['Date'],
        Time = json?['Time'],
        Longitude = json?['Longitude'],
        Latitude = json?['Latitude'],
        PickupAddress = json?['PickupAddress'],
        LabName = json?['LabName'],
        LabPicture = json?['LabPicture'],
        LabLocation = json?['LabLocation'],
        CityName = json?['CityName'],
        Status = json?['Status'],
        AppointmentStatus = json?['AppointmentStatus'],
        LabId = json?['LabId'],
        StatusValue = json?['StatusValue'],
        PackageGroupId = json?['PackageGroupId'],
        PackageGroupName = json?['PackageGroupName'],
        PackageGroupDiscountRate = json?['PackageGroupDiscountRate'],
        PackageGroupDiscountType = json?['PackageGroupDiscountType'],
        FileAttachment = json?['FileAttachment'];

  Map<String, dynamic>? toJson() {
    final data = <String, dynamic>{};
    data['LabTests'] = LabTests;
    data['AdditionalSubServices'] = AdditionalSubServices;
    data['LabTestList'] = LabTestList?.map((e) => e.toJson()).toList();
    data['AdditionalSubServiceList'] =
        AdditionalSubServiceList?.map((e) => e.toJson()).toList();
    data['LabNO'] = LabNO;
    data['PatientId'] = PatientId;
    data['PrescribedBy'] = PrescribedBy;
    data['Date'] = Date;
    data['Time'] = Time;
    data['Longitude'] = Longitude;
    data['Latitude'] = Latitude;
    data['PickupAddress'] = PickupAddress;
    data['LabName'] = LabName;
    data['LabPicture'] = LabPicture;
    data['LabLocation'] = LabLocation;
    data['CityName'] = CityName;
    data['Status'] = Status;
    data['AppointmentStatus'] = AppointmentStatus;
    data['LabId'] = LabId;
    data['StatusValue'] = StatusValue;
    data['PackageGroupId'] = PackageGroupId;
    data['PackageGroupName'] = PackageGroupName;
    data['PackageGroupDiscountRate'] = PackageGroupDiscountRate;
    data['PackageGroupDiscountType'] = PackageGroupDiscountType;
    data['FileAttachment'] = FileAttachment;
    return data;
  }
}

class LabTestLists {
  LabTestLists({
    this.LabTestId,
    this.Name,
    this.EXRURL,
    this.IsCreditPaymentpending,
    this.Status,
    this.ModifiedOn,
  });

  String? LabTestId;
  String? Name;
  String? EXRURL;
  bool? IsCreditPaymentpending;
  String? Status;
  String? ModifiedOn;

  LabTestLists.fromJson(Map<String, dynamic>? json)
      : LabTestId = json?['LabTestId'],
        Name = json?['Name'],
        EXRURL = json?['EXRURL'],
        IsCreditPaymentpending = json?['IsCreditPaymentpending'],
        Status = json?['Status'],
        ModifiedOn = json?['ModifiedOn'];

  Map<String, dynamic>? toJson() {
    final data = <String, dynamic>{};
    data['LabTestId'] = LabTestId;
    data['Name'] = Name;
    data['EXRURL'] = EXRURL;
    data['IsCreditPaymentpending'] = IsCreditPaymentpending;
    data['Status'] = Status;
    data['ModifiedOn'] = ModifiedOn;
    return data;
  }
}

class AdditionalSubServiceLists {
  AdditionalSubServiceLists({
    this.Id,
    this.SubServiceId,
    this.Name,
    this.Price,
    this.ActualPrice,
    this.IsForSampleCollectionCharges,
    this.IsForAdditionalCharges,
    this.IsForUrgentCharges,
    this.IsAdditionalChargesForPassenger,
    this.CalculatedPrice,
    this.IsForAdditionalChargesForCovid,
  });

  String? Id;
  String? SubServiceId;
  String? Name;
  double? Price;
  double? ActualPrice;
  bool? IsForSampleCollectionCharges;
  bool? IsForAdditionalCharges;
  bool? IsForUrgentCharges;
  bool? IsAdditionalChargesForPassenger;
  double? CalculatedPrice;
  bool? IsForAdditionalChargesForCovid;

  AdditionalSubServiceLists.fromJson(Map<String, dynamic>? json)
      : Id = json?['Id'],
        SubServiceId = json?['SubServiceId'],
        Name = json?['Name'],
        Price = json?['Price'] as double,
        ActualPrice = json?['ActualPrice'] as double,
        IsForSampleCollectionCharges = json?['IsForSampleCollectionCharges'],
        IsForAdditionalCharges = json?['IsForAdditionalCharges'],
        IsForUrgentCharges = json?['IsForUrgentCharges'],
        IsAdditionalChargesForPassenger =
            json?['IsAdditionalChargesForPassenger'],
        CalculatedPrice = json?['CalculatedPrice'] as double,
        IsForAdditionalChargesForCovid =
            json?['IsForAdditionalChargesForCovid'];

  Map<String, dynamic>? toJson() {
    final data = <String, dynamic>{};
    data['Id'] = Id;
    data['SubServiceId'] = SubServiceId;
    data['Name'] = Name;
    data['Price'] = Price;
    data['ActualPrice'] = ActualPrice;
    data['IsForSampleCollectionCharges'] = IsForSampleCollectionCharges;
    data['IsForAdditionalCharges'] = IsForAdditionalCharges;
    data['IsForUrgentCharges'] = IsForUrgentCharges;
    data['IsAdditionalChargesForPassenger'] = IsAdditionalChargesForPassenger;
    data['CalculatedPrice'] = CalculatedPrice;
    data['IsForAdditionalChargesForCovid'] = IsForAdditionalChargesForCovid;
    return data;
  }
}
