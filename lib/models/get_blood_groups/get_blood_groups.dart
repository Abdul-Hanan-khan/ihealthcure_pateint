class GetBloodGroups {
  int? status;
  List<BloodGroups>? data;

  GetBloodGroups({this.status, this.data});

  GetBloodGroups.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    if (json['Data'] != null) {
      data = <BloodGroups>[];
      json['Data'].forEach((v) {
        data!.add(BloodGroups.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Status'] = status;
    if (this.data != null) {
      data['Data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BloodGroups {
  String? id;
  String? name;

  BloodGroups({this.id, this.name});

  BloodGroups.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['Name'] = name;
    return data;
  }
}
