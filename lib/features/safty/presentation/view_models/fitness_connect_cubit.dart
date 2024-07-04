import 'package:estegatha/features/safty/presentation/view_models/fitness_connect_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/repositories/fitness_connect_repo.dart';
class FitnessConnectCubit extends Cubit<FitnessConnectState> {
  final FitnessConnectRepository repository;

  FitnessConnectCubit(this.repository) : super(FitnessConnectInitial());

  void connect() async {
    try {
      repository.connect();
    } catch (e) {
      emit(FitnessConnectFailure(e.toString()));
    }
  }
}