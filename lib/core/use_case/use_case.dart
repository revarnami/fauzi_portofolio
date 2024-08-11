import 'package:fauzi_portofolio/core/utils/typedef.dart';

abstract class UseCaseWithParams<T, params> {
  const UseCaseWithParams();

  ResultFuture<T> call(dynamic params);
}

abstract class UseCaseWithoutParams<T> {
  const UseCaseWithoutParams();

  ResultFuture<T> call();
}
