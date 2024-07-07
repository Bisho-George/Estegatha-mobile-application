import 'package:dio/dio.dart';
import 'package:estegatha/features/sos/domain/repositories/cancel_sos_repo.dart';

import '../../../../constants.dart';
import '../../../../core/data/api/dio_auth.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../organization/domain/models/member.dart';
import '../../../organization/domain/models/organization.dart';
import '../../domain/repositories/organizations_repo.dart';
import 'organizations_api.dart';

class CancelSosApi extends CancelSosRepo {
  @override
  Future<void> cancelSos(String pin) async {
    Dio dio = await DioAuth.getDio();
    OrganizationsRepo organizationsRepo = OrganizationsApi();
    Member member = await HelperFunctions.getUser();
    await dio.post(baseUrl + sosEndPoint, data: {
      subjectKey: 'Safe Now',
      contentKey:
          'your friend ${member.username} is fine now',
      "type": "CANCEL_SOS",
      'data': {
        'userId': member.id.toString(),
        'sos': pin.toString()
      }
    });
  }
}
