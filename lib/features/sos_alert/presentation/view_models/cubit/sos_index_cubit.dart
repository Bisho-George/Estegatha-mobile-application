import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'sos_index_state.dart';

class SosIndexCubit extends Cubit<SosIndexState> {
  SosIndexCubit() : super(SosIndexInitial());
  PageController? pageController = PageController();

  void changeIndex(int index) {
    emit(SosIndexChange(index));
  }
  @override
  Future<void> close() {
    pageController?.dispose();
    return super.close();
  }
}
