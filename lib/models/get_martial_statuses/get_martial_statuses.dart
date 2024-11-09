class MartialStatusesResponse {
  int? status;
  List<MartialStatuses>? data;

  MartialStatusesResponse({this.status, this.data});

  MartialStatusesResponse.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    if (json['Data'] != null) {
      data = <MartialStatuses>[];
      json['Data'].forEach((v) {
        data!.add(MartialStatuses.fromJson(v));
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

class MartialStatuses {
  String? id;
  String? name;

  MartialStatuses({this.id, this.name});

  MartialStatuses.fromJson(Map<String, dynamic> json) {
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
