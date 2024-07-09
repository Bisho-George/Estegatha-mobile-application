import 'package:dartz/dartz.dart';
import 'package:estegatha/features/add_place/domain/entities/organization_boundary_entity.dart';
import 'package:estegatha/features/sign-up/data/failure/failure.dart';

import '../../../../utils/helpers/two_param_use_case.dart';
import '../../data/models/organization_boundary_response.dart';
import '../repos/boundary_repo.dart';

class AddBoundaryUseCase extends UseCase<OrganizationBoundaryResponse, num,
    OrganizationBoundaryEntity> {
  final BoundaryRepo _boundaryRepo;

  AddBoundaryUseCase(this._boundaryRepo);

  @override
  Future<Either<Failure, OrganizationBoundaryResponse>> call(
      num param1, OrganizationBoundaryEntity param2) async {
    return await _boundaryRepo.addPlace(param1, param2);
  }

}
