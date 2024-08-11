import 'package:fauzi_portofolio/core/use_case/use_case.dart';
import 'package:fauzi_portofolio/core/utils/typedef.dart';
import 'package:fauzi_portofolio/src/profile/domain/entities/profile.dart';
import 'package:fauzi_portofolio/src/profile/domain/repositories/profile_repository.dart';

class GetProfile extends UseCaseWithoutParams <List<Profile>> {

  GetProfile(this._profileRepository);
  final ProfileRepository _profileRepository;

  @override
  ResultFuture<List<Profile>> call() async =>
      _profileRepository.getProfile();
}
