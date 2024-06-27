import 'package:estegatha/features/sign-up/domain/models/places_autocomplete_model/place_autocomplete_model.dart';

abstract class PredictionsRepo {
  Future<List<PlaceModel>> getPredictions();
}