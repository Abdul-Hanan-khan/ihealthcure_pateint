// ignore_for_file: file_names

class LabTestResultsResponse {
  int? status;
  List<LabTestResult>? data;
  int? totalRecord;
  int? filterRecord;

  LabTestResultsResponse(
      {this.status, this.data, this.totalRecord, this.filterRecord});

  LabTestResultsResponse.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    if (json['Data'] != null) {
      data = <LabTestResult>[];
      json['Data'].forEach((v) {
        data!.add( LabTestResult.fromJson(v));
      });
    }
    totalRecord = json['TotalRecord'];
    filterRecord = json['FilterRecord'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['Status'] = status;
    if (this.data != null) {
      data['Data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['TotalRecord'] = totalRecord;
    data['FilterRecord'] = filterRecord;
    return data;
  }
}

class LabTestResult {
  String? patientId;
  String? labNo;
  String? prescribedBy;
  String? visitTime;
  String? fullReportURL;
  List<LabTests>? labTests;
  String? additionalSubServices;

  LabTestResult(
      {this.patientId,
      this.labNo,
      this.prescribedBy,
      this.visitTime,
      this.fullReportURL,
      this.labTests,
      this.additionalSubServices});

  LabTestResult.fromJson(Map<String, dynamic> json) {
    patientId = json['PatientId'];
    labNo = json['LabNo'];
    prescribedBy = json['PrescribedBy'];
    visitTime = json['VisitTime'];
    fullReportURL = json['FullReportURL'];
    if (json['LabTests'] != null) {
      labTests = <LabTests>[];
      json['LabTests'].forEach((v) {
        labTests!.add(LabTests.fromJson(v));
      });
    }
    additionalSubServices = json['AdditionalSubServices'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['PatientId'] = patientId;
    data['LabNo'] = labNo;
    data['PrescribedBy'] = prescribedBy;
    data['VisitTime'] = visitTime;
    data['FullReportURL'] = fullReportURL;
    if (labTests != null) {
      data['LabTests'] = labTests!.map((v) => v.toJson()).toList();
    }
    data['AdditionalSubServices'] = additionalSubServices;
    return data;
  }
}

class LabTests {
  String? patientServiceId;
  String? patientId;
  String? labNo;
  String? prescribedBy;
  String? visitTime;
  String? visitNo;
  String? labTestId;
  String? testName;
  String? patientLabStatus;
  String? branchName;
  String? cityName;
  String? uRL;
  String? fullReportURL;
  String? labPatientStatusOn;
  bool? isCreditPaymentPending;

  LabTests(
      {this.patientServiceId,
      this.patientId,
      this.labNo,
      this.prescribedBy,
      this.visitTime,
      this.visitNo,
      this.labTestId,
      this.testName,
      this.patientLabStatus,
      this.branchName,
      this.cityName,
      this.uRL,
      this.fullReportURL,
      this.labPatientStatusOn,
      this.isCreditPaymentPending});

  LabTests.fromJson(Map<String, dynamic> json) {
    patientServiceId = json['PatientServiceId'];
    patientId = json['PatientId'];
    labNo = json['LabNo'];
    prescribedBy = json['PrescribedBy'];
    visitTime = json['VisitTime'];
    visitNo = json['VisitNo'];
    labTestId = json['LabTestId'];
    testName = json['TestName'];
    patientLabStatus = json['PatientLabStatus'];
    branchName = json['BranchName'];
    cityName = json['CityName'];
    uRL = json['URL'];
    fullReportURL = json['FullReportURL'];
    labPatientStatusOn = json['LabPatientStatusOn'];
    isCreditPaymentPending = json['IsCreditPaymentPending'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['PatientServiceId'] = patientServiceId;
    data['PatientId'] = patientId;
    data['LabNo'] = labNo;
    data['PrescribedBy'] = prescribedBy;
    data['VisitTime'] = visitTime;
    data['VisitNo'] = visitNo;
    data['LabTestId'] = labTestId;
    data['TestName'] = testName;
    data['PatientLabStatus'] = patientLabStatus;
    data['BranchName'] = branchName;
    data['CityName'] = cityName;
    data['URL'] = uRL;
    data['FullReportURL'] = fullReportURL;
    data['LabPatientStatusOn'] = labPatientStatusOn;
    data['IsCreditPaymentPending'] = isCreditPaymentPending;
    return data;
  }
}
