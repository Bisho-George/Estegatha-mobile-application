import 'package:dio/dio.dart';
import 'package:estegatha/constants.dart';
import 'package:estegatha/core/data/api/dio_auth.dart';
import 'package:estegatha/features/safty/domain/repositories/location_feedback_repo.dart';

class LocationFeedbackApi extends LocationFeedbackRepo {
  @override
  Future<bool> isAllowed() async {
    Dio dio = await DioAuth.getDio();
    Response response =
        await dio.get('$baseUrl$locationFeedbackAllowedEndPoint');
    return response.data as bool;
  }

  @override
  Future<void> sendFeedback(String feedback, double lat, double lng) async {
    bool allowed = await isAllowed();
    if(!allowed){
      throw(Exception("Location feedback is not allowed"));
    }
    Dio dio = await DioAuth.getDio();
    try{
      await dio.post(
        '$baseUrl$locationFeedbackEndPoint',
        data: {
          'emergencyType': feedback, 'lat': lat.toString(), 'lang': lng.toString()
        },
      );
    }catch(e){
      throw(Exception("Failed to send feedback"));
    }
  }
}
