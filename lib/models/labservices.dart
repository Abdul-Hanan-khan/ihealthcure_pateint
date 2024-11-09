class servicesmodel {
  String? id;
  String? name;
  String? imagePath;
  String? address;
  String? city;

  servicesmodel({this.id, this.name, this.imagePath, this.address, this.city});

  servicesmodel.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    imagePath = json['ImagePath'];
    address = json['Address'];
    city = json['City'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['Name'] = name;
    data['ImagePath'] = imagePath;
    data['Address'] = address;
    data['City'] = city;
    return data;
  }
}
