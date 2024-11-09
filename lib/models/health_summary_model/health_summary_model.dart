class HealthModel {
  String? id;
  String? patientId;
  String? title;
  String? value;
  String? value1;
  String? condition;
  String? dateTime;

  HealthModel(
      {this.id,
      this.value1,
      this.patientId,
      this.value,
      this.condition,
      this.dateTime,
      this.title});

  toMap() {
    return {
      'id': id,
      'patientId': patientId,
      'title': title,
      'value': value,
      'value1': value1,
      'condition': condition,
      'dateTime': dateTime
    };
  }

  HealthModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    patientId = json['patientId'];
    title = json['title'];
    value = json['value'];
    value1 = json['value1'];
    condition = json['condition'];
    dateTime = json['dateTime'];
  }
}
