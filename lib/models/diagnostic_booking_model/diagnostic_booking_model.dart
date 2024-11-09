class DiagnosticReportsResponse {
  int? status;
  List<ReportsData>? data;
  int? totalRecord;
  int? filterRecord;

  DiagnosticReportsResponse(
      {this.status, this.data, this.totalRecord, this.filterRecord});

  DiagnosticReportsResponse.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    if (json['Data'] != null) {
      data = <ReportsData>[];
      json['Data'].forEach((v) {
        // ignore: unnecessary_new
        data!.add(new ReportsData.fromJson(v));
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

class ReportsData {
  String? patientId;
  String? visitNo;
  String? labNo;
  String? testName;
  String? prescribedBy;
  String? visitTime;
  String? patientLabStatus;
  String? branchName;
  String? cityName;
  String? uRL;
  String? allinOneReportUrl;
  String? labTestId;
  String? patientServiceId;
  String? labPatientStatusOn;
  bool? isCreditPaymentPending;
  String? id;
  String? subServiceId;
  String? name;
  String? price;
  String? actualPrice;
  String? isForSampleCollectionCharges;
  String? isForAdditionalCharges;
  String? isForUrgentCharges;
  String? isAdditionalChargesForPassenger;
  String? calculatedPrice;
  String? isForAdditionalChargesForCovid;

  ReportsData(
      {this.patientId,
      this.visitNo,
      this.labNo,
      this.testName,
      this.prescribedBy,
      this.visitTime,
      this.patientLabStatus,
      this.branchName,
      this.cityName,
      this.uRL,
      this.allinOneReportUrl,
      this.labTestId,
      this.patientServiceId,
      this.labPatientStatusOn,
      this.isCreditPaymentPending,
      this.id,
      this.subServiceId,
      this.name,
      this.price,
      this.actualPrice,
      this.isForSampleCollectionCharges,
      this.isForAdditionalCharges,
      this.isForUrgentCharges,
      this.isAdditionalChargesForPassenger,
      this.calculatedPrice,
      this.isForAdditionalChargesForCovid});

  ReportsData.fromJson(Map<String, dynamic> json) {
    patientId = json['PatientId'];
    visitNo = json['VisitNo'];
    labNo = json['LabNo'];
    testName = json['TestName'];
    prescribedBy = json['PrescribedBy'];
    visitTime = json['VisitTime'];
    patientLabStatus = json['PatientLabStatus'];
    branchName = json['BranchName'];
    cityName = json['CityName'];
    uRL = json['URL'];
    allinOneReportUrl = json['AllinOneReportUrl'];
    labTestId = json['LabTestId'];
    patientServiceId = json['PatientServiceId'];
    labPatientStatusOn = json['LabPatientStatusOn'];
    isCreditPaymentPending = json['IsCreditPaymentPending'];
    id = json['Id'];
    subServiceId = json['SubServiceId'];
    name = json['Name'];
    price = json['Price'];
    actualPrice = json['ActualPrice'];
    isForSampleCollectionCharges = json['IsForSampleCollectionCharges'];
    isForAdditionalCharges = json['IsForAdditionalCharges'];
    isForUrgentCharges = json['IsForUrgentCharges'];
    isAdditionalChargesForPassenger = json['IsAdditionalChargesForPassenger'];
    calculatedPrice = json['CalculatedPrice'];
    isForAdditionalChargesForCovid = json['IsForAdditionalChargesForCovid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['PatientId'] = patientId;
    data['VisitNo'] = visitNo;
    data['LabNo'] = labNo;
    data['TestName'] = testName;
    data['PrescribedBy'] = prescribedBy;
    data['VisitTime'] = visitTime;
    data['PatientLabStatus'] = patientLabStatus;
    data['BranchName'] = branchName;
    data['CityName'] = cityName;
    data['URL'] = uRL;
    data['AllinOneReportUrl'] = allinOneReportUrl;
    data['LabTestId'] = labTestId;
    data['PatientServiceId'] = patientServiceId;
    data['LabPatientStatusOn'] = labPatientStatusOn;
    data['IsCreditPaymentPending'] = isCreditPaymentPending;
    data['Id'] = id;
    data['SubServiceId'] = subServiceId;
    data['Name'] = name;
    data['Price'] = price;
    data['ActualPrice'] = actualPrice;
    data['IsForSampleCollectionCharges'] = isForSampleCollectionCharges;
    data['IsForAdditionalCharges'] = isForAdditionalCharges;
    data['IsForUrgentCharges'] = isForUrgentCharges;
    data['IsAdditionalChargesForPassenger'] = isAdditionalChargesForPassenger;
    data['CalculatedPrice'] = calculatedPrice;
    data['IsForAdditionalChargesForCovid'] = isForAdditionalChargesForCovid;
    return data;
  }
}
