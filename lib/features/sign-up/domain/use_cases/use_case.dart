import 'package:dartz/dartz.dart';

import '../../data/failure/failure.dart';

abstract class UseCase<Type, Param> {
  Future<Either<Failure, Type>> call(Param param);
}
