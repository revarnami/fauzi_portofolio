import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:fauzi_portofolio/core/errors/APIException.dart';
import 'package:fauzi_portofolio/core/utils/firestore_data.dart';
import 'package:fauzi_portofolio/core/utils/typedef.dart';
import 'package:fauzi_portofolio/src/profile/data/data_sources/profile_remote_data_source.dart';
import 'package:fauzi_portofolio/src/profile/data/models/profile_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mock_exceptions/mock_exceptions.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

void main() {
  late FirebaseFirestore db;
  late FirebaseFirestore mockDb;
  late ProfileRemoteDataSource remoteDataSource;
  late ProfileRemoteDataSource mockRemoteDataSource;
  late DocumentSnapshot<DataMap> snapshot;

  setUp(() async {
    //this DB and Data Source is use for mocking data firestore
    // since mocktail cannot do it
    db = FakeFirebaseFirestore();
    remoteDataSource = ProfileRDSImplementation(db);

    //This DB is use only for mocking Firestore exceptions
    mockDb = MockFirebaseFirestore();
    mockRemoteDataSource = ProfileRDSImplementation(mockDb);
  });

  ProfileModel tModel = const ProfileModel.empty();
  DataMap map = tModel.toMap();

  Future<CollectionReference<DataMap>> initializeTest(
    String colPath,
  ) async {
    CollectionReference<Map<String, dynamic>> collection =
        db.collection(colPath);
    QuerySnapshot<Map<String, dynamic>> snapshot = await collection.get();

    await Future.forEach(snapshot.docs,
        (DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
      return documentSnapshot.reference.delete();
    });

    db.collection(CollectionPath.profile).doc(tModel.id).set(map);
    snapshot = await collection.get();

    return collection;
  }

  group('getProfile', () {
    const listProfile = [ProfileModel.empty()];
    test('Should return data when success', () async {
      //Arrange
      await initializeTest(CollectionPath.profile);
      //Act
      final result = await remoteDataSource.getProfile();
      //Assert
      expect(result, equals(listProfile));
    });

    test('Should return [APIException] when catch [Exception]', () async {
      //Arrange
      when(() => mockDb.collection(CollectionPath.profile).get()).thenThrow(
        Exception('Error message'),
      );
      //Act
      final methodCall = mockRemoteDataSource.getProfile;
      //Assert
      expect(
        () => methodCall(),
        throwsA(isA<APIException>()),
      );
      verify(() => mockDb.collection(CollectionPath.profile).get()).called(1);
      verifyNoMoreInteractions(mockDb);
    });

    test('Should return [APIException] when catch [FirebaseException]',
        () async {
      //Arrange
      when(() => mockDb.collection(CollectionPath.profile).get()).thenThrow(
        Exception('Error message'),
      );
      //Act
      final methodCall = mockRemoteDataSource.getProfile;
      //Assert
      expect(
        () => methodCall(),
        throwsA(isA<APIException>()),
      );
    });
  });
}
