import 'package:equatable/equatable.dart';

class Profile extends Equatable {
  final String id;
  final String name;
  final String avatar;
  final String about;

  const Profile({
    required this.id,
    required this.name,
    required this.avatar,
    required this.about,
  });

  const Profile.empty(): this(
    id: '_empty.id',
    name: '_empty.name',
    avatar: '_empty.avatar',
    about: '_empty.about',
  );

  @override
  List<Object?> get props => [id];
}
