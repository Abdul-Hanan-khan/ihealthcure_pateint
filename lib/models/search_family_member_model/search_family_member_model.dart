class SearchFamilyMemberResponse {
  int? status;
  List<Data>? data;

  SearchFamilyMemberResponse({this.status, this.data});

  SearchFamilyMemberResponse.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    if (json['Data'] != null) {
      data = <Data>[];
      json['Data'].forEach((v) {
        data!.add(Data.fromJson(v));
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

class Data {
  String? id;
  String? mRNo;
  String? name;
  String? identityNo;
  String? gender;
  dynamic age;
  String? registerationDate;
  String? cNICNumber;
  String? email;
  String? genderId;
  String? phoneNumber;
  String? dateofBirth;

  Data(
      {this.id,
      this.mRNo,
      this.name,
      this.identityNo,
      this.gender,
      this.age,
      this.registerationDate,
      this.cNICNumber,
      this.email,
      this.genderId,
      this.phoneNumber,
      this.dateofBirth});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    mRNo = json['MRNo'];
    name = json['Name'];
    identityNo = json['IdentityNo'];
    gender = json['Gender'];
    age = json['Age'];
    registerationDate = json['RegisterationDate'];
    cNICNumber = json['CNICNumber'];
    email = json['Email'];
    genderId = json['GenderId'];
    phoneNumber = json['PhoneNumber'];
    dateofBirth = json['DateofBirth'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['MRNo'] = mRNo;
    data['Name'] = name;
    data['IdentityNo'] = identityNo;
    data['Gender'] = gender;
    data['Age'] = age;
    data['RegisterationDate'] = registerationDate;
    data['CNICNumber'] = cNICNumber;
    data['Email'] = email;
    data['GenderId'] = genderId;
    data['PhoneNumber'] = phoneNumber;
    data['DateofBirth'] = dateofBirth;
    return data;
  }
}
