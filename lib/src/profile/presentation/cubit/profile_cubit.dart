import 'package:equatable/equatable.dart';
import 'package:fauzi_portofolio/src/profile/domain/entities/profile.dart';
import 'package:fauzi_portofolio/src/profile/domain/use_cases/get_profile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final GetProfile _getProfile;

  ProfileCubit({required GetProfile getProfile})
      : _getProfile = getProfile,
        super(
          const ProfileInitial(),
        );

  Future<void> getProfiles() async {
    emit(const GettingProfile());
    final result = await _getProfile();

    result.fold(
      (failure) => emit(ProfileError(failure.errorMessage)),
      (profiles) => emit(ProfileLoaded(profiles)),
    );
  }
}
