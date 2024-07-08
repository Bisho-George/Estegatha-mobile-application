import 'organization_boundary_model.dart';

class OrganizationBoundaryResponse {
  final bool? success;
  final String? message;
  final List<OrganizationBoundaryModel>? organizationBoundaries;

  OrganizationBoundaryResponse({
    this.success,
    this.message,
    this.organizationBoundaries,
  });
}