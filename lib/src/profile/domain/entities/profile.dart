import 'package:equatable/equatable.dart';

class Profile extends Equatable {
  final String id;
  final String name;
  final String avatar;
  final String about;
  final String email;
  final String phoneNumber;

  const Profile({
    required this.id,
    required this.name,
    required this.avatar,
    required this.about,
    required this.email,
    required this.phoneNumber,
  });

  const Profile.empty(): this(
    id: '_empty.id',
    name: '_empty.name',
    avatar: '_empty.avatar',
    about: '_empty.about',
    email: '_empty.email',
    phoneNumber: '_empty.phoneNum',
  );

  @override
  List<Object?> get props => [id];
}
