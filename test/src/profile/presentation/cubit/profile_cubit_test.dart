import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:fauzi_portofolio/core/errors/failure.dart';
import 'package:fauzi_portofolio/src/profile/domain/use_cases/get_profile.dart';
import 'package:fauzi_portofolio/src/profile/presentation/cubit/profile_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetProfile extends Mock implements GetProfile {}

void main() {
  late GetProfile getProfile;
  late ProfileCubit cubit;

  const mAPIFailure = APIFailure(message: 'message', statusCode: '4444');

  setUp(() {
    getProfile = MockGetProfile();
    cubit = ProfileCubit(getProfile: getProfile);
  });

  tearDown(() => cubit.close());

  test('Initial state should be [ProfileInitial]', () {
    expect(cubit.state, const ProfileInitial());
  });

  group('getProfile', () {
    blocTest<ProfileCubit, ProfileState>(
        'Should emit [GettingProfile], [ProfileLoaded]',
        build: () {
          when(() => getProfile()).thenAnswer((_) async => const Right([]));
          return cubit;
        },
        act: (cubit) => cubit.getProfiles(),
        expect: () => const [
              GettingProfile(),
              ProfileLoaded([]),
            ],
        verify: (_) {
          verify(() => getProfile()).called(1);
          verifyNoMoreInteractions(getProfile);
        },);

    blocTest<ProfileCubit, ProfileState>(
      'Should emit [GettingProfile, ProfileError] when unsuccessful',
      build: () {
        when(() => getProfile()).thenAnswer((_) async => const Left(mAPIFailure));
        return cubit;
      },
      act: (cubit) => cubit.getProfiles(),
      expect: () => [
        const GettingProfile(),
        ProfileError(mAPIFailure.errorMessage),
      ],
      verify: (_) {
        verify(() => getProfile()).called(1);
        verifyNoMoreInteractions(getProfile);
      },
    );
  });
}
