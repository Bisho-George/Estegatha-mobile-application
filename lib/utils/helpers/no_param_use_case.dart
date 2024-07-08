import 'package:dartz/dartz.dart';

import 'failure.dart';

abstract class UseCase<Type> {
  Future<Either<Failure, Type>> call();
}
