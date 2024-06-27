import 'package:estegatha/features/edit_account/presentation/view_models/edit_phone_state.dart';
import 'package:bloc/bloc.dart';
class EditPhoneCubit extends Cubit<EditPhoneState>{
  EditPhoneCubit(super.initialState);
  void editPhone(String phone){
    emit(EditPhoneLoadingState());
    try{

      emit(EditPhoneSuccessState());
    }catch(e){
      emit(EditPhoneFailureState(error: e.toString()));
    }
  }
}