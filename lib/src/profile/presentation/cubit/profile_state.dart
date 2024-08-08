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
  final List<Profile> profiles;

  const ProfileLoaded(this.profiles);

  @override
  List<Object> get props => profiles.map((profile) => profile.id).toList();
}

class ProfileError extends ProfileState {
  final String message;

  const ProfileError(this.message);

  @override
  List<Object> get props => [message];

}
