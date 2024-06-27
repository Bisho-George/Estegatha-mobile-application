import 'package:estegatha/features/edit_account/data/api/edit_account_api.dart';
import 'package:estegatha/features/edit_account/domain/repositories/edit_account_repo.dart';
import 'package:estegatha/features/edit_account/presentation/view_models/edit_account_state.dart';
import 'package:bloc/bloc.dart';
class EditAccountCubit extends Cubit<EditAccountState>{
  bool loading = false;
  String phone = '';
  EditAccountCubit():super(EditAccountInitialState());
  void logout() async{
    loading = true;
    try{
    }catch(e){
      emit(EditAccountFailureState(error: 'Failed to logout'));
    }
    loading = false;
  }
}