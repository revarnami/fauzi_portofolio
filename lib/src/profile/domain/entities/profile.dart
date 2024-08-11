import 'package:equatable/equatable.dart';

class Profile extends Equatable {

  const Profile({
    required this.id,
    required this.name,
    required this.avatar,
    required this.about,
    required this.email,
    required this.phoneNumber,
    required this.linkedIn,
  });

  const Profile.empty(): this(
    id: '_empty.id',
    name: '_empty.name',
    avatar: '_empty.avatar',
    about: '_empty.about',
    email: '_empty.email',
    phoneNumber: '_empty.phoneNum',
    linkedIn: '_empty.linkedin',
  );
  final String id;
  final String name;
  final String avatar;
  final String about;
  final String email;
  final String phoneNumber;
  final String linkedIn;

  @override
  List<Object?> get props => [id];
}
