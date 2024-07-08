import 'package:dio/dio.dart';
import 'package:estegatha/features/sos/domain/repositories/cancel_sos_repo.dart';

import '../../../../constants.dart';
import '../../../../core/data/api/dio_auth.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../organization/domain/models/member.dart';
import '../../../organization/domain/models/organization.dart';
import '../../../safty/data/api/contact_api.dart';
import '../../domain/message_repo.dart';
import '../../domain/repositories/organizations_repo.dart';
import 'message_api.dart';
import 'organizations_api.dart';

class CancelSosApi extends CancelSosRepo {
  @override
  Future<void> cancelSos(String pin) async {
    Dio dio = await DioAuth.getDio();
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
    try {
      var contacts = await ContactApi().fetchContacts();
      SmsMessageRepo messageApi = SmsMessageApi();
      String message = 'your friend ${member.username} is fine now';
      if (member.phone != null && member.phone!.isNotEmpty) {
        message += ' has phone ${member.phone}';
      }
      for (var contact in contacts) {
        await messageApi.sendMessage(message, contact.phoneNumber);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<void> sendFeedback(String text) async {
    Dio dio = await DioAuth.getDio();
    dio.post('$baseUrl$sendEmergencyRequestEndPoint', data: {
      "emergencyType": text
    });
  }
}
