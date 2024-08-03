import 'package:dartz/dartz.dart';
import 'package:fauzi_portofolio/src/profile/domain/entities/profile.dart';
import 'package:fauzi_portofolio/src/profile/domain/repositories/profile_repository.dart';
import 'package:fauzi_portofolio/src/profile/domain/use_cases/get_profile.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'profile_repository.mock.dart';



void main() {
  late GetProfile useCase;
  late ProfileRepository repository;

  setUp(() {
    repository = MockProfileRepo();
    useCase = GetProfile(repository);
  });

  const tResponse = [Profile.empty()];

  test('Should call [Profile Repository] and return [List<User>]', () async {
    when(() => repository.getProfile()).thenAnswer((_) async => const Right(tResponse));
    final result = await useCase();
    expect(result, equals(const Right<dynamic, List<Profile>>(tResponse)));
    verify(() => repository.getProfile()).called(1);
    verifyNoMoreInteractions(repository);
  });
}
