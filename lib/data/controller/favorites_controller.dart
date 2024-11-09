import 'dart:developer';
import 'package:get/get.dart';
import 'package:tabib_al_bait/data/controller/specialities_controller.dart';
import 'package:tabib_al_bait/data/localDB/local_db.dart';
import 'package:tabib_al_bait/data/repositories/favorites_repo/favorites_repo.dart';
import 'package:tabib_al_bait/models/search_models.dart';

class FavoritesController extends GetxController implements GetxService {
  List<Search> favoriteDoctors = [];
  bool? _isLoading = false;
  bool? get isLoading => _isLoading;

  updateFavoritesList(List<Search> doctors) {
    favoriteDoctors = doctors;
    update();
  }

  updateIsLoading(bool value) {
    _isLoading = value;
    update();
  }

  getAllFavoriteDoctors() async {
    log('here');
    try {
      _isLoading = true;
      List<Search> doctors = await FavoritesRepo.getAllFavoriteDoctors();

      updateFavoritesList(doctors);
      log(favoriteDoctors.toString());
      SpecialitiesController.i.getDoctors('');
      _isLoading = false;
    } catch (e) {
      // ToastManager.showToast('somethingWentWrong'.tr);
      _isLoading = false;
    }
  }

  bool favloader = false;
  updatefavloader() {
    favloader = !favloader;
  }

  addOrRemoveFromFavorites(Search doctor) async {
    var branchID = await LocalDb().getBranchId();
    var patientId = await LocalDb().getPatientId();
    bool isFavorite =
        favoriteDoctors.any((favDoctor) => favDoctor.id == doctor.id);
    if (isFavorite) {
      await FavoritesRepo.removeFromFavorites(
          doctorId: doctor.id, patientId: patientId, branchId: branchID);
      FavoritesController.i.updateIsLoading(false);
    } else {
      await FavoritesRepo.addToFavorites(
          doctorId: doctor.id, patientId: patientId, branchId: branchID);
      FavoritesController.i.updateIsLoading(false);
    }
    await getAllFavoriteDoctors();
    SpecialitiesController.i.getDoctors('');
  }

  @override
  void onInit() {
    getAllFavoriteDoctors();
    super.onInit();
  }

  static FavoritesController get i => Get.put(FavoritesController());
}
