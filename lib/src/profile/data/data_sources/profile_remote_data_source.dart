
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fauzi_portofolio/core/errors/APIException.dart';
import 'package:fauzi_portofolio/core/utils/firestore_data.dart';
import 'package:fauzi_portofolio/src/profile/data/models/profile_model.dart';

abstract class ProfileRemoteDataSource {
  Future<List<ProfileModel>> getProfile();
}

class ProfileRDSImplementation implements ProfileRemoteDataSource {

  ProfileRDSImplementation(this.db);
  final FirebaseFirestore db;

  @override
  Future<List<ProfileModel>> getProfile() async {
    try {
      final CollectionReference profiles =
      db.collection(CollectionPath.profile);
      final querySnapshot = await profiles.get();
      final allData = querySnapshot.docs
          .map(ProfileModel.fromFirestore)
          .toList();
      return allData;
    } on FirebaseException catch (e) {
      throw APIException(message: e.message!, statusCode: e.code);
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: '4444');
    }
  }
}
