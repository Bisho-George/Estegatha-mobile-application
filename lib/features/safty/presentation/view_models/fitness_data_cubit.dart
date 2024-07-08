import 'package:estegatha/features/safty/presentation/view_models/fitness_data_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/api/fitness_connect_api.dart';
import 'fitness_connect_state.dart';

class FitnessDataCubit extends Cubit<FitnessDataState>{
  FitnessDataCubit():super(FitnessDataInitial());
  final _repository = FitnessConnectApi();
  bool loading = false;
  void changeAccount() async{
    try{
      await _repository.changeAccount();
      emit(FitnessDataSuccess('Account changed'));
    }catch(e){
      emit(FitnessDataFailure('Failed to change account'));
    }
  }
  void fetchData() async{
    loading = true;
    try{
      await _repository.fetchData();
      emit(FitnessDataSuccess('Data fetched'));
    }catch(e){
      emit(FitnessDataFailure('Failed to fetch data'));
    }
    loading = false;
  }
}