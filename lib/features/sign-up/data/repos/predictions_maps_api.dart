import 'dart:convert';
import 'package:dio/dio.dart';
import '../../domain/models/places_autocomplete_model/place_autocomplete_model.dart';

class PredictionsMapsApi {
  final String _baseUrl = 'https://maps.googleapis.com/maps/api/place';
  final String apiKey = "AIzaSyCuTilAfnGfkZtIx0T3qf-eOmWZ_N2LpoY";

  Future<List<PlaceModel>> getPredictions({required String input}) async {
    final dio = Dio();
    try {
      var response = await dio.get('$_baseUrl/autocomplete/json?key=$apiKey&input=$input');

      if (response.statusCode == 200) {
        print('Response data: ${response.data}');

        var data = jsonDecode(response.data);
        var predictions = data['predictions'] as List<dynamic>;
        List<PlaceModel> places = predictions.map((e) => PlaceModel.fromJson(e as Map<String, dynamic>)).toList();

        return places;
      } else {
        throw Exception('Failed to load predictions');
      }
    } catch (e) {
      print('Error fetching predictions: $e');
      throw Exception('Failed to fetch predictions. Check your network connection.');
    }
  }
}
