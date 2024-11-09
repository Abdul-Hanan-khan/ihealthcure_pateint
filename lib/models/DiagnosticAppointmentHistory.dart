// ignore_for_file: non_constant_identifier_names, no_leading_underscores_for_local_identifiers

class DiagnosticAppointmentHistory {
  DiagnosticAppointmentHistory({
    this.Status,
    this.Data,
    this.TotalRecord,
    this.FilterRecord,
  });

  int? Status;
  List<DiagnositicAppointmentListData>? Data;
  int? TotalRecord;
  int? FilterRecord;

  DiagnosticAppointmentHistory.fromJson(Map<String, dynamic> json) {
    Status = json['Status'];
    Data = List.from(json['Data'])
        .map((e) => DiagnositicAppointmentListData.fromJson(e))
        .toList();
    TotalRecord = json['TotalRecord'];
    FilterRecord = json['FilterRecord'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['Status'] = Status;
    _data['Data'] = Data?.map((e) => e.toJson()).toList();
    _data['TotalRecord'] = TotalRecord;
    _data['FilterRecord'] = FilterRecord;
    return _data;
  }
}

class DiagnositicAppointmentListData {
  DiagnositicAppointmentListData({
    this.Id,
    this.DiagnosticId,
    this.PatientName,
    this.DiagnosticName,
    this.DiagnosticCenter,
    this.DiagnosticCenterImagePah,
    this.Location,
    this.CityName,
    this.BookingTime,
    this.Status,
    this.AppointmentDate,
    this.PrescribedByDoctor,
    this.PatientId,
    this.PatientDiagnosticAppointmentId,
    this.SessionId,
    this.BranchId,
    this.DiagnosticCenterId,
    this.Monday,
    this.Sunday,
    this.Tuesday,
    this.Wednesday,
    this.Thursday,
    this.Friday,
    this.Saturday,
    this.Price,
    this.EXRURL,
    this.IsCreditPaymentpending,
    this.StatusValue,
    this.ModifiedOn,
  });
  String? Id;
  String? DiagnosticId;
  String? PatientName;
  String? DiagnosticName;
  String? DiagnosticCenter;
  String? DiagnosticCenterImagePah;
  String? Location;
  String? CityName;
  String? BookingTime;
  String? Status;
  String? AppointmentDate;
  String? PrescribedByDoctor;
  String? PatientId;
  String? PatientDiagnosticAppointmentId;
  String? SessionId;
  String? BranchId;
  String? DiagnosticCenterId;
  int? Monday;
  int? Sunday;
  int? Tuesday;
  int? Wednesday;
  int? Friday;
  int? Thursday;
  int? Saturday;
  double? Price;
  String? EXRURL;
  bool? IsCreditPaymentpending;
  int? StatusValue;
  String? ModifiedOn;

  DiagnositicAppointmentListData.fromJson(Map<String, dynamic> json) {
    Id = json['Id'];
    DiagnosticId = json['DiagnosticId'];
    PatientName = json['PatientName'];
    DiagnosticName = json['DiagnosticName'];
    DiagnosticCenter = json['DiagnosticCenter'];
    DiagnosticCenterImagePah = json['DiagnosticCenterImagePah'];
    Location = json['Location'];
    CityName = json['CityName'];
    BookingTime = json['BookingTime'];
    Status = json['Status'];
    AppointmentDate = json['AppointmentDate'];
    PrescribedByDoctor = json['PrescribedByDoctor'];
    PatientId = json['PatientId'];
    PatientDiagnosticAppointmentId = json['PatientDiagnosticAppointmentId'];
    SessionId = json['SessionId'];
    BranchId = json['BranchId'];
    DiagnosticCenterId = json['DiagnosticCenterId'];
    Monday = json['Monday'];
    Sunday = json['Sunday'];
    Tuesday = json['Tuesday'];
    Wednesday = json['Wednesday'];
    Thursday = json['Thursday'];
    Friday = json['Friday'];
    Saturday = json['Saturday'];
    Price = json['Price'];
    EXRURL = json['EXRURL'];
    IsCreditPaymentpending = json['IsCreditPaymentpending'];
    StatusValue = json['StatusValue'];
    ModifiedOn = json['ModifiedOn'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['Id'] = Id;
    data['DiagnosticId'] = DiagnosticId;
    data['PatientName'] = PatientName;
    data['DiagnosticName'] = DiagnosticName;
    data['DiagnosticCenter'] = DiagnosticCenter;
    data['DiagnosticCenterImagePah'] = DiagnosticCenterImagePah;
    data['Location'] = Location;
    data['CityName'] = CityName;
    data['BookingTime'] = BookingTime;
    data['Status'] = Status;
    data['AppointmentDate'] = AppointmentDate;
    data['PrescribedByDoctor'] = PrescribedByDoctor;
    data['PatientId'] = PatientId;
    data['PatientDiagnosticAppointmentId'] = PatientDiagnosticAppointmentId;
    data['SessionId'] = SessionId;
    data['BranchId'] = BranchId;
    data['DiagnosticCenterId'] = DiagnosticCenterId;
    data['Monday'] = Monday;
    data['Sunday'] = Sunday;
    data['Tuesday'] = Tuesday;
    data['Wednesday'] = Wednesday;
    data['Thursday'] = Thursday;
    data['Friday'] = Friday;
    data['Saturday'] = Saturday;
    data['Price'] = Price;
    data['EXRURL'] = EXRURL;
    data['IsCreditPaymentpending'] = IsCreditPaymentpending;
    data['StatusValue'] = StatusValue;
    data['ModifiedOn'] = ModifiedOn;
    return data;
  }
}
