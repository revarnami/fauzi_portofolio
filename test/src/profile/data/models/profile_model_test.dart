import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:fauzi_portofolio/core/utils/firestore_data.dart';
import 'package:fauzi_portofolio/src/profile/data/models/profile_model.dart';
import 'package:fauzi_portofolio/src/profile/domain/entities/profile.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late FirebaseFirestore db;
  const tModel = ProfileModel.empty();
  final tMap = tModel.toMap();

  setUp(() {
    db = FakeFirebaseFirestore();
    db.collection(CollectionPath.profile).doc(tModel.id).set(tMap);
  });

  test('Should be a subclass of [Profile] entity', () {
    expect(tModel, isA<Profile>());
  });


  group('fromFirestore', () {
    test('Should return a [ProfileModel] with the right data', () async {
      //Arrange
      final coll = await db.collection(CollectionPath.profile).get();
      //Act
      final result = ProfileModel.fromFirestore(coll.docs.first);
      //Assert
      expect(result, equals(tModel));
    });
  });

  group('fromMap', () {
    test('Should return a [ProfileModel] with the right data', () async {
      //Arrange
      final fakeFirestore = FakeFirebaseFirestore();
      final collection = fakeFirestore.collection('profile');
      await collection.add(tMap);
      final snapshot = await collection.get();
      //Act
      final result = ProfileModel.fromMap(snapshot.docs.first.data());
      //Assert
      expect(result, equals(tModel));
    });
  });

  group('toMap', () {
    test('Should return [Map] with the right data', () {
      final result = tModel.toMap();
      expect(result, equals(tMap));
    });
  });

  group('copyWith', () {
    test('Should return a [ProfileModel] with different data', () {
      final result = tModel.copyWith(name: 'Burhan');
      expect(result.name, equals('Burhan'));

    });
  });
}