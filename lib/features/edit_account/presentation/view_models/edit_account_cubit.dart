import 'package:estegatha/features/edit_account/data/api/edit_account_api.dart';
import 'package:estegatha/features/edit_account/domain/repositories/edit_account_repo.dart';
import 'package:estegatha/features/edit_account/presentation/view_models/edit_account_state.dart';
import 'package:bloc/bloc.dart';
class EditAccountCubit extends Cubit<EditAccountState>{
  bool loading = false;
  String phone = '';
  EditAccountCubit():super(EditAccountInitialState());
  void editPhone() async{
    EditAccountRepo editAccountRepo = EditAccountApi();
    loading = true;
    try{
      int response = await editAccountRepo.editPhone(phone);
      if(response == 0){
        emit(EditAccountFailureState(error: 'Failed to update phone number'));
      }
      else {
        emit(EditAccountSuccessState(message: 'Phone number updated successfully'));
      }
    }catch(e){
      emit(EditAccountFailureState(error: 'Failed to update phone number'));
    }
    loading = false;
    phone = '';
  }
}