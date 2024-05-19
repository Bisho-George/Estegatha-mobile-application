import 'dart:convert';

import 'package:dio/dio.dart';

import '../../domain/models/places_autocomplete_model/place_autocomplete_model.dart';

class PredictionsMapsApi {
  final String _baseUrl = 'https://maps.googleapis.com/maps/api/place';
  final String apiKey = "AIzaSyD_Ab-wz4GHy7mtxwbzDmOiAetck1ARukQ";

  Future<List<PlaceModel>> getPredictions({required String input}) async {
    final dio = Dio();
    try {
      var response = await dio.get('$_baseUrl/autocomplete/json?key=$apiKey&input=$input');

      if (response.statusCode == 200) {
        var data = jsonDecode(response.data)['predictions'] as List;
        List<PlaceModel> places = [];

        for (var item in data) {
          places.add(PlaceModel.fromJson(item));
        }
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