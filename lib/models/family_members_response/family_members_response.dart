class FamilyMembersResponse {
  int? status;
  List<FamilyMembersData>? data;

  FamilyMembersResponse({this.status, this.data});

  FamilyMembersResponse.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    if (json['Data'] != null) {
      data = <FamilyMembersData>[];
      json['Data'].forEach((v) {
        data!.add(FamilyMembersData.fromJson(v));
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

class FamilyMembersData {
  String? id;
  String? familyMemberId;
  String? patientId;
  String? name;
  String? relationId;
  String? relation;
  String? identityNo;
  String? familyMemberPatientId;
  String? modifiedOn;
  String? createdOn;
  String? mRNo;
  String? gender;
  int? dependentStatus;
  String? age;
  String? picturePath;
  bool? isChildAccount;
  String? email;
  String? phone;
  String? dateOfBirth;
  String? action;

  FamilyMembersData(
      {this.id,
      this.familyMemberId,
      this.patientId,
      this.name,
      this.relationId,
      this.relation,
      this.identityNo,
      this.familyMemberPatientId,
      this.modifiedOn,
      this.createdOn,
      this.mRNo,
      this.gender,
      this.dependentStatus,
      this.age,
      this.picturePath,
      this.isChildAccount,
      this.email,
      this.phone,
      this.dateOfBirth,
      this.action});

  FamilyMembersData.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    familyMemberId = json['FamilyMemberId'];
    patientId = json['PatientId'];
    name = json['Name'];
    relationId = json['RelationId'];
    relation = json['Relation'];
    identityNo = json['IdentityNo'];
    familyMemberPatientId = json['FamilyMemberPatientId'];
    modifiedOn = json['ModifiedOn'];
    createdOn = json['CreatedOn'];
    mRNo = json['MRNo'];
    gender = json['Gender'];
    dependentStatus = json['DependentStatus'];
    age = json['Age'];
    picturePath = json['PicturePath'];
    isChildAccount = json['IsChildAccount'];
    email = json['Email'];
    phone = json['Phone'];
    dateOfBirth = json['DateOfBirth'];
    action = json['Action'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['FamilyMemberId'] = familyMemberId;
    data['PatientId'] = patientId;
    data['Name'] = name;
    data['RelationId'] = relationId;
    data['Relation'] = relation;
    data['IdentityNo'] = identityNo;
    data['FamilyMemberPatientId'] = familyMemberPatientId;
    data['ModifiedOn'] = modifiedOn;
    data['CreatedOn'] = createdOn;
    data['MRNo'] = mRNo;
    data['Gender'] = gender;
    data['DependentStatus'] = dependentStatus;
    data['Age'] = age;
    data['PicturePath'] = picturePath;
    data['IsChildAccount'] = isChildAccount;
    data['Email'] = email;
    data['Phone'] = phone;
    data['DateOfBirth'] = dateOfBirth;
    data['Action'] = action;
    return data;
  }
}
