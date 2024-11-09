import 'package:tabib_al_bait/data/controller/lab_investigations_controller.dart';

class Doctorconsultation {
  int? status;
  List<Doctorconsult>? data;
  String? errorMessage;

  Doctorconsultation({this.status, this.data, this.errorMessage});

  Doctorconsultation.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    if (json['Data'] != null) {
      data = <Doctorconsult>[];
      json['Data'].forEach((v) {
        data!.add(Doctorconsult.fromJson(v));
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

class Doctorconsult {
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

  Doctorconsult(
      {this.id,
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
      this.appointmentnotes});

  Doctorconsult.fromJson(Map<String, dynamic> json) {
    typeId =Typbitselection();
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
    appointmentnotes=json['AppointmentNotes'];
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

    return data;
  }

}

String Typbitselection() {
  var cont = LabInvestigationController.i;
  if(cont.selectedalue1==25){
    return "25";
  }else if(cont.selectedalue1==26){
    return "26";

  }else if(cont.selectedalue1==27){
    return "27";

  }else{
    return "25";
  }

  
  }
