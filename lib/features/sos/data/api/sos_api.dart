import 'package:dio/dio.dart';
import 'package:estegatha/constants.dart';
import 'package:estegatha/core/data/api/dio_auth.dart';
import 'package:estegatha/features/landing/domain/models/permissions.dart';
import 'package:estegatha/features/organization/domain/models/member.dart';
import 'package:estegatha/features/organization/domain/models/organizationMember.dart';
import 'package:estegatha/features/sos/data/api/organizations_api.dart';
import 'package:estegatha/features/sos/domain/repositories/organizations_repo.dart';
import 'package:estegatha/features/sos/domain/repositories/sos_repo.dart';
import 'package:estegatha/utils/helpers/helper_functions.dart';
import 'package:geolocator/geolocator.dart';

import '../../../organization/domain/models/organization.dart';

class SosApi extends SosRepo {
  @override
  Future<int> createSosPin(String sos) async {
    Dio dio = await DioAuth.getDio();
    Response response = await dio.post(baseUrl + createSosEndPoint, data: {
      sosPinKey: sos,
    });
    return response.statusCode ?? 404;
  }

  @override
  Future<int> sendSos() async {
    await Permissions().grantPermissions();
    var location = await Geolocator.getCurrentPosition();
    Member member = await HelperFunctions.getUser();
    int success = 0;
    Dio dio = await DioAuth.getDio();
    Response response = await dio.post(baseUrl + notifyMembersEndPoint, data: {
      subjectKey: 'Emergency',
      contentKey:
          'your friend ${member.username} needs help',
      "type": "INIT_SOS",
      'data': {
        'userId': member.id.toString(),
        'latitude': location.latitude.toString(),
        'longitude': location.longitude.toString()
      }
    });
    if (response.statusCode == 201) {
      success = 1;
    }
    return success;
  }
}
