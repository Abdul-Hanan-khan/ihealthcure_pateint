// ignore_for_file: non_constant_identifier_names


class LabTestsModelHome {
  int? status;
  List<LabTestHome>? data;
  String? errorMessage;
  LabTestsModelHome({this.status, this.data, this.errorMessage});
  LabTestsModelHome.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    if (json['Data'] != null) {
      data = <LabTestHome>[];
      json['Data'].forEach((v) {
        data!.add(LabTestHome.fromJson(v));
      });
    }
    errorMessage = json['ErrorMessage'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Status'] = status;
    if (this.data != null) {
      data['Data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['ErrorMessage'] = errorMessage;
    return data;
  }
}

class LabTestHome {
  String? labtestId;
  String? id;
  String? name;
  double? price;
  double? actualPrice;
  bool? isForSampleCollectionCharges;
  bool? isForAdditionalCharges;
  bool? isForUrgentCharges;
  bool? isAdditionalChargesForPassenger;
  bool? isForCovid;
  bool? isForAdditionalChargesForCovid;
  String? typeId;
  String? appointmentnotes;
  String? specialityid;
  int? IsOnlineAppointment;
  LabTestHome({
    this.id,
    this.labtestId,
    this.name,
    this.price,
    this.actualPrice,
    this.isForSampleCollectionCharges,
    this.isForAdditionalCharges,
    this.isForUrgentCharges,
    this.isAdditionalChargesForPassenger,
    this.isForCovid,
    this.isForAdditionalChargesForCovid,
    this.appointmentnotes,
    this.specialityid,
    this.IsOnlineAppointment,
  });
  LabTestHome.fromJson(Map<String, dynamic> json) {
    typeId = '2';
    id = json['Id'];
    labtestId = json['LabTestId'];
    name = json['Name'];
    price = json['Price'];
    actualPrice = json['ActualPrice'];
    isForSampleCollectionCharges = json['IsForSampleCollectionCharges'];
    isForAdditionalCharges = json['IsForAdditionalCharges'];
    isForUrgentCharges = json['IsForUrgentCharges'];
    isAdditionalChargesForPassenger = json['IsAdditionalChargesForPassenger'];
    isForCovid = json['IsForCovid'];
    isForAdditionalChargesForCovid = json['IsForAdditionalChargesForCovid'];
    appointmentnotes = json['AppointmentNotes'];
    specialityid = json['SpecialityId'];
    IsOnlineAppointment = json['IsOnlineAppointment'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['TypeBit'] = typeId;
    data['Id'] = id;
    data['LabTestId'] = id;
    data['Name'] = name;
    data['Price'] = price;
    data['ActualPrice'] = actualPrice;
    data['IsForSampleCollectionCharges'] = isForSampleCollectionCharges;
    data['IsForAdditionalCharges'] = isForAdditionalCharges;
    data['IsForUrgentCharges'] = isForUrgentCharges;
    data['IsAdditionalChargesForPassenger'] = isAdditionalChargesForPassenger;
    data['IsForCovid'] = isForCovid;
    data['IsForAdditionalChargesForCovid'] = isForAdditionalChargesForCovid;
    data['AppointmentNotes'] = appointmentnotes;
    data['SpecialityId'] = specialityid;
    data['IsOnlineAppointment'] = IsOnlineAppointment;
    return data;
  }
}
