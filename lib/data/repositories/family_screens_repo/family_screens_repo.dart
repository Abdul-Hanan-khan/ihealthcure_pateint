import 'dart:convert';
import 'dart:developer';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tabib_al_bait/data/controller/family_screens_controller.dart';
import 'package:tabib_al_bait/data/localDB/local_db.dart';
import 'package:tabib_al_bait/helpers/color_manager.dart';
import 'package:tabib_al_bait/helpers/show_toast.dart';
import 'package:tabib_al_bait/models/family_members_response/family_members_response.dart';
import 'package:tabib_al_bait/models/get_blood_groups/get_blood_groups.dart';
import 'package:tabib_al_bait/models/get_martial_statuses/get_martial_statuses.dart';
import 'package:tabib_al_bait/models/relation_ships_model/relation_ship_model.dart';
import 'package:tabib_al_bait/models/search_family_member_model/search_family_member_model.dart';
import 'package:tabib_al_bait/utils/constants.dart';

class FamilyScreensRepo {
  getFamilyMembers() async {
    var patientId = await LocalDb().getPatientId();
    var branchId = await LocalDb().getBranchId();
    var token = await LocalDb().getToken();
    var body = {
      "PatientId": "$patientId",
      "SWitchAccountId": "",
      "IsChildAccount": "true",
      "BranchId": "$branchId",
      "Token": "$token"
    };
    var headers = {'Content-Type': 'application/json'};
    try {
      MyFamilyScreensController.i.updateIsLoading(true);
      var response = await http.post(Uri.parse(AppConstants.getFamilyMembers),
          body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        FamilyMembersResponse familyResponseData =
            FamilyMembersResponse.fromJson(result);
        if (familyResponseData.status == 1) {
          MyFamilyScreensController.i.updateIsLoading(false);
          log(familyResponseData.toJson().toString());
          return familyResponseData.data;
        } else {
          ToastManager.showToast('${result['ErrorMessage']}');
          MyFamilyScreensController.i.updateIsLoading(false);
        }
      }
    } catch (e) {
      // ToastManager.showToast(e.toString());
      MyFamilyScreensController.i.updateIsLoading(false);

      handleError(e);
    }
  }

  searchFamilyMember(String mrNo) async {
    var branchId = await LocalDb().getBranchId();
    var token = await LocalDb().getToken();
    var body = {"IdentityNo": mrNo, "BranchId": "$branchId", "Token": "$token"};
    var headers = {'Content-Type': 'application/json'};

    try {
      var response = await http.post(Uri.parse(AppConstants.searchFamilyMember),
          headers: headers, body: jsonEncode(body));
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        SearchFamilyMemberResponse data =
            SearchFamilyMemberResponse.fromJson(result);
        if (data.status == 1) {
          log(data.toJson().toString());
          return data;
        } else {
          return [];
        }
      } else {
        return [];
      }
    } catch (e) {
      // handleError(e);
    }
  }

  getRelationShipTypes() async {
    var body = {};
    var headers = {'Content-Type': 'application/json'};
    try {
      var response = await http.post(
          Uri.parse(AppConstants.getRelationShipTypes),
          headers: headers,
          body: jsonEncode(body));
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        GetRelationShips data = GetRelationShips.fromJson(result);
        if (data.status == 1) {
          return data.data;
        } else {
          return [];
        }
      } else {
        return [];
      }
    } catch (e) {
      // handleError(e);
    }
  }

  DateTime convertDate(String age) {
    DateTime currentDate = DateTime.now();
    DateTime birthDate =
        currentDate.subtract(Duration(days: int.parse(age.split('y')[0])));
    birthDate = birthDate.subtract(Duration(
        days: int.parse(age.split('m')[0].split(' ').last) *
            30)); // Approximating a month as 30 days
    birthDate = birthDate.subtract(
        Duration(days: int.parse(age.split('d')[0].split(' ').last) * 365));
    return birthDate;
  }

  addExistingFamilyMember(
      {String? id,
      String? cellNumber,
      String? name,
      String? cnic,
      String? mrNo,
      String? document,
      String? email,
      String? age,
      String? relationId,
      String? genderId,
      String? dob}) async {
    MyFamilyScreensController.i.updateExistingFamilyMemberLoader(true);
    var patientId = await LocalDb().getPatientId();
    var branchId = await LocalDb().getBranchId();
    var token = await LocalDb().getToken();

    //  DateTime now =  convertDate(age?? "");

    var body = {
      "PatientId": "$patientId",
      "FamilyMemberPatientId": "$id",
      "FamilyMemberCNIC": "$cnic",
      "MRNO": "$mrNo",
      "FromFamilyMemberRelationId": "$relationId",
      "AtttachmentCNICFontSide": "",
      "AtttachmentCNICBackSide": "",
      "DocumentOfProof": "$document",
      "BranchId": "$branchId",
      "Token": "$token",
      "DateOfBirth": "$dob"
    };
    // {
    //   "PatientId": "$patientId",
    //   "FamilyMemberPatientId": id,
    //   "FamilyMemberCNIC": cnic,
    //   "MRNO": mrNo,
    //   "DocumentOfProof": "$document",
    //   "BranchId": "$branchId",
    //   "Token": "$token",
    //   "PatientName": "$name",
    //   "RelationId": "",
    //   "FromRelationId": "$relationId",
    //   "Email": "$email",
    //   "GenderId": "$genderId",
    //   "CellNumber": "$cellNumber",
    //   "DateOfBirth": dob.toString().split('T')[0]
    // };
    log(body.toString());
    var headers = {'Content-Type': 'application/json'};
    try {
      MyFamilyScreensController.i.updateExistingFamilyMemberLoader(false);

      var response = await http.post(
          Uri.parse(AppConstants.addExistingfamilyMember),
          body: jsonEncode(body),
          headers: headers);
      if (response.statusCode == 200) {
        MyFamilyScreensController.i.updateExistingFamilyMemberLoader(false);

        var result = jsonDecode(response.body);
        if (result['Status'] == 1 && result['ErrorMessage'] == 'Success') {
          Fluttertoast.showToast(
              msg: "Family Member Added Successfully",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.SNACKBAR,
              timeInSecForIosWeb: 1,
              backgroundColor: ColorManager.kPrimaryColor,
              textColor: ColorManager.kWhiteColor,
              fontSize: 16.0);
          Get.close(2);
          await MyFamilyScreensController.i.getFamilyMembers();
          MyFamilyScreensController.i.updateExistingFamilyMemberLoader(false);
        } else if (result['Status'] == 0 &&
            result['ErrorMessage'] == 'Relation Already Exists') {
          Fluttertoast.showToast(
              msg: "Relation Already Exists",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.SNACKBAR,
              timeInSecForIosWeb: 2,
              // backgroundColor: ColorManager.kPrimaryColor,
              textColor: ColorManager.kWhiteColor,
              fontSize: 16.0);
          MyFamilyScreensController.i.updateExistingFamilyMemberLoader(false);
        } else if (result['Status'] == 0) {
          Fluttertoast.showToast(
              msg: "${result['ErrorMessage']}",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.SNACKBAR,
              timeInSecForIosWeb: 2,
              backgroundColor: ColorManager.kblackColor,
              textColor: ColorManager.kWhiteColor,
              fontSize: 16.0);
          MyFamilyScreensController.i.updateExistingFamilyMemberLoader(false);
        } else {
          MyFamilyScreensController.i.updateExistingFamilyMemberLoader(false);
          log('${result['ErrorMessage']}');
        }
        log(result.toString());
      }
    } catch (e) {
      // ToastManager.showToast(e.toString());
      // handleError(e);
      log(e.toString());
      MyFamilyScreensController.i.updateExistingFamilyMemberLoader(false);
    }
  }

  getMartialStatuses() async {
    var body = {};
    var headers = {'Content-Type': 'application/json'};

    try {
      var response = await http.post(Uri.parse(AppConstants.getMartialStatuses),
          body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        if (result['Status'] == 1) {
          MartialStatusesResponse martialStatuses =
              MartialStatusesResponse.fromJson(result);
          if (martialStatuses.status == 1) {
            log(martialStatuses.toJson().toString());
            log(martialStatuses.data.toString());
            return martialStatuses.data;
          }
          return [];
        }
      }
    } catch (e) {
      // ToastManager.showToast(e.toString());
    }
  }

  getBloodGroups() async {
    var body = {};
    var headers = {'Content-Type': 'application/json'};

    try {
      var response = await http.post(Uri.parse(AppConstants.getBloodGroups),
          body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        if (result['Status'] == 1) {
          GetBloodGroups martialStatuses = GetBloodGroups.fromJson(result);
          if (martialStatuses.status == 1) {
            log(martialStatuses.toJson().toString());
            log(martialStatuses.data.toString());
            return martialStatuses.data;
          }
          return [];
        }
      }
    } catch (e) {
      // ToastManager.showToast(e.toString());
    }
  }

  addNewFamilyMember(
    String firstName,
    String lastName,
    String? middleName,
    String cnicNumber,
    String dob,
    String cellNumber,
    String picturePath,
    String? familyMemberCNIC,
    String? documentpath,
    String? fatherName,
    String? address,
    String? bloodGroupId,
    String? relationShipID,
  ) async {
    MyFamilyScreensController.i.updateIsFamilyMemberLoader(true);
    var patientId = await LocalDb().getPatientId();
    var branchID = await LocalDb().getBranchId();
    var myfam = MyFamilyScreensController.i;
    var body = {
      "PatientId": "$patientId",
      "FirstName": firstName,
      "MiddleName": "$middleName",
      "LastName": lastName,
      "GuardianName": "$fatherName",
      "CNICNumber": cnicNumber,
      "OtherIdentity": "",
      "Passport": "",
      "IdentityRelation": "$relationShipID",
      "DateOfBirth": dob,
      "Address": "$address",
      "CellNumber": cellNumber,
      "TelephoneNumber": cellNumber,
      "Email": "",
      "NOKFirstName": firstName,
      "NOKLastName": lastName,
      "NOKCNICNumber": cnicNumber,
      "NOKCellNumber": cellNumber,
      "PicturePath": picturePath,
      "PanelEntitleLetter": "",
      "PanelEntitleLetterB": "",
      "OccupationId": "",
      "PanelOrganizationPackageId": "",
      "GenderId": "${myfam.selectedGender?.id}",
      "RelationshipTypeId": "",
      "PersonTitleId": "",
      "PatientTypeId": "BEB03D33-E8AA-E711-80C1-A0B3CCE147BA",
      "MaritalStatusId": "${myfam.status?.id}",
      "BloodGroupId": "$bloodGroupId",
      "CountryId": "9eac3d33-e8aa-e711-80c1-a0b3cce147ba",
      "StateOrProvinceId": "a4ac3d33-e8aa-e711-80c1-a0b3cce147ba",
      "CityId": "b9ad3d33-e8aa-e711-80c1-a0b3cce147ba",
      "NOKRelationId": "",
      "Prefix": "",
      "IdentityTypeId": "52AE3D33-E8AA-E711-80C1-A0B3CCE147BA",
      "OrganizationId": "905C5EE5-5895-49DF-8E11-F44298B76BE4",
      "BranchId": "$branchID",
      "ReferenceId": "",
      "PanelOrganizationId": "",
      "PanelType": "1",
      "PanelValidDate": "",
      "PanelEmployeeCardNo": "",
      "PanelDepartment": "",
      "PanelDesignation": "",
      "PanelRelation": "",
      "PanelEmployeeCardNoDependent": "",
      "OnPanelValidDate": "",
      "OnPanelEmployeeNo": "",
      "OnPanelDepartment": "",
      "OnPanelDesignation": "",
      "OnPanelRelationId": "",
      "OnPanelOrganizationId": "",
      "OnPanelOrganizationPackageId": "",
      "OnPanelEmployeeCardNoDependent": "",
      "IsTakeRegistrationFee": "",
      "WorkingSessionId": "",
      "PatientAppointmentId": "",
      "DiscountType": "",
      "Discount": "",
      "Reference": "",
      "Remarks": "",
      "DependentStatus": "1",
      // "FamilyMemberCNIC": cnicNumber,
      "AtttachmentCNICFontSide":
          "/File/Download/Patient/132302019395862050.jpg",
      "AtttachmentCNICBackSide":
          "/File/Download/Patient/132302019396021637.jpg",
      "DocumentOfProof": "/File/Download/Patient/$documentpath",
      // "FromFamilyMemberRelationId": "$relationShipID"
    };
    log(body.toString());
    var headers = {'Content-Type': 'application/json'};
    try {
      var response = await http.post(Uri.parse(AppConstants.addNewFamilyMember),
          body: jsonEncode(body), headers: headers);

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        log(result.toString());
        if (result['Status'] == 1) {
          MyFamilyScreensController.i.updateIsFamilyMemberLoader(false);

          Fluttertoast.showToast(
              msg: "Family Member Added Successfully",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.SNACKBAR,
              timeInSecForIosWeb: 1,
              backgroundColor: ColorManager.kblackColor,
              textColor: ColorManager.kWhiteColor,
              fontSize: 16.0);
          getFamilyMembers();
          return result['Status'];
        } else if (result['Status'] == 0) {
          MyFamilyScreensController.i.updateIsFamilyMemberLoader(false);

          ToastManager.showToast('${result['ErrorMessage']}');
        }
      }
    } catch (e) {
      // Fluttertoast.showToast(
      //     msg: e.toString(),
      //     toastLength: Toast.LENGTH_LONG,
      //     gravity: ToastGravity.SNACKBAR,
      //     timeInSecForIosWeb: 1,
      //     backgroundColor: ColorManager.kblackColor,
      //     textColor: ColorManager.kWhiteColor,
      //     fontSize: 16.0);
      MyFamilyScreensController.i.updateIsFamilyMemberLoader(false);
    }
  }
}
