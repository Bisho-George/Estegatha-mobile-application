import 'package:dio/dio.dart';
import 'package:estegatha/core/data/api/dio_auth.dart';
import 'package:estegatha/features/sos/domain/repositories/sos_repo.dart';
import 'package:estegatha/utils/constant/strings.dart';
import 'package:geolocator/geolocator.dart';
class SosApi extends SosRepo {
  @override
  Future<int> createSosPin(String sos) async{
    Dio dio = DioAuth.getDio();
    Response response = await dio.post(baseUrl + createSosEndPoint, data: {
      sosPinKey: sos,
    });
    return response.statusCode ?? 404;
  }

  @override
  Future<int> sendSos() async{
    var location = await Geolocator.getCurrentPosition();
    Dio dio = DioAuth.getDio();
    Response response = await dio.post(baseUrl + sendSosEndPoint, data: {
      latKey: location.latitude,
      langKey: location.longitude,
      timeKey: '2024-05-12T08:30:00'
    });
    return response.statusCode ?? 404;
  }
}