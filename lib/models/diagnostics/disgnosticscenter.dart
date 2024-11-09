class Diagnosticscenter {
  dynamic id;
  dynamic name;
  dynamic city;
  dynamic imagePath;
  dynamic address;
  dynamic monday;
  dynamic sunday;
  dynamic tuesday;
  dynamic wednesday;
  dynamic thursday;
  dynamic friday;
  dynamic saturday;
  dynamic diagnosticId;
  dynamic diagnosticName;
  dynamic actualPrice;
  dynamic price;

  Diagnosticscenter(
      {this.id,
      this.name,
      this.city,
      this.imagePath,
      this.address,
      this.monday,
      this.sunday,
      this.tuesday,
      this.wednesday,
      this.thursday,
      this.friday,
      this.saturday,
      this.diagnosticId,
      this.diagnosticName,
      this.actualPrice,
      this.price});

  Diagnosticscenter.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    city = json['City'];
    imagePath = json['ImagePath'];
    address = json['Address'];
    monday = json['Monday'];
    sunday = json['Sunday'];
    tuesday = json['Tuesday'];
    wednesday = json['Wednesday'];
    thursday = json['Thursday'];
    friday = json['Friday'];
    saturday = json['Saturday'];
    diagnosticId = json['DiagnosticId'];
    diagnosticName = json['DiagnosticName'];
    actualPrice = json['ActualPrice'];
    price = json['Price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['Name'] = name;
    data['City'] = city;
    data['ImagePath'] = imagePath;
    data['Address'] = address;
    data['Monday'] = monday;
    data['Sunday'] = sunday;
    data['Tuesday'] = tuesday;
    data['Wednesday'] = wednesday;
    data['Thursday'] = thursday;
    data['Friday'] = friday;
    data['Saturday'] = saturday;
    data['DiagnosticId'] = diagnosticId;
    data['DiagnosticName'] = diagnosticName;
    data['ActualPrice'] = actualPrice;
    data['Price'] = price;
    return data;
  }
}
