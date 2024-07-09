import 'package:dartz/dartz.dart';
import 'package:estegatha/features/add_place/domain/entities/organization_boundary_entity.dart';
import 'package:estegatha/features/sign-up/data/failure/failure.dart';
import 'package:estegatha/utils/helpers/use_case.dart';

import '../repos/boundary_repo.dart';

class GetBoundariesUseCase extends UseCase<List<OrganizationBoundaryEntity>, num> {
  final BoundaryRepo _boundaryRepo;

  GetBoundariesUseCase(this._boundaryRepo);

  @override
  Future<Either<Failure, List<OrganizationBoundaryEntity>>> call(num param) async {
    return await _boundaryRepo.getBoundaries(param);
  }

}