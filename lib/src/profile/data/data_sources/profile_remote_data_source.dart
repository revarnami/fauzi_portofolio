import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fauzi_portofolio/core/errors/APIException.dart';
import 'package:fauzi_portofolio/core/utils/firestore_data.dart';
import 'package:fauzi_portofolio/core/utils/typedef.dart';
import 'package:fauzi_portofolio/src/profile/data/models/profile_model.dart';
import 'package:fauzi_portofolio/src/profile/domain/entities/profile.dart';

abstract class ProfileRemoteDataSource {
  Future<List<ProfileModel>> getProfile();
}

class ProfileRDSImplementation implements ProfileRemoteDataSource {
  final FirebaseFirestore db;

  ProfileRDSImplementation(this.db);

  @override
  Future<List<ProfileModel>> getProfile() async {
    try {
      CollectionReference profiles =
      db.collection(CollectionPath.profile);
      QuerySnapshot querySnapshot = await profiles.get();
      final allData = querySnapshot.docs
          .map((doc) => ProfileModel.fromFirestore(doc))
          .toList();
      return allData;
    } on FirebaseException catch (e) {
      throw APIException(message: e.message!, statusCode: e.code);
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: '4444');
    }
  }
}
