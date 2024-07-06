import '../../../organization/domain/models/member.dart';
import '../../../organization/domain/models/organization.dart';
import '../../../organization/domain/models/organizationMember.dart';

abstract class OrganizationsRepo {
  Future<List<Organization>> fetchOrganizations();
  Future<List<OrganizationMember>> fetchOrganizationMembers(
      num organizationId);
}