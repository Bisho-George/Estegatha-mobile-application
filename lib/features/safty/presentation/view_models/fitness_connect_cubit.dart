import 'package:estegatha/features/safty/data/api/fitness_connect_api.dart';
import 'package:estegatha/features/safty/presentation/view_models/fitness_connect_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/repositories/fitness_connect_repo.dart';
class FitnessConnectCubit extends Cubit<FitnessConnectState> {
  bool loading = false;
  FitnessConnectCubit() : super(FitnessConnectInitial());

  void connect() async {
    final FitnessConnectRepository repository = FitnessConnectApi();
    loading = true;
    try {
      await repository.connect();
      emit(FitnessConnectSuccess('Connected'));
    } catch (e) {
      emit(FitnessConnectFailure(e.toString()));
    }
    loading = false;
  }
}