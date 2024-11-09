class PrescriptionSummaryResponse {
  int? status;
  // List<Null>? medicineSummary;
  // List<Null>? diagnosticsSummary;
  List<InvestigationsSummary>? investigationsSummary;

  PrescriptionSummaryResponse(
      {this.status,
      // this.medicineSummary,
      // this.diagnosticsSummary,
      this.investigationsSummary});

  PrescriptionSummaryResponse.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    if (json['MedicineSummary'] != null) {
      // medicineSummary = <Null>[];
      // json['MedicineSummary'].forEach((v) {
      //   // medicineSummary!.add( Null.fromJson(v));
      // });
    }
    if (json['DiagnosticsSummary'] != null) {
      // diagnosticsSummary = <Null>[];
      json['DiagnosticsSummary'].forEach((v) {
        // diagnosticsSummary!.add(new Null.fromJson(v));
      });
    }
    if (json['InvestigationsSummary'] != null) {
      investigationsSummary = <InvestigationsSummary>[];
      json['InvestigationsSummary'].forEach((v) {
        investigationsSummary!.add(InvestigationsSummary.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Status'] = status;
    // if (this.medicineSummary != null) {
    //   data['MedicineSummary'] =
    //       this.medicineSummary!.map((v) => v.toJson()).toList();
    // }
    // if (this.diagnosticsSummary != null) {
    //   data['DiagnosticsSummary'] =
    //       this.diagnosticsSummary!.map((v) => v.toJson()).toList();
    // }
    if (investigationsSummary != null) {
      data['InvestigationsSummary'] =
          investigationsSummary!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class InvestigationsSummary {
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

  InvestigationsSummary(
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

  InvestigationsSummary.fromJson(Map<String, dynamic> json) {
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
