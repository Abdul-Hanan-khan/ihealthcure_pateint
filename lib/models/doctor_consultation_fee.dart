class DoctorConsultationData {
  int? status;
  ConsultancyDetail? consultancyDetail;

  DoctorConsultationData({this.status, this.consultancyDetail});

  DoctorConsultationData.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    consultancyDetail = json['ConsultancyDetail'] != null
        ?  ConsultancyDetail.fromJson(json['ConsultancyDetail'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['Status'] = status;
    if (consultancyDetail != null) {
      data['ConsultancyDetail'] = consultancyDetail!.toJson();
    }
    return data;
  }
}

class ConsultancyDetail {
  String? id;
  String? fullName;
  String? imagePath;
  String? displayEducation;
  String? displayDesignation;
  double? consultancyFee;
  double? actualFee;
  String? branchId;

  ConsultancyDetail(
      {this.id,
      this.fullName,
      this.imagePath,
      this.displayEducation,
      this.displayDesignation,
      this.consultancyFee,
      this.actualFee,
      this.branchId});

  ConsultancyDetail.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    fullName = json['FullName'];
    imagePath = json['ImagePath'];
    displayEducation = json['DisplayEducation'];
    displayDesignation = json['DisplayDesignation'];
    consultancyFee = json['ConsultancyFee'];
    actualFee = json['ActualFee'];
    branchId = json['BranchId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['FullName'] = fullName;
    data['ImagePath'] = imagePath;
    data['DisplayEducation'] = displayEducation;
    data['DisplayDesignation'] = displayDesignation;
    data['ConsultancyFee'] = consultancyFee;
    data['ActualFee'] = actualFee;
    data['BranchId'] = branchId;
    return data;
  }
}
