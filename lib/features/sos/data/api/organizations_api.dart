import 'package:dio/dio.dart';
import 'package:estegatha/core/data/api/dio_auth.dart';
import 'package:estegatha/features/organization/domain/models/organizationMember.dart';
import 'package:estegatha/features/sos/domain/repositories/organizations_repo.dart';
import 'package:estegatha/constants.dart';

import '../../../organization/domain/models/organization.dart';

class OrganizationsApi extends OrganizationsRepo{
  @override
  Future<List<Organization>> fetchOrganizations() async {
    Dio dio = await DioAuth.getDio();
    List<Organization> organizations = [];
    print('$baseUrl$getOrganizationsEndPoint');
    Response response = await dio.get('$baseUrl$getOrganizationsEndPoint');
    print(response.data);
    print(response.statusCode);
    if(response.statusCode == 200) {
      var elements = response.data;
      for (var element in elements) {
        organizations.add(Organization.fromJson(element));
      }
    }
    return organizations;
  }
  @override
  Future<List<OrganizationMember>> fetchOrganizationMembers(num organizationId) async{
    List<OrganizationMember> members = [];
    Dio dio = await DioAuth.getDio();
    Response response = await dio.get('$baseUrl$getOrganizationMembersEndPoint/$organizationId');

    for(var element in response.data){
      members.add(OrganizationMember.fromJson(element));
    }
    return members;
  }
}