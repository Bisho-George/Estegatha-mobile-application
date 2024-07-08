import 'package:dartz/dartz.dart';
import 'package:estegatha/features/add_place/domain/entities/organization_boundary_entity.dart';

import '../../../../utils/helpers/failure.dart';
import '../../data/models/organization_boundary_response.dart';

abstract class BoundaryRepo {
  Future<Either<Failure, OrganizationBoundaryResponse>> addPlace(OrganizationBoundaryEntity organizationBoundaryEntity);
}