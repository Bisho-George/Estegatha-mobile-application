import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum DatePickerState { initial, selectingDate, dateSelected }

class DatePickerCubit extends Cubit<DatePickerState> {
  DatePickerCubit() : super(DatePickerState.initial);

  Future<void> selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      emit(DatePickerState.dateSelected);
    }

    // Regardless of whether a date was picked or not, return to initial state
    emit(DatePickerState.initial);
  }


  void dateSelected() {
    emit(DatePickerState.initial);
  }
}
