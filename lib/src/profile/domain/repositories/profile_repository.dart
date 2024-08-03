import 'package:fauzi_portofolio/core/errors/failure.dart';
import 'package:fauzi_portofolio/core/utils/typedef.dart';
import 'package:fauzi_portofolio/src/profile/domain/entities/profile.dart';
import 'package:dartz/dartz.dart';

abstract class ProfileRepository {
  ResultFuture<List<Profile>> getProfile();
}