import 'package:bloc/bloc.dart';
import 'package:estegatha/features/edit_account/presentation/view_models/edit_phone_state.dart';
import 'package:estegatha/features/sign-in/presentation/veiw_models/user_cubit.dart';
import 'package:estegatha/constants.dart';
import 'package:flutter/cupertino.dart';

import '../../../../utils/helpers/helper_functions.dart';
import '../../../organization/domain/models/member.dart';
import '../../data/api/edit_account_api.dart';
import '../../domain/repositories/edit_account_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class EditPhoneCubit extends Cubit<EditPhoneState>{
  bool loading = false;
  String phone = '';
  EditPhoneCubit():super(EditPhoneInitial());
  void editPhone() async{
    EditAccountRepo editAccountRepo = EditAccountApi();
    loading = true;
    try{
      int response = await editAccountRepo.editPhone(phone).timeout(Duration(seconds: durationTimeout));
      if(response == 0){
        emit(EditPhoneFailure('Failed to update phone number'));
      }
      else {
        var member = await HelperFunctions.getUser();
        member.phone = phone;
        HelperFunctions.setUser(member);
        emit(EditPhoneSuccess(member, 'Phone number updated successfully'));
      }
    }catch(e){
      emit(EditPhoneFailure('Failed to update phone number'));
    }
    loading = false;
  }
}