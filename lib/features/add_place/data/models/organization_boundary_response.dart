import 'package:estegatha/features/add_place/domain/entities/organization_boundary_entity.dart';

import 'organization_boundary_model.dart';

class OrganizationBoundaryResponse {
  final bool? success;
  final String? message;
  final List<OrganizationBoundaryEntity>? organizationBoundaries;

  OrganizationBoundaryResponse({
    this.success,
    this.message,
    this.organizationBoundaries,
  });
}