import 'package:dartz/dartz.dart';

import '../../features/sign-up/data/failure/failure.dart';

abstract class UseCase<Type, Param1, Param2> {
  Future<Either<Failure, Type>> call(Param1 param1, Param2 param2);
}
