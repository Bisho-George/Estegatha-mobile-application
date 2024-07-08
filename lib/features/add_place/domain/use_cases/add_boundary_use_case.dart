import 'package:dartz/dartz.dart';
import 'package:estegatha/features/add_place/domain/entities/organization_boundary_entity.dart';

import '../../../../utils/helpers/failure.dart';
import '../../../../utils/helpers/use_case.dart';
import '../../data/models/organization_boundary_response.dart';
import '../repos/boundary_repo.dart';

class AddBoundaryUseCase
    extends UseCase<OrganizationBoundaryResponse, OrganizationBoundaryEntity> {
  final BoundaryRepo _boundaryRepo;

  AddBoundaryUseCase(this._boundaryRepo);

  @override
  Future<Either<Failure, OrganizationBoundaryResponse>> call(
      OrganizationBoundaryEntity param) async {
    return await _boundaryRepo.addPlace(param);
  }
}
