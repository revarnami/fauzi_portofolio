import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fauzi_portofolio/src/profile/data/data_sources/profile_remote_data_source.dart';
import 'package:fauzi_portofolio/src/profile/data/repositories/profile_repository_implementation.dart';
import 'package:fauzi_portofolio/src/profile/domain/repositories/profile_repository.dart';
import 'package:fauzi_portofolio/src/profile/domain/use_cases/get_profile.dart';
import 'package:fauzi_portofolio/src/profile/presentation/cubit/profile_cubit.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl
    // App Logic
    ..registerFactory(() => ProfileCubit(getProfile: sl()))

    // Use cases
    ..registerLazySingleton(() => GetProfile(sl()))

    // Repositories
    ..registerLazySingleton<ProfileRepository>(
        () => ProfileRepositoryImplementation(sl()),)

    // Data Sources
    ..registerLazySingleton<ProfileRemoteDataSource>(
        () => ProfileRDSImplementation(sl()),)

    // External Dependencies
    ..registerLazySingleton(() => FirebaseFirestore.instance);
}
