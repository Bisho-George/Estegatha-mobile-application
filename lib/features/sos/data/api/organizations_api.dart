import 'package:dio/dio.dart';
import 'package:estegatha/core/data/api/dio_auth.dart';
import 'package:estegatha/features/sos/domain/repositories/organizations_repo.dart';
import 'package:estegatha/utils/constant/strings.dart';

import '../../../organization/domain/models/member.dart';
import '../../../organization/domain/models/organization.dart';

class OrganizationsApi extends OrganizationsRepo{
  @override
  Future<List<Organization>> fetchOrganizations() async {
    Dio dio = DioAuth.getDio();
    List<Organization> organizations = [];
    Response response = await dio.get('$baseUrl$getOrganizationsEndPoint');
    if(response.statusCode == 200) {
      var elements = response.data;
      for (var element in elements) {
        organizations.add(Organization.fromJson(element));
      }
    }
    return organizations;
  }
  @override
  Future<List<Member>> fetchOrganizationMembers(int organizationId) async{
    List<Member> members = [];
    Dio dio = DioAuth.getDio();
    Response response = await dio.get('$baseUrl$getOrganizationMembersEndPoint/$organizationId');
    for(var element in response.data){
      members.add(Member.fromJson(element));
    }
    return members;
  }
}