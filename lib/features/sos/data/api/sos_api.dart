import 'package:dio/dio.dart';
import 'package:estegatha/constants.dart';
import 'package:estegatha/core/data/api/dio_auth.dart';
import 'package:estegatha/features/landing/domain/models/permissions.dart';
import 'package:estegatha/features/organization/domain/models/member.dart';
import 'package:estegatha/features/safty/data/api/contact_api.dart';
import 'package:estegatha/features/sos/data/api/message_api.dart';
import 'package:estegatha/features/sos/domain/message_repo.dart';
import 'package:estegatha/features/sos/domain/repositories/sos_repo.dart';
import 'package:estegatha/utils/helpers/helper_functions.dart';
import 'package:geolocator/geolocator.dart';

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
  Future<int> sendSos({String type = 'INIT_SOS'}) async {
    var location = await Geolocator.getCurrentPosition();
    Member member = await HelperFunctions.getUser();
    int success = 0;
    Dio dio = await DioAuth.getDio();
    Response response = await dio.post(baseUrl + sosEndPoint, data: {
      subjectKey: 'Emergency',
      contentKey: 'your friend ${member.username} needs help',
      "type": type,
      'data': {
        'userId': member.id.toString(),
        'latitude': location.latitude.toString(),
        'longitude': location.longitude.toString()
      }
    });
    try {
      var contacts = await ContactApi().fetchContacts();
      SmsMessageRepo messageApi = SmsMessageApi();
      String message = 'your friend ${member.username} needs help';
      if (member.phone != null && member.phone!.isNotEmpty) {
        message += ' has phone ${member.phone}';
      }
      for (var contact in contacts) {
        await messageApi.sendMessage(message, contact.phoneNumber);
      }
    } catch (e) {
      print(e);
    }
    if (response.statusCode == 201) {
      success = 1;
    }
    return success;
  }
}
