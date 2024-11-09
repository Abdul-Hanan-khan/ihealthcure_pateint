class DoctorsData {
  int? status;
  List<DoctorScheduleModel>? data;

  DoctorsData({this.status, this.data});

  DoctorsData.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    if (json['Data'] != null) {
      data = <DoctorScheduleModel>[];
      json['Data'].forEach((v) {
        data!.add( DoctorScheduleModel.fromJson(v));
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

class DoctorScheduleModel {
  String? id;
  String? name;
  String? cityId;
  String? address;
  String? cityName;
  String? startTime;
  String? endTime;
  String? day;
  double? consultancyFee;
  double? actualFee;
  bool? isOnlineConfiguration;
  String? doctorId;

  DoctorScheduleModel(
      {this.id,
      this.name,
      this.cityId,
      this.address,
      this.cityName,
      this.startTime,
      this.endTime,
      this.day,
      this.consultancyFee,
      this.actualFee,
      this.isOnlineConfiguration,
      this.doctorId});

  DoctorScheduleModel.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    cityId = json['CityId'];
    address = json['Address'];
    cityName = json['CityName'];
    startTime = json['StartTime'];
    endTime = json['EndTime'];
    day = json['Day'];
    consultancyFee = json['ConsultancyFee'];
    actualFee = json['ActualFee'];
    isOnlineConfiguration = json['IsOnlineConfiguration'];
    doctorId = json['DoctorId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['Name'] = name;
    data['CityId'] = cityId;
    data['Address'] = address;
    data['CityName'] = cityName;
    data['StartTime'] = startTime;
    data['EndTime'] = endTime;
    data['Day'] = day;
    data['ConsultancyFee'] = consultancyFee;
    data['ActualFee'] = actualFee;
    data['IsOnlineConfiguration'] = isOnlineConfiguration;
    data['DoctorId'] = doctorId;
    return data;
  }
}
