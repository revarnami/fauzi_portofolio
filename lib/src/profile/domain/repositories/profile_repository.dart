import 'package:fauzi_portofolio/core/utils/typedef.dart';
import 'package:fauzi_portofolio/src/profile/domain/entities/profile.dart';

abstract class ProfileRepository {
  ResultFuture<List<Profile>> getProfile();
}