import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/home/model/address_model.dart';
import 'package:flutter_application_1/features/home/model/data_model.dart';
import 'package:flutter_application_1/repo/firebase_data_repo.dart';

class MainProvider extends ChangeNotifier {
  List<DataModel> adminList = [];
  List<DataModel> userList = [];
  List<DataModel> searchList = [];
  List<DataModel> categoryList = [];
  AddressModel? addressModel;

  final FirebaseDataRepo _firebaseDataRepo = FirebaseDataRepo();

  Future<void> updateAddress(AddressModel data) async {
    addressModel = data;
    notifyListeners();
  }

  Future<void> getAllDataModels() async {
    adminList = await _firebaseDataRepo.getAllDataModels();
    userList = adminList;
    searchList = adminList;
    notifyListeners();
  }

  Future<void> getDataModelsByCategory(String category) async {
    categoryList = await _firebaseDataRepo.getDataModelsByCategory(category);
    notifyListeners();
  }

  Future<void> createDataModel(DataModel dataModel) async {
    await _firebaseDataRepo.createDataModel(dataModel);
    getAllDataModels();
  }

  Future<void> updateDataModel(DataModel dataModel) async {
    await _firebaseDataRepo.updateDataModel(dataModel);
    getAllDataModels();
  }

  Future<void> deleteDataModel(String uuid) async {
    await _firebaseDataRepo.deleteDataModel(uuid);
    getAllDataModels();
  }
}
