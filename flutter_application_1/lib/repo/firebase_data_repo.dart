import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_application_1/features/home/model/data_model.dart';
import 'package:uuid/uuid.dart';

class FirebaseDataRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> createDataModel(DataModel dataModel) async {
    await _firestore
        .collection('data_models')
        .doc(dataModel.uuid)
        .set(dataModel.toMap());
  }

  Future<List<DataModel>> getAllDataModels() async {
    QuerySnapshot querySnapshot =
        await _firestore.collection('data_models').get();
    return querySnapshot.docs
        .map((doc) => DataModel.fromMap(doc.data() as Map<String, dynamic>))
        .toList();
  }

  Future<List<DataModel>> getDataModelsByCategory(String category) async {
    QuerySnapshot querySnapshot = await _firestore
        .collection('data_models')
        .where('category', isEqualTo: category)
        .get();
    return querySnapshot.docs
        .map((doc) => DataModel.fromMap(doc.data() as Map<String, dynamic>))
        .toList();
  }

  Future<void> updateDataModel(DataModel dataModel) async {
    await _firestore
        .collection('data_models')
        .doc(dataModel.uuid)
        .update(dataModel.toMap());
  }

  Future<void> deleteDataModel(String uuid) async {
    await _firestore.collection('data_models').doc(uuid).delete();
  }

  Future<String> uploadImage(File imageFile) async {
    String fileName = Uuid().v4();
    Reference ref = _storage.ref().child('images/$fileName');
    UploadTask uploadTask = ref.putFile(imageFile);
    TaskSnapshot taskSnapshot = await uploadTask;
    return await taskSnapshot.ref.getDownloadURL();
  }
}
