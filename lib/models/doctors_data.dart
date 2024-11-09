class DoctorsResponse {
  int? status;
  List<Doctors>? doctors;

  DoctorsResponse({this.status, this.doctors});

  DoctorsResponse.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    if (json['Doctors'] != null) {
      doctors = <Doctors>[];
      json['Doctors'].forEach((v) {
        doctors!.add( Doctors.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Status'] = status;
    if (doctors != null) {
      data['Doctors'] = doctors!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Doctors {
  String? id;
  String? name;

  Doctors({this.id, this.name});

  Doctors.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['Id'] = id;
    data['Name'] = name;
    return data;
  }
}