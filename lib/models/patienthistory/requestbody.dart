class historyrequestbody {
  dynamic start;
  dynamic length;
  dynamic isDoNotApplyDateRangeFilter;
  dynamic isAllServicesAppointments;
  dynamic patientId;
  dynamic isAPI;
  dynamic search;

  historyrequestbody(
      {this.start,
      this.length,
      this.isDoNotApplyDateRangeFilter,
      this.isAllServicesAppointments,
      this.patientId,
      this.search,
      this.isAPI});

  historyrequestbody.fromJson(Map<String, dynamic> json) {
    search = json['Search'];
    start = json['start'];
    length = json['length'];
    isDoNotApplyDateRangeFilter = json['IsDoNotApplyDateRangeFilter'];
    isAllServicesAppointments = json['IsAllServicesAppointments'];
    patientId = json['PatientId'];
    isAPI = json['IsAPI'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Search'] = search;
    data['start'] = start;
    data['length'] = length;
    data['IsDoNotApplyDateRangeFilter'] = isDoNotApplyDateRangeFilter;
    data['IsAllServicesAppointments'] = isAllServicesAppointments;
    data['PatientId'] = patientId;
    data['IsAPI'] = isAPI;
    return data;
  }
}
