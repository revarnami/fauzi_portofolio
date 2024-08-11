part of 'profile_cubit.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

final class ProfileInitial extends ProfileState {
  const ProfileInitial();
}

class GettingProfile extends ProfileState {
  const GettingProfile();
}

class ProfileLoaded extends ProfileState {

  const ProfileLoaded(this.profiles);
  final List<Profile> profiles;

  @override
  List<Object> get props => profiles.map((profile) => profile.id).toList();
}

class ProfileError extends ProfileState {

  const ProfileError(this.message);
  final String message;

  @override
  List<Object> get props => [message];

}
