import 'package:dartz/dartz.dart';
import 'package:fauzi_portofolio/core/errors/APIException.dart';
import 'package:fauzi_portofolio/core/errors/failure.dart';
import 'package:fauzi_portofolio/src/profile/data/data_sources/profile_remote_data_source.dart';
import 'package:fauzi_portofolio/src/profile/data/repositories/profile_repository_implementation.dart';
import 'package:fauzi_portofolio/src/profile/domain/entities/profile.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockProfileRemoteDataSource extends Mock
    implements ProfileRemoteDataSource {}

void main() {
  late ProfileRemoteDataSource remoteDataSource;
  late ProfileRepositoryImplementation repoImpl;
  setUp(() {
    remoteDataSource = MockProfileRemoteDataSource();
    repoImpl = ProfileRepositoryImplementation(remoteDataSource);
  });

  group('getProfile', () {
    test(
      'Should call [RemoteDataSource.getProfile] and return [List<Profile>]complete successfully',
      () async {
        //Arrange
        when(() => remoteDataSource.getProfile()).thenAnswer((_) async => []);

        //Act
        final result = await repoImpl.getProfile();

        //Assert
        expect(result, isA<Right<dynamic, List<Profile>>>());
        verify(() => remoteDataSource.getProfile()).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );

    const tException = APIException(
      message: 'Unknown error',
      statusCode: '500',
    );

    test(
      'Should return a [APIException] when the call to the remote is failed',
      () async {
        //Arrange
        when(() => remoteDataSource.getProfile()).thenThrow(tException);
        //Act
        final result = await repoImpl.getProfile();
        //Assert
        expect(
          result,
          equals(
            Left<APIFailure, dynamic>(APIFailure.fromAPIException(tException)),
          ),
        );
        verify(() => remoteDataSource.getProfile()).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );
  });
}
