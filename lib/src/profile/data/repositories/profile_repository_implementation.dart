import 'package:dartz/dartz.dart';
import 'package:fauzi_portofolio/core/errors/APIException.dart';
import 'package:fauzi_portofolio/core/errors/failure.dart';
import 'package:fauzi_portofolio/core/utils/typedef.dart';
import 'package:fauzi_portofolio/src/profile/data/data_sources/profile_remote_data_source.dart';
import 'package:fauzi_portofolio/src/profile/domain/entities/profile.dart';
import 'package:fauzi_portofolio/src/profile/domain/repositories/profile_repository.dart';

class ProfileRepositoryImplementation implements ProfileRepository {

  ProfileRepositoryImplementation(this._profileRDS);
  final ProfileRemoteDataSource _profileRDS;

  @override
  ResultFuture<List<Profile>> getProfile() async {
    try {
      final result = await _profileRDS.getProfile();
      return Right(result);
    }  on APIException catch (e) {
      return Left(APIFailure.fromAPIException(e));
    }
  }

}