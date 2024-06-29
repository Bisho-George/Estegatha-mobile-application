import 'package:estegatha/features/sign-up/data/repos/predictions_maps_api.dart';
import 'package:estegatha/features/sign-up/domain/models/places_autocomplete_model/place_autocomplete_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'address_text_field_state.dart';

class AddressTextFieldCubit extends Cubit<AddressTextFieldState> {
  final PredictionsMapsApi _predictionsMapsApi;
  final TextEditingController _controller = TextEditingController();

  AddressTextFieldCubit(this._predictionsMapsApi) : super(AddressTextFieldInitial()) {
    _controller.addListener(_onTextChanged);
  }

  TextEditingController get controller => _controller;

  void _onTextChanged() {
    updatePredictions(_controller.text.toString());
  }

  void updatePredictions(String input) async {
    emit(AddressPredictionsLoadingState());
    try {
      List<PlaceModel> predictions = await _predictionsMapsApi.getPredictions(input: input);
      emit(AddressPredictionsLoadedState(predictions));
    } catch (e) {
      emit(AddressPredictionsErrorState(e.toString()));
    }
  }
}
