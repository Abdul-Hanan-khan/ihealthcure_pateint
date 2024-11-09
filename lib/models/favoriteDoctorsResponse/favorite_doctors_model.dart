import 'package:tabib_al_bait/models/search_models.dart';

class GetFavoriteDoctorsResponse {
  int? status;
  List<Search>? doctors;
  int? totalRecord;
  int? filterRecord;

  GetFavoriteDoctorsResponse(
      {this.status, this.doctors, this.totalRecord, this.filterRecord});

  GetFavoriteDoctorsResponse.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    if (json['Doctors'] != null) {
      doctors = <Search>[];
      json['Doctors'].forEach((v) {
        doctors!.add(Search.fromJson(v));
      });
    }
    totalRecord = json['TotalRecord'];
    filterRecord = json['FilterRecord'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Status'] = status;
    if (doctors != null) {
      data['Doctors'] = doctors!.map((v) => v.toJson()).toList();
    }
    data['TotalRecord'] = totalRecord;
    data['FilterRecord'] = filterRecord;
    return data;
  }
}
