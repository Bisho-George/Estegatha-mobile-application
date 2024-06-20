import '../../../organization/domain/models/member.dart';
import '../../../organization/domain/models/organization.dart';

abstract class OrganizationsRepo {
  Future<List<Organization>> fetchOrganizations();
  Future<List<Member>> fetchOrganizationMembers(
      int organizationId);
}