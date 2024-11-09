class drawerpackagesrequestbody {
  dynamic start;
  dynamic length;
  dynamic isDoNotApplyDateRangeFilter;
  dynamic isAllServicesAppointments;
  dynamic patientId;
  dynamic isAPI;
  dynamic isOnlyPackageAppointmentBookings;
  dynamic search;

  drawerpackagesrequestbody(
      {this.start,
      this.length,
      this.isDoNotApplyDateRangeFilter,
      this.isAllServicesAppointments,
      this.patientId,
      this.isOnlyPackageAppointmentBookings,
      this.isAPI,
      this.search});

  drawerpackagesrequestbody.fromJson(Map<String, dynamic> json) {
    isOnlyPackageAppointmentBookings = json['IsOnlyPackageAppointmentBookings'];
    start = json['start'];
    search = json['search'];
    length = json['length'];
    isDoNotApplyDateRangeFilter = json['IsDoNotApplyDateRangeFilter'];
    isAllServicesAppointments = json['IsAllServicesAppointments'];
    patientId = json['PatientId'];
    isAPI = json['IsAPI'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['IsOnlyPackageAppointmentBookings'] = isOnlyPackageAppointmentBookings;
    data['start'] = start;
    data['length'] = length;
    data['search'] = search;
    data['IsDoNotApplyDateRangeFilter'] = isDoNotApplyDateRangeFilter;
    data['IsAllServicesAppointments'] = isAllServicesAppointments;
    data['PatientId'] = patientId;
    data['IsAPI'] = isAPI;
    return data;
  }
}
