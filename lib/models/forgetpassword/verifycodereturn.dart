class Verifycoderesponse {
  String? id;
  String? name;
  String? username;
  String? cellNumber;
  String? email;
  String? errorMessage;
  String? verificationCode;
  String? mRNo;
  int? status;

  Verifycoderesponse(
      {this.id,
      this.name,
      this.username,
      this.cellNumber,
      this.email,
      this.errorMessage,
      this.verificationCode,
      this.mRNo,
      this.status});

  Verifycoderesponse.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    username = json['Username'];
    cellNumber = json['CellNumber'];
    email = json['Email'];
    errorMessage = json['ErrorMessage'];
    verificationCode = json['VerificationCode'];
    mRNo = json['MRNo'];
    status = json['Status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['Name'] = name;
    data['Username'] = username;
    data['CellNumber'] = cellNumber;
    data['Email'] = email;
    data['ErrorMessage'] = errorMessage;
    data['VerificationCode'] = verificationCode;
    data['MRNo'] = mRNo;
    data['Status'] = status;
    return data;
  }
}
