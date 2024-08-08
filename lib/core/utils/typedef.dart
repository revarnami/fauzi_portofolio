import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:fauzi_portofolio/core/errors/failure.dart';
import 'package:fauzi_portofolio/src/profile/domain/entities/profile.dart';

typedef ResultFuture<T> = Future<Either<Failure, T>>;
typedef ResultVoid = ResultFuture<void>;
typedef DataMap = Map<String, dynamic>;
typedef FirestoreMap = QueryDocumentSnapshot<DataMap>;