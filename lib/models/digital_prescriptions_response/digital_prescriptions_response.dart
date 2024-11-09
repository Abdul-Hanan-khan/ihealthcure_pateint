class DigitalPrescriptionsResponse {
  int? status;
  int? filterRecord;
  int? totalRecord;
  List<DigitalPrescriptions>? data;

  DigitalPrescriptionsResponse(
      {this.status, this.filterRecord, this.totalRecord, this.data});

  DigitalPrescriptionsResponse.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    filterRecord = json['FilterRecord'];
    totalRecord = json['TotalRecord'];
    if (json['Data'] != null) {
      data = <DigitalPrescriptions>[];
      json['Data'].forEach((v) {
        data!.add(DigitalPrescriptions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Status'] = status;
    data['FilterRecord'] = filterRecord;
    data['TotalRecord'] = totalRecord;
    if (this.data != null) {
      data['Data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DigitalPrescriptions {
  String? patientId;
  String? visitNo;
  String? admissionTime;
  String? section;
  String? doctorName;
  String? prescribedById;
  String? patientStatus;
  String? consultedTime;
  String? uRL;
  String? branchName;
  List<Medicines>? medicines;
  List<LabInvestigation>? labInvestigation;
  List<Diagnostics>? diagnostics;

  DigitalPrescriptions(
      {this.patientId,
      this.visitNo,
      this.admissionTime,
      this.section,
      this.doctorName,
      this.prescribedById,
      this.patientStatus,
      this.consultedTime,
      this.uRL,
      this.branchName,
      this.medicines,
      this.labInvestigation,
      this.diagnostics});

  DigitalPrescriptions.fromJson(Map<String, dynamic> json) {
    patientId = json['PatientId'];
    visitNo = json['VisitNo'];
    admissionTime = json['AdmissionTime'];
    section = json['Section'];
    doctorName = json['DoctorName'];
    prescribedById = json['PrescribedById'];
    patientStatus = json['PatientStatus'];
    consultedTime = json['ConsultedTime'];
    uRL = json['URL'];
    branchName = json['BranchName'];
    if (json['Medicines'] != null) {
      medicines = <Medicines>[];
      json['Medicines'].forEach((v) {
        medicines!.add(Medicines.fromJson(v));
      });
    }
    if (json['LabInvestigation'] != null) {
      labInvestigation = <LabInvestigation>[];
      json['LabInvestigation'].forEach((v) {
        labInvestigation!.add(LabInvestigation.fromJson(v));
      });
    }
    if (json['Diagnostics'] != null) {
      diagnostics = <Diagnostics>[];
      json['Diagnostics'].forEach((v) {
        diagnostics!.add(Diagnostics.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['PatientId'] = patientId;
    data['VisitNo'] = visitNo;
    data['AdmissionTime'] = admissionTime;
    data['Section'] = section;
    data['DoctorName'] = doctorName;
    data['PrescribedById'] = prescribedById;
    data['PatientStatus'] = patientStatus;
    data['ConsultedTime'] = consultedTime;
    data['URL'] = uRL;
    data['BranchName'] = branchName;
    if (medicines != null) {
      data['Medicines'] = medicines!.map((v) => v.toJson()).toList();
    }
    if (labInvestigation != null) {
      data['LabInvestigation'] =
          labInvestigation!.map((v) => v.toJson()).toList();
    }
    if (diagnostics != null) {
      data['Diagnostics'] = diagnostics!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Medicines {
  String? patientId;
  String? medicineId;
  String? name;
  int? quantity;
  String? dOS;
  String? dayDate;
  String? visitNo;
  String? dayId;
  String? dateId;
  String? frequencyNumeric;
  double? frequencyQuantity;
  String? medicineEventTimingId;
  String? prescribedInId;

  Medicines(
      {this.patientId,
      this.medicineId,
      this.name,
      this.quantity,
      this.dOS,
      this.dayDate,
      this.visitNo,
      this.dayId,
      this.dateId,
      this.frequencyNumeric,
      this.frequencyQuantity,
      this.medicineEventTimingId,
      this.prescribedInId});

  Medicines.fromJson(Map<String, dynamic> json) {
    patientId = json['PatientId'];
    medicineId = json['MedicineId'];
    name = json['Name'];
    quantity = json['Quantity'];
    dOS = json['DOS'];
    dayDate = json['DayDate'];
    visitNo = json['VisitNo'];
    dayId = json['DayId'];
    dateId = json['DateId'];
    frequencyNumeric = json['FrequencyNumeric'];
    frequencyQuantity = json['FrequencyQuantity'];
    medicineEventTimingId = json['MedicineEventTimingId'];
    prescribedInId = json['PrescribedInId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['PatientId'] = patientId;
    data['MedicineId'] = medicineId;
    data['Name'] = name;
    data['Quantity'] = quantity;
    data['DOS'] = dOS;
    data['DayDate'] = dayDate;
    data['VisitNo'] = visitNo;
    data['DayId'] = dayId;
    data['DateId'] = dateId;
    data['FrequencyNumeric'] = frequencyNumeric;
    data['FrequencyQuantity'] = frequencyQuantity;
    data['MedicineEventTimingId'] = medicineEventTimingId;
    data['PrescribedInId'] = prescribedInId;
    return data;
  }
}

class LabInvestigation {
  String? patientId;
  String? labTestId;
  String? labTestName;
  String? visitNo;

  LabInvestigation(
      {this.patientId, this.labTestId, this.labTestName, this.visitNo});

  LabInvestigation.fromJson(Map<String, dynamic> json) {
    patientId = json['PatientId'];
    labTestId = json['LabTestId'];
    labTestName = json['LabTestName'];
    visitNo = json['VisitNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['PatientId'] = patientId;
    data['LabTestId'] = labTestId;
    data['LabTestName'] = labTestName;
    data['VisitNo'] = visitNo;
    return data;
  }
}

class Diagnostics {
  String? patientId;
  String? diagnosticId;
  String? diagnosticName;
  String? visitNo;

  Diagnostics(
      {this.patientId, this.diagnosticId, this.diagnosticName, this.visitNo});

  Diagnostics.fromJson(Map<String, dynamic> json) {
    patientId = json['PatientId'];
    diagnosticId = json['DiagnosticId'];
    diagnosticName = json['DiagnosticName'];
    visitNo = json['VisitNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['PatientId'] = patientId;
    data['DiagnosticId'] = diagnosticId;
    data['DiagnosticName'] = diagnosticName;
    data['VisitNo'] = visitNo;
    return data;
  }
}
