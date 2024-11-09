
class GetRelationShips {
  int? status;
  List<RelationShipsData>? data;

  GetRelationShips({this.status, this.data});

  GetRelationShips.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    if (json['Data'] != null) {
      data = <RelationShipsData>[];
      json['Data'].forEach((v) {
        data!.add(RelationShipsData.fromJson(v));
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

class RelationShipsData {
  String? id;
  String? name;

  RelationShipsData({this.id, this.name});

  RelationShipsData.fromJson(Map<String, dynamic> json) {
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
