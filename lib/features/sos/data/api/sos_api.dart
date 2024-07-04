import 'package:dio/dio.dart';
import 'package:estegatha/core/data/api/dio_auth.dart';
import 'package:estegatha/features/landing/domain/models/permissions.dart';
import 'package:estegatha/features/organization/domain/models/member.dart';
import 'package:estegatha/features/organization/domain/models/organizationMember.dart';
import 'package:estegatha/features/sos/data/api/organizations_api.dart';
import 'package:estegatha/features/sos/domain/repositories/organizations_repo.dart';
import 'package:estegatha/features/sos/domain/repositories/sos_repo.dart';
import 'package:estegatha/constants.dart';
import 'package:estegatha/utils/helpers/helper_functions.dart';
import 'package:geolocator/geolocator.dart';

import '../../../organization/domain/models/organization.dart';
class SosApi extends SosRepo {
  @override
  Future<int> createSosPin(String sos) async{
    Dio dio = await DioAuth.getDio();
    Response response = await dio.post(baseUrl + createSosEndPoint, data: {
      sosPinKey: sos,
    });
    return response.statusCode ?? 404;
  }

  @override
  Future<int> sendSos() async{
    await Permissions().grantPermissions();
    var location = await Geolocator.getCurrentPosition();
    OrganizationsRepo organizationsRepo = OrganizationsApi();
    Member member = await HelperFunctions.getUser();
    List<Organization> organizations = await organizationsRepo.fetchOrganizations();
    if(organizations.isEmpty){
      return 0;
    }
    int success = 0;
    Dio dio = await DioAuth.getDio();
    for(var organization in organizations){
      Response response = await dio.post(baseUrl + notifyMembersEndPoint, data: {
        subjectKey: 'Emergency',
        contentKey: 'your friend ${member.username} in organization ${organization.name} needs help',
        "type": "INIT_SOS",
        'data':{
          'userId': member.id.toString(),
          'organizationId': organization.id.toString(),
        }
      }, queryParameters: {
        'organizationId': organization.id.toString(),
      });
      if(response.statusCode == 201){
        success++;
      }
    }
    return success;
  }
}