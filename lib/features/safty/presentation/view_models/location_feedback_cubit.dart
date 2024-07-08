import 'package:estegatha/features/safty/data/api/location_feedback_api.dart';
import 'package:estegatha/features/safty/domain/repositories/location_feedback_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'location_feedback_state.dart';

class LocationFeedbackCubit extends Cubit<LocationFeedbackState> {

  LocationFeedbackCubit() : super(LocationFeedbackInitial());
  TextEditingController feedbackController = TextEditingController();
  List<double> location = [];
  bool isLoading = false;
  void submitLocationFeedback() async {
    isLoading = true;
    String problems = '';
    if(location.isEmpty){
      problems += 'Please select a location';
    }
    if(feedbackController.text.isEmpty){
      if (problems.isNotEmpty) problems += 'and';
      problems += 'Please enter feedback';
    }
    if(problems.isNotEmpty){
      emit(LocationFeedbackFailure(message: problems));
    }
    else {
      LocationFeedbackRepo repo = LocationFeedbackApi();
      try {
        await repo.sendFeedback(
            feedbackController.text, location[0], location[1]);
        emit(LocationFeedbackSuccess(message: 'Feedback sent successfully'));
      } catch (e) {
        emit(LocationFeedbackFailure(message: e.toString()));
      }
    }
    isLoading = false;
  }
}