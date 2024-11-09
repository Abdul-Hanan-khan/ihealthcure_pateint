import 'dart:developer';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tabib_al_bait/data/repositories/family_screens_repo/family_screens_repo.dart';
import 'package:tabib_al_bait/models/family_members_response/family_members_response.dart';
import 'package:tabib_al_bait/models/genders_model.dart';
import 'package:tabib_al_bait/models/get_blood_groups/get_blood_groups.dart';
import 'package:tabib_al_bait/models/get_martial_statuses/get_martial_statuses.dart';
import 'package:tabib_al_bait/models/relation_ships_model/relation_ship_model.dart';

class MyFamilyScreensController extends GetxController implements GetxService {
  static DateTime dob = DateTime.now();
  RxString? formattedDob = DateFormat('yyyy-MM-dd').format(dob).obs;

  List<MartialStatuses> martialStatuses = [];

  GendersData? selectedGender;
  File? file;
  List<FamilyMembersData> _familyMembers = [];
  List<FamilyMembersData> get familyMembersData => _familyMembers;

  List<RelationShipsData> _relationShipsList = [];
  List<RelationShipsData> get relationShipsList => _relationShipsList;

  RelationShipsData? _relationShip;
  RelationShipsData? get relationShip => _relationShip;

  MartialStatuses? _status;
  MartialStatuses? get status => _status;

  List<BloodGroups>? _bloodGroupds = [];
  List<BloodGroups>? get bloodGroupds => _bloodGroupds;

  BloodGroups? _selectedBloodGroup;
  BloodGroups? get selectedBloodGroup => _selectedBloodGroup;

  RelationShipsData? _selectedRelationShip;
  RelationShipsData? get selectedRelationShip => _selectedRelationShip;

  // Loaders //
  bool? _familyMembersAddLoader = false;
  bool? get familyMembersAddLoader => _familyMembersAddLoader;

  bool? _existingFamilyMemberLoader = false;
  bool? get existingFamilyMemberLoader => _existingFamilyMemberLoader;

  updateIsFamilyMemberLoader(bool value) {
    _familyMembersAddLoader = value;
    update();
  }

  updateExistingFamilyMemberLoader(bool value) {
    _existingFamilyMemberLoader = value;
    update();
  }

  //===================== //

  getBloodGroups() async {
    _bloodGroupds = await FamilyScreensRepo().getBloodGroups();
    log('The length of Blood Groups is ${_bloodGroupds?.length}');
    update();
  }

  updateBloodGroup(BloodGroups? groups) {
    _selectedBloodGroup = groups;
    update();
  }

  updateSelectedRelation(RelationShipsData data) {
    _selectedRelationShip = data;
    update();
  }

  updateSelectedGender(GendersData data) {
    selectedGender = data;
    update();
  }

  updateMartialStatuses(MartialStatuses data) {
    _status = data;
    update();
  }

  getMartialStatuses() async {
    martialStatuses = await FamilyScreensRepo().getMartialStatuses();
    log('${martialStatuses.length} these are the martialStatuses');
    update();
  }

  updateSelectedRelationShip(RelationShipsData value) {
    _relationShip = value;
    update();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  updateIsLoading(bool value) {
    _isLoading = value;
    update();
  }

  Future<File?> pickImage(
    BuildContext context,
  ) async {
    try {
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(type: FileType.image);
      if (result != null) {
        file = File(result.files.first.path!);
      }
    } catch (e) {
      e;
    }
    update();
    return file;
  }

  getRelationShipsList() async {
    _relationShipsList = await FamilyScreensRepo().getRelationShipTypes();
    log(_relationShipsList.toString());
    update();
  }

  getFamilyMembers() async {
    _familyMembers = await FamilyScreensRepo().getFamilyMembers();
    update();
  }

  @override
  void onInit() {
    getMartialStatuses();
    getBloodGroups();
    super.onInit();
  }

  static MyFamilyScreensController get i =>
      Get.put(MyFamilyScreensController());
}
