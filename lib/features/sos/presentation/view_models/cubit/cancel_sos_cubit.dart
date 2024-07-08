import 'package:estegatha/features/sos/data/api/cancel_sos_api.dart';
import 'package:estegatha/features/sos/domain/repositories/cancel_sos_repo.dart';
import 'package:estegatha/features/sos/presentation/view_models/cubit/cancel_sos_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../constants.dart';

class CancelSosCubit extends Cubit<CancelSosState>{
  CancelSosCubit():super(CancelSosInitial());
  bool isLoading = false;
  void cancelSos(String sosPin) async {
    isLoading = true;
    try{
      CancelSosRepo repo = CancelSosApi();
      await repo.cancelSos(sosPin).timeout(Duration(seconds: durationTimeout));
      emit(CancelSosSuccess(message: 'Sos request cancelled successfully'));
    }catch(e){
      emit(CancelSosFailure(message: 'Failed to cancel sos request'));
    }
    isLoading = false;
  }

  void sendFeedback(String text) {
    try {
      CancelSosRepo repo = CancelSosApi();
      repo.sendFeedback(text);
    }catch(e){
      print(e);
    }
  }

}