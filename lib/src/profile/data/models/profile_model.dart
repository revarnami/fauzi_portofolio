import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fauzi_portofolio/core/utils/typedef.dart';
import 'package:fauzi_portofolio/src/profile/domain/entities/profile.dart';

class ProfileModel extends Profile {
  const ProfileModel({
    required super.id,
    required super.name,
    required super.avatar,
    required super.about,
    required super.email,
    required super.phoneNumber,
    required super.linkedIn,
  });

  factory ProfileModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data()! as DataMap;
    return ProfileModel(
      id: doc.id,
      name: data['name'].toString(),
      avatar: data['avatar'].toString(),
      about: data['about'].toString(),
      email: data['email'].toString(),
      phoneNumber: data['phone_number'].toString(),
      linkedIn: data['linkedin_url'].toString(),
    );
  }

  ProfileModel.fromMap(DataMap map)
      : this(
          id: map['id'] as String,
          name: map['name'] as String,
          avatar: map['avatar'] as String,
          about: map['about'] as String,
          email: map['email'] as String,
          phoneNumber: map['phone_number'] as String,
          linkedIn: map['linkedin_url'] as String,
        );

  const ProfileModel.empty()
      : this(
          id: '_empty.id',
          name: '_empty.name',
          avatar: '_empty.avatar',
          about: '_empty.about',
          email: '_empty.email',
          phoneNumber: '_empty.phoneNumber',
          linkedIn: '_empty.linkedIn',
        );

  ProfileModel copyWith({
    String? id,
    String? name,
    String? avatar,
    String? about,
  }) {
    return ProfileModel(
      id: id ?? this.id,
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
      about: about ?? this.about,
      email: about ?? email,
      phoneNumber: about ?? phoneNumber,
      linkedIn: about ?? linkedIn,
    );
  }

  DataMap toMap() => {
        'id': id,
        'name': name,
        'avatar': avatar,
        'about': about,
        'email': email,
        'phone_number': phoneNumber,
        'linkedin_url': linkedIn,
      };
}
