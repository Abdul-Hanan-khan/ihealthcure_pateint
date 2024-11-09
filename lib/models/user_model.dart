class UserDataModel {
  String? id;
  String? mRNo;
  String? cNICNumber;
  String? email;
  String? switchUserId;
  String? switchByUser;
  bool? isChildAccount;
  bool? isSwitchAccount;
  String? username;
  String? fullName;
  String? firstName;
  String? displayname;
  String? branchName;
  String? imagePath;
  String? organizationPicturePath;
  String? branchId;
  String? branchAddress;
  String? branchTelNo;
  String? branchEmail;
  int? userType;
  String? token;
  int? status;
  String? errorMessage;
  String? workingSessionId;
  String? countryId;
  String? cityId;
  String? stateOrProvinceId;
  String? country;
  String? city;
  String? stateOrProvince;
  String? deviceToken;
  String? webToken;
  String? cellNumber;
  String? telephoneNumber;
  String? patientAddress;
  String? passport;
  int? isFlightDetail;
  String? workingSessions;
  List<PatientBranches>? patientBranches;
  String? genderName;
  String? registrationDate;
  String? panelExpiryDate;
  String? panelOrganizationName;
  String? panelPackageName;
  String? panelPackageDiscount;
  String? panelPackageDiscountType;
  String? dob;
  String? address;
  String? dateofbirth;
  String? maritalStatus;

  UserDataModel(
      {this.id,
      this.mRNo,
      this.cNICNumber,
      this.email,
      this.switchUserId,
      this.switchByUser,
      this.isChildAccount,
      this.isSwitchAccount,
      this.username,
      this.fullName,
      this.firstName,
      this.displayname,
      this.branchName,
      this.imagePath,
      this.organizationPicturePath,
      this.branchId,
      this.branchAddress,
      this.branchTelNo,
      this.branchEmail,
      this.userType,
      this.token,
      this.status,
      this.errorMessage,
      this.workingSessionId,
      this.countryId,
      this.cityId,
      this.stateOrProvinceId,
      this.country,
      this.city,
      this.stateOrProvince,
      this.deviceToken,
      this.webToken,
      this.cellNumber,
      this.telephoneNumber,
      this.patientAddress,
      this.passport,
      this.isFlightDetail,
      this.workingSessions,
      this.patientBranches,
      this.genderName,
      this.registrationDate,
      this.panelExpiryDate,
      this.panelOrganizationName,
      this.panelPackageName,
      this.panelPackageDiscount,
      this.panelPackageDiscountType,
      this.dob,
      this.address,
      this.dateofbirth,
      this.maritalStatus});

  UserDataModel.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    mRNo = json['MRNo'];
    cNICNumber = json['CNICNumber'];
    email = json['Email'];
    switchUserId = json['SwitchUserId'];
    switchByUser = json['SwitchByUser'];
    isChildAccount = json['IsChildAccount'];
    isSwitchAccount = json['IsSwitchAccount'];
    username = json['Username'];
    fullName = json['FullName'];
    firstName = json['FirstName'];
    displayname = json['Displayname'];
    branchName = json['BranchName'];
    imagePath = json['ImagePath'];
    organizationPicturePath = json['OrganizationPicturePath'];
    branchId = json['BranchId'];
    branchAddress = json['BranchAddress'];
    branchTelNo = json['BranchTelNo'];
    branchEmail = json['BranchEmail'];
    userType = json['UserType'];
    token = json['Token'];
    status = json['Status'];
    errorMessage = json['ErrorMessage'];
    workingSessionId = json['WorkingSessionId'];
    countryId = json['CountryId'];
    cityId = json['CityId'];
    stateOrProvinceId = json['StateOrProvinceId'];
    country = json['Country'];
    city = json['City'];
    stateOrProvince = json['StateOrProvince'];
    deviceToken = json['DeviceToken'];
    webToken = json['WebToken'];
    cellNumber = json['CellNumber'];
    telephoneNumber = json['TelephoneNumber'];
    patientAddress = json['PatientAddress'];
    passport = json['Passport'];
    isFlightDetail = json['IsFlightDetail'];
    maritalStatus = json['MaritalStatus'];
    workingSessions = json['WorkingSessions'];
    if (json['PatientBranches'] != null) {
      patientBranches = <PatientBranches>[];
      json['PatientBranches'].forEach((v) {
        patientBranches!.add(PatientBranches.fromJson(v));
      });
    }
    genderName = json['GenderName'] ?? 'Male';
    registrationDate = json['RegistrationDate'];
    panelExpiryDate = json['PanelExpiryDate'];
    panelOrganizationName = json['PanelOrganizationName'];
    panelPackageName = json['PanelPackageName'];
    panelPackageDiscount = json['PanelPackageDiscount'].toString();
    panelPackageDiscountType = json['PanelPackageDiscountType'];
    address = json['Address'];
    dateofbirth = json['DateOfBirth'];
    dob = json['DateofBirth'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['MRNo'] = mRNo;
    data['CNICNumber'] = cNICNumber;
    data['Email'] = email;
    data['SwitchUserId'] = switchUserId;
    data['SwitchByUser'] = switchByUser;
    data['IsChildAccount'] = isChildAccount;
    data['IsSwitchAccount'] = isSwitchAccount;
    data['Username'] = username;
    data['FullName'] = fullName;
    data['FirstName'] = firstName;
    data['Displayname'] = displayname;
    data['BranchName'] = branchName;
    data['ImagePath'] = imagePath;
    data['OrganizationPicturePath'] = organizationPicturePath;
    data['BranchId'] = branchId;
    data['BranchAddress'] = branchAddress;
    data['BranchTelNo'] = branchTelNo;
    data['BranchEmail'] = branchEmail;
    data['UserType'] = userType;
    data['Token'] = token;
    data['Status'] = status;
    data['ErrorMessage'] = errorMessage;
    data['WorkingSessionId'] = workingSessionId;
    data['CountryId'] = countryId;
    data['CityId'] = cityId;
    data['StateOrProvinceId'] = stateOrProvinceId;
    data['Country'] = country;
    data['City'] = city;
    data['StateOrProvince'] = stateOrProvince;
    data['DeviceToken'] = deviceToken;
    data['WebToken'] = webToken;
    data['CellNumber'] = cellNumber;
    data['TelephoneNumber'] = telephoneNumber;
    data['PatientAddress'] = patientAddress;
    data['Passport'] = passport;
    data['IsFlightDetail'] = isFlightDetail;
    data['WorkingSessions'] = workingSessions;
    data['MaritalStatus'] = maritalStatus;
    if (patientBranches != null) {
      data['PatientBranches'] =
          patientBranches!.map((v) => v.toJson()).toList();
    }
    data['GenderName'] = genderName;
    data['RegistrationDate'] = registrationDate;
    data['PanelExpiryDate'] = panelExpiryDate;
    data['PanelOrganizationName'] = panelOrganizationName;
    data['PanelPackageName'] = panelPackageName;
    data['PanelPackageDiscount'] = panelPackageDiscount;
    data['PanelPackageDiscountType'] = panelPackageDiscountType;
    data['DateofBirth'] = dob;
    data['Address'] = address;
    data['DateOfBirth'] = dateofbirth;
    return data;
  }
}

class PatientBranches {
  String? patientId;
  String? branchId;
  String? branchName;
  String? cNICNumber;
  String? mRNo;
  bool? isDefaultBranch;
  String? branchImagePath;
  String? branchTelNo;
  String? address;

  PatientBranches(
      {this.patientId,
      this.branchId,
      this.branchName,
      this.cNICNumber,
      this.mRNo,
      this.isDefaultBranch,
      this.branchImagePath,
      this.branchTelNo,
      this.address});

  PatientBranches.fromJson(Map<String, dynamic> json) {
    patientId = json['PatientId'];
    branchId = json['BranchId'];
    branchName = json['BranchName'];
    cNICNumber = json['CNICNumber'];
    mRNo = json['MRNo'];
    isDefaultBranch = json['IsDefaultBranch'];
    branchImagePath = json['BranchImagePath'];
    branchTelNo = json['BranchTelNo'];
    address = json['Address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['PatientId'] = patientId;
    data['BranchId'] = branchId;
    data['BranchName'] = branchName;
    data['CNICNumber'] = cNICNumber;
    data['MRNo'] = mRNo;
    data['IsDefaultBranch'] = isDefaultBranch;
    data['BranchImagePath'] = branchImagePath;
    data['BranchTelNo'] = branchTelNo;
    data['Address'] = address;
    return data;
  }
}
