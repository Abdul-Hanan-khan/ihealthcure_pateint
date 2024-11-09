// ignore_for_file: non_constant_identifier_names

class UpcomingLabInvestigation {
  UpcomingLabInvestigation({
    this.Status,
    this.Data,
    this.TotalRecord,
    this.FilterRecord,
  });
  int? Status;
  List<UpComingLabIvestigationDataList>? Data;
  int? TotalRecord;
  int? FilterRecord;

  UpcomingLabInvestigation.fromJson(Map<String, dynamic> json) {
    Status = json['Status'];
    Data = (json['Data'] as List<dynamic>?)
        ?.map((e) =>
            UpComingLabIvestigationDataList.fromJson(e as Map<String, dynamic>))
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

class UpComingLabIvestigationDataList {
  UpComingLabIvestigationDataList({
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
  List<dynamic>? LabTests;
  List<dynamic>? AdditionalSubServices;
  dynamic LabTestList;
  dynamic AdditionalSubServiceList;
  String? LabNO;
  String? PatientId;
  String? PrescribedBy;
  String? Date;
  String? Time;
  dynamic Longitude;
  dynamic Latitude;
  String? PickupAddress;
  String? LabName;
  String? LabPicture;
  String? LabLocation;
  String? CityName;
  String? Status;
  dynamic AppointmentStatus;
  String? LabId;
  int? StatusValue;
  dynamic PackageGroupId;
  dynamic PackageGroupName;
  dynamic PackageGroupDiscountRate;
  dynamic PackageGroupDiscountType;
  dynamic FileAttachment;

  UpComingLabIvestigationDataList.fromJson(Map<String, dynamic> json) {
    LabTests = (json['LabTests'] as List<dynamic>?)?.cast<String>();
    AdditionalSubServices =
        (json['AdditionalSubServices'] as List<dynamic>?)?.toList();
    LabTestList = null;
    AdditionalSubServiceList = null;
    LabNO = json['LabNO'];
    PatientId = json['PatientId'];
    PrescribedBy = json['PrescribedBy'];
    Date = json['Date'];
    Time = json['Time'];
    Longitude = null;
    Latitude = null;
    PickupAddress = json['PickupAddress'];
    LabName = json['LabName'];
    LabPicture = json['LabPicture'];
    LabLocation = json['LabLocation'];
    CityName = json['CityName'];
    Status = json['Status'];
    AppointmentStatus = null;
    LabId = json['LabId'];
    StatusValue = json['StatusValue'];
    PackageGroupId = null;
    PackageGroupName = null;
    PackageGroupDiscountRate = null;
    PackageGroupDiscountType = null;
    FileAttachment = null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['LabTests'] = LabTests;
    data['AdditionalSubServices'] = AdditionalSubServices;
    data['LabTestList'] = LabTestList;
    data['AdditionalSubServiceList'] = AdditionalSubServiceList;
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
